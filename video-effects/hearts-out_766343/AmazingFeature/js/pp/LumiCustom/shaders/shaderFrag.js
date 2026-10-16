exports.source=`
//===begin_frag_code===
precision highp float;

#define PI 3.14159265359

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float pixelSizeMax; // = 0.05 [0.01, 0.1] // 最大像素块尺寸
uniform float blurMax; // = 12.0 [1.0, 20.0] // 最大模糊强度
uniform float heartCount; // = 8.0 [3.0, 15.0] // 爱心数量
uniform float spreadSpeed; // = 1.0 [0.5, 2.0] // 扩散速度
uniform vec3 heartColorTint; // = vec3(1.0, 0.6, 0.3) // 爱心暖色调

varying vec2 vUv;

float tween(float progress) {
    // 出场动画缓入曲线：扩散先快后慢，后期收缩加快
    if (progress < 0.7) {
        return progress * progress * 1.8;
    } else {
        return 1.0 - pow(1.0 - progress, 3.0);
    }
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 坐标空间转换函数
vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

// 获取能包裹整个屏幕的最大形状尺寸
float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

// 爱心距离场函数
float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0)
        return sqrt(dot(p - vec2(0.25, 0.75), p - vec2(0.25, 0.75))) - sqrt(2.0) / 4.0;
    return sqrt(min(dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00)),
                    dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50)))) * sign(p.x - p.y);
}

// 分辨率适配的爱心SDF
float heartSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p /= max(size, 0.0001);
    p.y += 0.45;
    return sdHeart(p) * size;
}

// 生成爱心蒙版
float generateHeartMask(vec2 uv, vec2 center, float size, float blurEdge) {
    float dist = heartSDF(uv, center, size);
    return 1.0 - smoothstep(-blurEdge, blurEdge, dist);
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
    if (progress <= 0.001) return texel;
    
    float t = tween(progress);
    
    // 1. 像素化处理
    float pixelSize = t * pixelSizeMax;
    vec2 pixelUV = pixelSize > 0.001 ? floor(vUv / pixelSize) * pixelSize + pixelSize * 0.5 : vUv;
    pixelUV = handleUVBounds(pixelUV);
    
    // 2. 原图模糊处理
    float blurStrength = t * blurMax;
    vec4 blurredTex = gaussianBlur(tDiffuse, pixelUV, blurStrength, ratio);
    
    // 3. 原图透明度逐渐降低
    float baseAlpha = 1.0 - t;
    vec4 baseColor = vec4(blurredTex.rgb, blurredTex.a * baseAlpha);
    
    // 4. 生成多层放射状像素爱心
    vec4 heartsColor = vec4(0.0);
    const int MAX_HEARTS = 15;
    float heartAlpha = progress < 0.5 ? progress * 2.0 : (progress < 0.7 ? 1.0 : (1.0 - progress) * 3.333);
    
    for(int i = 0; i < MAX_HEARTS; i++) {
        if (float(i) >= heartCount) break;
        
        // 爱心角度与伪随机参数
        float angle = float(i) * 2.0 * PI / heartCount + sin(float(i)*123.45)*0.2;
        float randomScale = 0.8 + 0.4 * fract(sin(float(i)*456.78));
        float randomSpeed = 0.8 + 0.4 * fract(cos(float(i)*789.01));
        
        // 爱心放射状位移
        float spreadDist = t * spreadSpeed * randomSpeed * 0.5;
        if (progress > 0.7) spreadDist *= (1.0 - progress) * 3.333;
        vec2 heartCenter = vec2(0.5) + vec2(cos(angle), sin(angle)) * spreadDist;
        
        // 爱心大小控制
        float heartSize = progress < 0.7 ? t * 0.25 * randomScale : (1.0 - progress) * 0.7 * randomScale;
        if (heartSize < 0.001) continue;
        
        // 生成像素风爱心遮罩（极小模糊保持锯齿）
        float heartMask = generateHeartMask(vUv, heartCenter, heartSize, 0.001);
        if (heartMask < 0.01) continue;
        
        // 爱心颜色处理：采样原图+暖色调+提升饱和度亮度
        vec4 heartTex = texture2D(tDiffuse, handleUVBounds(heartCenter));
        float gray = dot(heartTex.rgb, vec3(0.299, 0.587, 0.114));
        vec3 saturated = mix(vec3(gray), heartTex.rgb, 1.5);
        vec3 tinted = saturated * heartColorTint * 1.2;
        tinted = clamp(tinted, 0.0, 1.0);
        
        heartsColor.rgb += tinted * heartMask * heartAlpha;
        heartsColor.a += heartMask * heartAlpha;
    }
    heartsColor.a = clamp(heartsColor.a, 0.0, 1.0);
    
    // 5. 中心发光效果
    float glowIntensity = progress < 0.6 ? progress * 1.666 : (1.0 - progress) * 2.5;
    float glowMask = 1.0 - smoothstep(0.0, 0.8, length(vUv - 0.5));
    vec3 glowColor = heartColorTint * glowMask * glowIntensity * 0.3;
    
    // 6. 合并所有图层
    vec3 finalRGB = baseColor.rgb * baseColor.a + heartsColor.rgb * heartsColor.a + glowColor;
    float finalAlpha = clamp(baseColor.a + heartsColor.a, 0.0, 1.0);
    finalRGB = clamp(finalRGB, 0.0, 1.0);
    
    // 最终完全消失处理
    if (progress > 0.95) {
        finalAlpha *= (1.0 - progress) * 20.0;
    }
    
    return vec4(finalRGB, finalAlpha);
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