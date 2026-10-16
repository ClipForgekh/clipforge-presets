exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float flyStrength; // = 1.0 [0.5, 2.0] // 飞掠速度强度
uniform float glowIntensity; // = 0.9 [0.0, 2.0] // 鎏金辉光强度
uniform vec3 goldColor; // = vec3(1.0, 0.78, 0.38) // 鎏金主色

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

float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0) {
        vec2 q = p - vec2(0.25, 0.75);
        return length(q) - 0.35355339;
    }
    float a = dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00));
    float b = dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50));
    return sqrt(min(a, b)) * sign(p.x - p.y);
}

float heartDist3D(vec2 uv, vec2 center, float size, float yAngle) {
    vec2 p = getSDFCoordinate(uv, center);
    float projScale = 0.22 + 0.78 * abs(cos(yAngle));
    p.x /= projScale;
    p /= max(size, 0.0001);
    p.y += 0.45;
    return sdHeart(p) * size;
}

vec2 hash2(float n) {
    return fract(sin(vec2(n, n + 17.13)) * vec2(43758.5453, 22578.1459));
}

vec4 effect(vec4 texel, float p) {
    float t = clamp(p, 0.0, 1.0);

    float holeUnion = 0.0;
    float ringUnion = 0.0;
    float glowUnion = 0.0;

    for (int i = 0; i < 9; i++) {
        float fi = float(i);
        float layer = floor(fi / 3.0);            // 0:远, 1:中, 2:近
        float layerN = layer / 2.0;

        vec2 rnd = hash2(fi * 13.37 + 2.71);
        vec2 startPos = mix(vec2(0.08), vec2(0.92), rnd);

        float speed = mix(0.85, 1.55, layerN) * flyStrength;
        float localT = clamp(t * speed, 0.0, 1.25);

        vec2 driftDir = normalize((startPos - 0.5) + vec2(0.001));
        vec2 center = startPos + driftDir * localT * (0.08 + 0.06 * layerN);

        float baseSize = mix(0.05, 0.11, layerN);
        float size = baseSize * (1.0 + localT * localT * (6.0 + 3.0 * layerN));

        float angle = localT * 6.2831853 + fi * 0.9;
        float d = heartDist3D(vUv, center, size, angle);

        float hole = 1.0 - smoothstep(-0.003, 0.003, d);
        float thickness = 0.0025;
        float ring = 1.0 - smoothstep(thickness, thickness + 0.0045, abs(d));
        float glow = exp(-max(d, 0.0) * 90.0) * (0.35 + 0.25 * layerN);

        holeUnion = max(holeUnion, hole);
        ringUnion = max(ringUnion, ring);
        glowUnion = max(glowUnion, glow);
    }

    float globalReveal = smoothstep(0.70, 1.0, t);
    float revealMask = clamp(max(holeUnion, globalReveal), 0.0, 1.0);

    vec3 color = mix(vec3(0.0), texel.rgb, revealMask);

    float metalFade = 1.0 - smoothstep(0.72, 1.0, t);
    float metalLight = (ringUnion * 1.15 + glowUnion * 0.85) * glowIntensity * metalFade;
    color += goldColor * metalLight * (1.0 - revealMask * 0.85);

    color = clamp(color, 0.0, 1.0);

    float endRestore = smoothstep(0.98, 1.0, t);
    color = mix(color, texel.rgb, endRestore);

    return vec4(color, texel.a);
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