exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 画面特效类型声明
uniform float ratio; // = 1.0 [0.1, 2]

varying vec2 vUv; // 纹理坐标

// 自定义参数
uniform vec2 blurCenter; // = vec2(0.5, 0.5) // 放射模糊中心点
uniform float blurIntensity; // = 0.4 [0.0, 1.0] // 模糊最大强度系数

vec4 effect(vec4 texel, float progress) {
    // 根据progress计算当前模糊强度：0.0时模糊最大，1.0时无模糊
    float currentStrength = (1.0 - progress) * blurIntensity;
    
    // 放射方向：从当前点指向模糊中心
    vec2 dir = blurCenter - vUv;
    
    // 采样总颜色
    vec4 sum = vec4(0.0);
    
    // 固定的采样步数以保证性能和WebGL1.0兼容性
    const int SAMPLES = 20;
    
    // 在放射方向上进行多重采样
    for (int i = 0; i < SAMPLES; i++) {
        float scale = float(i) / float(SAMPLES - 1);
        // 通过偏移UV坐标获取邻域像素
        // 采样点沿着指向中心的矢量分布
        vec2 sampleUv = vUv + dir * currentStrength * scale;
        
        // 确保采样坐标在合法范围内
        sampleUv = clamp(sampleUv, 0.0, 1.0);
        
        sum += texture2D(tDiffuse, sampleUv);
    }
    
    // 计算平均颜色
    return sum / float(SAMPLES);
}

void main() {
    // 获取原始像素颜色
    vec4 texel = texture2D(tDiffuse, vUv);

    // --- Effect Configuration ---
    // 定义效果切入和切出的时间点
    const float fadeInEnd = 0.1;
    const float fadeOutStart = 0.9;

    // 1. 计算特效内部的进度 (0.0 到 1.0)
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    
    // 应用放射模糊特效逻辑
    vec4 effectColor = effect(texel, effectProgress);

    // 2. 计算统一的混合强度，处理入场和出场的平滑过渡
    float fadeInStrength = smoothstep(0.0, fadeInEnd, progress);
    float fadeOutStrength = 1.0 - smoothstep(fadeOutStart, 1.0, progress);
    float effectStrength = min(fadeInStrength, fadeOutStrength);

    // 3. 将原图与特效图根据强度进行混合
    vec4 finalColor = mix(texel, effectColor, effectStrength);

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;