exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float heartSize; // = 0.09 [0.03, 0.2] // 像素心形基础尺寸
uniform float pixelStep; // = 0.08 [0.03, 0.2] // 心形像素块大小
uniform float heartGlow; // = 0.35 [0.0, 1.0] // 心形自发光强度
uniform float zoomStrength; // = 0.05 [0.0, 0.2] // 入场呼吸缩放强度
uniform vec3 heartColor; // = vec3(0.45, 0.5, 1.0) // 蓝紫色心形颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
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
        return length(q) - 0.35355339059;
    }
    float d1 = dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00));
    float d2 = dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50));
    return sqrt(min(d1, d2)) * sign(p.x - p.y);
}

float hash11(float n) {
    return fract(sin(n * 127.1) * 43758.5453123);
}

vec2 hash21(float n) {
    return fract(sin(vec2(n * 91.7, n * 173.3)) * 43758.5453123);
}

float pixelHeartMask(vec2 uv, vec2 center, float size, float px) {
    vec2 p = getSDFCoordinate(uv, center) / max(size, 0.0001);
    p = floor(p / max(px, 0.0001) + 0.5) * max(px, 0.0001);
    p.y += 0.45;
    float d = sdHeart(p);
    return step(d, 0.0);
}

vec4 effect(vec4 texel, float p) {
    float effectStrength = 1.0 - p;

    float zoom = 1.0 + effectStrength * zoomStrength;
    vec2 zoomUV = 0.5 + (vUv - 0.5) / zoom;
    zoomUV = handleUVBounds(zoomUV);
    vec4 sceneTex = texture2D(tDiffuse, zoomUV);

    float baseReveal = smoothstep(0.03, 0.72, p);
    float heartEnvelope = sin(clamp(p / 0.77, 0.0, 1.0) * 3.14159265);

    float heartField = 0.0;
    const int HEART_COUNT = 36;
    for (int i = 0; i < HEART_COUNT; i++) {
        float fi = float(i) + 1.0;
        vec2 rnd = hash21(fi * 3.17);
        vec2 pos = rnd;

        float start = hash11(fi * 5.73) * 0.55;
        float life = mix(0.18, 0.32, hash11(fi * 9.31));
        float lt = (p - start) / life;
        float aliveMask = step(0.0, lt) * step(lt, 1.0);

        float inScale = clamp(lt / 0.4, 0.0, 1.0);
        float outScale = clamp((1.0 - lt) / 0.6, 0.0, 1.0);
        float lifeScale = min(inScale, outScale);

        float yFloat = (hash11(fi * 13.7) - 0.5) * 0.02 * sin(lt * 3.14159265);
        pos.y += yFloat;

        float size = heartSize * mix(0.85, 1.15, hash11(fi * 17.9)) * max(lifeScale, 0.0001);
        float m = pixelHeartMask(vUv, pos, size, pixelStep);
        heartField = max(heartField, m * aliveMask);
    }

    float revealMask = clamp(max(baseReveal, heartField * (0.45 + 0.55 * heartEnvelope)), 0.0, 1.0);

    vec3 revealed = sceneTex.rgb * revealMask;
    float tintAlpha = heartField * heartEnvelope * effectStrength * heartGlow;
    vec3 tinted = revealed + heartColor * tintAlpha;

    float borderMask = getHardBoundaryMask(vUv);
    return vec4(clamp(tinted, 0.0, 1.0), sceneTex.a * borderMask);
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