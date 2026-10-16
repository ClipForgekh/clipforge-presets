exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float spiralDensity; // = 1.0 [0.5, 2.0]
uniform float particleAmount; // = 1.0 [0.2, 2.0]
uniform float blurStrength; // = 1.0 [0.0, 2.0]

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

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec2 hash22(vec2 p) {
    float n = hash12(p);
    return vec2(n, hash12(p + n + 7.13));
}

vec3 adjustSaturation(vec3 color, float sat) {
    float l = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(l), color, sat);
}

vec4 fastBlur9(sampler2D tex, vec2 uv, float radius) {
    vec2 stepSize = vec2(0.0018 * radius, 0.0018 * radius / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0, -1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  0.0))) * 4.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  1.0))) * 1.0;
    return c / 16.0;
}

float particleLayer(vec2 uv, float grid, float minR, float maxR, float seed, float gate) {
    vec2 guv = uv * grid;
    vec2 id = floor(guv);
    vec2 fv = fract(guv) - 0.5;
    vec2 rnd = hash22(id + seed);
    vec2 pos = (rnd - 0.5) * 0.75;
    float rr = mix(minR, maxR, rnd.x);
    float d = length(fv - pos);
    float p = 1.0 - smoothstep(rr, rr * 1.9, d);
    float exist = step(1.0 - gate, rnd.y);
    return p * exist;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    float baseScale = mix(0.97, 1.0, p);
    vec2 uvRaw = 0.5 + (vUv - 0.5) / baseScale;
    vec2 uv = handleUVBounds(uvRaw);
    float borderMask = getHardBoundaryMask(uvRaw);

    vec4 src = texture2D(tDiffuse, uv);

    float brightness = mix(0.15, 1.0, p);
    float saturation = mix(0.45, 1.0, p);
    vec3 baseColor = adjustSaturation(src.rgb * brightness, saturation);

    vec2 start = vec2(0.82, 0.82);
    vec2 center = vec2(0.5, 0.5);
    vec2 head = mix(start, center, p);

    vec2 sp = getSDFCoordinate(vUv, head);
    float r = length(sp);
    float a = atan(sp.y, sp.x);
    float spin = p * (8.0 + 6.0 * spiralDensity) * 6.2831853;
    float arm = 0.5 + 0.5 * cos(a * (5.0 + 2.0 * spiralDensity) + r * (38.0 + 10.0 * spiralDensity) - spin);

    float coverRadius = mix(0.06, 1.35, p);
    float cover = 1.0 - smoothstep(coverRadius - 0.22, coverRadius + 0.02, r);
    float sweep = smoothstep(0.62, 0.98, arm) * cover;

    vec4 blurC = fastBlur9(tDiffuse, uv, 5.0 * blurStrength);
    float blurMask = sweep * strength;
    vec3 layeredBase = mix(baseColor, blurC.rgb, clamp(blurMask, 0.0, 1.0));

    float layerGate1 = 0.22 * particleAmount;
    float layerGate2 = 0.30 * particleAmount;
    float layerGate3 = 0.42 * particleAmount;

    float l1 = particleLayer(vUv + vec2(0.11, -0.03) * p, 48.0, 0.10, 0.18, 11.7, layerGate1);
    float l2 = particleLayer(vUv + vec2(0.07, 0.02) * p, 86.0, 0.08, 0.14, 27.3, layerGate2);
    float l3 = particleLayer(vUv + vec2(-0.04, 0.05) * p, 150.0, 0.05, 0.09, 49.9, layerGate3);

    float particleFade = strength;
    float particleMask = sweep * particleFade;

    vec3 c1 = vec3(1.0, 0.80, 0.42);
    vec3 c2 = vec3(1.0, 0.86, 0.55);
    vec3 c3 = vec3(1.0, 0.92, 0.70);

    float glow = 3.5 * (1.0 - p) * (1.0 - 0.35 * p);

    vec3 particles = (l1 * c1 + l2 * c2 + l3 * c3) * glow * particleMask;
    vec3 finalRgb = clamp(layeredBase + particles, 0.0, 1.0);

    return vec4(finalRgb, src.a * borderMask);
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