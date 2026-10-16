exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float burstStrength; // = 1.1 [0.0, 2.0] // 爆发能量倍率
uniform float ribbonTwist; // = 5.0 [0.0, 10.0] // 能量缠绕频率

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

vec4 effect(vec4 texel, float progress) {
    float inv = 1.0 - progress;
    vec2 center = vec2(0.5);
    vec2 offset = vUv - center;
    vec2 aspectOffset = getSDFCoordinate(vUv, center);
    float dist = length(aspectOffset);
    float distClamped = clamp(dist, 0.0, 1.5);
    float baseAngle = atan(aspectOffset.y, aspectOffset.x + 1e-6);

    float swirlStrength = inv * (0.6 + burstStrength * 0.5);
    float swirl = swirlStrength * sin(baseAngle * (3.0 + ribbonTwist) - progress * 8.0 + distClamped * 6.0);

    float s = sin(swirl);
    float c = cos(swirl);
    mat2 rot = mat2(c, -s, s, c);
    vec2 rotatedOffset = rot * offset;

    float depthScale = mix(0.35, 1.0, progress) + inv * 0.15 * distClamped * burstStrength;
    vec2 scaledOffset = rotatedOffset * depthScale;
    vec2 depthPush = offset * inv * (0.4 + 0.3 * burstStrength) * smoothstep(0.0, 0.6, distClamped);
    scaledOffset += depthPush;

    vec2 warpedUV = handleUVBounds(center + scaledOffset);
    vec4 warpedTexel = texture2D(tDiffuse, warpedUV);

    float borderMask = getHardBoundaryMask(center + scaledOffset);

    float pulse = pow(max(0.0, 1.0 - distClamped * 2.1), 4.0);
    float wave = max(0.0, sin(baseAngle * (6.0 + ribbonTwist * 1.5) - progress * 18.0 + distClamped * 24.0));
    float streaks = pow(max(0.0, cos(baseAngle * (8.0 + ribbonTwist) + progress * 10.0)), 4.0);
    float radialShock = 1.0 - smoothstep(0.05, 0.65, distClamped + inv * 0.25);

    float energyField = inv * (pulse * (1.5 + burstStrength) + wave * inv * 1.4 + streaks * inv * 0.9 + radialShock * burstStrength);

    vec3 colorA = vec3(0.08, 0.2, 0.8);
    vec3 colorB = vec3(0.45, 0.05, 0.85);
    vec3 colorC = vec3(0.55, 0.9, 1.0);
    float hueMix = clamp(0.5 + 0.5 * sin(baseAngle * 2.5 + progress * 12.0), 0.0, 1.0);
    vec3 energyTint = mix(colorA, colorB, hueMix);
    energyTint = mix(energyTint, colorC, clamp(pulse * 1.5, 0.0, 1.0));

    vec3 glow = energyTint * energyField * burstStrength * 0.8;
    float corona = pow(max(0.0, 1.0 - distClamped * 1.2), 6.0) * (0.5 + inv);
    vec3 coronaColor = mix(colorC, vec3(1.0), clamp(pulse * 1.2, 0.0, 1.0)) * corona;
    glow += coronaColor;

    float release = smoothstep(0.0, 0.4, progress);
    vec3 baseReveal = warpedTexel.rgb * mix(0.12, 1.0, release);
    vec3 energyComposite = baseReveal + glow * borderMask;

    float restore = smoothstep(0.55, 1.0, progress);
    vec3 finalRGB = mix(energyComposite, texel.rgb, restore);
    finalRGB = clamp(finalRGB, 0.0, 1.0);

    float energyAlpha = warpedTexel.a * borderMask;
    float finalAlpha = mix(energyAlpha, texel.a, restore);

    return vec4(finalRGB, finalAlpha);
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