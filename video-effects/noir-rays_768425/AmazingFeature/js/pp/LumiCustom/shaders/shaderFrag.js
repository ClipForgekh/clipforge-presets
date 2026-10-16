exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float thresholdBias; // = 0.35 [0.1, 0.9] // 阈值基准
uniform float thresholdSharpness; // = 14.0 [2.0, 40.0] // 阈值锐度
uniform float chromaStrength; // = 1.2 [0.0, 2.5] // 色差强度
uniform float shakeStrength; // = 0.035 [0.0, 0.1] // 抖动幅度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
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

float rand(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float easeInQuad(float t) {
    return t * t;
}

float easeOutQuad(float t) {
    float inv = 1.0 - t;
    return 1.0 - inv * inv;
}

float phaseProgress(float t, float start, float end) {
    return clamp((t - start) / max(end - start, 0.0001), 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float timeline = 1.0 - pow(max(0.0, 1.0 - progress), 0.33333334);
    vec2 sdfCoord = getSDFCoordinate(vUv, vec2(0.5));
    float radial = length(sdfCoord);
    
    float phase1 = phaseProgress(timeline, 0.0, 0.25);
    float phase2 = phaseProgress(timeline, 0.25, 0.55);
    float phase3 = phaseProgress(timeline, 0.55, 0.8);
    float phase4 = phaseProgress(timeline, 0.8, 1.0);
    
    float revealEase = easeInQuad(phase1);
    float expansionEase = easeOutQuad(phase2);
    float releaseEase = easeOutQuad(phase3);
    float settleEase = easeOutQuad(phase4);
    
    float thresholdEnvelope = mix(1.0, 0.7, revealEase);
    float thresholdStrength = thresholdEnvelope * (1.0 - releaseEase);
    
    float shakeEnvelope = easeOutQuad(phase2);
    float decay = 1.0 - settleEase;
    float sustain = 1.0 - releaseEase * 0.85;
    float shakeAmount = shakeStrength * shakeEnvelope * sustain * decay;
    
    float chromaEnvelope = 0.6 + 0.4 * (1.0 - releaseEase);
    float chromaIntensity = chromaStrength * chromaEnvelope * decay;
    float chromaBlend = clamp(chromaIntensity, 0.0, 1.0);
    
    float timeFactor = timeline * 6.2831853;
    vec2 diag = normalize(vec2(1.0, -1.0));
    float wave = sin(timeFactor * 12.0) * 0.7 + sin(timeFactor * 19.0 + vUv.x * 12.0) * 0.3;
    vec2 shakeOffset = diag * wave * shakeAmount;
    
    vec2 baseUV = handleUVBounds(vUv + shakeOffset);
    vec4 baseSample = texture2D(tDiffuse, baseUV);
    vec3 baseColor = baseSample.rgb;
    
    vec2 aberrAxis = normalize(vec2(0.8, 0.6));
    float aberrMag = (0.004 + 0.012 * thresholdStrength) * chromaIntensity;
    vec2 offset = aberrAxis * aberrMag;
    
    vec3 aberratedColor = vec3(
        texture2D(tDiffuse, handleUVBounds(baseUV + offset)).r,
        baseColor.g,
        texture2D(tDiffuse, handleUVBounds(baseUV - offset)).b
    );
    vec3 colorChroma = mix(baseColor, aberratedColor, chromaBlend);
    
    float lum = dot(colorChroma, vec3(0.2126, 0.7152, 0.0722));
    vec2 grainCoord = vUv * (240.0 + 240.0 * expansionEase) + vec2(timeline * 60.0, timeline * 40.0);
    float grain = rand(grainCoord);
    float stripe = sin(atan(sdfCoord.y, sdfCoord.x) * 9.0 + timeline * 18.0);
    
    float softness = 1.0 / max(thresholdSharpness, 0.0001);
    float fragmentField = lum - thresholdBias;
    fragmentField += (grain - 0.5) * (0.8 + 0.6 * expansionEase);
    fragmentField -= radial * (1.6 - 1.2 * expansionEase);
    fragmentField += stripe * (0.25 + 0.35 * (1.0 - releaseEase));
    
    float thresholdMask = smoothstep(-softness, softness, fragmentField);
    float hardCut = step(0.0, fragmentField);
    vec3 fragmentColor = mix(vec3(thresholdMask), vec3(hardCut), 0.65);
    
    vec3 mixedColor = mix(colorChroma, fragmentColor, clamp(thresholdStrength, 0.0, 1.0));
    
    float borderMask = getHardBoundaryMask(vUv);
    return vec4(mixedColor, texel.a * borderMask);
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