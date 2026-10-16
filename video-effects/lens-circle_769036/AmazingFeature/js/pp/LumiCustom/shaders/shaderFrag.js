exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float burstIntensity; // = 1.2 [0.0, 3.0] // 能量爆发强度
uniform float streakCount; // = 18.0 [6.0, 48.0] // 径向光束数量
uniform vec3 energyColor; // = vec3(0.45, 0.75, 1.0) // 能量颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float cornerDistance() {
    if (ratio > 1.0) return length(vec2(0.5, 0.5 / ratio));
    return length(vec2(0.5 * ratio, 0.5));
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 19.19);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    vec2 center = vec2(0.5);
    vec2 sp = getSDFCoordinate(vUv, center);
    float r = length(sp);
    float ang = atan(sp.y, sp.x);

    float startT = 0.05; // 0.1s / 2.0s
    float q = clamp((p - startT) / (1.0 - startT), 0.0, 1.0);

    float maxR = cornerDistance();
    float revealR = pow(q, 0.78) * maxR;
    float edgeSoft = 0.01 + (1.0 - q) * 0.01;
    float revealMask = 1.0 - smoothstep(revealR - edgeSoft, revealR + edgeSoft, r);

    float coreAppear = smoothstep(0.0, 0.08, q) * (1.0 - smoothstep(0.18, 0.45, q));
    float coreGlow = exp(-r * 90.0) * coreAppear * 2.5 * burstIntensity;

    float ring1 = exp(-abs(r - revealR) * 260.0) * (1.0 - q) * 1.6;
    float ring2 = exp(-abs(r - revealR * 0.78) * 220.0) * smoothstep(0.08, 0.9, q) * (1.0 - q) * 1.2;
    float shock = (ring1 + ring2) * burstIntensity;

    float rayPhase = ang * streakCount + r * 85.0 - q * 16.0;
    float rays = pow(max(0.0, cos(rayPhase)), 10.0) * smoothstep(0.02, 0.9, q);
    rays *= exp(-abs(r - revealR) * 45.0) * (1.0 - q) * 2.0 * burstIntensity;

    float sectors = floor((ang + 3.14159265) / (6.2831853 / (streakCount * 0.7)));
    float rnd = hash12(vec2(sectors, floor(q * 40.0)));
    float sparkBand = exp(-abs(r - revealR) * 120.0);
    float sparks = step(0.84, rnd) * sparkBand * (0.6 + 0.4 * rnd) * (1.0 - q) * 2.2 * burstIntensity;

    vec3 energy = energyColor * (coreGlow + shock + rays + sparks);

    vec3 revealed = texel.rgb * revealMask;
    float alpha = texel.a * revealMask;

    return vec4(clamp(revealed + energy, 0.0, 1.0), clamp(alpha + (coreGlow + shock + rays + sparks) * 0.25, 0.0, 1.0));
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