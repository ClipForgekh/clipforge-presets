exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float pixelSize; // = 0.05 [0.01, 0.1] // 初始像素块大小
uniform vec3 outlineColor; // = vec3(1.0, 0.0, 0.8) // 荧光粉描边颜色
uniform float spiralTightness; // = 10.0 [5.0, 20.0] // 螺旋路径松紧度
uniform float outlineThickness; // = 0.005 [0.001, 0.02] // 描边厚度

varying vec2 vUv;

float tween(float progress) {
    // 正弦缓出曲线，自然平滑适合短动画
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用step函数实现硬边界裁切，避免缩小时的边缘拉丝效果
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
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

// 爱心距离场基础函数
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
    p.y += 0.45; // 重心偏移修正
    return sdHeart(p) * size;
}

vec4 effect(vec4 texel, float progress) {
    const float PI = 3.14159265;
    const float TWO_PI = 6.2831853;
    const float OUTLINE_PHASE = 0.3; // 轮廓绘制阶段占比
    const float FILL_PHASE = 0.9; // 填充阶段占比
    
    float maxHeartSize = getMaxShapeSize();
    float heartDist = heartSDF(vUv, vec2(0.5), maxHeartSize);
    
    // 阶段1：螺旋绘制心形轮廓
    if (progress <= OUTLINE_PHASE) {
        float spiralProgress = progress / OUTLINE_PHASE;
        vec2 p = getSDFCoordinate(vUv, vec2(0.5));
        float r = length(p);
        float a = atan(p.y, p.x) + PI;
        
        // 螺旋路径判断
        float spiralValue = mod(a + r * spiralTightness, TWO_PI);
        float spiralThreshold = spiralProgress * TWO_PI;
        bool onSpiral = abs(spiralValue - spiralThreshold) < 0.2 && r < spiralProgress * 1.5;
        
        // 心形轮廓判断
        bool onHeartOutline = abs(heartDist) < outlineThickness * (1.0 + spiralProgress * 2.0);
        
        if (onSpiral && onHeartOutline) {
            // 像素化描边
            vec2 pixelUV = floor(vUv / pixelSize) * pixelSize + pixelSize * 0.5;
            float pixelMask = step(0.0, pixelSize - length(vUv - pixelUV));
            return vec4(outlineColor * pixelMask, 1.0);
        }
        return vec4(0.0, 0.0, 0.0, 1.0);
    }
    // 阶段2：向内填充+清晰度提升
    else if (progress <= FILL_PHASE) {
        float fillProgress = (progress - OUTLINE_PHASE) / (FILL_PHASE - OUTLINE_PHASE);
        float fillThreshold = maxHeartSize * (1.0 - fillProgress);
        
        // 仅显示填充区域
        if (heartDist > fillThreshold) {
            return vec4(0.0, 0.0, 0.0, 1.0);
        }
        
        // 像素大小随填充进度减小
        float currentPixelSize = pixelSize * (1.0 - fillProgress * 0.95);
        vec2 pixelUV = floor(vUv / currentPixelSize) * currentPixelSize + currentPixelSize * 0.5;
        pixelUV = handleUVBounds(pixelUV);
        vec4 pixelatedTexel = texture2D(tDiffuse, pixelUV);
        
        // 描边效果（当前填充边界）
        bool isOutline = abs(heartDist - fillThreshold) < outlineThickness;
        if (isOutline) {
            return vec4(mix(pixelatedTexel.rgb, outlineColor, 0.8), 1.0);
        }
        
        return pixelatedTexel;
    }
    // 阶段3：特效消失，恢复原图
    else {
        float finalProgress = (progress - FILL_PHASE) / (1.0 - FILL_PHASE);
        float outlineAlpha = 1.0 - finalProgress;
        float currentPixelSize = pixelSize * 0.05 * (1.0 - finalProgress);
        
        // 最后阶段像素化逐渐消失
        if (currentPixelSize > 0.001) {
            vec2 pixelUV = floor(vUv / currentPixelSize) * currentPixelSize + currentPixelSize * 0.5;
            pixelUV = handleUVBounds(pixelUV);
            vec4 pixelatedTexel = texture2D(tDiffuse, pixelUV);
            bool isOutline = abs(heartDist) < outlineThickness * outlineAlpha;
            return vec4(mix(pixelatedTexel.rgb, outlineColor, outlineAlpha * 0.3 * float(isOutline)), 1.0);
        }
        
        return texel;
    }
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