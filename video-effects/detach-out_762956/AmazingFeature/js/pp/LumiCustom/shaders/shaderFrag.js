exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float maxRotation; // = -2.094 [-3.1416, 0.0] // 最大旋转角度（弧度，逆时针为负，默认-120度）
uniform float displacementStrength; // = 1.5 [0.5, 3.0] // 位移强度
uniform float maxBlurRadius; // = 8.0 [2.0, 15.0] // 最大模糊半径（像素）
uniform float minScale; // = 0.9 [0.5, 1.0] // 最小缩放比例

varying vec2 vUv; // 纹理坐标

// 缓动函数：三次方缓入，实现匀加速运动效果
float tween(float progress) {
    return pow(progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用step函数实现硬边界裁切，避免缩小时的边缘拉丝效果
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 方向模糊函数：沿指定方向实现动态模糊
vec4 directionBlur(sampler2D tex, vec2 uv, vec2 dir, float radius, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    
    // 适配屏幕比例，确保模糊方向在不同比例下一致
    dir.y /= ratio;
    if(length(dir) < 0.001) {
        dir = vec2(1.0, 0.0);
    }
    dir = normalize(dir) * radius * 0.001; // 转换为UV坐标单位
    
    // 5点采样，权重中间高两边低
    for(int i = -2; i <= 2; i++) {
        float offset = float(i);
        float weight = 1.0 - abs(offset) / 3.0;
        vec2 sampleUV = handleUVBounds(uv + dir * offset);
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float t = progress;
    
    // 计算变换参数
    float currentAngle = t * maxRotation;
    vec2 currentDisplacement = vec2(1.0, 1.0) * t * displacementStrength;
    float currentScale = 1.0 - t * (1.0 - minScale);
    float currentBlurRadius = t * maxBlurRadius;
    
    // 构造旋转矩阵
    float s = sin(currentAngle);
    float c = cos(currentAngle);
    
    // UV变换：居中->缩放->旋转->位移->还原
    vec2 transformedUV = vUv - vec2(0.5);
    transformedUV *= currentScale;
    transformedUV = vec2(
        transformedUV.x * c - transformedUV.y * s,
        transformedUV.x * s + transformedUV.y * c
    );
    transformedUV += currentDisplacement;
    transformedUV += vec2(0.5);
    
    // 应用方向模糊
    vec4 blurredColor = directionBlur(tDiffuse, transformedUV, currentDisplacement, currentBlurRadius, ratio);
    
    // 边界遮罩+淡出
    float boundaryMask = getHardBoundaryMask(transformedUV);
    float alpha = 1.0 - t;
    
    return vec4(blurredColor.rgb, blurredColor.a * boundaryMask * alpha);
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