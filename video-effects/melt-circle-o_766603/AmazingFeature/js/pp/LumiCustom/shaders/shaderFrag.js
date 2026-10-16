exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float overExposureStrength; // = 2.0 [0.5, 5.0] // 过曝强度
uniform float fragmentCount; // = 60.0 [20.0, 100.0] // 碎片密度（值越大碎片越多）
uniform float flySpeed; // = 2.0 [0.5, 5.0] // 飞散速度
uniform float blurStrength; // = 0.05 [0.01, 0.2] // 径向模糊强度

varying vec2 vUv;

// 随机函数
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float tween(float progress) {
    // 强缓入曲线，符合出场动画加速消失的特性
    return pow(progress, 5.0);
}

vec4 effect(vec4 texel, float progress) {
    float t = progress;
    if (t <= 0.001) return texel;
    
    // 适配宽高比的中心坐标
    vec2 centeredUv = vUv - 0.5;
    if (ratio > 1.0) centeredUv.y /= ratio;
    else centeredUv.x *= ratio;
    
    // 径向参数计算
    float angle = atan(centeredUv.y, centeredUv.x);
    float dist = length(centeredUv);
    vec2 radialDir = vec2(cos(angle), sin(angle));
    
    // 碎片网格化处理
    vec2 gridUV = centeredUv * fragmentCount;
    vec2 cellId = floor(gridUV);
    float cellRand = random(cellId);
    float cellRand2 = random(cellId + 123.45);
    
    // 碎片加速飞散
    float flyDist = t * t * flySpeed * (0.6 + cellRand * 0.8);
    vec2 flyOffset = radialDir * flyDist + vec2(cellRand - 0.5, cellRand2 - 0.5) * t * 0.1;
    vec2 fragmentUV = centeredUv + flyOffset;
    
    // 转换回标准UV坐标
    if (ratio > 1.0) fragmentUV.y *= ratio;
    else fragmentUV.x /= ratio;
    fragmentUV += 0.5;
    fragmentUV = handleUVBounds(fragmentUV);
    
    // 径向模糊采样
    float blurSize = t * blurStrength;
    vec2 blurStep = radialDir * blurSize * (0.8 + cellRand * 0.4);
    vec4 blurColor = vec4(0.0);
    float totalWeight = 0.0;
    for (int i = 0; i < 4; i++) {
        float weight = 1.0 - float(i) / 4.0;
        vec2 sampleUV = handleUVBounds(fragmentUV + blurStep * float(i));
        blurColor += texture2D(tDiffuse, sampleUV) * weight;
        totalWeight += weight;
    }
    blurColor /= totalWeight;
    
    // 暖金色过曝效果
    vec3 goldTint = vec3(1.0, 0.75, 0.35);
    vec3 overExposed = mix(blurColor.rgb, goldTint, t * 0.6);
    overExposed *= 1.0 + t * overExposureStrength * (1.0 + cellRand * 0.5);
    
    // 亮度衰减与边界消隐
    float alpha = 1.0 - t * 1.2;
    alpha *= smoothstep(1.0, 0.6, dist + t * 1.8);
    alpha *= smoothstep(0.0, 0.1, alpha);
    alpha = clamp(alpha, 0.0, 1.0);
    
    return vec4(overExposed * alpha, alpha);
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