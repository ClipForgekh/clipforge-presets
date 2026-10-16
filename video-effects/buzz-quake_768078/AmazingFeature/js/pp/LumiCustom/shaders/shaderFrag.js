exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float maxBlurStrength; // = 0.1 [0.01, 0.5] // 最大垂直模糊强度
uniform float maxBrightnessBoost; // = 0.12 [0.01, 0.3] // 最大亮度提升值

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    // 缓入缓出平滑曲线
    return progress < 0.5 ? 2.0 * progress * progress : 1.0 - pow(-2.0 * progress + 2.0, 2.0) * 0.5;
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 垂直模糊函数：实现LumiBoxBlur垂直拖影效果
vec4 verticalBlur(sampler2D tex, vec2 uv, float strength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    float stepSize = strength / ratio;
    
    // 5点采样实现平滑垂直模糊
    for (int i = -2; i <= 2; i++) {
        float weight = 1.0 - abs(float(i)) / 3.0;
        vec2 sampleUV = uv + vec2(0.0, float(i) * stepSize);
        sampleUV = handleUVBounds(sampleUV);
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float totalDuration = 2.8;
    float t = progress * totalDuration;
    
    // 1. 计算垂直模糊强度
    float blurFactor = 0.0;
    if (t >= 0.34 && t <= 1.8) {
        float midBlurTime = 0.34 + (1.8 - 0.34) / 2.0;
        if (t <= midBlurTime) {
            blurFactor = (t - 0.34) / (midBlurTime - 0.34) * maxBlurStrength;
        } else {
            blurFactor = (1.8 - t) / (1.8 - midBlurTime) * maxBlurStrength;
        }
    }
    
    // 2. 计算亮度提升强度
    float brightnessFactor = 0.0;
    if (t >= 0.48 && t <= 2.0) {
        if (t <= 0.82) {
            brightnessFactor = (t - 0.48) / (0.82 - 0.48) * maxBrightnessBoost;
        } else if (t <= 1.42) {
            brightnessFactor = maxBrightnessBoost;
        } else {
            float p = (t - 1.42) / (2.0 - 1.42);
            brightnessFactor = maxBrightnessBoost * (1.0 - 0.5 * (1.0 + sin(p * 3.14159265)));
        }
    }
    
    // 3. 应用垂直模糊
    vec4 blurredTexel = verticalBlur(tDiffuse, vUv, blurFactor, ratio);
    
    // 4. 应用亮度提升
    float centerAxisMask = smoothstep(0.55, 0.45, abs(vUv.x - 0.5)); // 竖井中轴遮罩
    float bCardMask = 0.0;
    
    if (t >= 0.96 && t <= 2.62) {
        float bProgress = 0.0;
        if (t <= 1.66) {
            bProgress = (t - 0.96) / (1.66 - 0.96);
        } else {
            bProgress = (2.62 - t) / (2.62 - 1.66);
        }
        float bSize = 0.34 * bProgress; // 主卡B显示区域大小
        vec2 bUv = abs(vUv - 0.5);
        bUv.y *= ratio;
        bCardMask = smoothstep(bSize + 0.02, bSize, max(bUv.x, bUv.y));
    }
    
    float brightMask = max(centerAxisMask, bCardMask);
    vec3 finalRGB = blurredTexel.rgb + brightMask * brightnessFactor;
    finalRGB = clamp(finalRGB, 0.0, 1.0);
    
    return vec4(finalRGB, blurredTexel.a);
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