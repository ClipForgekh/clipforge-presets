exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform vec3 plasmaColor; // = vec3(0.35, 0.75, 1.0) // 等离子主色
uniform float glowIntensity; // = 1.2 [0.0, 3.0] // 发光强度
uniform float arcDensity; // = 7.0 [2.0, 16.0] // 电弧密度

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    if (p < 0.5) {
        float x = 2.0 * p;
        return 0.5 * (1.0 - sqrt(1.0 - x * x));
    } else {
        float x = -2.0 * p + 2.0;
        return 0.5 * (sqrt(1.0 - x * x) + 1.0);
    }
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

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

vec4 effect(vec4 texel, float p) {
    const float blankStart = 0.90;
    if (p >= blankStart) return vec4(0.0);

    vec2 center = vec2(0.5, 0.5);
    vec2 sp = getSDFCoordinate(vUv, center);
    float dist = length(sp);
    float ang = atan(sp.y, sp.x);
    float maxR = getMaxShapeSize() * 0.5;

    float local = p / blankStart;
    float expandEnd = 0.72;

    if (local < expandEnd) {
        float ep = local / expandEnd;
        float appear = smoothstep(0.01, 0.08, local);

        float radius = maxR * ep;
        float ringWidth = mix(0.14, 0.035, ep);
        float ring = exp(-abs(dist - radius) / max(ringWidth, 0.0001));

        float arcWave = 0.5 + 0.5 * sin(arcDensity * ang + 60.0 * dist - 18.0 * local + sin(ang * 9.0) * 2.0);
        float arcs = pow(arcWave, 3.0);

        float core = exp(-dist / max(0.03 + 0.22 * (1.0 - ep), 0.0001));
        float engulf = smoothstep(0.55, 1.0, ep);

        float glow = (ring * (0.8 + 1.2 * arcs) + core * 0.6 + engulf * 0.9) * glowIntensity * appear;
        glow = clamp(glow, 0.0, 1.5);

        vec3 plasmaTint = texel.rgb * 0.35 + plasmaColor * 1.15;
        vec3 col = mix(texel.rgb, plasmaTint, clamp(glow * 0.75, 0.0, 1.0));
        col += plasmaColor * ring * arcs * 0.35 * appear;
        col = clamp(col, 0.0, 1.0);
        return vec4(col, texel.a);
    } else {
        float ip = (local - expandEnd) / (1.0 - expandEnd);

        float shrinkR = maxR * (1.0 - ip);
        float mask = 1.0 - smoothstep(shrinkR, shrinkR + 0.012, dist);

        float pull = ip * 0.92;
        vec2 uv = center + (vUv - center) * (1.0 - pull);
        uv = handleUVBounds(uv);
        vec4 pulled = texture2D(tDiffuse, uv);

        float spark = exp(-dist / max(0.008 + 0.12 * (1.0 - ip), 0.0001)) * (1.0 - ip);
        vec3 col = mix(pulled.rgb, plasmaColor * 1.3, 0.4 * ip) + plasmaColor * spark * 1.6;
        col = clamp(col, 0.0, 1.0);

        float alpha = pulled.a * mask * (1.0 - ip);
        return vec4(col, alpha);
    }
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