exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float chromaIntensity; // = 0.025 [0.0, 0.1] // 色差位移强度系数
uniform float radialBlurStrength; // = 1.0 [0.0, 2.0] // 径向模糊强度系数
uniform float glitchStrength; // = 0.6 [0.0, 1.5] // 信号干扰强度系数
uniform float shockwaveBrightness; // = 0.6 [0.0, 1.0] // 冲击波亮度系数

varying vec2 vUv;

float tween(float t) {
    return t;
}

float segmentProgress(float p, float start, float end) {
    return clamp((p - start) / max(end - start, 1e-5), 0.0, 1.0);
}

float cubicInOut(float t) {
    return t < 0.5 ? 4.0 * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 3.0) * 0.5;
}

float exponentialIn(float t) {
    if (t <= 0.0) return 0.0;
    return pow(2.0, 10.0 * (t - 1.0));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

vec2 safeNormalize(vec2 v) {
    float len = length(v);
    return len < 1e-5 ? vec2(0.0) : v / len;
}

vec4 radialBlurSample(vec2 uv, float amount) {
    vec2 center = vec2(0.5);
    const int SAMPLES = 7;
    vec4 sum = vec4(0.0);
    float total = 0.0;
    float clampedAmount = clamp(amount, 0.0, 1.5);
    for (int i = 0; i < SAMPLES; i++) {
        float t = float(i) / float(SAMPLES - 1);
        vec2 sampleUV = mix(uv, center, t * clampedAmount);
        sampleUV = handleUVBounds(sampleUV);
        sum += texture2D(tDiffuse, sampleUV);
        total += 1.0;
    }
    return sum / total;
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.0) return texel;

    float sSubtle = cubicInOut(segmentProgress(p, 0.10, 0.25));
    float sBuild = cubicInOut(segmentProgress(p, 0.25, 0.40));
    float sGlitchRise = segmentProgress(p, 0.40, 0.525);
    float sShock = segmentProgress(p, 0.525, 0.65);
    float sGlitchPeak = segmentProgress(p, 0.65, 0.75);

    float collapseWindow = segmentProgress(p, 0.75, 0.825);
    float collapseEase = exponentialIn(collapseWindow);
    float collapseDamp = p < 0.825 ? 1.0 - collapseEase : 0.0;

    float baseChroma = (sSubtle * 0.35 + sBuild * 0.55 + sGlitchRise * 0.8 + sShock * 1.3 + sGlitchPeak * 1.1) * chromaIntensity * collapseDamp;
    float radialAmount = (sBuild * 0.5 + sGlitchRise * 0.8 + sShock * 1.4 + sGlitchPeak * 0.9) * radialBlurStrength * collapseDamp;
    float glitchAmount = (sGlitchRise * 0.5 + sShock * 0.9 + sGlitchPeak * 1.3) * glitchStrength * collapseDamp;

    vec2 center = vec2(0.5);
    vec2 diff = vUv - center;
    float contractionStrength = clamp(sBuild * 0.28 + sGlitchRise * 0.45 + sShock * 0.75 + sGlitchPeak * 0.85 + collapseEase * 0.98, 0.0, 0.98);
    float swirlStrength = (sBuild * 0.15 + sShock * 0.45 + sGlitchPeak * 0.55) * (0.5 + 0.5 * sin(p * 30.0));

    float sinA = sin(swirlStrength);
    float cosA = cos(swirlStrength);
    vec2 rotated = vec2(cosA * diff.x - sinA * diff.y, sinA * diff.x + cosA * diff.y);

    vec2 sdfCoord = getSDFCoordinate(vUv, center);
    vec2 sdfDir = safeNormalize(sdfCoord);
    vec2 uvDir = sdfDir;
    if (ratio > 1.0) uvDir.y *= ratio;
    else uvDir.x /= ratio;

    float radius = length(sdfCoord);
    float ripple = sShock * 0.04 * sin(radius * 18.0 - p * 25.0);
    vec2 rippleOffset = uvDir * ripple;

    vec2 contractedUV = center + rotated * (1.0 - contractionStrength) + rippleOffset;

    float timeSeed = p * 220.0;
    float stripeIndex = floor(contractedUV.y * 110.0 + timeSeed);
    float glitchNoise = hash(vec2(stripeIndex, timeSeed));
    float glitchSign = hash(vec2(stripeIndex, 13.37)) * 2.0 - 1.0;
    float tearMask = step(0.925, fract(stripeIndex * 0.123 + p * 2.7));
    vec2 glitchOffset = vec2(glitchSign * 0.015 * glitchAmount * (0.3 + 0.7 * sGlitchPeak), (glitchNoise - 0.5) * 0.006 * glitchAmount);
    vec2 tearOffset = vec2(tearMask * glitchAmount * 0.02, 0.0);

    vec2 distortedUV = contractedUV + glitchOffset;

    vec4 blurred = radialBlurSample(distortedUV, radialAmount);

    vec2 lateral = vec2(-uvDir.y, uvDir.x);
    float jitter = hash(vec2(stripeIndex, 91.0)) - 0.5;

    vec2 chromaDir = uvDir * baseChroma;
    vec2 chromaShiftR = chromaDir + lateral * baseChroma * 0.3 * jitter + tearOffset;
    vec2 chromaShiftG = -chromaDir * 0.6 - lateral * baseChroma * 0.15 * jitter - tearOffset * 0.5;
    vec2 chromaShiftB = chromaDir * -0.3 + lateral * baseChroma * 0.2 * (1.0 - jitter) + tearOffset * 0.25;

    float r = texture2D(tDiffuse, handleUVBounds(distortedUV + chromaShiftR)).r;
    float g = texture2D(tDiffuse, handleUVBounds(distortedUV + chromaShiftG)).g;
    float b = texture2D(tDiffuse, handleUVBounds(distortedUV + chromaShiftB)).b;

    vec3 chromaColor = vec3(r, g, b);
    float blurMix = clamp(radialAmount, 0.0, 1.0);
    vec3 combined = mix(chromaColor, blurred.rgb, blurMix * 0.65);

    float shockRadius = 0.2 + 0.6 * sShock;
    float ring = exp(-abs(radius - shockRadius) * 30.0) * sShock;
    float coreGlow = exp(-radius * 60.0) * (sShock + sGlitchPeak) * 0.6;
    combined += shockwaveBrightness * ring + coreGlow;

    float scan = sin(p * 120.0 + vUv.y * 1200.0);
    combined += glitchAmount * 0.04 * vec3(scan * 0.5 + 0.5);

    combined *= collapseDamp;
    combined = clamp(combined, 0.0, 1.0);
    combined *= getHardBoundaryMask(vUv);

    float finalFade = collapseDamp;
    vec4 finalColor = vec4(combined, texel.a * finalFade);
    return finalColor;
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