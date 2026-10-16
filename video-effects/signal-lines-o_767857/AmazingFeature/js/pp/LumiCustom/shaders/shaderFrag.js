exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float stripDensity; // = 160.0 [40.0, 420.0] // 条带数量峰值
uniform float aberrationStrength; // = 0.01 [0.0, 0.05] // 最大色散强度
uniform float sprintStretch; // = 0.14 [0.0, 0.4] // 光迹拉伸距离
uniform float motionBlurStrength; // = 0.6 [0.0, 1.0] // 运动模糊强度
uniform float flickerContrast; // = 0.45 [0.0, 1.0] // 闪烁对比度

varying vec2 vUv;

// ---------------------- 辅助函数 ----------------------
float tween(float p) {
    if (p <= 0.0) return 0.0;
    if (p >= 1.0) return 1.0;
    p *= 2.0;
    if (p < 1.0) {
        return 0.5 * pow(2.0, 10.0 * (p - 1.0));
    }
    return 0.5 * (-pow(2.0, -10.0 * (p - 1.0)) + 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float timelineRamp(float t, float startT, float endT) {
    return clamp((t - startT) / max(endT - startT, 0.0001), 0.0, 1.0);
}

// ---------------------- 时间轴配置 ----------------------
float lumiSplitTimeline(float p) {
    const float lowVal = 0.28;
    const float mediumVal = 0.58;
    const float highVal = 1.0;
    float rise = timelineRamp(p, 0.125, 0.338);
    float fall = timelineRamp(p, 0.338, 0.675);
    float settle = timelineRamp(p, 0.675, 0.86);
    float release = timelineRamp(p, 0.86, 1.0);
    float intensity = 0.0;
    intensity += lowVal * rise;
    intensity = mix(intensity, highVal, fall);
    intensity = mix(intensity, mediumVal, settle);
    intensity = mix(intensity, 0.0, release);
    return clamp(intensity, 0.0, 1.0);
}

float lumiChromaticAberrationTimeline(float p) {
    const float lowVal = 0.2;
    const float mediumVal = 0.52;
    const float highVal = 1.0;
    float rise = timelineRamp(p, 0.0, 0.175);
    float fall = timelineRamp(p, 0.175, 0.72);
    float release = timelineRamp(p, 0.72, 0.92);
    float intensity = 0.0;
    intensity += lowVal * rise;
    intensity = mix(intensity, highVal, rise);
    intensity = mix(intensity, mediumVal, fall);
    intensity = mix(intensity, 0.0, release);
    return clamp(intensity, 0.0, 1.0);
}

float lumiPixelSprintTimeline(float p) {
    const float highVal = 1.0;
    const float mediumVal = 0.55;
    float rise = timelineRamp(p, 0.375, 0.6);
    float fall = timelineRamp(p, 0.6, 0.88);
    float release = timelineRamp(p, 0.88, 1.0);
    float intensity = 0.0;
    intensity = mix(intensity, highVal, rise);
    intensity = mix(intensity, mediumVal, fall);
    intensity = mix(intensity, 0.0, release);
    return clamp(intensity, 0.0, 1.0);
}

float lumiMotionBlurTimeline(float p) {
    const float mediumVal = 0.58;
    const float lowVal = 0.32;
    float rise = timelineRamp(p, 0.675, 0.85);
    float release = timelineRamp(p, 0.85, 1.0);
    float intensity = mix(0.0, mediumVal, rise);
    intensity = mix(intensity, lowVal, release);
    return clamp(intensity, 0.0, 1.0);
}

float lumiFlickerTimeline(float p) {
    const float mediumVal = 0.55;
    float rise = timelineRamp(p, 0.375, 0.78);
    float release = timelineRamp(p, 0.78, 0.94);
    float intensity = mix(0.0, mediumVal, rise);
    intensity = mix(intensity, 0.0, release);
    return clamp(intensity, 0.0, 1.0);
}

// ---------------------- 特效主体 ----------------------
vec4 effect(vec4 texel, float easedProgress) {
    float p = clamp(easedProgress, 0.0, 1.0);

    vec3 baseColor = texel.rgb;
    float baseAlpha = texel.a;

    float splitIntensity = lumiSplitTimeline(p);
    float chromaIntensity = lumiChromaticAberrationTimeline(p);
    float sprintIntensity = lumiPixelSprintTimeline(p);
    float blurIntensity = lumiMotionBlurTimeline(p);
    float flickerIntensity = lumiFlickerTimeline(p);

    float aggregated = clamp(splitIntensity + chromaIntensity + sprintIntensity + blurIntensity + flickerIntensity, 0.0, 1.0);

    float strips = mix(1.0, stripDensity, splitIntensity);
    float stripIndex = floor(vUv.y * strips);
    vec2 stripSeed = vec2(stripIndex + 0.5, 0.5);

    float baseHash = hash21(stripSeed + vec2(0.11, 0.73));
    float dirHash = hash21(stripSeed + vec2(3.19, 7.91));
    float hueHash = hash21(stripSeed + vec2(5.41, 2.63));
    float jitterHash = hash21(stripSeed + vec2(9.77, 1.37));

    float jitterAmpX = (0.08 * splitIntensity + 0.35 * sprintIntensity);
    float jitterAmpY = (0.01 * splitIntensity + 0.07 * sprintIntensity);
    vec2 jitterVec = vec2((baseHash - 0.5) * jitterAmpX, (dirHash - 0.5) * jitterAmpY);

    float flyEnvelope = smoothstep(0.675, 0.85, p);
    float sideSign = dirHash < 0.5 ? -1.0 : 1.0;
    vec2 rawFlyDir = vec2(sideSign, (jitterHash - 0.5) * 0.6 + 0.08);
    float rawFlyLen = max(length(rawFlyDir), 0.0001);
    vec2 flyDir = rawFlyDir / rawFlyLen;
    vec2 flyOffset = flyDir * flyEnvelope * (0.02 + 0.22 * sprintIntensity + 0.25 * splitIntensity);

    vec2 displacedUV = handleUVBounds(vUv + jitterVec + flyOffset);

    vec2 centerVec = vUv - 0.5;
    float centerLen = length(centerVec);
    vec2 dirNorm = centerLen > 0.0 ? centerVec / centerLen : vec2(0.0);
    float aberration = aberrationStrength * chromaIntensity;
    vec2 aberrOffset = dirNorm * aberration;

    vec2 uvR = handleUVBounds(displacedUV + aberrOffset);
    vec2 uvG = displacedUV;
    vec2 uvB = handleUVBounds(displacedUV - aberrOffset);

    vec3 colorR = texture2D(tDiffuse, uvR).rgb;
    vec3 colorG = texture2D(tDiffuse, uvG).rgb;
    vec3 colorB = texture2D(tDiffuse, uvB).rgb;
    vec3 colorSample = vec3(colorR.r, colorG.g, colorB.b);

    vec2 sprintDir = normalize(vec2(sideSign, (jitterHash - 0.5) * 0.35) + vec2(0.0001));
    float sprintAmount = sprintStretch * sprintIntensity;
    if (sprintAmount > 0.0) {
        vec2 sprintUV = handleUVBounds(displacedUV - sprintDir * sprintAmount);
        vec3 sprintColor = texture2D(tDiffuse, sprintUV).rgb;
        colorSample = mix(colorSample, sprintColor, 0.45 * sprintIntensity);
    }

    vec2 velocity = (flyDir * (0.004 + 0.01 * sprintIntensity) + jitterVec * 0.25) * (0.6 + 0.4 * sprintIntensity);
    float blurAmount = motionBlurStrength * blurIntensity;
    vec3 blurredColor = vec3(0.0);
    float blurWeightSum = 0.0;
    for (int i = -2; i <= 2; i++) {
        float offsetIndex = float(i);
        float w = 3.0 - abs(offsetIndex);
        vec2 blurUV = handleUVBounds(displacedUV - velocity * blurAmount * offsetIndex);
        vec3 sampleColor = texture2D(tDiffuse, blurUV).rgb;
        blurredColor += sampleColor * w;
        blurWeightSum += w;
    }
    blurredColor /= max(blurWeightSum, 0.0001);
    colorSample = mix(colorSample, blurredColor, blurIntensity);

    vec3 paletteColor = vec3(1.0);
    if (hueHash < 0.25) paletteColor = vec3(0.12, 0.95, 1.0);
    else if (hueHash < 0.5) paletteColor = vec3(1.0, 0.2, 0.95);
    else if (hueHash < 0.75) paletteColor = vec3(0.2, 0.4, 1.0);
    vec3 holographicColor = mix(colorSample, paletteColor, clamp(0.35 * splitIntensity + 0.55 * sprintIntensity, 0.0, 0.9));

    float localY = fract(vUv.y * strips);
    float microDensity = mix(1.0, 16.0, splitIntensity);
    float microPhase = fract(localY * microDensity + baseHash);
    float fragmentMaskRaw = smoothstep(0.0, 0.12, microPhase) * (1.0 - smoothstep(0.68, 1.0, microPhase));
    float destructionMix = clamp(splitIntensity + sprintIntensity, 0.0, 1.0);
    float fragmentMask = mix(1.0, fragmentMaskRaw, destructionMix);

    float flickerPhase = sin((stripIndex + 0.5) * 17.0 + p * 140.0 + hueHash * 6.28318530718);
    float flickerAmount = flickerIntensity * flickerContrast * (0.5 - 0.5 * flickerPhase);
    float flickerFactor = clamp(1.0 - flickerAmount, 0.0, 1.2);

    vec3 effectContribution = holographicColor * flickerFactor * fragmentMask;
    vec3 composedColor = mix(baseColor, effectContribution, aggregated);
    float coverage = mix(1.0, fragmentMask, aggregated);
    float alpha = baseAlpha * coverage;

    float trailFade = smoothstep(0.85, 1.0, p);
    composedColor = mix(composedColor, vec3(0.0), trailFade);
    alpha *= (1.0 - trailFade);

    float borderMask = getHardBoundaryMask(vUv);
    composedColor *= borderMask;
    alpha *= borderMask;

    composedColor = clamp(composedColor, 0.0, 1.0);
    alpha = clamp(alpha, 0.0, 1.0);

    return vec4(composedColor, alpha);
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