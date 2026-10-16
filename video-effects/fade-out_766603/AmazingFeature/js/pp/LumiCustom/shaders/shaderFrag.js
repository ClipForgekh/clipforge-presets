exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2]
uniform vec3 goldColor; // = vec3(1.0, 0.82, 0.32)
uniform float particleDensity; // = 180.0 [60.0, 360.0]
uniform float explosionStrength; // = 1.2 [0.2, 2.5]
uniform float blurMax; // = 0.02 [0.0, 0.06]
uniform float spiralTightness; // = 1.4 [0.5, 3.0]

varying vec2 vUv;

float tween(float p) {
    return p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec2 hash22(vec2 p) {
    float n = hash21(p);
    return vec2(n, hash21(p + n));
}

mat2 rot(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

vec4 blur9(vec2 uv, float r) {
    if (r <= 0.00001) return texture2D(tDiffuse, uv);
    vec2 stepv = vec2(r, r / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2(-1.0, -1.0))) * 0.075;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2( 0.0, -1.0))) * 0.10;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2( 1.0, -1.0))) * 0.075;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2(-1.0,  0.0))) * 0.10;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.30;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2( 1.0,  0.0))) * 0.10;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2(-1.0,  1.0))) * 0.075;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2( 0.0,  1.0))) * 0.10;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepv * vec2( 1.0,  1.0))) * 0.075;
    return c;
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = vUv;
    vec2 center = vec2(0.5);
    vec2 q = uv - center;
    vec2 qa = q;
    if (ratio > 1.0) qa.y /= ratio; else qa.x *= ratio;
    float r = length(qa);
    float a = atan(qa.y, qa.x);

    float converge = smoothstep(0.0, 0.55, p);
    float explode = smoothstep(0.50, 0.82, p);
    float vanish = smoothstep(0.78, 1.0, p);

    vec2 c0 = uv;
    float d0 = length(c0 - vec2(0.0, 0.0));
    float d1 = length(c0 - vec2(1.0, 0.0));
    float d2 = length(c0 - vec2(0.0, 1.0));
    float d3 = length(c0 - vec2(1.0, 1.0));
    float corner = exp(-10.0 * min(min(d0, d1), min(d2, d3)));
    float cornerBlur = blurMax * (0.25 + 0.75 * p) * (1.0 - explode) * corner;

    float radialBlur = blurMax * 1.8 * smoothstep(0.55, 1.0, p) * (1.0 - vanish * 0.4);
    vec4 bgA = blur9(uv, cornerBlur);
    vec4 bgB = blur9(uv, radialBlur);
    vec4 bg = mix(bgA, bgB, smoothstep(0.5, 0.9, p));

    float darken = 0.85 * smoothstep(0.0, 1.0, p);
    bg.rgb *= (1.0 - darken);

    float spin = p * 9.0 * spiralTightness;
    vec2 flowUv = center + rot(spin + r * 18.0 * (1.0 - explode)) * q;
    flowUv = center + (flowUv - center) * mix(1.8, 0.7 + explosionStrength, converge);
    flowUv += normalize(q + 1e-4) * explode * (0.35 + 0.35 * hash21(floor(uv * 64.0)));

    vec2 g1 = flowUv * particleDensity;
    vec2 id1 = floor(g1);
    vec2 f1 = fract(g1) - 0.5;
    vec2 p1 = hash22(id1) - 0.5;
    float dLarge = length(f1 - p1 * 0.7);
    float largeMask = smoothstep(0.23, 0.0, dLarge) * step(0.35, hash21(id1 + 11.3));

    vec2 g2 = flowUv * (particleDensity * 2.4 + 37.0);
    vec2 id2 = floor(g2);
    vec2 f2 = fract(g2) - 0.5;
    vec2 p2 = hash22(id2 + 13.7) - 0.5;
    float jitter = sin((a * 9.0 + r * 80.0 + hash21(id2) * 6.2831) + p * 40.0) * 0.12;
    float dSmall = length((f2 - p2 * 0.9) + vec2(jitter, -jitter));
    float smallMask = smoothstep(0.09, 0.0, dSmall) * step(0.45, hash21(id2 + 7.1));

    float spiralBand = 0.5 + 0.5 * cos(a * 2.0 + r * 32.0 - p * 24.0 * spiralTightness);
    float cornerToCenter = mix(corner, exp(-8.0 * r), converge);
    float coverage = mix(0.30, 1.0, explode);
    float particleField = (largeMask * 1.2 + smallMask * 0.8) * spiralBand * cornerToCenter;
    particleField *= smoothstep(0.02, coverage, particleField + r * 0.2);

    float glow = mix(0.5, 4.0, converge) * (1.0 - vanish);
    float spark = pow(max(0.0, sin((r * 260.0 - p * 60.0) + hash21(id1) * 6.2831)), 28.0) * largeMask * explode;
    vec3 particleRgb = goldColor * (particleField * glow + spark * 0.8);

    vec3 outRgb = bg.rgb + particleRgb;
    outRgb = clamp(outRgb, 0.0, 1.0);

    float alphaFade = (1.0 - p) * (1.0 - p);
    float particleFade = (1.0 - vanish) * (1.0 - smoothstep(0.88, 1.0, p));
    float outA = clamp(bg.a * alphaFade + particleField * 0.35 * particleFade, 0.0, 1.0);

    if (p <= 0.00001) return texel;
    return vec4(outRgb * (1.0 - vanish), outA * (1.0 - vanish));
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