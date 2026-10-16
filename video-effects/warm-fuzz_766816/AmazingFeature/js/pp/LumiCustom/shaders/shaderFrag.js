exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义参数
uniform float maxBlur; // = 10.0 [1.0, 20.0] // 最大模糊强度
uniform vec3 glowColor; // = vec3(1.0, 0.7, 0.2) // 强光颜色（暖黄色）
uniform float glowIntensity; // = 2.0 [0.5, 5.0] // 最大光效强度
uniform float initialScaleOffset; // = 0.1 [0.0, 0.3] // 初始缩放偏移量

varying vec2 vUv;

// 缓入曲线，实现先缓慢后快速的消散节奏
float tween(float progress) {
    return pow(progress, 3.0);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 伪噪声函数，用于生成动态光效纹理
float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
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

vec4 effect(vec4 texel, float progress) {
    // 计算动态缩放
    float scale = 1.0 + (1.0 - progress) * initialScaleOffset;
    vec2 scaledUV = 0.5 + (vUv - 0.5) * scale;
    scaledUV = handleUVBounds(scaledUV);
    
    // 计算当前模糊强度并采样模糊纹理
    float currentBlur = (1.0 - progress) * maxBlur;
    vec4 blurredTex = gaussianBlur(tDiffuse, scaledUV, currentBlur, ratio);
    
    // 生成动态流动的光效噪声
    vec2 noiseUV = vUv * 8.0 + vec2(0.0, (1.0 - progress) * 4.0);
    float noiseVal = noise(noiseUV) * noise(noiseUV * 2.0 + 0.5);
    
    // 计算光效强度并混合
    float currentGlow = (1.0 - progress) * glowIntensity * noiseVal;
    vec3 finalColor = blurredTex.rgb + glowColor * currentGlow;
    
    return vec4(finalColor, blurredTex.a);
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