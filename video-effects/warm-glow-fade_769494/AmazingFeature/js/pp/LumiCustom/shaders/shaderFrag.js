exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义参数
uniform float maxBlur; // = 32.0 [10.0, 50.0] // 最大径向模糊强度
uniform float maxWarp; // = 1.2 [0.5, 2.0] // 最大波形扭曲强度
uniform float maxExposure; // = 4.8 [2.0, 6.0] // 最大曝光强度
uniform float maxGlow; // = 2.8 [1.0, 4.0] // 最大暖光发光强度
uniform float maxScale; // = 1.25 [1.1, 1.5] // 最大画面缩放比例
uniform vec3 warmColor; // = vec3(1.0, 0.8, 0.3) // 暖光色调

varying vec2 vUv;

// 缓入快出曲线，符合前期慢后期快的消散节奏
float tween(float progress) {
    return pow(progress, 2.5);
}

// 边界处理函数：clamp留黑避免边缘采样问题
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 适配分辨率的径向模糊函数
vec4 radialBlur(sampler2D tex, vec2 uv, vec2 center, float strength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    const int samples = 8;
    
    for (int i = 0; i < samples; i++) {
        float offset = float(i) / float(samples) * strength;
        vec2 dir = normalize(uv - center);
        
        // 适配屏幕比例，避免模糊方向变形
        if (ratio > 1.0) dir.y /= ratio;
        else dir.x *= ratio;
        
        vec2 sampleUV = uv + dir * offset;
        sampleUV = handleUVBounds(sampleUV);
        float weight = 1.0 - float(i) / float(samples);
        
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    if (progress <= 0.0) return texel;
    
    const vec2 center = vec2(0.5, 0.6); // 模糊和缩放中心点
    const float waveLength = 0.35; // 波形扭曲波长为画面高度35%
    
    // 1. 水平波形扭曲
    vec2 uv = vUv;
    float warpOffset = sin(uv.y * 3.14159265 * 2.0 / waveLength) * progress * maxWarp * 0.01;
    uv.x += warpOffset;
    
    // 2. 中心向外缩放
    float scale = 1.0 + progress * (maxScale - 1.0);
    uv = center + (uv - center) / scale;
    uv = handleUVBounds(uv);
    
    // 3. 径向模糊采样
    float blurStrength = progress * maxBlur * 0.001;
    vec4 blurredColor = radialBlur(tDiffuse, uv, center, blurStrength, ratio);
    
    // 4. 曝光提升
    float exposure = 1.0 + progress * (maxExposure - 1.0);
    blurredColor.rgb *= exposure;
    
    // 5. 暖光发光Screen混合
    float glowStrength = progress * maxGlow;
    vec3 glow = warmColor * glowStrength;
    blurredColor.rgb = 1.0 - (1.0 - blurredColor.rgb) * (1.0 - glow);
    
    // 6. 透明度衰减
    float alpha = 1.0 - progress;
    
    return vec4(blurredColor.rgb, alpha);
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