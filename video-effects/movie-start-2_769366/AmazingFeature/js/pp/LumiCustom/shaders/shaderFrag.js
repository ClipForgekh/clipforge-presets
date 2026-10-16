exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float sliceHeight; // = 0.18 [0.05, 0.5] // 第一阶段结束时的切片高度
uniform float edgeSoftness; // = 0.002 [0.0, 0.02] // 边缘柔和度
uniform float settleScaleStart; // = 1.03 [1.0, 1.1] // 收尾阶段初始缩放
uniform float settleOffsetY; // = 0.02 [-0.1, 0.1] // 收尾阶段初始Y偏移

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float p1 = 0.3;
    float p2 = 0.75;

    float width = 0.0;
    float height = 0.0;
    float settleT = 0.0;

    if (p < p1) {
        float t = p / p1;
        float e = 1.0 - pow(1.0 - t, 3.0);
        width = e;
        height = mix(0.0, sliceHeight, e);
    } else if (p < p2) {
        float t = (p - p1) / (p2 - p1);
        float e = 1.0 - pow(1.0 - t, 2.0);
        width = 1.0;
        height = mix(sliceHeight, 1.0, e);
    } else {
        width = 1.0;
        height = 1.0;
        float t = (p - p2) / (1.0 - p2);
        settleT = 1.0 - pow(1.0 - t, 2.0);
    }

    float halfW = 0.5 * width;
    float halfH = 0.5 * height;
    vec2 d = abs(vUv - 0.5);
    float maskX = 1.0 - smoothstep(halfW, halfW + edgeSoftness, d.x);
    float maskY = 1.0 - smoothstep(halfH, halfH + edgeSoftness, d.y);
    float mask = maskX * maskY;

    float s = mix(settleScaleStart, 1.0, settleT);
    float oy = mix(settleOffsetY, 0.0, settleT);
    vec2 uv = (vUv - 0.5) / s + 0.5 + vec2(0.0, oy);
    uv = handleUVBounds(uv);

    vec4 col = texture2D(tDiffuse, uv);
    return vec4(col.rgb, col.a * mask);
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