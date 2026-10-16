exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform vec2 revealCenter; // = vec2(0.5, 0.5) // 展开中心
uniform float sliceMinWidth; // = 0.04 [0.0, 0.2] // 初始垂直切片最小宽度
uniform float sliceMinHeight; // = 0.2 [0.05, 1.0] // 初始垂直切片最小高度
uniform float edgeSoftness; // = 0.0005 [0.0, 0.01] // 遮罩柔边范围
uniform float settleOvershoot; // = 0.03 [0.0, 0.1] // 最终阶段缩放余波

varying vec2 vUv;

// 进度曲线：保持线性，分阶段内使用自定义缓动
float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

float rectSDF(vec2 uv, vec2 center, vec2 size) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    vec2 dist = abs(aspectUV - center) - size * 0.5;
    return length(max(dist, 0.0)) + min(max(dist.x, dist.y), 0.0);
}

float easeOutCubic(float t) {
    float inv = 1.0 - t;
    return 1.0 - inv * inv * inv;
}

float easeOutQuad(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

vec4 effect(vec4 texel, float progress) {
    const float stage1End = 0.3;
    const float stage2End = 0.75;

    float activation = smoothstep(0.0, 0.02, progress);

    float p1 = stage1End > 0.0 ? clamp(progress / stage1End, 0.0, 1.0) : 1.0;
    float widthFactor = mix(sliceMinWidth, 1.0, easeOutCubic(p1));
    widthFactor = max(widthFactor * activation, 1e-6);

    float p2 = stage2End > stage1End ? clamp((progress - stage1End) / (stage2End - stage1End), 0.0, 1.0) : 1.0;
    float heightFactor = mix(sliceMinHeight, 1.0, easeOutCubic(p2));
    heightFactor = max(heightFactor * activation, 1e-6);

    float p3 = clamp((progress - stage2End) / (1.0 - stage2End), 0.0, 1.0);
    float settleEase = easeOutQuad(p3);
    float settleScale = 1.0 + settleOvershoot * (1.0 - settleEase);

    vec2 scaledUV = revealCenter + (vUv - revealCenter) / settleScale;
    scaledUV = handleUVBounds(scaledUV);
    vec4 color = texture2D(tDiffuse, scaledUV);

    vec2 size = vec2(widthFactor, heightFactor);
    float dist = rectSDF(vUv, revealCenter, size);
    float mask = smoothstep(edgeSoftness, 0.0, dist);

    return color * mask;
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