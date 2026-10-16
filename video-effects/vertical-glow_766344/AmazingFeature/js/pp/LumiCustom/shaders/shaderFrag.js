exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float maxBlurStrength; // = 20.0 [5.0, 50.0] // 最大纵向模糊强度
uniform float maxGlowIntensity; // = 2.0 [0.5, 5.0] // 最大发光强度
uniform vec3 glowColor; // = vec3(0.8, 0.9, 1.0) // 发光颜色，默认白蓝色

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    // 三次缓出曲线，平衡初始冲击力和结尾平滑度
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 纵向方向模糊函数（适配宽高比）
vec4 directionalBlur(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    const int samples = 7;
    // 适配宽高比，确保不同屏幕比例下纵向模糊强度一致
    float stepSize = 0.001 * blurStrength / ratio;
    
    for(int i = -3; i <= 3; i++) {
        float weight = 1.0 - abs(float(i)) / 4.0; // 线性权重，中间采样点权重更高
        vec2 offset = vec2(0.0, float(i) * stepSize);
        vec2 sampleUV = handleUVBounds(uv + offset);
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float t = tween(progress);
    float currentBlur = (1.0 - t) * maxBlurStrength;
    float currentGlow = (1.0 - t) * maxGlowIntensity;
    
    // 纵向方向模糊
    vec4 blurredTexel = directionalBlur(tDiffuse, vUv, currentBlur, ratio);
    
    // 发光效果（Add混合模式）
    vec3 glow = blurredTexel.rgb * glowColor * currentGlow;
    vec3 finalRGB = blurredTexel.rgb + glow;
    
    // 避免颜色过曝
    finalRGB = clamp(finalRGB, 0.0, 1.0);
    
    return vec4(finalRGB, texel.a);
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