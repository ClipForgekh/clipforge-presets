exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float spiralDensity; // = 7.0 [2.0, 16.0]
uniform float glowStrength; // = 1.2 [0.0, 3.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 34.45);
    return fract(p.x * p.y);
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, 0.5);
    vec2 q = getSDFCoordinate(vUv, center);
    float r = length(q);
    float a = atan(q.y, q.x);

    float maxR = getMaxShapeSize() * 0.5;
    float revealR = p * maxR;

    float phase = a + r * spiralDensity - p * 6.2831853;
    float ribbons = exp(-16.0 * pow(abs(sin(phase * 5.0)), 1.25));
    float streams = pow(max(cos(phase * 5.0), 0.0), 2.5);
    float spiralMask = max(ribbons, streams);

    float revealed = smoothstep(0.03, -0.03, r - revealR);
    float front = smoothstep(0.09, 0.0, abs(r - revealR));
    float revealMask = clamp(revealed + front * spiralMask * 0.9, 0.0, 1.0);

    float rise = smoothstep(0.02, 0.35, p);
    float fall = 1.0 - smoothstep(0.55, 0.95, p);
    float glowEnv = max(rise * fall, (1.0 - p) * 0.35);

    float core = exp(-65.0 * r * r) * (1.0 - p);
    float dustRnd = hash21(vUv * vec2(420.0, 310.0) + vec2(p * 17.0, p * 29.0));
    float dust = step(0.985, dustRnd) * front * (0.35 + 0.65 * spiralMask);

    float tint = 0.5 + 0.5 * sin(phase * 1.7 + r * 8.0);
    vec3 auroraColor = mix(vec3(0.25, 1.0, 0.85), vec3(0.95, 0.55, 1.0), tint);

    float auroraLight = (spiralMask * front + core + dust) * glowEnv * glowStrength;
    vec3 scene = texel.rgb * revealMask;
    vec3 glow = auroraColor * auroraLight;

    float finalFlash = (1.0 - smoothstep(0.92, 1.0, p)) * exp(-120.0 * r * r) * 0.15;
    vec3 rgb = scene + glow + vec3(0.7, 0.9, 1.0) * finalFlash;

    float settle = smoothstep(0.96, 1.0, p);
    rgb = mix(rgb, texel.rgb, settle);

    float alpha = max(texel.a * revealMask, auroraLight * 0.35);
    alpha = mix(alpha, texel.a, settle);

    return vec4(clamp(rgb, 0.0, 1.0), clamp(alpha, 0.0, 1.0));
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