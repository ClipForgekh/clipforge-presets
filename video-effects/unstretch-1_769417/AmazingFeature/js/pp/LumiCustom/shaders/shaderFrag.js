exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float maxZoom; // = 1.5 [1.0, 2.0] // 起始放大倍率
uniform float maxSlant; // = 0.25 [0.0, 0.5] // 起始水平倾斜偏移（相对宽度）

varying vec2 vUv;

// 线性缓动，确保变换在整个时长内均匀推进
float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float sampleFraction(float p, float f0, float f1, float f2, float f3, float f4) {
    if (p <= 0.0) return f0;
    if (p < 0.25) return mix(f0, f1, p / 0.25);
    if (p < 0.5) return mix(f1, f2, (p - 0.25) / 0.25);
    if (p < 0.75) return mix(f2, f3, (p - 0.5) / 0.25);
    if (p < 1.0) return mix(f3, f4, (p - 0.75) / 0.25);
    return f4;
}

vec4 effect(vec4 texel, float progress) {
    float slantFraction = sampleFraction(progress, 1.0, 0.75, 0.5, 0.25, 0.0);
    float scaleFraction = sampleFraction(progress, 1.0, 0.76, 0.5, 0.24, 0.0);

    float currentSlant = maxSlant * slantFraction;
    float currentScale = 1.0 + (maxZoom - 1.0) * scaleFraction;

    vec2 uv = vUv;
    float signedY = (uv.y - 0.5) * 2.0;
    uv.x = uv.x - signedY * currentSlant;

    vec2 centered = uv - 0.5;
    vec2 scaledUV = centered / currentScale + 0.5;
    scaledUV = handleUVBounds(scaledUV);

    vec4 transformedTexel = texture2D(tDiffuse, scaledUV);
    float borderMask = getHardBoundaryMask(vUv);
    return vec4(transformedTexel.rgb, transformedTexel.a * borderMask);
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