exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float blockCount; // = 7.0 [3.0, 10.0] // 横向区块数量
uniform float sweepWidth; // = 0.15 [0.05, 0.3] // 扫光宽度
uniform float blurStrength; // = 0.02 [0.005, 0.05] // 初始横向模糊强度
uniform float rgbOffset; // = 0.005 [0.001, 0.02] // RGB分离最大偏移量
uniform vec4 neonColor1; // = vec4(1.0, 0.2, 0.8, 1.0) // 紫粉霓虹色
uniform vec4 neonColor2; // = vec4(0.2, 0.8, 1.0, 1.0) // 冰蓝霓虹色
uniform float delayPerBlock; // = 0.1 [0.05, 0.2] // 相邻区块触发延迟

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    // 缓出曲线，实现扫光先快后慢的运动效果
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    // 动画完成时直接返回原图
    if (progress >= 1.0) {
        return texel;
    }
    
    // 计算当前所属区块索引（从下到上编号0~blockCount-1）
    float blockIndex = floor(vUv.y * blockCount);
    float totalDelay = (blockCount - 1.0) * delayPerBlock;
    float delay = blockIndex * delayPerBlock;
    
    // 计算当前区块的本地动画进度
    float localProgress = clamp((progress - delay) / (1.0 - totalDelay), 0.0, 1.0);
    float p = tween(localProgress);
    
    // 计算扫光位置：奇数区块左→右，偶数区块右→左
    bool isOdd = mod(blockIndex, 2.0) == 1.0;
    float sweepPos = isOdd ? 
        p * (1.0 + sweepWidth) - sweepWidth * 0.5 : 
        1.0 - p * (1.0 + sweepWidth) + sweepWidth * 0.5;
    
    // 计算扫光区域蒙版
    float sweepMask = 1.0 - smoothstep(0.0, sweepWidth * 0.5, abs(vUv.x - sweepPos));
    
    // 计算当前帧的效果参数（随进度衰减）
    float currentBlur = blurStrength * (1.0 - p) / ratio;
    float currentOffset = rgbOffset * (1.0 - p) / ratio;
    float brightness = 1.0 + 0.9 * (1.0 - p);
    
    // 横向模糊采样+RGB分离
    vec4 finalTexel = vec4(0.0);
    float totalWeight = 0.0;
    // 5点加权横向模糊采样
    for (int i = -2; i <= 2; i++) {
        float blurOffset = float(i) * currentBlur;
        vec2 sampleUV = vec2(vUv.x + blurOffset, vUv.y);
        sampleUV = handleUVBounds(sampleUV);
        
        // RGB通道分离采样
        float r = texture2D(tDiffuse, sampleUV + vec2(currentOffset, 0.0)).r;
        float g = texture2D(tDiffuse, sampleUV).g;
        float b = texture2D(tDiffuse, sampleUV - vec2(currentOffset, 0.0)).b;
        float a = texture2D(tDiffuse, sampleUV).a;
        
        // 高斯加权，中心权重更高
        float weight = 1.0 - abs(float(i)) / 3.0;
        finalTexel += vec4(r, g, b, a) * weight;
        totalWeight += weight;
    }
    finalTexel /= totalWeight;
    
    // 应用亮度调整
    finalTexel.rgb *= brightness;
    
    // 混合霓虹扫光效果
    float neonGradientPos = isOdd ? 
        (vUv.x - sweepPos + sweepWidth * 0.5) / sweepWidth : 
        (sweepPos - vUv.x + sweepWidth * 0.5) / sweepWidth;
    vec4 neonColor = mix(neonColor1, neonColor2, clamp(neonGradientPos, 0.0, 1.0));
    finalTexel.rgb = mix(finalTexel.rgb, neonColor.rgb, sweepMask * (1.0 - p) * 0.5);
    
    // 透明度随进度提升
    finalTexel.a *= p;
    
    return finalTexel;
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