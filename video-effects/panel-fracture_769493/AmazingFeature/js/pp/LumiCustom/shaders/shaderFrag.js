exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float stripCount; // = 12.0 [4.0, 24.0] // 竖条数量
uniform float maxStretch; // = 2.3 [1.0, 5.0] // 最大垂直拉伸强度
uniform float neonIntensity; // = 0.02 [0.0, 0.1] // 霓虹RGB偏移强度
uniform float maxBlur; // = 8.0 [1.0, 20.0] // 最大纵向模糊强度
uniform float delayStep; // = 0.05 [0.01, 0.2] // 相邻竖条延迟比例

varying vec2 vUv;

float tween(float p) {
    if(p <= 0.0) return 0.0;
    if(p >= 1.0) return 1.0;
    // ease-out缓出曲线，后期消散速度加快
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 纵向方向模糊函数
vec4 verticalBlur(sampler2D tex, vec2 uv, float blurAmount, float ratio) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    float kernel[5];
    kernel[0] = 1.0;
    kernel[1] = 4.0;
    kernel[2] = 6.0;
    kernel[3] = 4.0;
    kernel[4] = 1.0;
    float stepY = 0.001 * blurAmount / ratio;
    
    for(int i = -2; i <= 2; i++) {
        float weight = kernel[i + 2];
        vec2 sampleUV = handleUVBounds(uv + vec2(0.0, float(i) * stepY));
        color += texture2D(tex, sampleUV) * weight;
        totalWeight += weight;
    }
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    if(progress <= 0.0) return texel;
    if(progress >= 1.0) return vec4(0.0, 0.0, 0.0, 0.0);
    
    float stripWidth = 1.0 / stripCount;
    float centerStrip = (stripCount - 1.0) * 0.5;
    float stripIndex = floor(vUv.x / stripWidth);
    float distToCenter = abs(stripIndex - centerStrip);
    float delay = distToCenter * delayStep;
    
    float localProgress = clamp((progress - delay) / (1.0 - delayStep * centerStrip), 0.0, 1.0);
    float t = tween(localProgress);
    
    if(t <= 0.0) {
        float stripMask = step(stripIndex * stripWidth, vUv.x) * step(vUv.x, (stripIndex + 1.0) * stripWidth);
        return texel * stripMask;
    }
    
    // 垂直拉伸变换
    float scaleY = 1.0 + t * maxStretch;
    vec2 stripUV = vUv;
    stripUV.y = 0.5 + (stripUV.y - 0.5) / scaleY;
    stripUV.x = clamp(stripUV.x, stripIndex * stripWidth, (stripIndex + 1.0) * stripWidth);
    
    // 霓虹RGB偏移+模糊
    float offset = t * neonIntensity / ratio;
    vec4 rSample = verticalBlur(tDiffuse, stripUV + vec2(0.0, offset), t * maxBlur, ratio);
    vec4 gSample = verticalBlur(tDiffuse, stripUV, t * maxBlur * 0.8, ratio);
    vec4 bSample = verticalBlur(tDiffuse, stripUV - vec2(0.0, offset), t * maxBlur, ratio);
    
    // 提升亮度+色彩偏移
    vec3 neonColor = vec3(rSample.r * 1.2, gSample.g * 1.1, bSample.b * 1.3) * (1.0 + t * 0.8);
    float alpha = 1.0 - t;
    
    // 竖条边缘柔化遮罩
    float edgeMask = smoothstep(0.0, stripWidth * 0.01, vUv.x - stripIndex * stripWidth) * 
                    smoothstep(0.0, stripWidth * 0.01, (stripIndex + 1.0) * stripWidth - vUv.x);
    
    return vec4(neonColor, alpha * edgeMask);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    vec4 effectColor = effect(texel, effectProgress);
    vec4 finalColor = effectColor;
    gl_FragColor = finalColor;
}
//===end_frag_code===
`;