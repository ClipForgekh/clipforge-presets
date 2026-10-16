exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float noiseAmount; // = 0.55 [0.0, 1.0] // 复印颗粒强度
uniform float displacementStrength; // = 0.006 [0.0, 0.03] // LE位移强度
uniform float sweepSoftness; // = 0.12 [0.02, 0.3] // 扫描羽化宽度

varying vec2 vUv;

float cubicInOut(float p) {
    if (p < 0.5) {
        return 4.0 * p * p * p;
    }
    float f = -2.0 * p + 2.0;
    return 1.0 - 0.5 * f * f * f;
}

float tween(float p) {
    return cubicInOut(p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) {
        p.y /= ratio;
    } else {
        p.x *= ratio;
    }
    return p;
}

float phaseProgress(float value, float start, float end) {
    float denom = max(end - start, 0.0001);
    return clamp((value - start) / denom, 0.0, 1.0);
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    float x1 = mix(a, b, u.x);
    float x2 = mix(c, d, u.x);
    return mix(x1, x2, u.y);
}

vec4 effect(vec4 texel, float progress) {
    float phase1End = cubicInOut(0.25);
    float phase2End = cubicInOut(0.65);
    float phase3End = cubicInOut(0.85);

    float stage1 = phaseProgress(progress, 0.0, phase1End);
    float stage2 = phaseProgress(progress, phase1End, phase2End);
    float stage3 = phaseProgress(progress, phase2End, phase3End);
    float stage4 = phaseProgress(progress, phase3End, 1.0);

    float reduction = clamp(stage3 * 0.9 + stage4, 0.0, 1.0);
    float displacementFade = 1.0 - reduction;

    vec2 baseUV = vUv;
    float dispNoiseX = noise(baseUV * vec2(160.0, 90.0) + vec2(progress * 30.0, progress * 18.0));
    float dispNoiseY = noise(baseUV * vec2(90.0, 210.0) + vec2(progress * 26.0, progress * 33.0));
    vec2 displacement = (vec2(dispNoiseX, dispNoiseY) - 0.5) * displacementStrength * displacementFade;
    vec2 displacedUV = handleUVBounds(baseUV + displacement);

    vec4 displacedTexel = texture2D(tDiffuse, displacedUV);

    float gray = dot(displacedTexel.rgb, vec3(0.299, 0.587, 0.114));
    vec3 mono = vec3(gray);

    float grainHigh = noise(baseUV * vec2(620.0, 520.0) + vec2(progress * 42.0, progress * 37.0));
    float grainLow = noise(baseUV * vec2(140.0, 80.0) + vec2(progress * 18.0, progress * 22.0));
    float lineGrain = noise(vec2(baseUV.y * 260.0, progress * 28.0));
    float combinedGrain = mix(grainLow, grainHigh, 0.65);
    combinedGrain = mix(combinedGrain, lineGrain, 0.25);

    float dynamicNoise = noiseAmount * (1.0 - reduction);
    vec3 photocopyColor = mono + (combinedGrain - 0.5) * dynamicNoise;
    photocopyColor = clamp(photocopyColor, 0.0, 1.0);

    float centerMask = smoothstep(0.6, 0.12, length(getSDFCoordinate(baseUV, vec2(0.5, 0.5))));
    float stage1Mask = centerMask * stage1 * (1.0 - stage2);

    float sweepTail = mix(0.48, 0.0, stage2);
    float sweepHead = mix(0.52, 1.05, stage2);
    float span = max(sweepHead - sweepTail, 0.0001);
    float sweepMask = clamp((baseUV.x - sweepTail) / span, 0.0, 1.0);
    sweepMask = smoothstep(0.0, 1.0, sweepMask);
    sweepMask = pow(sweepMask, 1.1);
    sweepMask *= stage2;

    float revealMask = clamp(stage1Mask + sweepMask, 0.0, 1.0);

    float scanPos = mix(0.46, 1.02, stage2);
    float scanHighlight = exp(-abs(baseUV.x - scanPos) * 40.0) * (1.0 - stage3) * 0.18;
    photocopyColor += scanHighlight;
    photocopyColor = clamp(photocopyColor, 0.0, 1.0);

    vec3 exposureColor = mix(vec3(0.0), photocopyColor, revealMask);

    float detailBlend = clamp(stage2 * 0.85 + stage3 * 0.35, 0.0, 1.0);
    vec3 detailColor = mix(exposureColor, displacedTexel.rgb, detailBlend * 0.6);

    float restore = clamp(stage3 * 0.9 + stage4, 0.0, 1.0);
    vec3 restoredColor = mix(detailColor, displacedTexel.rgb, restore);
    vec3 finalColor = mix(restoredColor, texel.rgb, stage4);

    finalColor = clamp(finalColor, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(baseUV);
    float finalAlpha = mix(displacedTexel.a, texel.a, stage4) * borderMask;

    return vec4(finalColor, finalAlpha);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);
    vec4 finalColor = effectColor;
    gl_FragColor = finalColor;
}
//===end_frag_code===
`;