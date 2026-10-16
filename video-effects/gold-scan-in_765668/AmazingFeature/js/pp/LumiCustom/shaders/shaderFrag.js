exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float blurMax; // = 12.0 [0.0, 20.0]
uniform float particleIntensity; // = 1.0 [0.0, 2.0]
uniform float glowIntensity; // = 3.0 [0.0, 5.0]
uniform float trailWidth; // = 0.12 [0.02, 0.35]
uniform float particleScale; // = 180.0 [60.0, 360.0]
uniform float wipeSoftness; // = 0.08 [0.01, 0.25]
uniform vec4 goldColor; // = vec4(1.0, 0.78, 0.28, 1.0)
uniform vec4 highlightColor; // = vec4(1.0, 0.95, 0.55, 1.0)

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec2 hash22(vec2 p) {
    float n = hash12(p);
    return vec2(n, hash12(p + n + 17.17));
}

vec3 adjustSaturation(vec3 c, float s) {
    float l = dot(c, vec3(0.299, 0.587, 0.114));
    return mix(vec3(l), c, s);
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float radius) {
    float stepBase = radius * 0.0015;
    vec2 st = vec2(stepBase, stepBase / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv)) * 0.227027;
    c += texture2D(tex, handleUVBounds(uv + vec2( st.x, 0.0))) * 0.1945946;
    c += texture2D(tex, handleUVBounds(uv - vec2( st.x, 0.0))) * 0.1945946;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  st.y))) * 0.1216216;
    c += texture2D(tex, handleUVBounds(uv - vec2(0.0,  st.y))) * 0.1216216;
    c += texture2D(tex, handleUVBounds(uv + vec2( st.x,  st.y))) * 0.0702703;
    c += texture2D(tex, handleUVBounds(uv + vec2(-st.x,  st.y))) * 0.0702703;
    return c;
}

float particleField(vec2 uv, float p, float bandMask) {
    vec2 dir = normalize(vec2(1.0, 1.0));
    vec2 nor = vec2(-dir.y, dir.x);
    float u = dot(uv, dir);
    float v = dot(uv, nor);

    vec2 grid = vec2(particleScale, particleScale * 0.34);
    vec2 g = vec2(u * grid.x, v * grid.y);
    vec2 id = floor(g);
    vec2 f = fract(g) - 0.5;

    float acc = 0.0;
    float density = 1.0 - p;

    for (int j = -1; j <= 1; j++) {
        for (int i = -1; i <= 1; i++) {
            vec2 o = vec2(float(i), float(j));
            vec2 cid = id + o;
            vec2 rnd = hash22(cid + floor(p * 12.0));
            vec2 pos = o + rnd - 0.5;
            float d = length(f - pos);
            float size = mix(0.16, 0.05, p) * (0.75 + 0.6 * hash12(cid + 3.1));
            float dotMask = 1.0 - smoothstep(size * 0.45, size, d);
            float alive = step(0.35 + 0.55 * (1.0 - density), hash12(cid * 1.37 + 7.3));
            acc += dotMask * alive;
        }
    }

    acc = clamp(acc / 2.2, 0.0, 1.0);
    return acc * bandMask * density * particleIntensity;
}

vec4 effect(vec4 texel, float p) {
    float diag = (vUv.x + vUv.y) * 0.5;
    float front = mix(-0.2, 1.2, p);
    float reveal = 1.0 - smoothstep(front - wipeSoftness, front + wipeSoftness, diag);

    float blurAmount = blurMax * (1.0 - p) * (1.0 - reveal * 0.9);
    vec4 base = gaussianBlur9(tDiffuse, vUv, blurAmount);

    float brightness = mix(0.3, 1.0, p);
    float saturation = mix(1.2, 1.0, p);
    vec3 baseRgb = adjustSaturation(base.rgb * brightness, saturation);

    vec2 dir = normalize(vec2(1.0, 1.0));
    float u = dot(vUv, dir);
    float sweepFront = mix(-0.25, 1.45, p);
    float band = exp(-pow((u - sweepFront) / max(trailWidth, 0.0001), 2.0));

    float particles = particleField(vUv, p, band);
    float glow = band * band * (1.0 - p) * glowIntensity * 0.35;

    vec3 pColor = mix(goldColor.rgb, highlightColor.rgb, clamp(particles * 1.8, 0.0, 1.0));
    vec3 additive = pColor * (particles + glow);

    vec3 rgb = baseRgb * reveal + additive;
    float alpha = texel.a * reveal + clamp((particles + glow) * 0.6, 0.0, 1.0) * (1.0 - p);
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