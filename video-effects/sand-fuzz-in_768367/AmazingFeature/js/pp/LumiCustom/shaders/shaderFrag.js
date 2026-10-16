exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float brightnessFocus; // = 0.6 [0.2, 0.9] // 亮部偏好控制粒点分布
uniform float grainSoftness; // = 0.08 [0.01, 0.3] // 粒点阈值柔化
uniform float glowStrength; // = 0.4 [0.0, 1.0] // 高亮粒点光晕强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - clamp(p, 0.0, 1.0), 3.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 effect(vec4 texel, float easedProgress) {
    float linearProgress = 1.0 - pow(max(1.0 - easedProgress, 0.0), 1.0 / 3.0);
    float time = linearProgress * 2.0;

    const float finalCount = 51200.0;
    const float baseCount = 400.0;

    float coverage = 0.0;

    if (time > 0.1) {
        float initialPhase = clamp((time - 0.1) / 0.2, 0.0, 1.0);
        coverage = (baseCount / finalCount) * initialPhase;
    }

    if (time >= 0.3) {
        float stagePos = clamp((time - 0.3) / 0.15, 0.0, 7.0);
        float stage = floor(stagePos);
        float stageProgress = stagePos - stage;
        float prevExp = stage;
        float nextExp = min(stage + 1.0, 7.0);
        float prevCount = baseCount * pow(2.0, prevExp);
        float nextCount = baseCount * pow(2.0, nextExp);
        float stageCoverage = (stage >= 7.0) ? (nextCount / finalCount) : mix(prevCount, nextCount, stageProgress) / finalCount;
        coverage = max(coverage, stageCoverage);
    }

    coverage = clamp(coverage, 0.0, 1.0);

    float luminance = dot(texel.rgb, vec3(0.2126, 0.7152, 0.0722));
    float luminanceClamped = clamp(luminance, 0.0, 1.0);
    float importance = pow(luminanceClamped + 1e-6, max(0.05, brightnessFocus));
    float weight = 2.0 * importance - 1.0;
    float threshold = clamp(coverage + weight * brightnessFocus * coverage * (1.0 - coverage), 0.0, 1.0);

    float noise = hash12(vUv * 4096.0);
    float pointMask = smoothstep(0.0, max(grainSoftness, 0.0001), threshold - noise);

    float colorPhase = clamp((time - 1.45) / 0.25, 0.0, 1.0);
    float colorEase = 1.0 - pow(1.0 - colorPhase, 2.0);
    float grainPresence = 1.0 - colorEase;

    vec3 grayscale = vec3(luminance);
    vec3 seedColor = mix(vec3(0.2), vec3(1.0), clamp(importance + 0.05, 0.0, 1.0));
    vec3 stageColor = mix(seedColor, mix(grayscale, texel.rgb, colorEase), colorEase);
    vec3 granularColor = stageColor * pointMask;
    vec3 blendedColor = mix(mix(grayscale, texel.rgb, colorEase), granularColor, grainPresence);

    float glowPhase = clamp((1.75 - time) / 0.35, 0.0, 1.0);
    float glowEnvelope = glowStrength * glowPhase * grainPresence;
    float glowMask = smoothstep(0.6, 1.0, luminanceClamped);
    vec3 glowColor = stageColor * glowMask * pointMask * glowEnvelope;
    blendedColor += glowColor;

    float contrastPhase = clamp((time - 1.65) / 0.15, 0.0, 1.0);
    float contrastAmount = mix(0.8, 1.0, contrastPhase);
    blendedColor = (blendedColor - 0.5) * contrastAmount + 0.5;

    blendedColor = clamp(blendedColor, 0.0, 1.0);
    float finalAlpha = texel.a;

    return vec4(blendedColor, finalAlpha);
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