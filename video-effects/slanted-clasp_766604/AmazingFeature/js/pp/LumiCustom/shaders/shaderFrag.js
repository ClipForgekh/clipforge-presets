exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float bandWidth; // = 0.15 [0.05, 0.3] // 霓虹光带宽度
uniform float glitchStrength; // = 0.05 [0.01, 0.1] // RGB故障偏移强度
uniform float blurIntensity; // = 5.0 [1.0, 10.0] // 模糊强度
uniform vec3 neonColor1; // = vec3(1.0, 0.2, 1.0) // 霓虹紫色
uniform vec3 neonColor2; // = vec3(1.0, 0.6, 0.2) // 霓虹橙色

varying vec2 vUv;

float tween(float progress) {
    // 缓出曲线，先快后慢符合衰减要求
    return 1.0 - pow(1.0 - progress, 2.0);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 分辨率适配坐标转换
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

// 高斯模糊函数
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

vec4 effect(vec4 texel, float progress) {
    float t = progress;
    vec2 p = getAspectCorrectUV(vUv);
    
    // 三条平行45度扫描线位置，t=0在边缘，t=1汇聚中心
    float scan1Pos = -1.8 * (1.0 - t); // 左上扫描线
    float scan2Pos = 1.8 * (1.0 - t); // 右侧扫描线
    float scan3Pos = -0.8 * (1.0 - t); // 左下扫描线
    
    // 45度线距离计算
    float lineDist = p.x - p.y;
    float d1 = abs(lineDist - scan1Pos);
    float d2 = abs(lineDist - scan2Pos);
    float d3 = abs(lineDist - scan3Pos);
    float minDist = min(d1, min(d2, d3));
    
    // 扫过区域mask
    float showMask = step(scan1Pos, lineDist) * step(lineDist, scan2Pos) * step(scan3Pos, lineDist);
    
    // 光带区域判定
    float currentBandWidth = bandWidth * (1.0 - t + 0.1);
    float inBand = smoothstep(currentBandWidth, 0.0, minDist);
    
    // 45度方向故障偏移
    vec2 glitchDir = normalize(vec2(1.0, -1.0));
    float offset = glitchStrength * (1.0 - t) * inBand;
    vec2 uvR = handleUVBounds(vUv + glitchDir * offset);
    vec2 uvG = handleUVBounds(vUv);
    vec2 uvB = handleUVBounds(vUv - glitchDir * offset);
    
    // 模糊采样
    float currentBlur = blurIntensity * (1.0 - t) * inBand;
    vec4 colR = gaussianBlur(tDiffuse, uvR, currentBlur, ratio);
    vec4 colG = gaussianBlur(tDiffuse, uvG, currentBlur, ratio);
    vec4 colB = gaussianBlur(tDiffuse, uvB, currentBlur, ratio);
    vec4 baseCol = vec4(colR.r, colG.g, colB.b, 1.0);
    
    // 霓虹光带叠加
    vec3 neonGrad = mix(neonColor1, neonColor2, minDist / currentBandWidth);
    float neonAlpha = inBand * (1.0 - t) * 1.5;
    vec3 neonCol = neonGrad * neonAlpha;
    
    // 中心交汇爆闪效果
    float flash = smoothstep(0.9, 0.95, t) * smoothstep(1.0, 0.95, t) * 2.5;
    
    // 最终颜色合成
    vec3 finalCol = mix(baseCol.rgb + neonCol + flash, vec3(0.0), 1.0 - showMask);
    
    return vec4(finalCol, 1.0);
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