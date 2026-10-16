exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform vec3 glowColor; // = vec3(0.2, 0.5, 1.0) // 扫描光效颜色，默认冷蓝色
uniform float maxBlurStrength; // = 10.0 [1.0, 20.0] // 最大垂直模糊强度
uniform float maxGlowIntensity; // = 3.0 [0.5, 5.0] // 最大光效强度
uniform float edgeSoftness; // = 0.1 [0.01, 0.3] // 扫描边缘柔化程度
uniform float noiseStrength; // = 0.1 [0.0, 0.3] // 光效边缘颗粒噪声强度

varying vec2 vUv;

float tween(float progress) {
    // 二次缓出曲线，适配短动画，过渡丝滑自然
    return 1.0 - pow(1.0 - progress, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 verticalBlur(sampler2D tex, vec2 uv, float strength) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    float stepSize = 0.001 * strength;
    
    for(int i = -4; i <= 4; i++) {
        float weight = 1.0 - abs(float(i)) / 5.0;
        vec2 sampleUV = handleUVBounds(uv + vec2(0.0, float(i) * stepSize));
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float t = progress;
    if(t >= 1.0) return texel;
    
    float scanPos = 1.0 - t;
    float baseMask = smoothstep(scanPos, scanPos + edgeSoftness, vUv.y);
    float distanceToScan = abs(vUv.y - scanPos);
    
    // 垂直模糊计算
    float blurFactor = 1.0 - t;
    float areaBlurFactor = smoothstep(edgeSoftness * 2.0, 0.0, distanceToScan);
    float currentBlur = maxBlurStrength * blurFactor * areaBlurFactor;
    vec4 blurredTexel = verticalBlur(tDiffuse, vUv, currentBlur);
    
    // 冷蓝色光效计算
    float glowArea = smoothstep(edgeSoftness * 1.5, 0.0, distanceToScan);
    float glowFactor = blurFactor * glowArea * maxGlowIntensity;
    float noise = random(vUv * 120.0 + t * 15.0) * noiseStrength;
    vec3 glow = glowColor * (glowFactor + noise);
    
    // 亮度恢复
    float brightness = 0.3 + 0.7 * t;
    
    vec3 finalRGB = mix(vec3(0.0), blurredTexel.rgb * brightness + glow, baseMask);
    float finalAlpha = mix(0.0, texel.a, baseMask);
    
    return vec4(finalRGB, finalAlpha);
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