exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义特效参数
uniform vec3 neonColor1; // = vec3(0.1, 0.3, 1.0) // 主霓虹蓝色
uniform vec3 neonColor2; // = vec3(0.7, 0.2, 0.9) // 次霓虹紫色
uniform float particleGroups; // = 8.0 [4, 16] // 粒子束组数
uniform float glowIntensity; // = 2.5 [0.5, 5.0] // 发光强度
uniform float spiralRotation; // = 3.0 [1.0, 6.0] // 螺旋旋转速度
uniform float glitchStrength; // = 0.05 [0.01, 0.2] // 故障拖影强度

varying vec2 vUv;

// 伪随机函数
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

// 缓出曲线
float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 分辨率适配UV
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

vec4 effect(vec4 texel, float progress) {
    // 底层画面亮度与对比度恢复
    float brightness = progress;
    float contrast = mix(0.5, 1.0, progress);
    vec3 baseColor = texel.rgb * contrast - (contrast - 1.0) * 0.5;
    baseColor *= brightness;
    
    // 粒子效果完全消失时直接返回原图
    if (progress >= 1.0) return vec4(baseColor, texel.a);
    
    // 转换到中心坐标系统
    vec2 uv = getAspectCorrectUV(vUv);
    vec2 p = uv - 0.5;
    float len = length(p);
    float angle = atan(p.y, p.x);
    
    // 粒子发光衰减因子
    float decay = 1.0 - progress;
    vec3 neonGlow = vec3(0.0);
    float edgeFlash = 0.0;
    
    // 生成多组螺旋粒子束
    for (float i = 0.0; i < 16.0; i++) {
        if (i >= particleGroups) break;
        
        // 每组粒子的基础参数
        float groupId = i / particleGroups;
        float baseAngle = groupId * 6.28318 + progress * spiralRotation;
        float speedOffset = rand(vec2(groupId, 0.123)) * 0.5 + 0.75;
        float flyDistance = progress * speedOffset * 1.2;
        
        // 主粒子束
        float angleDiff = mod(angle - baseAngle + 3.14159, 6.28318) - 3.14159;
        float particleRadius = 0.02 * (1.0 + rand(vec2(groupId, 0.456)) * 0.5) * decay;
        float mainParticle = smoothstep(particleRadius, 0.0, abs(angleDiff)) * smoothstep(flyDistance + 0.02, flyDistance, len);
        
        // 次级分裂粒子
        float subAngle1 = baseAngle + (rand(vec2(groupId, 0.789)) - 0.5) * 0.8;
        float subSpeed1 = speedOffset * (rand(vec2(groupId, 0.111)) * 0.3 + 0.6);
        float subFly1 = progress * subSpeed1 * 1.2;
        float subParticle1 = smoothstep(particleRadius * 0.6, 0.0, abs(mod(angle - subAngle1 + 3.14159, 6.28318) - 3.14159)) * smoothstep(subFly1 + 0.02, subFly1, len);
        
        float subAngle2 = baseAngle + (rand(vec2(groupId, 0.222)) - 0.5) * 0.8;
        float subSpeed2 = speedOffset * (rand(vec2(groupId, 0.333)) * 0.3 + 0.6);
        float subFly2 = progress * subSpeed2 * 1.2;
        float subParticle2 = smoothstep(particleRadius * 0.6, 0.0, abs(mod(angle - subAngle2 + 3.14159, 6.28318) - 3.14159)) * smoothstep(subFly2 + 0.02, subFly2, len);
        
        // 拖影效果
        float trail = smoothstep(flyDistance - 0.1 * decay, flyDistance, len) * smoothstep(particleRadius * 3.0, 0.0, abs(angleDiff)) * decay * 0.5;
        
        // 边缘碰撞闪光
        if (flyDistance > 0.9 && len > 0.9) {
            edgeFlash += smoothstep(0.9, 1.0, flyDistance) * 0.3 * decay;
        }
        
        // 故障彩条效果
        vec3 particleColor = mix(neonColor1, neonColor2, rand(vec2(groupId, progress)));
        neonGlow += (mainParticle + subParticle1 + subParticle2 + trail) * particleColor * glowIntensity * decay;
    }
    
    // 故障拖影RGB分离
    float glitchOffset = glitchStrength * decay;
    vec2 glitchUVR = handleUVBounds(vUv + vec2(glitchOffset * sin(progress * 10.0), 0.0));
    vec2 glitchUVB = handleUVBounds(vUv + vec2(-glitchOffset * cos(progress * 10.0), 0.0));
    float r = texture2D(tDiffuse, glitchUVR).r;
    float b = texture2D(tDiffuse, glitchUVB).b;
    baseColor = mix(baseColor, vec3(r, baseColor.g, b), decay * 0.3);
    
    // 边缘电弧闪光
    neonGlow += vec3(0.8, 0.9, 1.0) * edgeFlash;
    
    // 叠加粒子效果
    vec3 finalColor = baseColor + neonGlow;
    
    // 初始全黑
    if (progress < 0.01) finalColor = vec3(0.0);
    
    return vec4(finalColor, texel.a);
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