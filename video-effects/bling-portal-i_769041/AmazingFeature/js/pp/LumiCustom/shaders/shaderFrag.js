exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float burstIntensity; // = 1.4 [0.2, 3.0] // 能量爆发强度
uniform float rayCount; // = 30.0 [8.0, 64.0] // 径向光束数量
uniform vec3 energyColor; // = vec3(0.45, 0.78, 1.0) // 能量颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5);
    vec2 sp = getSDFCoordinate(vUv, center);
    float r = length(sp);
    float a = atan(sp.y, sp.x);

    float maxR = length(getSDFCoordinate(vec2(1.0, 1.0), center));
    float t = p;
    float appear = smoothstep(0.05, 0.08, progress);

    float front = t * maxR * 1.03;
    float edgeSoft = mix(0.09, 0.015, t);
    float reveal = (1.0 - smoothstep(front - edgeSoft, front + edgeSoft, r)) * appear;

    float frontBand = exp(-abs(r - front) * mix(90.0, 170.0, t));
    float rays = pow(max(0.0, sin(a * rayCount + r * 36.0 - progress * 30.0)), 7.0);

    vec2 polarCell = vec2(floor((a + 3.14159265) * 24.0), floor((r - front) * 260.0 + progress * 60.0));
    float sparkSeed = hash21(polarCell);
    float sparks = step(0.93, sparkSeed) * exp(-abs(r - front) * 220.0);

    float shock1 = exp(-abs(r - front) * 120.0);
    float shock2 = exp(-abs(r - front * 0.72) * 140.0) * (1.0 - t * 0.35);
    float shock3 = exp(-abs(r - front * 0.48) * 160.0) * (1.0 - t * 0.65);

    float burst = (rays * 0.9 + sparks * 1.25) * frontBand + shock1 * 0.65 + shock2 * 0.45 + shock3 * 0.3;
    burst *= burstIntensity * (1.0 - t) * appear;

    float core = exp(-r * 180.0) * smoothstep(0.05, 0.08, progress) * (1.0 - smoothstep(0.20, 0.65, progress)) * 2.2;

    vec3 glow = energyColor * (burst + core);
    vec3 rgb = texel.rgb * reveal + glow;

    float glowAlpha = clamp((burst + core) * 0.9, 0.0, 1.0);
    float alpha = max(texel.a * reveal, glowAlpha * (1.0 - reveal * 0.35));

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