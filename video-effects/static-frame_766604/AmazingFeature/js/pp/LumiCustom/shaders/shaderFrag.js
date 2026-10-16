exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float particleDensity; // = 0.72 [0.2, 1.0] // 粒子密度
uniform float flowStrength; // = 1.0 [0.5, 2.0] // 聚拢流动强度
uniform vec3 inkColor; // = vec3(0.26, 0.17, 0.10) // 焦茶色水墨
uniform vec3 glowColor; // = vec3(0.45, 0.30, 0.18) // 淡赭石暖光

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
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

float fbm(vec2 p) {
    float v = 0.0;
    float a = 0.5;
    v += a * noise(p); p *= 2.02; a *= 0.5;
    v += a * noise(p); p *= 2.03; a *= 0.5;
    v += a * noise(p); p *= 2.01; a *= 0.5;
    v += a * noise(p);
    return v;
}

vec4 effect(vec4 texel, float p) {
    float inv = 1.0 - p;

    vec2 suv = vUv - 0.5;
    if (ratio > 1.0) suv.y /= ratio;
    else suv.x *= ratio;

    float r = length(suv);
    float dEdge = min(min(vUv.x, 1.0 - vUv.x), min(vUv.y, 1.0 - vUv.y));

    float front = p * 0.5 * flowStrength;
    float width = mix(0.085, 0.028, p);
    float edgeBand = exp(-pow((dEdge - front) / max(width, 0.0001), 2.0) * 2.6);

    vec2 nUv1 = vec2(vUv.x * 260.0, vUv.y * (260.0 / max(ratio, 0.0001)));
    vec2 nUv2 = vec2(vUv.x * 120.0, vUv.y * (120.0 / max(ratio, 0.0001)));
    float n1 = fbm(nUv1 + vec2(p * 10.0, -p * 7.0));
    float n2 = fbm(nUv2 + vec2(-p * 6.0, p * 5.0));

    float particles = smoothstep(1.0 - particleDensity, 1.0, n1) * edgeBand;
    float trails = smoothstep(0.35, 0.95, n2 * edgeBand + edgeBand * 0.55);

    float centerRadius = p * 0.78;
    float centerInk = smoothstep(centerRadius + 0.12, centerRadius - 0.08, r);

    float inkCoverage = clamp(centerInk * 0.95 + trails * 0.55 + particles * 0.85, 0.0, 1.0);

    float dissolve = smoothstep(0.78, 1.0, p);
    float inkVisible = inkCoverage * (1.0 - dissolve);

    float revealBoost = smoothstep(0.55, 0.95, p) * 0.35;
    float reveal = clamp(inkCoverage + revealBoost, 0.0, 1.0);

    float paperN = fbm(vec2(vUv.x * 180.0, vUv.y * (180.0 / max(ratio, 0.0001))));
    float paperPhase = smoothstep(0.80, 0.90, p) * (1.0 - smoothstep(0.93, 1.0, p));
    vec3 paperTex = (paperN - 0.5) * vec3(0.10, 0.09, 0.08) * paperPhase;

    vec3 revealedColor = texel.rgb + paperTex;
    vec3 baseColor = mix(vec3(0.0), revealedColor, reveal);

    vec3 inkTint = mix(inkColor, glowColor, clamp(particles * 0.9 + trails * 0.25, 0.0, 1.0));
    vec3 color = baseColor + inkTint * inkVisible * (0.35 + 0.65 * particles);

    float alpha = max(texel.a * reveal, inkVisible * 0.9);
    if (p >= 1.0) {
        return texel;
    }
    return vec4(clamp(color, 0.0, 1.0), clamp(alpha, 0.0, 1.0));
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