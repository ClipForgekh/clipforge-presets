exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float particleDensity; // = 170.0 [60.0, 320.0]
uniform float turbulenceStrength; // = 0.22 [0.0, 0.6]
uniform float blurStrength; // = 0.018 [0.0, 0.05]
uniform vec4 inkColor; // = vec4(0.18, 0.20, 0.22, 1.0)
uniform float glowStrength; // = 0.35 [0.0, 1.0]

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
    return vec2(n, hash12(p + n + 7.13));
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    float a = hash12(i);
    float b = hash12(i + vec2(1.0, 0.0));
    float c = hash12(i + vec2(0.0, 1.0));
    float d = hash12(i + vec2(1.0, 1.0));
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

vec2 flowField(vec2 p, float t) {
    float n1 = noise(p * 3.0 + vec2(0.0, t * 0.7));
    float n2 = noise(p * 3.0 + vec2(9.7, -t * 0.6));
    vec2 v = vec2(n1 - 0.5, n2 - 0.5);
    if (ratio > 1.0) v.y /= ratio;
    else v.x *= ratio;
    return v;
}

vec4 motionBlur(sampler2D tex, vec2 uv, vec2 vel, float radius) {
    vec2 dir = normalize(vel + vec2(1e-5));
    vec2 stepv = dir * radius;
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv - stepv * 2.0)) * 0.12;
    c += texture2D(tex, handleUVBounds(uv - stepv * 1.0)) * 0.23;
    c += texture2D(tex, handleUVBounds(uv)) * 0.30;
    c += texture2D(tex, handleUVBounds(uv + stepv * 1.0)) * 0.23;
    c += texture2D(tex, handleUVBounds(uv + stepv * 2.0)) * 0.12;
    return c;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 1.0) return texel;

    float strength = 1.0 - p;

    float grid = max(8.0, particleDensity);
    vec2 cell = floor(vUv * grid);
    vec2 cellUV = (cell + 0.5) / grid;

    vec2 rnd = hash22(cell);
    vec2 randDir = normalize(rnd - 0.5 + vec2(1e-4));
    float spread = (0.52 + 0.45 * (1.0 - rnd.x)) * strength;

    vec2 turb = flowField(cellUV * 2.7 + rnd * 5.3, p) * turbulenceStrength * strength * 2.4;
    vec2 swirl = vec2(-(vUv.y - 0.5), (vUv.x - 0.5)) * (0.22 * strength * (0.5 + rnd.y));
    vec2 offset = randDir * spread + turb + swirl;

    vec2 srcUV = handleUVBounds(cellUV + offset);
    vec2 vel = srcUV - cellUV;

    float blurR = blurStrength * strength * 2.0;
    vec4 movingTexel = motionBlur(tDiffuse, srcUV, vel, blurR);

    float luma = dot(movingTexel.rgb, vec3(0.299, 0.587, 0.114));
    float inkNoise = noise(cellUV * 18.0 + rnd * 13.0 + p * 2.0);
    vec3 inkBase = mix(vec3(luma * 0.55), inkColor.rgb, 0.75);
    float glow = glowStrength * strength * (0.5 + 0.5 * inkNoise);
    vec3 particleRgb = clamp(inkBase + glow * inkColor.rgb * 0.6, 0.0, 1.0);

    vec2 gv = fract(vUv * grid) - 0.5;
    float r = mix(0.80, 0.52, p);
    float particleMask = smoothstep(r, r - 0.22, length(gv));
    particleMask = mix(1.0, particleMask, smoothstep(0.35, 0.95, p));

    vec3 inkLayer = mix(particleRgb, movingTexel.rgb * 0.65 + inkColor.rgb * 0.20, 0.35);
    inkLayer = mix(inkLayer, texel.rgb, p * p);

    float reveal = smoothstep(0.22, 1.0, p);
    vec3 finalRgb = mix(inkLayer * particleMask, texel.rgb, reveal);

    return vec4(clamp(finalRgb, 0.0, 1.0), texel.a);
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