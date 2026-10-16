exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float swirlStrength; // = 10.0 [1.0, 20.0] // 漩涡扭曲强度

varying vec2 vUv;

// 缓出曲线，模拟液体逐渐平复的过程
float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：使用clamp留黑，模拟被搅动时边缘的空缺
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    // 强度计算：入场动画，progress=0时效果最强，progress=1时效果消失
    float intensity = (1.0 - tween(progress)) * swirlStrength;
    
    // 1. 坐标中心化
    vec2 uv = vUv - 0.5;
    
    // 2. 宽高比修正：确保漩涡是圆形的，而不是椭圆
    if (ratio > 1.0) {
        uv.y /= ratio;
    } else {
        uv.x *= ratio;
    }
    
    // 3. 计算极坐标
    float dist = length(uv);
    
    // 4. 计算液化漩涡角度
    // 使用指数衰减 exp(-dist) 让中心扭曲最强
    // 叠加 sin 波动模拟液体的流动和干扰感
    float angle = intensity * exp(-dist * 2.5) * sin(dist * 5.0 - intensity);
    
    float s = sin(angle);
    float c = cos(angle);
    
    // 5. 应用旋转
    vec2 rotatedUV = vec2(
        uv.x * c - uv.y * s,
        uv.x * s + uv.y * c
    );
    
    // 6. 还原宽高比修正
    if (ratio > 1.0) {
        rotatedUV.y *= ratio;
    } else {
        rotatedUV.x /= ratio;
    }
    
    // 7. 还原坐标系并处理边界
    vec2 finalUV = rotatedUV + 0.5;
    finalUV = handleUVBounds(finalUV);
    
    return texture2D(tDiffuse, finalUV);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    
    // 视频动画专用配置
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;
    
    // 计算特效进度
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    
    // 应用特效
    vec4 finalColor = effect(texel, effectProgress);
    
    gl_FragColor = finalColor;
}
//===end_frag_code===
`;