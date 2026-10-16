exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

// 自定义uniform
uniform float diamondStartSize; // = 0.08 [0.02, 0.3] // 初始菱形尺寸占短边比例
uniform float edgeSoftness; // = 0.02 [0.001, 0.1] // 遮罩边缘柔化范围
uniform float glowWidth; // = 0.05 [0.005, 0.2] // 光晕宽度
uniform float glowIntensity; // = 0.35 [0.0, 1.0] // 光晕强度
uniform vec3 glowEdgeColor; // = vec3(1.0, 0.6, 0.8) // 光晕颜色

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 2.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用硬边界
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 边界裁切函数：使用柔和的边界裁切
float getSoftBoundaryMask(vec2 uv, float borderSize) {
    vec2 mask = smoothstep(vec2(0.0), vec2(borderSize), uv) * (1.0 - smoothstep(vec2(1.0 - borderSize), vec2(1.0), uv));
    return mask.x * mask.y;
}

// 分辨率适配函数：将UV坐标转换为等比例坐标
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

// 圆形距离场函数
float circleSDF(vec2 uv, vec2 center, float radius) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    return length(aspectUV - center) - radius;
}

// 矩形距离场函数
float rectSDF(vec2 uv, vec2 center, vec2 size) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    vec2 dist = abs(aspectUV - center) - size * 0.5;
    return length(max(dist, 0.0)) + min(max(dist.x, dist.y), 0.0);
}

// 爱心距离场
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

// 创建全屏爱心遮罩
float createFullScreenHeartMask(vec2 uv, vec2 center, float progress) {
    float maxSize = getMaxShapeSize();
    float acceleratedProgress = progress * progress;
    float currentSize = acceleratedProgress * maxSize;
    float dist = heartSDF(uv, center, currentSize);
    return smoothstep(0.01, -0.01, dist);
}

// 计算屏幕短边的相对尺寸
float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction;
    else return fraction * ratio;
}

// 计算屏幕长边的相对尺寸
float getLongSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction * ratio;
    else return fraction;
}

// 旋转工具函数
vec2 rotateVec(vec2 p, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c, -s, s, c) * p;
}

vec2 rotateAround(vec2 uv, vec2 center, float angle) {
    vec2 translated = uv - center;
    vec2 rotated = rotateVec(translated, angle);
    return rotated + center;
}

// 菱形距离场
float diamondSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p = abs(p);
    return (p.x + p.y) - size;
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;
    vec2 center = vec2(0.5);
    float shortSideSize = getShortSideRelativeSize(diamondStartSize);
    float heartMaxSize = getMaxShapeSize();
    float heartSize = mix(shortSideSize * 1.2, heartMaxSize, progress);
    float diamondSize = mix(shortSideSize, heartSize, progress);
    float rotationAngle = progress * 0.78539816339;
    vec2 rotatedUv = rotateAround(vUv, center, rotationAngle);
    float diamondDist = diamondSDF(rotatedUv, center, diamondSize);
    float heartDist = heartSDF(rotatedUv, center, heartSize);
    float morph = smoothstep(0.2, 0.8, progress);
    float shapeDist = mix(diamondDist, heartDist, morph);
    float softness = max(edgeSoftness, 0.0001);
    float mask = 1.0 - smoothstep(-softness, softness, shapeDist);
    float heartMask = generateHeartMask(rotatedUv, center, heartSize, softness);
    mask = mix(mask, heartMask, morph);
    mask = clamp(mask, 0.0, 1.0);
    float glowRange = max(glowWidth, softness * 1.5);
    float glow = (1.0 - smoothstep(0.0, glowRange, abs(shapeDist))) * effectStrength;
    vec3 glowContribution = glowEdgeColor * (glowIntensity * glow);
    vec3 color = clamp(texel.rgb * mask + glowContribution, 0.0, 1.0);
    float alpha = texel.a * mask;
    return vec4(color, alpha);
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