exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2]

// 自定义uniform
uniform float impactForce; // = 0.5 [0.1, 1.0] // 控制凹陷的深度和初始冲击力
uniform float elasticity; // = 15.0 [5.0, 30.0] // 控制材质的回弹频率
uniform vec4 glowColor; // = vec4(0.4, 0.8, 1.0, 1.0) // 放射模糊的叠加光色

varying vec2 vUv; // 纹理坐标

vec4 effect(vec4 texel, float progress) {
    // 画面中心
    vec2 center = vec2(0.5);
    
    // 计算当前像素到中心的向量，并根据长宽比修正距离
    vec2 dir = vUv - center;
    float dist = length(dir * vec2(ratio, 1.0));
    
    // 创建一个圆形蒙版，模拟周边被铆钉固定，边缘不受影响，中心受影响最大
    // 范围从中心(0.0)到边缘(0.7左右)
    float mask = smoothstep(0.7, 0.0, dist);
    
    // 物理模拟：从极限凹陷状态(progress=0)回弹到平静状态(progress=1)
    // 使用阻尼振荡公式：Amplitude * decay * cos(freq * t)
    // progress = 0 时，cos(0)=1，位移最大（凹陷）
    float decay = exp(-progress * 4.0); // 随进度指数衰减
    float bounce = cos(progress * elasticity) * decay;
    
    // 计算扭曲后的UV坐标
    // impactForce决定凹陷深度，bounce决定当前时刻的位移量
    // 画面凹陷意味着纹理向中心聚集（类似于放大镜效果的反向），或者向外拉伸
    // 这里模拟“陷下去”的视觉，通常像素会被拉向中心
    vec2 distortedUV = vUv - dir * bounce * impactForce * mask;
    
    // 放射模糊效果
    // 仅在运动剧烈时（decay值较大时）产生模糊
    float blurAmount = 0.05 * decay * mask * impactForce;
    
    vec4 finalColor = vec4(0.0);
    float totalWeight = 0.0;
    
    // 简单的放射模糊采样循环
    // 沿变形方向进行多次采样叠加
    for (float i = 0.0; i < 8.0; i++) {
        float percent = i / 7.0;
        float weight = 1.0 - percent; // 中心样本权重更高
        
        // 在径向方向上偏移采样
        vec2 sampleUV = distortedUV - dir * blurAmount * percent;
        
        // 简单的色散效果（Chromatic Aberration），模拟剧烈冲击下的透镜色差
        vec2 rUV = sampleUV + vec2(0.002, 0.0) * decay;
        vec2 bUV = sampleUV - vec2(0.002, 0.0) * decay;
        
        float r = texture2D(tDiffuse, clamp(rUV, 0.0, 1.0)).r;
        float g = texture2D(tDiffuse, clamp(sampleUV, 0.0, 1.0)).g;
        float b = texture2D(tDiffuse, clamp(bUV, 0.0, 1.0)).b;
        
        finalColor += vec4(r, g, b, 1.0) * weight;
        totalWeight += weight;
    }
    
    finalColor /= totalWeight;
    
    // 叠加光色，随着震动衰减而消失
    // 在初始冲击时混合glowColor
    finalColor = mix(finalColor, glowColor, decay * 0.3 * mask);
    
    return finalColor;
}

void main() {
    // Get the pixel color from both textures
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- Effect Configration ---
    const float fadeInEnd = 0.1;
    const float fadeOutStart = 0.9;

    // 1. Calculate the effect's own progress.
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    vec4 effectColor = effect(texel, effectProgress);

    // 2. Calculate the unified effect strength.
    float fadeInStrength = smoothstep(0.0, fadeInEnd, progress);
    float fadeOutStrength = 1.0 - smoothstep(fadeOutStart, 1.0, progress);
    float effectStrength = min(fadeInStrength, fadeOutStrength);

    // 3. Apply the blending.
    vec4 finalColor = mix(texel, effectColor, effectStrength);

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;