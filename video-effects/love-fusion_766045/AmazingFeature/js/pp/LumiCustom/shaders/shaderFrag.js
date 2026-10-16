exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float heartScale; // = 0.34 [0.12, 0.8] // 单个心形基础尺寸
uniform float edgeBlur; // = 0.008 [0.0005, 0.03] // 心形边缘软化
uniform float stagger; // = 0.55 [0.0, 0.9] // 心形出现的错峰时间
uniform float popStrength; // = 0.18 [0.0, 0.5] // 出现瞬间弹性强度
uniform float rotateStrength; // = 0.35 [0.0, 1.5] // 轻微旋转强度

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

float hash11(float p) {
    return fract(sin(p * 127.1) * 43758.5453123);
}

vec2 hash21(float p) {
    return fract(sin(vec2(p * 127.1, p * 311.7)) * 43758.5453123);
}

float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0) {
        vec2 q = p - vec2(0.25, 0.75);
        return sqrt(dot(q, q)) - sqrt(2.0) * 0.25;
    }
    float a = dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00));
    float b = dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50));
    return sqrt(min(a, b)) * sign(p.x - p.y);
}

float heartMaskRot(vec2 uv, vec2 center, float size, float angle, float blurEdge) {
    vec2 p = getSDFCoordinate(uv, center);
    float s = sin(angle);
    float c = cos(angle);
    p = mat2(c, -s, s, c) * p;
    p /= max(size, 0.0001);
    p.y += 0.45;
    float d = sdHeart(p) * size;
    return 1.0 - smoothstep(-blurEdge, blurEdge, d);
}

vec4 effect(vec4 texel, float p) {
    const int HEARTS = 8;
    float reveal = 0.0;

    for (int i = 0; i < HEARTS; i++) {
        float fi = float(i);
        vec2 rnd = hash21(fi + 3.7);
        vec2 center = vec2(0.12 + rnd.x * 0.76, 0.10 + rnd.y * 0.80);

        float order = hash11(fi + 19.3);
        float delay = order * stagger;
        float lp = clamp((p - delay) / max(1.0 - stagger, 0.0001), 0.0, 1.0);

        float pop = sin(lp * 3.14159265) * (1.0 - lp) * popStrength;
        float grow = lp + pop;

        float size = heartScale * (0.55 + hash11(fi + 7.1) * 0.9) * grow;
        float angle = (hash11(fi + 41.2) - 0.5) * rotateStrength * (1.0 - lp);

        float m = heartMaskRot(vUv, center, size, angle, edgeBlur);
        reveal = max(reveal, m);
    }

    reveal = max(reveal, p);
    reveal = clamp(reveal, 0.0, 1.0);

    vec3 col = mix(vec3(0.0), texel.rgb, reveal);
    return vec4(col, texel.a * reveal);
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