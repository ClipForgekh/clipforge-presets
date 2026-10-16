exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float heartCount; // = 12.0 [3.0, 30.0] // 心形碎片数量
uniform float maxPixelSize; // = 0.08 [0.01, 0.2] // 最大像素块尺寸
uniform float heartEdgeBlur; // = 0.02 [0.001, 0.1] // 心形边缘模糊度

varying vec2 vUv;

// 伪随机函数
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float tween(float progress) {
    // 缓出二次曲线，适合短动画，变化均匀自然
    return 1.0 - pow(1.0 - progress, 2.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用step函数实现硬边界裁切
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 坐标空间转换函数：确保形状在不同屏幕比例下不变形
vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

// 获取能包裹整个屏幕的最大形状尺寸
float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

// 爱心距离场函数
float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0)
        return sqrt(dot(p - vec2(0.25, 0.75), p - vec2(0.25, 0.75))) - sqrt(2.0) / 4.0;
    return sqrt(min(dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00)),
                    dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50)))) * sign(p.x - p.y);
}

// 分辨率适配的爱心SDF
float heartSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p /= max(size, 0.0001);
    p.y += 0.45; // 重心偏移修正
    return sdHeart(p) * size;
}

// 生成爱心蒙版的函数
float generateHeartMask(vec2 uv, vec2 center, float size, float blurEdge) {
    float dist = heartSDF(uv, center, size);
    return 1.0 - smoothstep(-blurEdge, blurEdge, dist);
}

vec4 effect(vec4 texel, float progress) {
    float t = tween(progress);
    float maxSize = getMaxShapeSize();
    
    // 计算像素化尺寸，progress=0时最大，progress=1时为0
    float pixelSize = (1.0 - t) * maxPixelSize;
    vec2 pixelUV = vUv;
    if (pixelSize > 0.0001) {
        pixelUV = floor(vUv / pixelSize) * pixelSize + pixelSize * 0.5;
    }
    pixelUV = handleUVBounds(pixelUV);
    vec4 pixelColor = texture2D(tDiffuse, pixelUV);
    
    // 计算心形遮罩总和
    float totalMask = 0.0;
    int count = int(floor(heartCount));
    for (int i = 0; i < 30; i++) {
        if (i >= count) break;
        
        // 生成随机心形位置和出现延迟
        vec2 randSeed = vec2(float(i) * 0.123, float(i) * 0.456);
        vec2 heartCenter = vec2(random(randSeed), random(randSeed + 0.1));
        float delay = random(randSeed + 0.2) * 0.6; // 随机延迟0-0.6秒
        float heartProgress = clamp(t - delay, 0.0, 1.0) / (1.0 - delay);
        
        // 计算当前心形大小
        float currentSize = heartProgress * maxSize;
        float heartMask = generateHeartMask(vUv, heartCenter, currentSize, heartEdgeBlur);
        totalMask += heartMask;
    }
    totalMask = clamp(totalMask, 0.0, 1.0);
    
    // 边界裁切处理
    float borderMask = getHardBoundaryMask(vUv);
    return vec4(pixelColor.rgb, pixelColor.a * totalMask * borderMask);
}

void main() {
    // 获取纹理像素颜色
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- 特效配置 ---
    // 视频动画专用配置，不影响其他模块
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    // 1. 计算特效自身的进度
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);

    // 2. 直接应用特效（视频动画不需要额外的淡入淡出混合）
    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;