exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义参数
uniform float fogInitRadius; // = 0.1 [0.01, 0.3] // 初始光雾半径
uniform float fogFeather; // = 0.3 [0.05, 0.8] // 光雾边缘羽化程度
uniform float breathFreq; // = 2.0 [1.0, 4.0] // 呼吸节奏频率
uniform float glowIntensity; // = 1.5 [1.0, 3.0] // 光雾亮晕强度
uniform float maxBlur; // = 8.0 [2.0, 15.0] // 最大模糊强度

varying vec2 vUv;

// 缓出曲线，自然平滑
float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 分辨率适配UV
vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

// 圆形距离场
float circleSDF(vec2 uv, vec2 center, float radius) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    return length(aspectUV - center) - radius;
}

// 高斯模糊函数
vec4 gaussianBlur(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    // 修复数组构造语法，适配WebGL 1.0
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
    float t = progress;
    // 呼吸波动效果
    float breathWave = 0.1 * sin(t * breathFreq * 3.14159265);
    // 光雾扩散半径，叠加呼吸波动
    float currentRadius = fogInitRadius + t * (1.5 + breathWave);
    // 计算光雾蒙版
    float dist = circleSDF(vUv, vec2(0.5), currentRadius);
    float fogMask = smoothstep(fogFeather, -fogFeather, dist);
    // 边缘亮晕效果
    float glow = smoothstep(fogFeather * 0.5, -fogFeather * 0.5, dist + 0.05) * glowIntensity;
    // 清晰度过渡：从模糊到清晰
    float blurStrength = (1.0 - t) * maxBlur;
    vec4 blurredTex = gaussianBlur(tDiffuse, vUv, blurStrength, ratio);
    vec4 mixedTex = mix(blurredTex, texel, t);
    // 亮度过渡：从纯黑到正常亮度，光雾区域优先亮起
    float brightness = t + fogMask * (1.0 - t) * 0.8;
    // 组合最终颜色
    vec3 finalRGB = mixedTex.rgb * brightness + vec3(glow) * (1.0 - t);
    
    return vec4(finalRGB, texel.a);
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