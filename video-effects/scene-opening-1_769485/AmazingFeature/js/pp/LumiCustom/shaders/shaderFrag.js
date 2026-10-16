exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float slitWidth; // = 0.012 [0.001, 0.08] // 中心细缝总宽度
uniform float asymmetry; // = 1.1 [1.0, 1.3] // 右侧相对左侧速度倍率
uniform float edgeSoftness; // = 0.0015 [0.0, 0.02] // 分割边缘柔和度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec4 effect(vec4 texel, float p) {
    float halfSlit = max(0.0005, slitWidth * 0.5);
    float leftWidth = halfSlit;
    float rightWidth = halfSlit;

    const float t1End = 0.2;
    const float t2End = 0.625;

    if (p < t1End) {
        leftWidth = halfSlit;
        rightWidth = halfSlit;
    } else if (p < t2End) {
        float t = (p - t1End) / (t2End - t1End);
        float g = smoothstep(0.0, 1.0, t);

        float leftEnd = 0.45;
        float rightEnd = min(0.5, leftEnd * asymmetry);

        leftWidth = mix(halfSlit, leftEnd, g);
        rightWidth = mix(halfSlit, rightEnd, g);
    } else {
        float t = (p - t2End) / (1.0 - t2End);
        float g = smoothstep(0.0, 1.0, t);

        float leftStart = 0.45;
        float rightStart = min(0.5, leftStart * asymmetry);

        leftWidth = mix(leftStart, 0.5, g);
        rightWidth = mix(rightStart, 0.5, g);
    }

    float d = vUv.x - 0.5;

    float leftMask = 1.0 - smoothstep(leftWidth, leftWidth + edgeSoftness, -d);
    float rightMask = 1.0 - smoothstep(rightWidth, rightWidth + edgeSoftness, d);

    float sideLeft = step(d, 0.0);
    float mask = mix(rightMask, leftMask, sideLeft);

    return vec4(texel.rgb, texel.a * clamp(mask, 0.0, 1.0));
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