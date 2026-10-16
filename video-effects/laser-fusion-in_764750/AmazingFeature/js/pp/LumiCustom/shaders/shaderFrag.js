exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义参数
uniform float maxBlurRadius; // = 30.0 [5.0, 50.0] // 初始最大模糊半径
uniform vec4 neonColor1; // = vec4(1.0, 0.2, 0.8, 1.0) [0.0, 1.0] // 霓虹粉色
uniform vec4 neonColor2; // = vec4(0.6, 0.2, 1.0, 1.0) [0.0, 1.0] // 霓虹紫色
uniform float glowIntensity; // = 4.0 [2.0, 8.0] // 光带发光强度
uniform float stripeMaxWidth; // = 0.15 [0.05, 0.3] // 光带最大宽度
uniform float chromaAberrationStrength; // = 0.01 [0.0, 0.03] // 光带交汇色差强度

varying vec2 vUv;

float tween(float progress) {
    // 先快后慢的缓出曲线，适配0.3s汇聚+0.7s收尾的节奏
    return 1.0 - pow(1.0 - progress, 2.5);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 高斯模糊函数
vec4 gaussianBlur(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    
    float kernel[25];
    kernel[0] = 1.0; kernel[1] = 4.0; kernel[2] = 6.0; kernel[3] = 4.0; kernel[4] = 1.0;
    kernel[5] = 4.0; kernel[6] = 16.0; kernel[7] = 24.0; kernel[8] = 16.0; kernel[9] = 4.0;
    kernel[10] = 6.0; kernel[11] = 24.0; kernel[12] = 36.0; kernel[13] = 24.0; kernel[14] = 6.0;
    kernel[15] = 4.0; kernel[16] = 16.0; kernel[17] = 24.0; kernel[18] = 16.0; kernel[19] = 4.0;
    kernel[20] = 1.0; kernel[21] = 4.0; kernel[22] = 6.0; kernel[23] = 4.0; kernel[24] = 1.0;
    
    float baseStep = 0.001 * blurStrength;
    vec2 stepSize = vec2(baseStep, baseStep / ratio);
    
    for (int i = -2; i <= 2; i++) {
        for (int j = -2; j <= 2; j++) {
            float weight = kernel[(i + 2) * 5 + (j + 2)];
            vec2 offset = vec2(float(i) * stepSize.x, float(j) * stepSize.y);
            vec2 sampleUV = handleUVBounds(uv + offset);
            color += texture2D(tex, sampleUV) * weight;
            totalWeight += weight;
        }
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    // 1. 计算各阶段进度
    float stripeProgress = clamp(progress / 0.3, 0.0, 1.0); // 光带汇聚进度
    float stripeAlpha = 1.0 - smoothstep(0.3, 0.4, progress); // 光带消散进度
    float baseAlpha = smoothstep(0.0, 0.3, progress); // 底层素材透明度
    float chromaAmount = chromaAberrationStrength * smoothstep(0.0, 1.0, 1.0 - abs(progress - 0.3) / 0.1); // 色差强度
    
    // 2. 旋转UV得到45度斜向坐标
    float angle = -3.14159265 / 4.0;
    float s = sin(angle);
    float c = cos(angle);
    vec2 rotatedUV = vec2(dot(vUv - 0.5, vec2(c, -s)), dot(vUv - 0.5, vec2(s, c))) + 0.5;
    
    // 3. 生成霓虹光带
    float stripePositions[5];
    stripePositions[0] = -0.2; // 左上
    stripePositions[1] = 1.2; // 右上
    stripePositions[2] = -0.3; // 左下
    stripePositions[3] = 1.3; // 右下
    stripePositions[4] = -0.1; // 顶部
    
    float stripeWidths[5];
    stripeWidths[0] = stripeMaxWidth * 0.8;
    stripeWidths[1] = stripeMaxWidth * 1.2;
    stripeWidths[2] = stripeMaxWidth * 0.9;
    stripeWidths[3] = stripeMaxWidth * 1.1;
    stripeWidths[4] = stripeMaxWidth * 1.0;
    
    vec3 stripeColor = vec3(0.0);
    for (int i = 0; i < 5; i++) {
        float currentPos = mix(stripePositions[i], 0.5, stripeProgress);
        float dist = abs(rotatedUV.x - currentPos);
        float stripeMask = smoothstep(stripeWidths[i], 0.0, dist);
        vec3 colorMix = mix(neonColor1.rgb, neonColor2.rgb, fract(float(i) * 0.314));
        stripeColor += stripeMask * colorMix * glowIntensity;
    }
    
    // 4. 模糊处理+色差效果
    float currentBlur = (1.0 - progress) * maxBlurRadius;
    vec4 blurredTexel;
    if (chromaAmount > 0.0) {
        vec4 r = gaussianBlur(tDiffuse, vUv + vec2(chromaAmount, 0.0), currentBlur, ratio);
        vec4 g = gaussianBlur(tDiffuse, vUv, currentBlur, ratio);
        vec4 b = gaussianBlur(tDiffuse, vUv - vec2(chromaAmount, 0.0), currentBlur, ratio);
        blurredTexel = vec4(r.r, g.g, b.b, (r.a + g.a + b.a) / 3.0);
    } else {
        blurredTexel = gaussianBlur(tDiffuse, vUv, currentBlur, ratio);
    }
    
    // 5. 亮度和饱和度调整
    float currentBrightness = mix(2.0, 1.0, progress);
    float currentSaturation = mix(0.7, 1.0, progress);
    blurredTexel.rgb *= currentBrightness;
    
    float gray = dot(blurredTexel.rgb, vec3(0.299, 0.587, 0.114));
    blurredTexel.rgb = mix(vec3(gray), blurredTexel.rgb, currentSaturation);
    
    // 6. 混合最终效果
    vec3 finalRGB = blurredTexel.rgb * baseAlpha + stripeColor * stripeAlpha;
    float finalA = baseAlpha + max(stripeColor.r, max(stripeColor.g, stripeColor.b)) * stripeAlpha * 0.5;
    
    return vec4(finalRGB, finalA);
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