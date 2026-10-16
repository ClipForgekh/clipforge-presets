exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float maxBlur; // = 20.0 [1.0, 30.0] // 最大模糊强度
uniform float scaleStrength; // = 0.2 [0.0, 0.5] // 初始缩放增量
uniform vec3 warmColor; // = vec3(1.0, 0.6, 0.2) // 暖光颜色
uniform float maxGlowIntensity; // = 3.0 [0.5, 5.0] // 最大发光强度
uniform float maxBrightness; // = 1.5 [0.3, 2.0] // 最大亮度增量
uniform float maxSaturation; // = 0.8 [0.2, 1.5] // 最大饱和度增量

varying vec2 vUv;

float tween(float progress) {
    // 缓出三次方曲线，前半段衰减快后半段慢，符合需求
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
    
    // 根据屏幕比例调整步长，确保不同比例下模糊效果一致
    float baseStep = 0.001 * blurStrength;
    vec2 stepSize = vec2(baseStep, baseStep / ratio);
    
    // 5x5采样
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
    float t = tween(progress);
    float effectIntensity = 1.0 - t;
    
    // 1. 中心缩放处理
    float scale = 1.0 + scaleStrength * effectIntensity;
    vec2 uv = 0.5 + (vUv - 0.5) * scale;
    uv = handleUVBounds(uv);
    
    // 2. 高斯模糊处理
    float currentBlur = maxBlur * effectIntensity;
    vec4 blurredTex = gaussianBlur(tDiffuse, uv, currentBlur, ratio);
    
    // 3. 亮度饱和度调整
    float brightness = 1.0 + maxBrightness * effectIntensity;
    float saturation = 1.0 + maxSaturation * effectIntensity;
    
    // 亮度调整
    vec3 color = blurredTex.rgb * brightness;
    
    // 饱和度调整
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    color = mix(vec3(gray), color, saturation);
    
    // 4. 暖光Screen混合
    float glowIntensity = maxGlowIntensity * effectIntensity;
    vec3 glow = warmColor * glowIntensity;
    // Screen混合模式公式：1 - (1 - a) * (1 - b)
    vec3 finalColor = 1.0 - (1.0 - color) * (1.0 - glow);
    
    return vec4(finalColor, blurredTex.a);
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