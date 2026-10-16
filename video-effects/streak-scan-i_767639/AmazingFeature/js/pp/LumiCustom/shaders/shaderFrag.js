exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform vec3 particleColor; // = vec3(1.0, 0.78, 0.32) // 金色粒子颜色
uniform float glowIntensity; // = 1.2 [0.0, 3.0] // 发光强度
uniform float flowTurbulence; // = 0.06 [0.0, 0.2] // 粒子流扰动强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float noise2(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash12(i);
    float b = hash12(i + vec2(1.0, 0.0));
    float c = hash12(i + vec2(0.0, 1.0));
    float d = hash12(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

vec4 effect(vec4 texel, float p) {
    float e = tween(p);
    float strength = 1.0 - e;

    float flow = -0.25 + e * 1.55;
    float n = noise2(vUv * vec2(16.0, 10.0) + vec2(e * 9.0, e * 3.0));
    float wave = sin(vUv.y * 22.0 + e * 9.0) * 0.5 + sin(vUv.y * 41.0 - e * 7.0) * 0.5;
    float warp = (wave * 0.5 + (n - 0.5)) * flowTurbulence * (0.5 + 0.5 * strength);

    float reveal = 1.0 - smoothstep(flow + warp, flow + 0.22 + warp, vUv.x);
    reveal = clamp(reveal, 0.0, 1.0);

    float front = flow + warp * 0.35;
    float dFront = abs(vUv.x - front);

    float trail = exp(-dFront * 45.0) * (0.35 + 0.65 * n);
    float sparkCell = hash12(floor(vUv * vec2(120.0, 68.0) + e * 70.0));
    float spark = step(0.985 - 0.08 * strength, sparkCell) * exp(-dFront * 85.0);

    vec3 glow = particleColor * (trail * glowIntensity + spark * (1.2 + glowIntensity * 0.4)) * strength;
    vec3 revealed = texel.rgb * reveal;

    vec4 stylized = vec4(clamp(revealed + glow, 0.0, 1.0), texel.a * reveal);
    return mix(stylized, texel, e);
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