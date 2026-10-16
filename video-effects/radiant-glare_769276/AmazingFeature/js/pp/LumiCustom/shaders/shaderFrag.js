exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float flareIntensity; // = 1.2 [0.0, 2.5] // 镜头光晕强度
uniform float overexposure; // = 1.0 [0.0, 2.0] // 起始过曝强度
uniform float residualStrength; // = 0.6 [0.0, 1.5] // 残留辉光强度
uniform float ghostStrength; // = 0.35 [0.0, 1.0] // 鬼影强度
uniform vec2 flareCenter; // = vec2(0.52, 0.46) // 光源中心位置
uniform vec3 coreColor; // = vec3(1.0, 0.98, 0.93) // 核心暖白色
uniform vec3 glowColor; // = vec3(1.0, 0.80, 0.52) // 衰减金色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 q = uv - center;
    if (ratio > 1.0) q.y /= ratio;
    else q.x *= ratio;
    return q;
}

float gaussian(float d, float r) {
    float rr = max(r * r, 1e-5);
    return exp(-(d * d) / rr);
}

float ghostBlob(vec2 uv, vec2 c, float r) {
    vec2 p = getSDFCoordinate(uv, c);
    return gaussian(length(p), r);
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    vec2 pc = getSDFCoordinate(vUv, flareCenter);
    float dist = length(pc);
    float ang = atan(pc.y, pc.x);

    float coreRadius = mix(0.015, 0.42, strength);
    float core = gaussian(dist, coreRadius) * 1.5;
    float halo = gaussian(dist, coreRadius * 2.4) * 0.9;
    float rays = pow(max(0.0, cos(ang * 6.0)), 8.0) * gaussian(dist, mix(0.18, 0.95, strength)) * 0.5;

    vec2 axis = normalize(vec2(0.5, 0.5) - flareCenter + vec2(1e-4, -1e-4));
    vec2 g1 = flareCenter + axis * 0.18;
    vec2 g2 = flareCenter + axis * 0.33;
    vec2 g3 = flareCenter - axis * 0.22;

    float ghosts = 0.0;
    ghosts += ghostBlob(vUv, g1, 0.07) * 0.55;
    ghosts += ghostBlob(vUv, g2, 0.10) * 0.40;
    ghosts += ghostBlob(vUv, g3, 0.06) * 0.45;
    ghosts *= ghostStrength * strength * strength;

    float mainBloom = (core + halo + rays) * flareIntensity * strength;
    float residual = gaussian(dist, 0.10) * residualStrength * pow(strength, 0.45);
    float totalBloom = mainBloom + ghosts + residual;

    float veil = overexposure * pow(strength, 1.1);
    float lift = clamp(veil + totalBloom * 0.38, 0.0, 1.0);

    vec3 tint = mix(glowColor, coreColor, smoothstep(0.0, 0.75, strength));
    vec3 base = texel.rgb;
    vec3 lifted = mix(base, vec3(1.0), lift);
    vec3 outRgb = lifted + tint * totalBloom * (0.65 + 0.35 * strength);

    return vec4(clamp(outRgb, 0.0, 1.0), texel.a);
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