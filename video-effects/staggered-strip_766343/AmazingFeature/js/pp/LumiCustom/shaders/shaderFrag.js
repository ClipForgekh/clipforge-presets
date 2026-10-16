exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform int sliceCount; // = 12 [4, 24] // 垂直切片数量
uniform float delayPerSlice; // = 0.05 [0.01, 0.1] // 相邻切片启动延迟比例
uniform float maxStretch; // = 2.0 [0.5, 5.0] // 最大垂直拉伸强度
uniform float maxBlur; // = 0.1 [0.01, 0.3] // 最大垂直模糊半径
uniform vec4 neonColor1; // = vec4(1.0, 0.2, 0.8, 1.0) // 霓虹颜色1（粉色）
uniform vec4 neonColor2; // = vec4(0.6, 0.2, 1.0, 1.0) // 霓虹颜色2（紫色）
uniform float maxGlitch; // = 0.02 [0.001, 0.05] // 最大Glitch错位强度
uniform float neonStrength; // = 0.8 [0.1, 2.0] // 霓虹辉光强度

varying vec2 vUv;

// 缓出曲线（Ease-Out）
float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 伪随机函数
float random(float seed) {
    return fract(sin(seed) * 43758.5453123);
}

// 垂直模糊采样
vec4 verticalBlur(sampler2D tex, vec2 uv, float blurRadius) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    float steps = 5.0;
    
    for (float i = -2.0; i <= 2.0; i += 1.0) {
        float weight = 1.0 - abs(i) / 3.0;
        vec2 offset = vec2(0.0, i * blurRadius / steps);
        vec2 sampleUV = handleUVBounds(uv + offset);
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float sliceFloat = float(sliceCount);
    float sliceWidth = 1.0 / sliceFloat;
    
    // 计算当前像素所属切片
    float sliceIndex = floor(vUv.x / sliceWidth);
    float slicePos = fract(vUv.x / sliceWidth); // 切片内坐标 0-1
    
    // 计算切片专属进度（错落延迟）
    float maxTotalDelay = (sliceFloat - 1.0) * delayPerSlice;
    float sliceDelay = sliceIndex * delayPerSlice;
    float localProgress = clamp((progress - sliceDelay) / (1.0 - maxTotalDelay), 0.0, 1.0);
    float tweenedProgress = tween(localProgress);
    float effectStrength = 1.0 - tweenedProgress;
    
    // 随机Glitch效果（仅在动画过程中偶尔触发）
    float glitchSeed = sliceIndex * 1234.567 + progress * 1000.0;
    float glitchRandom = random(glitchSeed);
    float glitchOffset = (glitchRandom > 0.95) ? (glitchRandom - 0.95) * 2.0 * maxGlitch * effectStrength : 0.0;
    
    // 切片位移：奇数向上，偶数向下
    float isOdd = mod(sliceIndex, 2.0);
    float direction = isOdd > 0.5 ? -1.0 : 1.0;
    float yOffset = direction * effectStrength * 1.2;
    
    // 垂直拉伸计算
    float stretch = effectStrength * maxStretch;
    vec2 sampleUV = vUv;
    sampleUV.x += glitchOffset;
    sampleUV.y = 0.5 + (sampleUV.y - 0.5) / (1.0 + stretch) + yOffset;
    sampleUV = handleUVBounds(sampleUV);
    
    // 垂直模糊采样
    float blurRadius = effectStrength * maxBlur;
    vec4 blurredColor = verticalBlur(tDiffuse, sampleUV, blurRadius);
    
    // 霓虹辉光效果（切片边缘）
    float edgeDistance = min(slicePos, 1.0 - slicePos);
    float neonMask = smoothstep(0.0, 0.1, 0.1 - edgeDistance) * effectStrength * neonStrength;
    vec4 neonColor = mix(neonColor1, neonColor2, vUv.y);
    vec4 neonGlow = neonColor * neonMask;
    
    // 透明度计算：初始30%，最终100%
    float alpha = 0.3 + 0.7 * tweenedProgress;
    
    // 合并效果
    vec4 finalColor = blurredColor + neonGlow;
    finalColor.a *= alpha;
    
    // 进度100%时完全返回原图
    return mix(finalColor, texel, step(1.0, progress));
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