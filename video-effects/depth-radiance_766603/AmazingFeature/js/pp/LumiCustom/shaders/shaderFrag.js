exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理A（转场前画面）
uniform sampler2D tDiffuse1; // 目标纹理B（转场后画面）
uniform float progress; // = 0.0 [0.0, 1.0] // 转场进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float layerCount; // = 5.0 [3.0, 10.0] // 纵深切片层数
uniform float grainIntensity; // = 0.12 [0.0, 0.3] // 胶片颗粒强度
uniform vec3 glowColor; // = vec3(1.0, 0.6, 0.2) // 暖金色眩光颜色
uniform float maxBlur; // = 0.35 [0.1, 0.8] // 最大垂直模糊强度

varying vec2 vUv;

// 随机数生成函数（用于胶片颗粒）
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 垂直模糊函数
vec4 verticalBlur(sampler2D tex, vec2 uv, float blurAmount) {
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    // 5阶高斯权重
    float weights[5];
    weights[0] = 0.0545; weights[1] = 0.2442; weights[2] = 0.4026; weights[3] = 0.2442; weights[4] = 0.0545;
    float stepSize = blurAmount * 0.02;
    
    for(int i = -2; i <= 2; i++) {
        vec2 offset = vec2(0.0, float(i) * stepSize);
        vec2 sampleUV = clamp(uv + offset, 0.0, 1.0);
        color += texture2D(tex, sampleUV) * weights[i + 2];
        totalWeight += weights[i + 2];
    }
    return color / totalWeight;
}

// 缓入缓出动画曲线
float tween(float p) {
    return p < 0.5 ? 4.0 * p * p * p : 1.0 - pow(-2.0 * p + 2.0, 3.0) * 0.5;
}

void main() {
    float t = tween(progress);
    
    // 转场阶段划分：0-0.5为A画面穿梭阶段，0.5-1为B画面回落阶段
    float phase = step(0.5, t);
    float phaseProgress = phase == 0.0 ? t * 2.0 : (t - 0.5) * 2.0;
    
    vec4 finalColor = vec4(0.0);
    float layerStep = 1.0 / layerCount;
    
    // 分层渲染纵深切片
    for(float i = 0.0; i < 10.0; i++) {
        if(i >= layerCount) break;
        
        // 计算切片Z轴偏移：A阶段向前运动，B阶段向后回落
        float zOffset = phase == 0.0 ? phaseProgress * (1.0 + i * layerStep) : (1.0 - phaseProgress) * (1.0 + i * layerStep);
        float scale = 1.0 + zOffset * 0.5;
        
        // B阶段添加对焦呼吸效应
        if(phase == 1.0) {
            scale += sin(phaseProgress * 12.566) * 0.03 * (1.0 - phaseProgress);
        }
        
        // 计算切片UV坐标
        vec2 layerUV = (vUv - 0.5) / scale + 0.5;
        layerUV = clamp(layerUV, 0.0, 1.0);
        
        // 距离镜头越近模糊强度越高
        float blurAmount = maxBlur * zOffset;
        // 分别采样两个纹理再混合，避免sampler赋值错误
        vec4 layerColorA = verticalBlur(tDiffuse, layerUV, blurAmount);
        vec4 layerColorB = verticalBlur(tDiffuse1, layerUV, blurAmount);
        vec4 layerColor = mix(layerColorA, layerColorB, phase);
        
        // 每层透明度权重，近实远虚
        float layerWeight = (i + 1.0) / layerCount * layerStep * 2.0;
        
        // 亮部提取生成眩光
        float luminance = dot(layerColor.rgb, vec3(0.299, 0.587, 0.114));
        vec3 glow = glowColor * pow(luminance, 3.0) * blurAmount * 2.0;
        layerColor.rgb += glow;
        
        finalColor += layerColor * layerWeight;
    }
    
    // 转场中点峰值眩光
    float centerGlow = pow(sin(t * 3.14159265), 8.0) * 1.5;
    finalColor.rgb += glowColor * centerGlow;
    
    // 叠加胶片颗粒，B阶段结束保留10%颗粒质感
    float grain = random(vUv + t * 10.0);
    float grainAmount = phase == 0.0 ? grainIntensity : mix(grainIntensity, 0.1 * grainIntensity, phaseProgress);
    finalColor.rgb += grain * grainAmount;
    
    // 边界帧处理
    if(progress <= 0.01) finalColor = texture2D(tDiffuse, vUv);
    if(progress >= 0.99) finalColor = texture2D(tDiffuse1, vUv);
    
    gl_FragColor = clamp(finalColor, 0.0, 1.0);
}
//===end_frag_code===
`;