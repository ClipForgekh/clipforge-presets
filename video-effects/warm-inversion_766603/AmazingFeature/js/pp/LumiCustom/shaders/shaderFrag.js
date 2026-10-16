exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float maxBlurStrength; // = 20.0 [1.0, 30.0] // 最大模糊强度
uniform float initialScale; // = 1.2 [1.0, 2.0] // 初始缩放比例
uniform vec4 warmGlowColor; // = vec4(1.0, 0.8, 0.3, 1.0) // 暖光颜色
uniform float maxGlowIntensity; // = 3.0 [0.0, 5.0] // 最大暖光强度
uniform float initialBrightness; // = 2.0 [1.0, 3.0] // 初始亮度
uniform float initialSaturation; // = 1.8 [1.0, 3.0] // 初始饱和度

varying vec2 vUv;

float tween(float progress) {
    // 缓出三次方曲线，符合前快后慢的衰减节奏
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：硬边界裁切避免缩小时的边缘拉丝效果
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
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
    
    float baseStep = 0.001 * blurStrength;
    vec2 stepSize = vec2(baseStep, baseStep / ratio);
    
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

// 调整饱和度函数
vec3 adjustSaturation(vec3 color, float saturation) {
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(gray), color, saturation);
}

// Screen混合模式
vec3 screenBlend(vec3 base, vec3 blend) {
    return 1.0 - (1.0 - base) * (1.0 - blend);
}

vec4 effect(vec4 texel, float progress) {
    float t = tween(progress);
    float invT = 1.0 - t;
    
    // 1. 中心缩放处理
    float currentScale = initialScale - invT * 0.0 + t * (1.0 - initialScale);
    vec2 scaledUV = 0.5 + (vUv - 0.5) * currentScale;
    scaledUV = handleUVBounds(scaledUV);
    
    // 2. 高斯模糊处理
    float currentBlur = invT * maxBlurStrength;
    vec4 blurredColor = gaussianBlur(tDiffuse, scaledUV, currentBlur, ratio);
    
    // 3. 亮度和饱和度调整
    float currentBrightness = 1.0 + invT * (initialBrightness - 1.0);
    float currentSaturation = 1.0 + invT * (initialSaturation - 1.0);
    vec3 adjustedColor = blurredColor.rgb * currentBrightness;
    adjustedColor = adjustSaturation(adjustedColor, currentSaturation);
    
    // 4. 暖光叠加（Screen混合）
    float currentGlow = invT * maxGlowIntensity;
    vec3 glowColor = warmGlowColor.rgb * currentGlow * warmGlowColor.a;
    vec3 finalColor = screenBlend(adjustedColor, glowColor);
    
    // 边界裁切
    float borderMask = getHardBoundaryMask(vUv);
    
    return vec4(finalColor, blurredColor.a * borderMask);
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