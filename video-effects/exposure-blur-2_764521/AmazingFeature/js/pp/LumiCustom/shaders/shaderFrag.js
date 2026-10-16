exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float maxBlurStrength; // = 20.0 [1.0, 30.0] // 最大模糊强度
uniform float exposureStrength; // = 3.0 [1.5, 5.0] // 初始曝光强度
uniform float saturationStrength; // = 2.0 [1.0, 3.0] // 初始饱和度

varying vec2 vUv;

float tween(float progress) {
    // 缓出三次方曲线，前半段变化快，后半段平缓过渡
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 优化的高斯模糊函数（带分辨率适配）
vec4 gaussianBlur(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    
    // 5x5 高斯模糊核
    float kernel[25];
    kernel[0] = 1.0; kernel[1] = 4.0; kernel[2] = 6.0; kernel[3] = 4.0; kernel[4] = 1.0;
    kernel[5] = 4.0; kernel[6] = 16.0; kernel[7] = 24.0; kernel[8] = 16.0; kernel[9] = 4.0;
    kernel[10] = 6.0; kernel[11] = 24.0; kernel[12] = 36.0; kernel[13] = 24.0; kernel[14] = 6.0;
    kernel[15] = 4.0; kernel[16] = 16.0; kernel[17] = 24.0; kernel[18] = 16.0; kernel[19] = 4.0;
    kernel[20] = 1.0; kernel[21] = 4.0; kernel[22] = 6.0; kernel[23] = 4.0; kernel[24] = 1.0;
    
    // 根据屏幕比例调整步长，确保不同屏幕比例下模糊效果一致
    float baseStep = 0.001 * blurStrength;
    vec2 stepSize = vec2(baseStep, baseStep / ratio);
    
    // 5x5 采样
    for (int i = -2; i <= 2; i++) {
        for (int j = -2; j <= 2; j++) {
            float weight = kernel[(i + 2) * 5 + (j + 2)];
            vec2 offset = vec2(float(i) * stepSize.x, float(j) * stepSize.y);
            vec2 sampleUV = handleUVBounds(uv + offset);
            color += texture2D(tex, sampleUV) * weight;
            totalWeight += weight;
        }
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;
    
    // 计算当前模糊强度
    float currentBlur = maxBlurStrength * effectStrength;
    vec4 blurredColor = gaussianBlur(tDiffuse, vUv, currentBlur, ratio);
    
    // 计算当前曝光值
    float currentExposure = 1.0 + (exposureStrength - 1.0) * effectStrength;
    vec3 exposedColor = blurredColor.rgb * currentExposure;
    
    // 计算当前饱和度
    float currentSaturation = 1.0 + (saturationStrength - 1.0) * effectStrength;
    float gray = dot(exposedColor, vec3(0.299, 0.587, 0.114));
    vec3 saturatedColor = mix(vec3(gray), exposedColor, currentSaturation);
    
    // 约束颜色范围避免溢出
    saturatedColor = clamp(saturatedColor, 0.0, 1.0);
    
    return vec4(saturatedColor, texel.a);
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