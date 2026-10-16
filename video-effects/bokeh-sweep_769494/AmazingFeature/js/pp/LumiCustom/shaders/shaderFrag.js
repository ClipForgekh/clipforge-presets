exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform参数
uniform float hexBaseSize; // = 0.08 [0.03, 0.15] // 六边形散景基础大小
uniform float glowMaxIntensity; // = 2.8 [1.0, 4.0] // 辉光最大强度
uniform float sweepSpeed; // = 1.5 [0.8, 2.5] // 斜扫速度
uniform float radialBlurMax; // = 20.0 [5.0, 30.0] // 径向模糊最大半径

varying vec2 vUv;

// 缓出曲线，自然平滑过渡
float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

// 边界处理函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 伪随机函数
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

// 六边形SDF
float hexSDF(vec2 p, float r) {
    const vec3 k = vec3(-0.866025404, 0.5, 0.577350269);
    p = abs(p);
    p -= 2.0 * min(dot(k.xy, p), 0.0) * k.xy;
    p -= vec2(clamp(p.x, -k.z * r, k.z * r), r);
    return length(p) * sign(p.y);
}

// 坐标适配
vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

// 径向模糊实现
vec4 radialBlur(sampler2D tex, vec2 uv, float strength, vec2 center) {
    vec4 color = vec4(0.0);
    float total = 0.0;
    float blur = strength * 0.001;
    vec2 dir = uv - center;
    for (float i = 0.0; i < 10.0; i += 1.0) {
        float percent = i / 10.0;
        vec2 sampleUV = uv - dir * blur * percent;
        sampleUV = handleUVBounds(sampleUV);
        color += texture2D(tex, sampleUV) * (10.0 - i);
        total += 10.0 - i;
    }
    return color / total;
}

// 生成一层六边形散景
vec4 generateHexLayer(vec2 uv, float t, float gridSize, float spinSpeed, float sizeScale, float intensity) {
    vec4 layerColor = vec4(0.0);
    vec2 sweepOffset = vec2(-t * sweepSpeed * 1.2, t * sweepSpeed * 1.2); // 斜下45度位移
    vec2 gridUV = (uv + sweepOffset) / gridSize;
    vec2 gridID = floor(gridUV);
    vec2 gridPos = fract(gridUV) - 0.5;
    
    float rand = random(gridID);
    float size = hexBaseSize * sizeScale * (0.6 + rand * 0.8);
    float spin = t * spinSpeed * 3.14159265 * (rand > 0.5 ? 1.0 : -1.0);
    
    float s = sin(spin);
    float c = cos(spin);
    vec2 rotatedPos = vec2(dot(gridPos, vec2(c, -s)), dot(gridPos, vec2(s, c)));
    
    float dist = hexSDF(rotatedPos, size);
    float glow = smoothstep(0.0, size * 1.5, -dist) * intensity;
    vec3 color = rand > 0.4 ? vec3(0.2, 0.6, 1.0) : vec3(0.9, 0.95, 1.0); // 冰蓝+银白随机
    
    layerColor = vec4(color * glow, glow);
    return layerColor;
}

vec4 effect(vec4 texel, float progress) {
    float t = tween(1.0 - progress); // 入场效果强度因子
    float currentBlur = t * radialBlurMax;
    float brightness = mix(0.15, 1.0, 1.0 - t);
    float saturation = mix(0.7, 1.0, 1.0 - t);
    float currentGlow = mix(0.3, glowMaxIntensity, t);
    float alpha = t;
    
    // 处理背景径向模糊
    vec4 blurredTex = radialBlur(tDiffuse, vUv, currentBlur, vec2(0.5));
    
    // 调整背景亮度和饱和度
    vec3 bgColor = blurredTex.rgb * brightness;
    float gray = dot(bgColor, vec3(0.299, 0.587, 0.114));
    bgColor = mix(vec3(gray), bgColor, saturation);
    
    // 生成三层六边形散景
    vec4 layer1 = generateHexLayer(vUv, t, 0.3, 2.0, 1.0, currentGlow);
    vec4 layer2 = generateHexLayer(vUv, t, 0.45, 1.2, 1.6, currentGlow * 0.8);
    vec4 layer3 = generateHexLayer(vUv, t, 0.6, 0.7, 2.2, currentGlow * 0.5);
    
    // Add混合叠加散景
    vec3 finalColor = bgColor + layer1.rgb * alpha + layer2.rgb * alpha + layer3.rgb * alpha;
    finalColor = clamp(finalColor, 0.0, 1.0);
    
    return vec4(finalColor, blurredTex.a);
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