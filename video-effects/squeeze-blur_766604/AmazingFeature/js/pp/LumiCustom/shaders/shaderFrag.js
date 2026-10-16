exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float maxVerticalScale; // = 3.0 [1.5, 5.0] // 最大垂直缩放比例
uniform float maxBlurStrength; // = 0.035 [0.01, 0.05] // 最大垂直模糊强度
uniform float maxBrightness; // = 1.2 [1.0, 1.5] // 最大亮度提升幅度
uniform float maxSaturation; // = 1.3 [1.0, 2.0] // 最大饱和度提升幅度

varying vec2 vUv; // 纹理坐标

// 缓入缓出曲线，适配出场动画节奏感
float tween(float progress) {
    return progress < 0.5 ? 2.0 * progress * progress : 1.0 - pow(-2.0 * progress + 2.0, 2.0) * 0.5;
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用step函数实现硬边界裁切，避免缩小时的边缘拉丝效果
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 垂直方向模糊采样函数
vec4 verticalBlur(sampler2D tex, vec2 uv, float blurStrength) {
    vec4 color = vec4(0.0);
    // 9采样点垂直模糊，效果平滑性能优秀
    float totalWeight = 0.0;
    for(int i = -4; i <= 4; i++) {
        float weight = 1.0 - abs(float(i)) / 5.0;
        vec2 sampleUV = uv + vec2(0.0, float(i) * blurStrength);
        sampleUV = handleUVBounds(sampleUV);
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float t = tween(progress);
    
    // 1. 垂直拉伸变换
    float scaleY = 1.0 + t * (maxVerticalScale - 1.0);
    vec2 stretchedUV = vUv;
    stretchedUV.y = 0.5 + (stretchedUV.y - 0.5) * scaleY;
    stretchedUV = handleUVBounds(stretchedUV);
    
    // 2. 垂直模糊处理，适配分辨率
    float currentBlur = t * maxBlurStrength / ratio;
    vec4 blurredColor = verticalBlur(tDiffuse, stretchedUV, currentBlur);
    
    // 3. 亮度提升
    blurredColor.rgb *= 1.0 + t * (maxBrightness - 1.0);
    
    // 4. 饱和度提升
    float gray = dot(blurredColor.rgb, vec3(0.299, 0.587, 0.114));
    blurredColor.rgb = mix(vec3(gray), blurredColor.rgb, 1.0 + t * (maxSaturation - 1.0));
    
    // 5. 透明度渐隐
    float alpha = 1.0 - t;
    
    // 6. 边界裁切避免边缘问题
    float borderMask = getHardBoundaryMask(vUv);
    
    return vec4(blurredColor.rgb, alpha * borderMask);
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
    vec4 effectColor = effect(texel, effectProgress);

    // 2. 直接应用特效（视频动画不需要额外的淡入淡出混合）
    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;