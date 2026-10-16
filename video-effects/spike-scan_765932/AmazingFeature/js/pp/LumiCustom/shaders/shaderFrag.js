exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义参数
uniform float beamDensity; // = 80.0 [40.0, 120.0] // 光束数量
uniform vec3 beamColor; // = vec3(0.7, 0.8, 1.0) // 光束颜色（银灰蓝色）
uniform float grainIntensity; // = 0.3 [0.0, 1.0] // 胶片颗粒强度
uniform float maxBeamBlur; // = 0.05 [0.01, 0.1] // 光束最大模糊半径

varying vec2 vUv;

// 伪随机函数
float hash11(float p) {
    return fract(sin(p * 12.9898) * 43758.5453);
}
float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float tween(float progress) {
    // 正弦缓出曲线，平滑自然适合短动画
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

vec4 effect(vec4 texel, float animProgress) {
    vec2 uv = vUv;
    
    // 计算当前光束索引
    float beamIndex = floor(uv.x * beamDensity);
    
    // 每个光束的随机参数
    float randomSpeed = hash11(beamIndex) * 0.6 + 0.4; // 速度范围0.4~1.0
    float randomDelay = hash11(beamIndex + 114.514) * 0.2; // 延迟范围0~0.2
    float randomBlur = hash11(beamIndex + 1919.810) * maxBeamBlur * 0.5 + maxBeamBlur * 0.5; // 模糊范围随机
    
    // 计算光束当前Y位置 (向上移动)
    float beamY = (animProgress - randomDelay) * randomSpeed * 1.5;
    // 光束有效范围裁剪
    beamY = clamp(beamY, -0.1, 1.1);
    
    // 计算显示蒙版：光束扫过的区域显示原图
    float showMask = step(uv.y, beamY);
    
    // 计算光束光效
    float beamMask = smoothstep(beamY, beamY - randomBlur, uv.y);
    float beamIntensity = (1.0 - animProgress) * 3.2; // 初始强度3.2逐渐减弱
    vec3 beamLight = beamColor * beamMask * beamIntensity;
    
    // 胶片颗粒效果
    float grain = (hash21(uv * 1000.0 + vec2(animProgress * 50.0)) * 2.0 - 1.0) * grainIntensity * (1.0 - animProgress);
    
    // 曝光闪烁效果
    float flicker = 1.0 + (hash21(vec2(animProgress * 20.0, 0.0)) * 0.15 - 0.075) * (1.0 - animProgress);
    
    // 混合结果
    vec3 baseColor = texel.rgb * showMask;
    vec3 finalColor = (baseColor + beamLight) * flicker + grain;
    
    // 动画结束时完全返回原图
    return mix(vec4(finalColor, texel.a * showMask), texel, animProgress);
}

void main() {
    // 获取纹理像素颜色
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- 特效配置 ---
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;

    // 1. 计算特效自身的进度
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, effectProgress);

    // 2. 直接应用特效
    vec4 finalColor = effectColor;

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;