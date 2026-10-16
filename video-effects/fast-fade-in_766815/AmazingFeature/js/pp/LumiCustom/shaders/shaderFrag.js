exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform vec3 goldColor; // = vec3(1.0, 0.88, 0.35) // 金箔主颜色
uniform float particleSize; // = 0.003 [0.001, 0.01] // 金箔粒子大小
uniform float bleedStrength; // = 0.2 [0.0, 0.5] // 水彩晕染强度
uniform float outlineThreshold; // = 0.2 [0.1, 0.5] // 边缘检测阈值
uniform float particleFlowSpeed; // = 2.0 [0.5, 5.0] // 粒子流动速度

varying vec2 vUv;

// 缓动函数：正弦缓出，自然平滑适合国风风格
float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 随机函数：生成0-1的随机值
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

// 灰度转换函数
float getGray(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}

// Sobel边缘检测函数
float sobelEdgeDetection(vec2 uv) {
    vec2 texel = vec2(1.0 / (1000.0 * ratio), 1.0 / 1000.0);
    
    float kernel[9];
    kernel[0] = -1.0; kernel[1] = -2.0; kernel[2] = -1.0;
    kernel[3] =  0.0; kernel[4] =  0.0; kernel[5] =  0.0;
    kernel[6] =  1.0; kernel[7] =  2.0; kernel[8] =  1.0;
    
    float gx = 0.0;
    float gy = 0.0;
    
    for(int i = -1; i <= 1; i++) {
        for(int j = -1; j <= 1; j++) {
            float gray = getGray(texture2D(tDiffuse, handleUVBounds(uv + vec2(i,j) * texel)).rgb);
            int idx = (i+1)*3 + (j+1);
            gx += gray * kernel[idx];
            gy += gray * kernel[(j+1)*3 + (i+1)];
        }
    }
    
    float edge = sqrt(gx*gx + gy*gy);
    return smoothstep(outlineThreshold, outlineThreshold * 2.0, edge);
}

// 生成金箔粒子效果
float generateGoldParticles(vec2 uv, float edgeMask, float flowOffset) {
    // 适配分辨率的粒子网格
    vec2 gridUV = uv / vec2(particleSize * ratio, particleSize);
    gridUV.y += flowOffset * particleFlowSpeed;
    vec2 cellID = floor(gridUV);
    vec2 cellUV = fract(gridUV) - 0.5;
    
    // 仅在边缘区域生成粒子
    float cellEdge = texture2D(tDiffuse, handleUVBounds(cellID * vec2(particleSize * ratio, particleSize))).a;
    if(cellEdge < 0.1) return 0.0;
    
    // 随机粒子大小和亮度
    float rand = random(cellID);
    float particle = smoothstep(0.3 + rand * 0.3, 0.0, length(cellUV));
    particle *= rand * edgeMask;
    
    return particle;
}

vec4 effect(vec4 texel, float progress) {
    // progress=1时直接返回原图
    if(progress >= 1.0) return texel;
    
    float t = tween(progress);
    
    // 1. 提取画面边缘
    float edgeMask = sobelEdgeDetection(vUv);
    
    // 2. 生成流动的金箔粒子
    float flowOffset = fract(progress * 3.0);
    float particles = generateGoldParticles(vUv, edgeMask, flowOffset);
    // 粒子后期消散
    particles *= 1.0 - smoothstep(0.7, 1.0, progress);
    
    // 3. 水彩晕染效果：从边缘向内扩散
    float fillRange = smoothstep(0.2, 0.8, t) * (1.0 + bleedStrength);
    float bleedMask = smoothstep(fillRange, fillRange - bleedStrength, edgeMask);
    
    // 4. 原图显示控制：跟随晕染范围显现
    float imageAlpha = smoothstep(0.2, 1.0, t) * bleedMask;
    
    // 颜色混合：Screen模式叠加金箔粒子和晕染色
    vec3 goldParticleColor = goldColor * particles * 1.5;
    vec3 bleedColor = goldColor * bleedMask * 0.3 * (1.0 - smoothstep(0.7, 1.0, progress));
    vec3 finalColor = mix(vec3(0.0), texel.rgb, imageAlpha);
    finalColor = 1.0 - (1.0 - finalColor) * (1.0 - goldParticleColor);
    finalColor = mix(finalColor, bleedColor, 0.3 * (1.0 - imageAlpha));
    
    return vec4(finalColor, 1.0);
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