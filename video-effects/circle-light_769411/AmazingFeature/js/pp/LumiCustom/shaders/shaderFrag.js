exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float bloomStrength; // = 1.1 [0.0, 2.5]
uniform float particleDensity; // = 0.75 [0.0, 1.5]
uniform float edgeSoftness; // = 0.08 [0.005, 0.25]
uniform vec3 glowColorWhite; // = vec3(1.0, 1.0, 1.0)
uniform vec3 glowColorPink; // = vec3(1.0, 0.78, 0.9)

varying vec2 vUv;

float tween(float p) {
    float base = 1.0 - pow(1.0 - p, 3.0);
    float w = smoothstep(0.58, 0.78, p) * (1.0 - smoothstep(0.78, 1.0, p));
    float settle = 0.03 * sin((p - 0.58) * 24.0) * w;
    return clamp(base + settle, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec2 aspectCoord(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float particleLayer(vec2 uv, float scale, float threshold, float seed) {
    vec2 gv = uv * scale;
    vec2 id = floor(gv);
    vec2 f = fract(gv) - 0.5;
    float rnd = hash21(id + seed);
    vec2 offs = vec2(hash21(id + seed + 17.3), hash21(id + seed + 53.1)) - 0.5;
    vec2 d = f - offs * 0.65;
    float dotShape = smoothstep(0.10, 0.0, length(d));
    float appear = smoothstep(threshold, 1.0, rnd);
    return dotShape * appear;
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, 0.5);
    vec2 pc = aspectCoord(vUv, center);
    float dist = length(pc);

    float strength = 1.0 - p;
    float growth = smoothstep(0.0, 0.82, p);
    float tSettle = max(p - 0.75, 0.0);
    float overshoot = 0.08 * exp(-16.0 * tSettle) * sin(30.0 * tSettle);

    float maxRadius = 1.6;
    float radius = mix(0.035, maxRadius, growth) * (1.0 + overshoot);
    float feather = max(edgeSoftness, 0.001);

    float reveal = 1.0 - smoothstep(radius, radius + feather, dist);

    float coreGlow = exp(-dist * (10.0 - 6.0 * growth)) * bloomStrength * strength;
    float ringWidth = mix(0.09, 0.04, p);
    float ringGlow = exp(-pow((dist - radius) / max(ringWidth, 0.001), 2.0)) * bloomStrength * (0.35 + 0.65 * strength);

    float frontBand = exp(-pow((dist - radius) * 26.0, 2.0));
    float insideMask = smoothstep(radius + feather, radius * 0.35, dist);
    float appearCtrl = smoothstep(0.08, 0.78, p);

    float thr = mix(0.985, 0.90, particleDensity * appearCtrl);
    float particles =
        particleLayer(vUv + vec2(0.013, -0.009), 70.0, thr, 3.1) * 0.55 +
        particleLayer(vUv + vec2(-0.011, 0.014), 95.0, thr + 0.01, 7.7) * 0.35 +
        particleLayer(vUv, 125.0, thr + 0.02, 12.4) * 0.25;

    particles *= (0.35 * insideMask + 0.95 * frontBand) * appearCtrl * strength;

    float pinkMix = smoothstep(0.05, 0.9, growth) * (0.55 + 0.45 * sin(dist * 24.0 + p * 6.2831853));
    vec3 glowColor = mix(glowColorWhite, glowColorPink, clamp(pinkMix, 0.0, 1.0));

    vec3 base = texel.rgb * reveal;
    vec3 glow = glowColor * (coreGlow * 0.35 + ringGlow * 0.6);
    vec3 particleCol = mix(glowColorWhite, glowColorPink, 0.45) * particles * 1.3;

    vec3 rgb = base + glow + particleCol;
    rgb = clamp(rgb, 0.0, 1.0);

    float alpha = texel.a * reveal + clamp(coreGlow * 0.15 + particles * 0.5, 0.0, 1.0);
    alpha = clamp(alpha, 0.0, 1.0);

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