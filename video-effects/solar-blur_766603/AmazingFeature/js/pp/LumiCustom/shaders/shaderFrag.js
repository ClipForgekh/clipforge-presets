exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float maxBlurStrength; // = 25.0 [5.0, 50.0] // 最大模糊强度
uniform float maxGlowIntensity; // = 3.5 [1.0, 5.0] // 最大发光强度
uniform float maxExposure; // = 1.5 [1.1, 2.0] // 最大曝光强度
uniform float maxSaturation; // = 1.8 [1.2, 2.5] // 最大饱和度
uniform vec3 glowColor; // = vec3(1.0, 0.82, 0.3) // 暖光发光颜色

varying vec2 vUv;

float tween(float progress) {
    // 缓出曲线，前快后慢，符合入场动画节奏
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
    
    // 根据屏幕比例调整步长
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
    float effectFactor = 1.0 - progress; // 效果强度因子，progress=0时最强，progress=1时为0
    
    // 微小缩放动画，0.98 -> 1.0
    float scale = 0.98 + 0.02 * progress;
    vec2 uv = 0.5 + (vUv - 0.5) * scale;
    uv = handleUVBounds(uv);
    
    // 高斯模糊处理
    float currentBlur = effectFactor * maxBlurStrength;
    vec4 blurredColor = gaussianBlur(tDiffuse, uv, currentBlur, ratio);
    
    // 曝光调整 1.5 -> 1.0
    float exposure = 1.0 + effectFactor * (maxExposure - 1.0);
    vec3 exposedColor = blurredColor.rgb * exposure;
    
    // 饱和度调整 1.8 -> 1.0
    float saturation = 1.0 + effectFactor * (maxSaturation - 1.0);
    float gray = dot(exposedColor, vec3(0.299, 0.587, 0.114));
    vec3 saturatedColor = mix(vec3(gray), exposedColor, saturation);
    
    // 暖光发光效果，Screen混合
    float glowIntensity = effectFactor * maxGlowIntensity;
    vec3 glow = glowColor * glowIntensity;
    vec3 finalColor = 1.0 - (1.0 - saturatedColor) * (1.0 - glow);
    
    return vec4(finalColor, blurredColor.a);
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