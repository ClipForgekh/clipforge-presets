exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2]
uniform float maxBlur; // = 0.03 [0.0, 0.12]
uniform float delayStep; // = 0.08 [0.0, 0.2]
uniform vec3 neonColor; // = vec3(1.0, 0.25, 0.95)
uniform float neonStrength; // = 0.9 [0.0, 2.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 sampleVerticalBlur(vec2 uv, float radius) {
    vec2 d = vec2(0.0, radius);
    vec4 c0 = texture2D(tDiffuse, handleUVBounds(uv));
    vec4 c1 = texture2D(tDiffuse, handleUVBounds(uv + d));
    vec4 c2 = texture2D(tDiffuse, handleUVBounds(uv - d));
    vec4 c3 = texture2D(tDiffuse, handleUVBounds(uv + d * 2.0));
    vec4 c4 = texture2D(tDiffuse, handleUVBounds(uv - d * 2.0));
    return c0 * 0.40 + (c1 + c2) * 0.24 + (c3 + c4) * 0.06;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    float bands = 8.0;
    float bandIdx = floor(clamp(vUv.y, 0.0, 0.999999) * bands);
    float localY = fract(vUv.y * bands);

    float distCenter = min(abs(bandIdx - 3.0), abs(bandIdx - 4.0));
    float delay = distCenter * delayStep;
    float localP = clamp((p - delay) / max(1.0 - delay, 0.0001), 0.0, 1.0);

    float moveOffset = (1.0 - localP) * (1.0 + 1.0 / bands);
    vec2 rawUV = vec2(vUv.x, vUv.y + moveOffset);
    float stripMask = getHardBoundaryMask(rawUV);

    float centerFactor = 1.0 - clamp(distCenter / 3.0, 0.0, 1.0);
    float blurRadius = maxBlur * (1.0 - localP) * mix(1.15, 0.65, centerFactor);

    vec4 stripTexel = sampleVerticalBlur(rawUV, blurRadius) * stripMask;

    float edgeDist = min(localY, 1.0 - localY);
    float edgeMask = 1.0 - smoothstep(0.0, 0.08, edgeDist);

    float neon = neonStrength * (1.0 - localP) * edgeMask;
    vec3 edgeGlow = neonColor * neon;

    float gapGlowStrength = (1.0 - stripMask) * (1.0 - p) * (0.25 + 0.35 * edgeMask);
    vec3 gapGlow = vec3(0.74, 0.56, 1.0) * gapGlowStrength;

    vec3 base = stripTexel.rgb;
    vec3 glow = clamp(edgeGlow + gapGlow, 0.0, 1.0);
    vec3 rgb = 1.0 - (1.0 - base) * (1.0 - glow);

    float alpha = clamp(mix(0.3, 1.0, p) * stripMask + gapGlowStrength, 0.0, 1.0);

    return vec4(rgb, alpha);
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