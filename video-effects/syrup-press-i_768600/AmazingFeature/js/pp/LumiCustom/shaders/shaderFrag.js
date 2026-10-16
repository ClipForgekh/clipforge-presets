exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float bookThickness; // = 0.12 [0.02, 0.4] // 闭合状态下书脊占比
uniform float pageBendStrength; // = 0.18 [0.0, 0.5] // 页面弯曲幅度
uniform float bounceStrength; // = 0.08 [0.0, 0.2] // 末端弹性幅度

varying vec2 vUv;

// 用归一化的progress动态生成归一化的变速曲线,模拟效果强度的关键帧变化
float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用step函数实现硬边界裁切，避免缩小时的边缘拉丝效果
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 分辨率适配函数：将UV坐标转换为等比例坐标，确保几何图形在不同屏幕比例下不变形
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

// 【强制使用】坐标空间转换函数：确保形状在不同屏幕比例下不变形
vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

// 【强制使用】获取能包裹整个屏幕的最大形状尺寸
float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

// 圆形距离场函数
float circleSDF(vec2 uv, vec2 center, float radius) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    return length(aspectUV - center) - radius;
}

// 矩形距离场函数
float rectSDF(vec2 uv, vec2 center, vec2 size) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    vec2 dist = abs(aspectUV - center) - size * 0.5;
    return length(max(dist, 0.0)) + min(max(dist.x, dist.y), 0.0);
}

// 爱心距离场函数
float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0)
        return sqrt(dot(p - vec2(0.25, 0.75), p - vec2(0.25, 0.75))) - sqrt(2.0) / 4.0;
    return sqrt(min(dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00)),
                    dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50)))) * sign(p.x - p.y);
}

// 【强制使用】分辨率适配的爱心SDF
float heartSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p /= max(size, 0.0001);
    p.y += 0.45;
    return sdHeart(p) * size;
}

// 【强制使用】生成爱心蒙版的函数
float generateHeartMask(vec2 uv, vec2 center, float size, float blurEdge) {
    float dist = heartSDF(uv, center, size);
    return 1.0 - smoothstep(-blurEdge, blurEdge, dist);
}

// 【强制使用】创建能包裹整个屏幕的爱心遮罩
float createFullScreenHeartMask(vec2 uv, vec2 center, float progress) {
    float maxSize = getMaxShapeSize();
    float acceleratedProgress = progress * progress;
    float currentSize = acceleratedProgress * maxSize;
    float dist = heartSDF(uv, center, currentSize);
    return smoothstep(0.01, -0.01, dist);
}

// 【强制使用】计算屏幕短边的相对尺寸
float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction;
    else return fraction * ratio;
}

// 【强制使用】计算屏幕长边的相对尺寸
float getLongSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction * ratio;
    else return fraction;
}

vec4 effect(vec4 texel, float progress) {
    float appearPhase = clamp(progress * 1.5, 0.0, 1.0);
    float appearScale = mix(0.05, 1.0, appearPhase);
    vec2 uv = 0.5 + (vUv - 0.5) * appearScale;

    float bounceWindow = clamp((progress - 0.6) / 0.4, 0.0, 1.0);
    float bounce = sin(bounceWindow * 3.14159265) * bounceStrength * (1.0 - progress);
    float easedOpen = clamp(progress + bounce, 0.0, 1.0);

    float width = mix(bookThickness, 1.0, easedOpen);
    uv.x = 0.5 + (uv.x - 0.5) * width;

    vec2 aspectUV = getAspectCorrectUV(vUv);
    float yProfile = sin((aspectUV.y - 0.5) * 3.14159265);
    float spread = 1.0 - clamp(abs(vUv.x - 0.5) * 2.0, 0.0, 1.0);
    float swing = 1.0 - easedOpen;
    float swingAmount = swing * spread;
    float side = mix(-1.0, 1.0, step(0.5, vUv.x));

    uv.y = 0.5 + (uv.y - 0.5) * (1.0 - 0.15 * swingAmount);
    uv.x += pageBendStrength * (1.0 - easedOpen) * yProfile * spread;
    uv.x += swingAmount * side * 0.08 * (0.5 - abs(yProfile));

    float flutter = (1.0 - progress) * 0.015 * sin((aspectUV.y * 18.0 + progress * 9.0) * 3.14159265);
    uv.x += flutter * spread;

    uv = handleUVBounds(uv);
    vec4 warped = texture2D(tDiffuse, uv);

    float effectStrength = 1.0 - progress;
    float spineHighlight = exp(-pow(abs(vUv.x - 0.5) / max(bookThickness, 0.001), 1.35)) * 0.6;
    float coverShadow = smoothstep(0.3, 0.0, abs(vUv.x - 0.5)) * 0.4;
    float pageSheen = yProfile * 0.2 * spread;

    float lighting = 1.0 + effectStrength * (spineHighlight + pageSheen - coverShadow);
    vec3 shaded = clamp(warped.rgb * lighting, 0.0, 1.0);
    vec3 finalRgb = mix(warped.rgb, shaded, effectStrength);

    float borderMask = getHardBoundaryMask(vUv);
    return vec4(finalRgb, warped.a * borderMask);
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