exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float maxGaussianBlur; // = 10.0 [1.0, 20.0] // 最大高斯模糊强度
uniform float maxDirectionalBlur; // = 60.0 [20.0, 100.0] // 最大纵向模糊强度
uniform float maxScale; // = 3.0 [1.5, 5.0] // 最大缩放比例
uniform float stretchStrength; // = 1.0 [0.5, 2.0] // 纵向拉伸强度
uniform float maxGlow; // = 2.0 [1.0, 3.0] // 最大发光强度
uniform vec4 glowColor; // = vec4(1.0, 0.6, 0.2, 1.0) // 发光暖橙色

varying vec2 vUv;

float tween(float progress) {
    // 缓入曲线，后半段加速，符合出场消散效果
    return pow(progress, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 gaussianBlur(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    
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

vec4 directionalBlurVertical(sampler2D tex, vec2 uv, float blurStrength, float ratio) {
    vec4 color = vec4(0.0);
    float stepSize = 0.001 * blurStrength / ratio;
    int samples = 15;
    
    for (int i = -samples/2; i <= samples/2; i++) {
        float offset = float(i) * stepSize;
        vec2 sampleUV = handleUVBounds(uv + vec2(0.0, offset));
        color += texture2D(tex, sampleUV);
    }
    
    return color / float(samples + 1);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    // 计算各阶段效果强度
    float gaussianProgress = clamp(progress / 0.3, 0.0, 1.0);
    float dirBlurProgress = progress > 0.3 ? pow((progress - 0.3) / 0.7, 2.0) : 0.0;
    
    float currentGaussian = gaussianProgress * maxGaussianBlur;
    float currentDirBlur = dirBlurProgress * maxDirectionalBlur;
    float currentScale = 1.0 + progress * (maxScale - 1.0);
    float currentStretch = 1.0 + progress * stretchStrength;
    float currentGlow = 0.5 + progress * (maxGlow - 0.5);
    float currentAlpha = 1.0 - progress * 0.9;
    
    // 处理UV变换：中心缩放+纵向拉伸
    vec2 uv = 0.5 + (vUv - 0.5) / currentScale;
    uv.y = 0.5 + (uv.y - 0.5) / currentStretch;
    uv = handleUVBounds(uv);
    
    // 模糊处理：先高斯模糊，再纵向方向模糊
    vec4 blurred = gaussianBlur(tDiffuse, uv, currentGaussian, ratio);
    blurred = directionalBlurVertical(tDiffuse, uv, currentDirBlur + currentGaussian, ratio);
    
    // 颜色处理：提升亮度和饱和度
    float gray = dot(blurred.rgb, vec3(0.299, 0.587, 0.114));
    vec3 saturated = mix(vec3(gray), blurred.rgb, 1.0 + progress * 0.2);
    vec3 brightened = saturated * (1.0 + progress * 1.0);
    
    // 叠加暖光发光效果（Screen混合）
    vec3 glow = glowColor.rgb * currentGlow * blurred.a;
    vec3 finalRgb = 1.0 - (1.0 - brightened) * (1.0 - glow);
    
    // 边界裁切+透明度控制
    float borderMask = getHardBoundaryMask(vUv);
    return vec4(finalRgb, blurred.a * currentAlpha * borderMask);
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