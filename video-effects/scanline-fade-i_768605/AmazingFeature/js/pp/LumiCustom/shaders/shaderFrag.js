exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float scanlineDensity; // = 220.0 [60.0, 400.0] // 垂直扫描线数量
uniform float wobbleStrength; // = 0.003 [0.0, 0.01] // 磁带抖动幅度
uniform float overshootAmount; // = 0.01 [0.0, 0.05] // 过冲比例
uniform float breathingCycles; // = 1.6 [0.5, 3.0] // 呼吸节奏循环次数

varying vec2 vUv;

float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float reveal = progress;

    float startScale = 0.96;
    float baseScale = mix(startScale, 1.0, reveal);
    float settle = smoothstep(0.7, 1.0, reveal);
    float overshootWave = sin(settle * 3.14159265);
    float scale = baseScale * (1.0 + overshootAmount * overshootWave);

    vec2 centered = vUv - 0.5;
    vec2 rawUv = 0.5 + centered * scale;

    float breathingPhase = reveal * breathingCycles * 3.14159265 * 2.0;
    float breathingEnvelope = 0.5 + 0.5 * sin(breathingPhase - 1.57079633);
    float wobbleEnvelope = (1.0 - reveal) * breathingEnvelope;
    float aspectComp = ratio > 1.0 ? ratio : 1.0;
    float wobble = sin(breathingPhase + rawUv.y * scanlineDensity * 0.03);
    rawUv.x += (wobbleStrength / aspectComp) * wobble * wobbleEnvelope;

    vec2 sampleUv = handleUVBounds(rawUv);
    vec4 sampled = texture2D(tDiffuse, sampleUv);

    float density = scanlineDensity * (ratio > 1.0 ? ratio : 1.0);
    float stripe = abs(fract((vUv.y - 0.5) * density + 0.5) - 0.5) * 2.0;
    float breathingOffset = (breathingEnvelope - 0.5) * 0.35 * (1.0 - reveal);
    float gapReach = mix(0.02, 1.15, reveal) + breathingOffset;
    gapReach = clamp(gapReach, 0.0, 1.2);
    float softness = mix(0.2, 0.06, reveal);
    float lineMask = 1.0 - smoothstep(gapReach, gapReach + softness, stripe);

    float centerBias = pow(1.0 - clamp(abs(vUv.y - 0.5) * 2.0, 0.0, 1.0), 2.0);
    float centerEmphasis = mix(centerBias, 1.0, reveal);
    float revealGate = smoothstep(0.02, 0.35, reveal);
    float visibility = clamp(lineMask * centerEmphasis * revealGate, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(rawUv);
    float fullMask = clamp(visibility * borderMask, 0.0, 1.0);

    vec3 finalRgb = sampled.rgb * fullMask;
    float finalAlpha = sampled.a * fullMask;

    return vec4(finalRgb, finalAlpha);
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