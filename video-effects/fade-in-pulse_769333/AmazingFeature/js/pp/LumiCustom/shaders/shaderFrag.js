exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float maxGlowRadius; // = 0.045 [0.0, 0.1] // 最大辉光半径
uniform float pulseStrength; // = 1.25 [0.0, 2.0] // 脉冲辉光强度
uniform vec3 glowColor; // = vec3(1.0, 0.92, 0.75) // 辉光颜色

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float p) {
    return 0.5 * (1.0 + sin((p - 0.5) * PI));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec3 computeSoftGlow(vec2 uv, float radius) {
    if (radius <= 0.00001) {
        return vec3(0.0);
    }
    float invRatio = 1.0 / max(ratio, 0.0001);
    vec2 stepX = vec2(radius, 0.0);
    vec2 stepY = vec2(0.0, radius * invRatio);

    vec3 accum = vec3(0.0);
    float total = 0.0;

    float w0 = 0.28;
    vec3 c0 = texture2D(tDiffuse, handleUVBounds(uv)).rgb;
    accum += c0 * w0;
    total += w0;

    float w1 = 0.18;
    vec3 c1 = texture2D(tDiffuse, handleUVBounds(uv + stepX)).rgb;
    vec3 c2 = texture2D(tDiffuse, handleUVBounds(uv - stepX)).rgb;
    vec3 c3 = texture2D(tDiffuse, handleUVBounds(uv + stepY)).rgb;
    vec3 c4 = texture2D(tDiffuse, handleUVBounds(uv - stepY)).rgb;
    accum += (c1 + c2 + c3 + c4) * w1;
    total += 4.0 * w1;

    vec2 diagStep = vec2(stepX.x, stepY.y) * 0.6;
    float w2 = 0.08;
    vec3 c5 = texture2D(tDiffuse, handleUVBounds(uv + diagStep)).rgb;
    vec3 c6 = texture2D(tDiffuse, handleUVBounds(uv - diagStep)).rgb;
    vec3 c7 = texture2D(tDiffuse, handleUVBounds(uv + vec2(-diagStep.x, diagStep.y))).rgb;
    vec3 c8 = texture2D(tDiffuse, handleUVBounds(uv + vec2(diagStep.x, -diagStep.y))).rgb;
    accum += (c5 + c6 + c7 + c8) * w2;
    total += 4.0 * w2;

    return accum / max(total, 0.0001);
}

vec4 effect(vec4 texel, float progress) {
    float borderMask = getHardBoundaryMask(vUv);

    float scalePhase = clamp(progress / 0.7, 0.0, 1.0);
    float scaleFactor = mix(0.92, 1.0, scalePhase);

    vec2 scaledUV = 0.5 + (vUv - 0.5) * scaleFactor;
    scaledUV = handleUVBounds(scaledUV);

    vec4 scaledTexel = texture2D(tDiffuse, scaledUV);

    float visibility = smoothstep(0.05, 0.35, progress);

    float initialGlow = 1.0 - progress;
    float pulse = exp(-pow((progress - 0.85) / 0.08, 2.0)) * pulseStrength;
    float combinedGlow = clamp(initialGlow + pulse, 0.0, 1.5);
    float cleanup = 1.0 - smoothstep(0.98, 1.0, progress);
    float glowIntensity = combinedGlow * cleanup;

    float glowRadius = glowIntensity * maxGlowRadius;

    vec3 blurred = computeSoftGlow(scaledUV, glowRadius);
    vec3 glow = max(blurred - scaledTexel.rgb, 0.0) * glowColor * glowIntensity;

    vec3 baseRGB = scaledTexel.rgb * visibility;
    float baseAlpha = mix(texel.a, scaledTexel.a, scalePhase) * visibility;

    vec3 finalRGB = clamp(baseRGB + glow, 0.0, 1.0);
    float finalAlpha = baseAlpha;

    return vec4(finalRGB, finalAlpha) * borderMask;
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