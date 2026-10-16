exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float liftDistance; // = 0.12 [0.0, 0.4] // 初始下方位移距离
uniform float overshootAmount; // = 0.05 [0.0, 0.15] // 末段缩放超调幅度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float t = clamp(p, 0.0, 1.0);

    float baseScale = mix(0.55, 1.0, t);

    float x = clamp((t - 0.75) / 0.25, 0.0, 1.0);
    float overshoot = overshootAmount * sin(3.14159265 * x);
    float scale = baseScale + overshoot;

    vec2 offset = vec2(0.0, (1.0 - t) * liftDistance);

    vec2 uvRaw = (vUv - 0.5 - offset) / max(scale, 0.0001) + 0.5;
    float mask = getHardBoundaryMask(uvRaw);
    vec2 uv = handleUVBounds(uvRaw);

    vec4 color = texture2D(tDiffuse, uv);

    float alphaFade = t;
    return vec4(color.rgb, color.a * alphaFade * mask);
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