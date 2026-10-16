exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform参数
uniform float maxBlurStrength; // = 15.0 [1.0, 30.0] // 最大纵向模糊强度
uniform vec4 glowColor; // = vec4(0.2, 0.6, 1.0, 1.0) // 冰蓝色光效颜色
uniform float glowWidth; // = 0.1 [0.01, 0.3] // 光带宽度
uniform float feather; // = 0.05 [0.01, 0.2] // 擦除边缘羽化值
uniform float glowIntensity; // = 2.0 [0.5, 5.0] // 光效最大强度

varying vec2 vUv;

// 缓动函数：正弦缓出，先快后慢，平滑过渡
float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

// 边界处理函数：clamp边界留黑处理
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 计算屏幕短边的相对尺寸，适配不同分辨率
float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction;
    else return fraction * ratio;
}

// 纵向方向模糊函数，适配屏幕比例
vec4 verticalBlur(sampler2D tex, vec2 uv, float strength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    float stepSize = 0.001 * strength / ratio; // 适配屏幕比例的步长，确保模糊像素数一致
    
    // 9点高斯权重，模糊效果更自然
    float weights[9];
    weights[0] = 0.02; weights[1] = 0.05; weights[2] = 0.10; weights[3] = 0.18; weights[4] = 0.30;
    weights[5] = 0.18; weights[6] = 0.10; weights[7] = 0.05; weights[8] = 0.02;
    
    for(int i = -4; i <= 4; i++) {
        float offset = float(i) * stepSize;
        vec2 sampleUV = handleUVBounds(uv + vec2(0.0, offset));
        float weight = weights[i + 4];
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    // 擦除位置：从下（y=0）往上（y=1）移动
    float wipeY = progress;
    // 当前模糊强度：progress=0时最大，progress=1时为0
    float currentBlur = (1.0 - progress) * maxBlurStrength;
    
    // 采样清晰纹理和模糊纹理
    vec4 clearTex = texel;
    vec4 blurTex = verticalBlur(tDiffuse, vUv, currentBlur, ratio);
    
    // 模糊遮罩：wipeY以下为清晰区，以上为模糊区，带羽化过渡
    float blurMask = smoothstep(wipeY - feather, wipeY + feather, vUv.y);
    vec4 baseColor = mix(clearTex, blurTex, blurMask);
    
    // 计算冰蓝色光效，Add混合模式
    float adjustedGlowWidth = glowWidth * getShortSideRelativeSize(1.0);
    float glowMask = 1.0 - abs(vUv.y - wipeY) / adjustedGlowWidth;
    glowMask = clamp(glowMask, 0.0, 1.0);
    glowMask = pow(glowMask, 2.0); // 光效边缘衰减更自然
    
    vec3 glow = glowColor.rgb * glowMask * (1.0 - progress) * glowIntensity * glowColor.a;
    baseColor.rgb += glow;
    baseColor.rgb = clamp(baseColor.rgb, 0.0, 1.0); // 避免过曝
    
    return baseColor;
}

void main() {
    // 获取纹理像素颜色
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- 特效配置 ---
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    // 1. 计算特效自身的进度
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);

    // 2. 直接应用特效
    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;