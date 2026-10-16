exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float pixelSize; // = 0.02 [0.01, 0.05] // 像素块大小
uniform float pixelJumpIntensity; // = 1.0 [0.0, 2.0] // 像素跳动强度
uniform float flightSpeed; // = 1.0 [0.5, 2.0] // 心形飞行速度
uniform vec4 gbColor1; // = vec4(0.94, 0.96, 0.89, 1.0) // Game Boy米白色
uniform vec4 gbColor2; // = vec4(0.61, 0.66, 0.56, 1.0) // Game Boy浅灰色
uniform vec4 gbColor3; // = vec4(0.27, 0.29, 0.23, 1.0) // Game Boy深灰色
uniform vec4 gbColor4; // = vec4(0.05, 0.07, 0.06, 1.0) // Game Boy黑色

varying vec2 vUv;

// 随机哈希函数
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float tween(float progress) {
    // 三次缓出曲线，适合短动画
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用step函数实现硬边界裁切，避免缩小时的边缘拉丝效果
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 【强制使用】坐标空间转换函数：确保形状在不同屏幕比例下不变形
vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

// 【强制使用】获取能包裹整个屏幕的最大形状尺寸
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

// 【强制使用】分辨率适配的爱心SDF
float heartSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p /= max(size, 0.0001);
    p.y += 0.45; // 重心偏移修正
    return sdHeart(p) * size;
}

vec4 effect(vec4 texel, float progress) {
    const float explodeThreshold = 0.8;
    float flightT = clamp(progress / explodeThreshold, 0.0, 1.0);
    float explodeT = clamp((progress - explodeThreshold) / (1.0 - explodeThreshold), 0.0, 1.0);
    
    // 像素化UV处理
    vec2 pixelUV = floor(vUv / pixelSize) * pixelSize + pixelSize * 0.5;
    
    // 飞行过程像素跳动
    float jumpOffset = flightT * pixelJumpIntensity * pixelSize;
    pixelUV.x += (hash(pixelUV * flightT) * 2.0 - 1.0) * jumpOffset;
    pixelUV.y += (hash(pixelUV.yx * flightT) * 2.0 - 1.0) * jumpOffset;
    
    // 解体阶段像素飞散
    if (explodeT > 0.0) {
        vec2 flyDir = normalize(pixelUV - vec2(0.5 + hash(vec2(progress)) * 0.2));
        float flySpeed = explodeT * 3.0 * flightSpeed;
        pixelUV += flyDir * flySpeed * hash(pixelUV);
    }
    
    pixelUV = handleUVBounds(pixelUV);
    
    // 渲染27个带景深的3D心形
    vec4 heartLayer = vec4(0.0);
    for (int i = 0; i < 27; i++) {
        float rand1 = hash(vec2(float(i), 12.34));
        float rand2 = hash(vec2(float(i), 56.78));
        float rand3 = hash(vec2(float(i), 90.12));
        
        // 随机初始位置
        vec2 center = vec2(rand1, rand2);
        // 抛物线飞行轨迹偏移
        center.y -= 0.3 * flightT * flightT * (rand3 - 0.5) * 2.0;
        
        // 景深计算：初始z=10米，飞行到z=0
        float z = 10.0 * (1.0 - flightT * flightSpeed * (0.6 + rand3 * 0.4));
        if (z < 0.0) continue;
        
        // 近大远小缩放
        float heartSize = 0.12 / max(z, 0.1);
        float dist = heartSDF(pixelUV, center, heartSize);
        
        if (dist < 0.0) {
            // Game Boy四色映射
            float gray = hash(vec2(float(i), dist * 100.0));
            vec4 pixelCol;
            if (gray > 0.75) pixelCol = gbColor1;
            else if (gray > 0.5) pixelCol = gbColor2;
            else if (gray > 0.25) pixelCol = gbColor3;
            else pixelCol = gbColor4;
            
            // 近实远透
            float alpha = clamp(1.0 - z / 10.0, 0.0, 1.0);
            heartLayer = mix(heartLayer, pixelCol, alpha);
        }
    }
    
    // 解体阶段心形淡出
    heartLayer.a *= (1.0 - explodeT);
    
    // 底层素材淡入
    vec4 originalTex = texture2D(tDiffuse, vUv);
    
    // 混合效果
    vec4 finalColor = mix(heartLayer, originalTex, explodeT);
    
    // 最终帧完全返回原图
    if (progress >= 1.0) finalColor = originalTex;
    
    return finalColor;
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