exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float glowStrength; // = 1.6 [0.0, 4.0]
uniform float ringWidth; // = 0.02 [0.004, 0.08]
uniform float sparkDensity; // = 72.0 [8.0, 160.0]
uniform vec3 energyColor; // = vec3(0.35, 0.85, 1.0)

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 pt = uv - center;
    if (ratio > 1.0) pt.y /= ratio;
    else pt.x *= ratio;
    return pt;
}

float waveReveal(float dn, float r, float edge) {
    return 1.0 - smoothstep(r - edge, r + edge, dn);
}

float waveRing(float dn, float r, float w) {
    float x = (dn - r) / max(w, 0.0001);
    return exp(-x * x);
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.00001) return vec4(0.0);

    const float detonateAt = 0.075;
    float waveEnabled = step(detonateAt, p);
    float tRaw = clamp((p - detonateAt) / (1.0 - detonateAt), 0.0, 1.0);

    vec2 center = vec2(0.5);
    vec2 sp = getSDFCoordinate(vUv, center);
    vec2 corner = getSDFCoordinate(vec2(1.0, 1.0), center);
    float maxDist = length(corner);
    float dn = length(sp) / max(maxDist, 0.0001);
    float ang = atan(sp.y, sp.x);

    float reveal = 0.0;
    float energy = 0.0;

    float t0 = clamp((tRaw - 0.00) / 1.00, 0.0, 1.0);
    float r0 = pow(t0, 1.55) * 1.22;
    float ring0 = waveRing(dn, r0, ringWidth);
    float spark0 = pow(max(0.0, sin(ang * sparkDensity + t0 * 36.0)), 10.0);
    reveal = max(reveal, waveReveal(dn, r0, 0.020));
    energy += ring0 * (0.60 + 0.40 * spark0);

    float t1 = clamp((tRaw - 0.10) / 0.90, 0.0, 1.0);
    float r1 = pow(t1, 1.40) * 1.24;
    float ring1 = waveRing(dn, r1, ringWidth * 0.9);
    float spark1 = pow(max(0.0, cos(ang * (sparkDensity * 0.85) - t1 * 42.0)), 9.0);
    reveal = max(reveal, waveReveal(dn, r1, 0.017));
    energy += ring1 * (0.56 + 0.44 * spark1);

    float t2 = clamp((tRaw - 0.22) / 0.78, 0.0, 1.0);
    float r2 = pow(t2, 1.28) * 1.27;
    float ring2 = waveRing(dn, r2, ringWidth * 0.8);
    float spark2 = pow(max(0.0, sin(ang * (sparkDensity * 1.15) + t2 * 50.0)), 8.0);
    reveal = max(reveal, waveReveal(dn, r2, 0.015));
    energy += ring2 * (0.52 + 0.48 * spark2);

    float t3 = clamp((tRaw - 0.34) / 0.66, 0.0, 1.0);
    float r3 = pow(t3, 1.18) * 1.30;
    float ring3 = waveRing(dn, r3, ringWidth * 0.72);
    float spark3 = pow(max(0.0, cos(ang * (sparkDensity * 1.35) - t3 * 58.0)), 7.0);
    reveal = max(reveal, waveReveal(dn, r3, 0.013));
    energy += ring3 * (0.48 + 0.52 * spark3);

    reveal *= waveEnabled;
    reveal = max(reveal, smoothstep(0.80, 0.96, tRaw));
    reveal = clamp(reveal, 0.0, 1.0);

    float nearEndFill = smoothstep(0.85, 1.0, p);
    reveal = max(reveal, nearEndFill);

    float glowFade = (1.0 - tRaw) * (1.0 - tRaw);
    vec3 glow = energyColor * energy * glowStrength * glowFade * waveEnabled;

    vec3 rgb = texel.rgb * reveal + glow;
    rgb = clamp(rgb, 0.0, 1.0);
    float alpha = texel.a * reveal;

    if (p >= 0.99999) return texel;
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