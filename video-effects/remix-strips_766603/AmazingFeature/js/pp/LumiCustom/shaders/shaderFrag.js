exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform int bandCount; // = 9 [3, 15] // 光带数量
uniform vec3 neonColor1; // = vec3(1.0, 0.2, 0.8) // 霓虹粉色
uniform vec3 neonColor2; // = vec3(0.6, 0.2, 1.0) // 霓虹紫色
uniform float blurMax; // = 20.0 [5.0, 50.0] // 最大纵向模糊像素值
uniform float bandThickness; // = 0.05 [0.01, 0.2] // 光带厚度
uniform float delayStep; // = 0.1 [0.0, 0.2] // 相邻光带延迟差
uniform float glitchIntensity; // = 0.02 [0.0, 0.1] // 故障闪烁强度

varying vec2 vUv;

// 随机函数（用于故障效果）
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 纵向模糊函数（适配分辨率）
vec4 verticalBlur(sampler2D tex, vec2 uv, float blurPixels) {
    vec4 color = vec4(0.0);
    float step = 1.0 / (1080.0 * ratio); // 基于1080P基准的步长适配
    float blurStrength = blurPixels * step;
    float totalWeight = 0.0;
    
    // 9采样高斯核
    float kernel[9];
    kernel[0] = 0.0285; kernel[1] = 0.0672; kernel[2] = 0.1238; kernel[3] = 0.1789; kernel[4] = 0.2031;
    kernel[5] = 0.1789; kernel[6] = 0.1238; kernel[7] = 0.0672; kernel[8] = 0.0285;
    
    for (int i = -4; i <= 4; i++) {
        float weight = kernel[i + 4];
        vec2 offset = vec2(0.0, float(i) * blurStrength);
        vec2 sampleUV = handleUVBounds(uv + offset);
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    return color / totalWeight;
}

float tween(float progress) {
    // 正弦缓出曲线，自然平滑适合短动画
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

vec4 effect(vec4 texel, float progress) {
    float t = progress;
    if (t >= 1.0) return texel;
    
    // 故障效果（仅在前80%动画显示）
    float glitchFactor = step(t, 0.8) * glitchIntensity;
    vec2 glitchUV = vUv;
    glitchUV.x += random(glitchUV + t) * glitchFactor * 2.0 - glitchFactor;
    glitchUV.y += random(glitchUV * 2.0 + t) * glitchFactor * 0.5 - glitchFactor * 0.25;
    
    // 分割光带区域
    float bands = float(bandCount);
    float bandWidth = 1.0 / bands;
    float bandIndex = floor(glitchUV.x / bandWidth);
    float uvInBand = mod(glitchUV.x, bandWidth) / bandWidth;
    
    // 计算每个光带的独立进度（带延迟）
    float bandDelay = float(int(mod(bandIndex, 2.0))) * delayStep + float(int(bandIndex)) * delayStep * 0.5;
    float bandT = clamp(t * 1.4 - bandDelay, 0.0, 1.0); // 1.4系数适配0.7s完成扫描
    
    // 奇偶光带方向：奇数从下往上，偶数从上往下
    bool isOdd = mod(bandIndex, 2.0) == 1.0;
    float bandPos = isOdd ? bandT : 1.0 - bandT;
    
    // 扫描区域判断
    float scanMask = isOdd ? step(glitchUV.y, bandT) : step(1.0 - bandT, glitchUV.y);
    float scanProgress = isOdd ? clamp(glitchUV.y / max(bandT, 0.001), 0.0, 1.0) : clamp((1.0 - glitchUV.y) / max(bandT, 0.001), 0.0, 1.0);
    
    // 光带霓虹效果
    float bandDist = abs(glitchUV.y - bandPos);
    float bandMask = smoothstep(bandThickness, 0.0, bandDist);
    vec3 neonColor = mix(neonColor1, neonColor2, uvInBand + bandIndex * 0.1);
    float neonGlow = bandMask * (1.0 - t) * 2.0;
    
    // 相邻光带交错叠加效果（Add混合）
    float nextBandIndex = bandIndex + 1.0;
    float nextBandDelay = float(int(mod(nextBandIndex, 2.0))) * delayStep + float(int(nextBandIndex)) * delayStep * 0.5;
    float nextBandT = clamp(t * 1.4 - nextBandDelay, 0.0, 1.0);
    float nextBandPos = mod(nextBandIndex, 2.0) == 1.0 ? nextBandT : 1.0 - nextBandT;
    float nextBandDist = abs(glitchUV.y - nextBandPos);
    float overlapMask = bandMask * smoothstep(bandThickness * 1.5, 0.0, nextBandDist);
    vec3 overlapGlow = vec3(1.0) * overlapMask * 3.0;
    
    // 模糊效果：未扫描区域最大模糊，扫描区域逐步清晰
    float blurStrength = blurMax * (1.0 - scanMask * scanProgress);
    vec4 blurredTex = verticalBlur(tDiffuse, glitchUV, blurStrength);
    
    // 亮度饱和度控制：未扫描区域低亮低饱和，扫描区域逐步恢复
    float brightness = mix(0.2, 1.0, scanMask * scanProgress);
    float saturation = mix(0.1, 1.0, scanMask * scanProgress);
    float gray = dot(blurredTex.rgb, vec3(0.299, 0.587, 0.114));
    vec3 baseColor = mix(vec3(gray), blurredTex.rgb, saturation) * brightness;
    
    // 混合所有效果
    vec3 finalColor = baseColor + neonColor * neonGlow + overlapGlow;
    float glitchFlash = random(glitchUV * 100.0 + t) * step(0.8, random(vec2(t * 10.0))) * glitchFactor * 2.0;
    finalColor += glitchFlash;
    
    // 收尾阶段全图恢复
    finalColor = mix(finalColor, texel.rgb, smoothstep(0.7, 1.0, t));
    
    return vec4(finalColor, texel.a);
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