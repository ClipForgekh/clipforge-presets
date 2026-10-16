exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float maxBlurStep; // = 0.2 [0.05, 0.5] // 最大纵向模糊步长
uniform float maxStretch; // = 3.5 [1.5, 5.0] // 最大纵向拉伸倍数
uniform float maxGlow; // = 2.5 [1.0, 4.0] // 最大金属发光强度
uniform vec4 metalColor; // = vec4(0.4, 0.6, 1.0, 1.0) // 银蓝色金属基色

varying vec2 vUv;

float tween(float progress) {
    // 中度缓出曲线，平衡冲击力和平滑度
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：硬边界裁切避免边缘拉丝
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;
    
    // 进度接近1时直接返回原图优化性能
    if (effectStrength < 0.001) return texel;
    
    // 计算纵向采样步长，适配分辨率
    float stepY = maxBlurStep * effectStrength / ratio;
    
    // 纵向拉伸变换
    vec2 baseUV = vUv;
    baseUV.y = 0.5 + (baseUV.y - 0.5) * (1.0 + effectStrength * (maxStretch - 1.0));
    
    // 添加流体拉丝扭曲效果
    float distort = sin(baseUV.x * 20.0 + progress * 3.14159) * 0.02 * effectStrength;
    baseUV.y += distort;
    
    // 纵向高斯采样模拟模糊效果
    vec4 sumColor = vec4(0.0);
    float totalWeight = 0.0;
    float kernel[9];
    kernel[0] = 1.0; kernel[1] = 2.0; kernel[2] = 4.0; kernel[3] = 8.0; kernel[4] = 16.0;
    kernel[5] = 8.0; kernel[6] = 4.0; kernel[7] = 2.0; kernel[8] = 1.0;
    
    for(int i = -4; i <= 4; i++) {
        float weight = kernel[i + 4];
        vec2 sampleUV = handleUVBounds(baseUV + vec2(0.0, float(i) * stepY));
        sumColor += texture2D(tDiffuse, sampleUV) * weight;
        totalWeight += weight;
    }
    
    vec4 sampledColor = sumColor / totalWeight;
    
    // 混合金属发光效果
    vec4 glowTint = metalColor * maxGlow * effectStrength;
    vec3 blendedColor = mix(glowTint.rgb, sampledColor.rgb, 1.0 - effectStrength * 0.8);
    
    // 汇聚阶段透明度控制
    float alpha = 1.0 - effectStrength * 0.9;
    
    // 应用边界遮罩
    float mask = getHardBoundaryMask(baseUV);
    
    return vec4(blendedColor, alpha * mask * sampledColor.a);
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