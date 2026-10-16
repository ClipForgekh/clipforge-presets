exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float maxBlurStrength; // = 1.0 [0.1, 3.0] // 最大纵向模糊强度
uniform vec4 glowColor; // = vec4(1.0, 0.8, 0.4, 1.0) // 扫光颜色（暖橙白）
uniform float glowIntensity; // = 3.0 [1.0, 5.0] // 扫光最大发光强度
uniform float glowWidth; // = 0.2 [0.05, 0.5] // 扫光条宽度

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    // 二次缓出曲线，实现光效扫动前慢后快的节奏感
    return 1.0 - pow(1.0 - progress, 2.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 纵向方向模糊函数
vec4 directionBlur(sampler2D tex, vec2 uv, float strength) {
    vec4 color = vec4(0.0);
    float stepSize = 0.002 * strength;
    float totalWeight = 0.0;
    
    // 9次采样纵向偏移，线性权重分布
    for(int i = -4; i <= 4; i++) {
        float weight = 1.0 - abs(float(i)) / 4.0;
        vec2 offset = vec2(0.0, float(i) * stepSize);
        vec2 sampleUV = handleUVBounds(uv + offset);
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    // progress=0时完全显示原图，progress=1时完全消失为纯黑
    if (progress <= 0.0) return texel;
    if (progress >= 1.0) return vec4(0.0, 0.0, 0.0, 0.0);
    
    // 1. 计算纵向模糊效果
    float blurStrength = progress * maxBlurStrength;
    vec4 blurredTexel = directionBlur(tDiffuse, vUv, blurStrength);
    
    // 2. 计算水平扫光效果
    float glowPos = progress * 1.5 - 0.25; // 光条从画面底部外移动到顶部外
    float glowMask = smoothstep(glowPos - glowWidth, glowPos, vUv.y) * smoothstep(glowPos + glowWidth, glowPos, vUv.y);
    vec3 glowEffect = glowColor.rgb * glowMask * progress * glowIntensity;
    
    // 3. 混合模糊纹理与光效
    vec3 mixedColor = blurredTexel.rgb + glowEffect;
    mixedColor = clamp(mixedColor, 0.0, 2.5); // 限制最高亮度符合需求
    
    // 4. 控制最终透明度，最后阶段快速降为0实现闭幕
    float alpha = 1.0 - smoothstep(0.8, 1.0, progress);
    mixedColor *= alpha;
    
    return vec4(mixedColor, alpha);
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