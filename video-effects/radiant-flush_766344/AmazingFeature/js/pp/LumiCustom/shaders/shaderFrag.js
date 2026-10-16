exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform参数
uniform float maxBlurStrength; // = 25.0 [5.0, 50.0] // 最大模糊强度
uniform float maxExposure; // = 3.0 [1.0, 5.0] // 最大曝光强度
uniform float maxSaturation; // = 2.0 [1.0, 3.0] // 最大饱和度
uniform float maxGlowStrength; // = 4.0 [1.0, 8.0] // 最大暖光强度
uniform float maxNoiseStrength; // = 0.8 [0.1, 1.5] // 最大噪声强度
uniform vec3 glowColor; // = vec3(1.0, 0.6, 0.2) // 暖光颜色（橙黄色）

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    // 缓出曲线：前期衰减快后期慢，符合强光消散的人眼感知规律
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

// 随机噪声生成函数
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress; // progress=0时效果最强，progress=1时无效果
    
    // 1. 高斯模糊效果
    float currentBlur = effectStrength * maxBlurStrength;
    vec4 blurredTex = gaussianBlur(tDiffuse, vUv, currentBlur, ratio);
    
    // 2. 曝光调整
    vec3 exposedColor = blurredTex.rgb * (1.0 + effectStrength * maxExposure);
    
    // 3. 饱和度调整
    float currentSaturation = 1.0 + effectStrength * (maxSaturation - 1.0);
    float gray = dot(exposedColor, vec3(0.299, 0.587, 0.114));
    vec3 saturatedColor = mix(vec3(gray), exposedColor, currentSaturation);
    
    // 4. 暖光柔光Add混合
    vec3 glow = glowColor * effectStrength * maxGlowStrength;
    vec3 glowedColor = saturatedColor + glow;
    
    // 5. 叠加颗粒噪声
    float noise = rand(vUv) * effectStrength * maxNoiseStrength;
    vec3 finalColor = glowedColor + noise;
    
    // 确保颜色在合法范围
    finalColor = clamp(finalColor, 0.0, 1.0);
    
    return vec4(finalColor, texel.a);
}

void main() {
    // 获取纹理像素颜色
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- 特效配置 ---
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    // 1. 计算特效自身的进度
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);

    // 2. 直接应用特效
    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;