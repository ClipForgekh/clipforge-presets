exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float stretchStrength; // = 2.0 [0.5, 5.0] // 垂直拉伸强度
uniform float blurStrength; // = 8.0 [1.0, 20.0] // 垂直模糊强度
uniform vec4 glowColor; // = vec4(1.0, 0.82, 0.32, 1.0) // 暖金色眩光颜色
uniform float shakeStrength; // = 0.1 [0.01, 0.3] // 水平震荡幅度
uniform float grainStrength; // = 0.05 [0.0, 0.2] // 胶片颗粒强度

varying vec2 vUv;

// 随机函数（用于胶片颗粒）
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 硬边界裁切函数
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float tween(float progress) {
    // 中度缓出曲线，符合快速冲刺后减速稳定的运动逻辑
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec4 effect(vec4 texel, float progress) {
    float t = tween(progress);
    float reverseT = 1.0 - t;
    
    // 1. 水平震荡效果
    float shakeOffset = sin(progress * 30.0) * reverseT * shakeStrength;
    
    // 2. Z轴缩放 + 垂直拉伸形变
    float scale = 0.01 + t * 0.99; // 初始1%大小，最终满屏
    float stretch = reverseT * stretchStrength;
    vec2 uv = vUv - 0.5;
    uv.x += shakeOffset;
    uv.x *= scale * (1.0 - stretch * 0.8); // X方向初始压缩成窄条
    uv.y *= scale * (1.0 + stretch * 0.5); // Y方向初始拉伸成长条
    uv += 0.5;
    uv = handleUVBounds(uv);
    
    // 3. 垂直方向模糊
    float blurStep = reverseT * blurStrength * 0.001 / ratio;
    vec4 blurredColor = vec4(0.0);
    float totalWeight = 0.0;
    for(int i = -4; i <= 4; i++) {
        float weight = 1.0 - abs(float(i))/4.0;
        blurredColor += texture2D(tDiffuse, uv + vec2(0.0, float(i) * blurStep)) * weight;
        totalWeight += weight;
    }
    blurredColor /= totalWeight;
    
    // 4. 暖金色眩光效果
    float glowIntensity = reverseT * 1.5;
    float edgeGlow = (smoothstep(0.0, 0.1, uv.y) + smoothstep(1.0, 0.9, uv.y)) * glowIntensity;
    float fullGlow = reverseT * 0.6 * glowIntensity;
    vec4 glow = glowColor * (edgeGlow + fullGlow);
    
    // 5. 混合基础颜色与眩光
    vec4 result = blurredColor + glow;
    
    // 6. 胶片颗粒效果（仅在动画末尾显示）
    if(progress > 0.8) {
        float grainFactor = (progress - 0.8) / 0.2;
        float grain = random(vUv + progress) * grainStrength * grainFactor;
        result.rgb += vec3(grain * 0.5 - grainStrength * 0.25);
    }
    
    // 7. 边界裁切避免边缘拉丝
    float mask = getHardBoundaryMask(uv);
    result.a *= mask;
    
    return result;
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