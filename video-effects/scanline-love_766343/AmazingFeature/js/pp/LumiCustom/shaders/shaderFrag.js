exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float pixelSize; // = 15.0 [5.0, 30.0] // 像素块大小
uniform float scanLineIntensity; // = 0.3 [0.0, 0.8] // 扫描线强度
uniform vec3 lightPink; // = vec3(1.0, 0.7, 0.8) // GameBoy浅粉色
uniform vec3 offWhite; // = vec3(0.95, 0.95, 0.9) // GameBoy米白色
uniform vec3 darkGray; // = vec3(0.2, 0.2, 0.2) // GameBoy深灰色
uniform float bounceIntensity; // = 0.3 [0.1, 0.8] // 弹跳强度

varying vec2 vUv;

// 随机函数
float random(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float tween(float progress) {
    // 正弦缓出曲线，自然平滑适配两段动画
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
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

// 获取最大形状尺寸
float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

// 爱心SDF
float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0)
        return sqrt(dot(p - vec2(0.25, 0.75), p - vec2(0.25, 0.75))) - sqrt(2.0) / 4.0;
    return sqrt(min(dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00)),
                    dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50)))) * sign(p.x - p.y);
}

// 分辨率适配爱心SDF
float heartSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p /= max(size, 0.0001);
    p.y += 0.45;
    return sdHeart(p) * size;
}

// 生成像素爱心蒙版
float generatePixelHeartMask(vec2 uv, vec2 center, float size) {
    float dist = heartSDF(uv, center, size);
    return step(dist, 0.0);
}

vec4 effect(vec4 texel, float progress) {
    // 像素化UV
    float pixelUV = pixelSize / 1080.0;
    vec2 pixelatedUV = floor(vUv / pixelUV) * pixelUV + pixelUV * 0.5;
    
    // 两段动画分割：前半段汇聚，后半段消散
    float phase = progress < 0.5 ? progress * 2.0 : (1.0 - progress) * 2.0;
    bool isGatherPhase = progress < 0.5;
    
    // 底层原图处理
    float gray = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float saturation = smoothstep(0.5, 1.0, progress);
    float brightness = 0.25 + progress * 0.75;
    vec3 baseColor = mix(vec3(gray) * brightness, texel.rgb, saturation);
    
    // 扫描线效果
    float scanLine = step(0.5, fract(pixelatedUV.y * 1080.0 / 2.0)) * scanLineIntensity * (1.0 - progress);
    baseColor -= scanLine;
    
    // 爱心簇参数
    vec2 heartStartPositions[8];
    heartStartPositions[0] = vec2(-0.2, -0.2);
    heartStartPositions[1] = vec2(-0.2, 1.2);
    heartStartPositions[2] = vec2(1.2, -0.2);
    heartStartPositions[3] = vec2(1.2, 1.2);
    heartStartPositions[4] = vec2(-0.5, 0.5);
    heartStartPositions[5] = vec2(1.5, 0.5);
    heartStartPositions[6] = vec2(0.5, -0.3);
    heartStartPositions[7] = vec2(0.5, 1.3);
    
    vec3 heartColors[3];
    heartColors[0] = lightPink;
    heartColors[1] = offWhite;
    heartColors[2] = darkGray;
    
    vec3 heartLayer = vec3(0.0);
    float heartAlpha = 0.0;
    
    // 生成8个爱心簇
    for(int i = 0; i < 8; i++) {
        float rnd = random(vec2(float(i), 0.0));
        // 抛物线弹跳轨迹
        vec2 dir = vec2(0.5, 0.5) - heartStartPositions[i];
        float bounceY = sin(phase * 3.14159 * (1.0 + rnd * 0.5)) * bounceIntensity * (1.0 - phase);
        vec2 currentPos = heartStartPositions[i] + dir * phase + vec2(0.0, bounceY);
        
        // 爱心缩放 0.4→1.1→0
        float scale = isGatherPhase ? (0.4 + phase * 0.7) : (1.1 - (1.0 - phase) * 1.1);
        scale *= (0.9 + rnd * 0.2);
        
        // 弹性形变
        float deform = sin(phase * 3.14159) * 0.1;
        vec2 deformUV = pixelatedUV;
        deformUV.y += deform * abs(deformUV.x - 0.5);
        
        // 生成爱心
        float heartSize = scale * 0.15 * (1.0 + rnd * 0.3);
        float mask = generatePixelHeartMask(deformUV, currentPos, heartSize);
        
        // 随机颜色
        int colorIdx = int(floor(rnd * 3.0));
        heartLayer += heartColors[colorIdx] * mask;
        heartAlpha += mask;
    }
    
    // 混合爱心和底层
    float heartOpacity = isGatherPhase ? phase : (1.0 - phase) * 1.5;
    vec3 finalColor = mix(baseColor, heartLayer, clamp(heartAlpha * heartOpacity, 0.0, 1.0));
    
    return vec4(finalColor, 1.0);
}

void main() {
    // 获取纹理像素颜色
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- 特效配置 ---
    // 视频动画专用配置，不影响其他模块
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    // 1. 计算特效自身的进度
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);

    // 2. 直接应用特效（视频动画不需要额外的淡入淡出混合）
    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;