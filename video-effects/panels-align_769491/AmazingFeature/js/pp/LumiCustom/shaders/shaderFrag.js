exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float maxOffset; // = 0.05 [0.01, 0.1] // 碎块最大偏移量
uniform float maxBlur; // = 5.0 [1.0, 10.0] // 最大模糊强度
uniform float glowStrength; // = 0.3 [0.1, 0.8] // 暖橘色发光强度
uniform float grainOpacity; // = 0.15 [0.0, 0.3] // 胶片颗粒最大透明度

varying vec2 vUv;

// 伪随机函数
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

float tween(float progress) {
    // ease-out三次方缓出曲线，符合碎块归位的物理运动感
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 【强制使用】计算屏幕短边的相对尺寸
float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction;
    else return fraction * ratio;
}

// 优化的高斯模糊函数（带分辨率适配）
vec4 gaussianBlur(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    
    // 3x3高斯核，平衡性能和效果
    float kernel[9];
    kernel[0] = 1.0; kernel[1] = 2.0; kernel[2] = 1.0;
    kernel[3] = 2.0; kernel[4] = 4.0; kernel[5] = 2.0;
    kernel[6] = 1.0; kernel[7] = 2.0; kernel[8] = 1.0;
    
    float baseStep = 0.001 * blurStrength;
    vec2 stepSize = vec2(baseStep, baseStep / ratio);
    
    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            float weight = kernel[(i + 1) * 3 + (j + 1)];
            vec2 offset = vec2(float(i) * stepSize.x, float(j) * stepSize.y);
            vec2 sampleUV = handleUVBounds(uv + offset);
            color += texture2D(tex, sampleUV) * weight;
            totalWeight += weight;
        }
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float tweened = tween(progress);
    float effectStrength = 1.0 - tweened;
    
    // 当效果强度为0时直接返回原图，优化性能
    if (effectStrength <= 0.001) return texel;
    
    // 分割为3行4列共12个碎块
    const vec2 gridSize = vec2(4.0, 3.0);
    vec2 blockId = floor(vUv * gridSize);
    vec2 blockCenter = (blockId + 0.5) / gridSize;
    
    // 生成每个碎块的随机参数（固定种子保证一致性）
    float randX = random(blockId) * 2.0 - 1.0;
    float randY = random(blockId + 123.45) * 2.0 - 1.0;
    float randScale = 1.0 + 0.1 * random(blockId + 456.78) * effectStrength;
    
    // 计算碎块偏移和变换后的UV
    vec2 offset = vec2(randX, randY) * maxOffset * effectStrength;
    offset.y /= ratio; // 适配屏幕比例，保证偏移各方向一致
    vec2 transformedUV = (vUv - blockCenter) / randScale + blockCenter + offset;
    transformedUV = handleUVBounds(transformedUV);
    
    // 采样模糊后的纹理
    float currentBlur = maxBlur * effectStrength;
    vec4 blockColor = gaussianBlur(tDiffuse, transformedUV, currentBlur, ratio);
    
    // 叠加暖橘色发光
    vec3 glowColor = vec3(1.0, 0.55, 0.2);
    blockColor.rgb += glowColor * glowStrength * effectStrength;
    
    // 调整曝光（+3EV初始值）
    float exposure = pow(2.0, 3.0 * effectStrength);
    blockColor.rgb *= exposure;
    
    // 调整饱和度（1.8倍初始值）
    float saturation = 1.0 + 0.8 * effectStrength;
    float gray = dot(blockColor.rgb, vec3(0.299, 0.587, 0.114));
    blockColor.rgb = mix(vec3(gray), blockColor.rgb, saturation);
    
    // 叠加复古胶片颗粒
    float grain = random(vUv * 1200.0 + vec2(progress * 10.0)) * 2.0 - 1.0;
    blockColor.rgb += grain * grainOpacity * effectStrength;
    
    // 颜色范围限制，避免过曝
    blockColor.rgb = clamp(blockColor.rgb, 0.0, 1.0);
    
    return blockColor;
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    vec4 effectColor = effect(texel, effectProgress);
    gl_FragColor = effectColor;
}
//===end_frag_code===
`;