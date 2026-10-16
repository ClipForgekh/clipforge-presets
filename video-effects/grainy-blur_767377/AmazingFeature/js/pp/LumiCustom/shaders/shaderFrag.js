exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform参数
uniform float waveAmplitude; // = 0.05 [0.01, 0.2] // 纬线波纹振幅
uniform float glowIntensity; // = 0.2 [0.0, 0.5] // 边缘辉光最大强度
uniform vec3 glowColor; // = vec3(1.0, 0.8, 0.6) // 暖色调辉光颜色
uniform float heatStrength; // = 0.1 [0.0, 0.3] // 热扰动最大强度
uniform float noiseScale; // = 10.0 [5.0, 30.0] // 热扰动噪声缩放系数

varying vec2 vUv;
const float PI = 3.141592653589793;

float tween(float progress) {
    // 循环动画使用线性进度，确保周期完全闭合
    return progress;
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 分辨率适配坐标转换
vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

// 伪随机噪声函数
float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

// 湍流噪声模拟热扰动
float turbulence(vec2 p) {
    float val = 0.0;
    float freq = 1.0;
    for (int i = 0; i < 3; i++) {
        val += abs(noise(p * freq) * 2.0 - 1.0) / freq;
        freq *= 2.0;
    }
    return val;
}

vec4 effect(vec4 texel, float progress) {
    // 三纬线相位错开120度
    float phaseTotal = progress * 2.0 * PI;
    float phaseUpper = phaseTotal;
    float phaseMiddle = phaseTotal + 2.0 * PI / 3.0;
    float phaseLower = phaseTotal + 4.0 * PI / 3.0;
    
    // 动态强度周期：0→峰值→0，确保首尾一致
    float dynamicFactor = sin(progress * PI);
    float currentHeat = dynamicFactor * heatStrength;
    float currentGlow = dynamicFactor * glowIntensity;
    
    // 适配坐标计算
    vec2 p = getSDFCoordinate(vUv, vec2(0.5));
    float dist = length(p);
    
    // 三纬线波纹偏移计算
    float upperWave = sin(phaseUpper + dist * 3.0) * waveAmplitude * smoothstep(0.3, 0.5, dist);
    float middleWave = sin(phaseMiddle + dist * 5.0) * waveAmplitude * smoothstep(0.5, 0.7, dist);
    float lowerWave = sin(phaseLower + dist * 7.0) * waveAmplitude * smoothstep(0.7, 1.0, dist);
    float totalWave = upperWave + middleWave + lowerWave;
    
    // 热扰动偏移
    vec2 heatOffset = vec2(
        turbulence(vUv * noiseScale + vec2(progress * 0.5, 0.0)),
        turbulence(vUv * noiseScale + vec2(0.0, progress * 0.5))
    ) * currentHeat - currentHeat * 0.5;
    
    // 采样UV计算
    vec2 uv = vUv + totalWave * normalize(p + 0.0001) + heatOffset;
    uv = handleUVBounds(uv);
    vec4 baseColor = texture2D(tDiffuse, uv);
    
    // 钟罩边缘动态辉光
    float edgeMask = smoothstep(0.8, 0.2, dist) - smoothstep(0.9, 0.1, dist);
    edgeMask *= (1.0 + sin(phaseTotal + dist * 10.0) * 0.2);
    vec3 glow = glowColor * edgeMask * currentGlow;
    
    // 混合最终颜色，不修改透明度符合禁用Opacity渐变要求
    vec3 finalRGB = baseColor.rgb + glow;
    return vec4(finalRGB, baseColor.a);
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