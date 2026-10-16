exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float ballSize; // = 0.25 [0.1, 0.5] // 小球初始大小
uniform float bounceIntensity; // = 0.4 [0.1, 0.8] // 弹跳高度强度
uniform float rollCycles; // = 2.0 [1.0, 5.0] // 滚动圈数

varying vec2 vUv; // 纹理坐标

// 缓出曲线：适合入场，初始速度快，结尾平滑
float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0); 
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 旋转函数
vec2 rotate(vec2 uv, vec2 center, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    uv -= center;
    uv = vec2(uv.x * c - uv.y * s, uv.x * s + uv.y * c);
    uv += center;
    return uv;
}

vec4 effect(vec4 texel, float p) {
    // p 从 0.0 (入场开始) 到 1.0 (完全恢复)
    
    // 1. 阶段划分：0.0-0.7 滚动入场，0.7-1.0 快速展开
    float stage1 = smoothstep(0.0, 0.7, p);
    float stage2 = smoothstep(0.7, 1.0, p);
    
    // 2. 计算球心位置
    // X: 从左侧屏幕外 (-ballSize) 到 中心 (0.5)
    float startX = -ballSize * ratio;
    float posX = mix(startX, 0.5, stage1);
    
    // Y: 弹跳效果 (使用绝对值正弦模拟重力回弹)，强度随进度衰减
    float bounce = abs(sin(stage1 * 10.0)) * bounceIntensity * (1.0 - stage1);
    float posY = 0.5 + bounce;
    vec2 center = vec2(posX, posY);
    
    // 3. 计算当前半径：从初始大小到覆盖全屏
    // 为了覆盖全屏，半径最终需要达到 > 1.0
    float currentRadius = mix(ballSize, 1.5, stage2);
    
    // 4. 计算到球心的距离 (考虑宽高比)
    vec2 aspectUv = vUv;
    aspectUv.x *= ratio;
    vec2 aspectCenter = center;
    aspectCenter.x *= ratio;
    float dist = length(aspectUv - aspectCenter);
    
    // 如果在球体外且还未到展开阶段，显示透明
    if (dist > currentRadius && stage2 < 0.01) {
        return vec4(0.0);
    }
    
    // 5. 模拟球体映射 (球面畸变)
    // 畸变强度在stage2逐渐消失
    float distortion = 1.0 - stage2;
    vec2 delta = vUv - center;
    float r = dist / currentRadius;
    
    // 球面投影公式简易版
    float rho = r * 1.570796; // PI/2
    float zoom = mix(1.0, 0.4, distortion); // 球体状态下缩小内容以显示更多画面
    
    // 计算旋转 (滚动效果)
    float angle = (1.0 - stage1) * rollCycles * 6.283185;
    vec2 uv = rotate(vUv, center, angle);
    
    // 应用球面扭曲
    if (r < 1.0) {
        vec2 sphericalDelta = (uv - center) * (sin(rho) / r) * zoom;
        uv = center + mix(uv - center, sphericalDelta, distortion);
    }
    
    // 6. 边缘混合 (让小球边缘平滑)
    float edgeAlpha = 1.0 - smoothstep(currentRadius - 0.01, currentRadius, dist);
    // 展开阶段 alpha 强制为 1.0
    float finalAlpha = mix(edgeAlpha, 1.0, stage2);
    
    vec4 finalTexel = texture2D(tDiffuse, handleUVBounds(uv));
    return vec4(finalTexel.rgb, finalTexel.a * finalAlpha);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);

    // 视频动画专用配置
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    // 使用自定义的缓动逻辑
    float t = tween(effectProgress);
    
    vec4 effectColor = effect(texel, t);

    gl_FragColor = effectColor;
}
//===end_frag_code===
`;