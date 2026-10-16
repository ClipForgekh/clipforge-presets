exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义可调节参数
uniform float scanLineWidth; // = 0.02 [0.005, 0.05] // 扫描线宽度
uniform vec3 blueColor; // = vec3(0.0, 0.8, 1.0) // 冰蓝发光色
uniform vec3 redColor; // = vec3(1.0, 0.2, 0.8) // 玫红发光色
uniform float glitchStrength; // = 0.05 [0.01, 0.2] // RGB故障偏移强度
uniform float flySpeed; // = 2.0 [0.5, 5.0] // 切片飞离速度
uniform float glowIntensity; // = 2.0 [0.5, 5.0] // 扫描线发光强度

varying vec2 vUv;

// 前快后慢的缓入曲线，匹配扫描线移动节奏
float tween(float progress) {
    return sqrt(progress);
}

// 边界处理函数：留黑处理避免纹理重复
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 硬边界裁切函数，避免边缘拉丝
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

// 分辨率适配UV，保证45度斜向不变形
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

vec4 effect(vec4 texel, float t) {
    // 进度为0时直接返回原图
    if (t <= 0.0) return texel;
    
    vec2 uv = getAspectCorrectUV(vUv);
    float diag = uv.x + uv.y; // 45度斜向坐标
    
    // 两组共6条扫描线，3条从左上出发(冰蓝)，3条从右下出发(玫红)
    float scanBlue1 = abs(diag - (t * 0.9 + 0.0));
    float scanBlue2 = abs(diag - (t * 0.9 + 0.3));
    float scanBlue3 = abs(diag - (t * 0.9 + 0.6));
    float scanRed1 = abs(diag - (2.0 - t * 0.9 - 0.0));
    float scanRed2 = abs(diag - (2.0 - t * 0.9 - 0.3));
    float scanRed3 = abs(diag - (2.0 - t * 0.9 - 0.6));
    
    // 计算扫描线发光效果
    float blueGlow = smoothstep(scanLineWidth, 0.0, scanBlue1) + 
                     smoothstep(scanLineWidth, 0.0, scanBlue2) + 
                     smoothstep(scanLineWidth, 0.0, scanBlue3);
    float redGlow = smoothstep(scanLineWidth, 0.0, scanRed1) + 
                    smoothstep(scanLineWidth, 0.0, scanRed2) + 
                    smoothstep(scanLineWidth, 0.0, scanRed3);
    vec3 glowColor = blueGlow * blueColor * glowIntensity + redGlow * redColor * glowIntensity;
    
    // 判定当前像素所属切片，获取触发时间与切片ID
    float triggerTime = 0.0;
    int sliceId = 0;
    if (diag < t * 0.9 + 0.0) { triggerTime = 0.0; sliceId = 0; }
    else if (diag < t * 0.9 + 0.3) { triggerTime = 0.0; sliceId = 1; }
    else if (diag < t * 0.9 + 0.6) { triggerTime = 0.333; sliceId = 2; }
    else if (diag < 2.0 - t * 0.9 - 0.6) { triggerTime = 0.666; sliceId = 3; }
    else if (diag < 2.0 - t * 0.9 - 0.3) { triggerTime = 0.666; sliceId = 4; }
    else if (diag < 2.0 - t * 0.9 - 0.0) { triggerTime = 0.333; sliceId = 5; }
    else { triggerTime = 0.0; sliceId = 6; }
    
    // 计算切片触发后的持续时间
    float triggerDur = max(0.0, t - triggerTime);
    if (triggerDur <= 0.0) {
        return vec4(texel.rgb + glowColor, texel.a);
    }
    
    // 替换%运算判断奇偶，避免WebGL1不支持模运算的问题
    float sliceFloat = float(sliceId);
    float isEven = 1.0 - step(0.001, fract(sliceFloat / 2.0));
    vec2 flyDir = mix(vec2(1.0, 1.0), vec2(-1.0, -1.0), isEven);
    float randomSpeed = 0.5 + fract(sliceFloat * 17.239) * 0.5;
    vec2 offsetUV = vUv + flyDir * triggerDur * flySpeed * randomSpeed;
    offsetUV = handleUVBounds(offsetUV);
    
    // RGB通道偏移故障效果
    float glitchOffset = triggerDur * glitchStrength * randomSpeed;
    vec4 rTex = texture2D(tDiffuse, offsetUV + vec2(glitchOffset, glitchOffset * 0.5));
    vec4 gTex = texture2D(tDiffuse, offsetUV);
    vec4 bTex = texture2D(tDiffuse, offsetUV - vec2(glitchOffset, glitchOffset * 0.5));
    vec3 glitchColor = vec3(rTex.r, gTex.g, bTex.b);
    
    // 透明度衰减与边界裁切
    float alpha = 1.0 - smoothstep(0.0, 1.0, triggerDur * 1.2);
    float mask = getHardBoundaryMask(offsetUV);
    alpha *= mask;
    
    // 最终颜色混合发光效果
    vec3 finalColor = glitchColor + glowColor;
    
    // 最后阶段残影衰减至纯黑
    float fadeOut = smoothstep(0.8, 1.0, progress);
    finalColor = mix(finalColor, vec3(0.0), fadeOut);
    alpha *= (1.0 - fadeOut);
    
    return vec4(finalColor, alpha);
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