exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float initialScale; // = 0.55 [0.3, 0.9] // 入场起始缩放
uniform float overshootScale; // = 1.2 [1.0, 1.5] // 弹跳峰值缩放
uniform float reboundScale; // = 0.75 [0.5, 0.95] // 压缩阶段缩放
uniform float verticalOffset; // = 0.45 [0.0, 0.8] // 初始向下位移比例
uniform float fadeInPortion; // = 0.25 [0.05, 0.6] // 淡入持续占比
uniform float settleExponent; // = 1.35 [0.8, 3.0] // 位移衰减指数

varying vec2 vUv;

float tween(float progress) {
    float p = clamp(progress, 0.0, 1.0);
    return 1.0 - pow(1.0 - p, 2.5);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float smoothBlend(float t) {
    t = clamp(t, 0.0, 1.0);
    return t * t * (3.0 - 2.0 * t);
}

float bounceScaleCurve(float p) {
    float segment1End = 0.45;
    float segment2End = 0.7;
    if (p < segment1End) {
        float t = smoothBlend(p / segment1End);
        return mix(initialScale, overshootScale, t);
    } else if (p < segment2End) {
        float t = smoothBlend((p - segment1End) / (segment2End - segment1End));
        return mix(overshootScale, reboundScale, t);
    } else {
        float t = smoothBlend((p - segment2End) / (1.0 - segment2End));
        return mix(reboundScale, 1.0, t);
    }
}

vec4 effect(vec4 texel, float progress) {
    float p = clamp(progress, 0.0, 1.0);
    float scale = bounceScaleCurve(p);
    float safeScale = max(scale, 0.05);

    float inv = 1.0 - p;
    float travel = verticalOffset * pow(inv, settleExponent);
    float travelBounce = sin(p * 3.14159265) * exp(-p * 5.0) * verticalOffset * 0.25;
    float currentOffset = travel - travelBounce;
    vec2 translation = vec2(0.0, currentOffset);

    vec2 center = vec2(0.5);
    vec2 uv = center + (vUv - center) / safeScale + translation;
    vec2 boundedUV = handleUVBounds(uv);

    vec4 sampleColor = texture2D(tDiffuse, boundedUV);
    float fadeEdge = max(fadeInPortion, 0.0001);
    float opacity = smoothstep(0.0, fadeEdge, p);
    float borderMask = getHardBoundaryMask(vUv);

    sampleColor.rgb *= opacity;
    sampleColor.a *= opacity;
    sampleColor *= borderMask;

    return sampleColor;
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