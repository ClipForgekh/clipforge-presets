exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float uBrightness; // = 1.0 [0.0, 1.0] // 画面亮度控制
uniform float uVortexStrength; // = 0.8 [0.0, 2.0] // 旋涡扭曲强度
uniform float uGlowStrength; // = 0.6 [0.0, 2.0] // 辉光效果强度

varying vec2 vUv;

float tween(float progress) {
    // 阻尼振荡曲线，匹配螺旋推进的物理运动效果
    return 1.0 - exp(-progress * 4.0) * cos(progress * 8.0 * 3.14159265);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 旋涡扭曲效果函数
vec2 vortexWarp(vec2 uv, vec2 center, float strength) {
    vec2 p = uv - center;
    float radius = length(p);
    float angle = atan(p.y, p.x) + strength * exp(-radius * 3.0);
    return vec2(cos(angle), sin(angle)) * radius + center;
}

// 软辉光效果函数
vec4 softGlow(sampler2D tex, vec2 uv, float strength, float ratio) {
    vec4 base = texture2D(tex, uv);
    float brightness = dot(base.rgb, vec3(0.299, 0.587, 0.114));
    if (brightness < 0.7) return base;
    
    vec2 stepSize = vec2(0.002, 0.002 / ratio) * strength;
    vec4 sum = vec4(0.0);
    sum += texture2D(tex, uv + stepSize);
    sum += texture2D(tex, uv - stepSize);
    sum += texture2D(tex, uv + vec2(stepSize.x, -stepSize.y));
    sum += texture2D(tex, uv + vec2(-stepSize.x, stepSize.y));
    sum *= 0.2;
    
    return base + sum * strength * 0.5;
}

vec4 effect(vec4 texel, float progress) {
    // 旋涡扭曲强度，首尾自动归零
    float warpAmount = uVortexStrength * (1.0 - pow(abs(progress * 2.0 - 1.0), 3.0));
    vec2 warpedUV = vortexWarp(vUv, vec2(0.5), warpAmount);
    warpedUV = handleUVBounds(warpedUV);
    vec4 warpedTexel = texture2D(tDiffuse, warpedUV);
    
    // 亮度调整
    vec3 brightColor = warpedTexel.rgb * uBrightness;
    
    // 辉光强度，首尾自动归零
    float glowAmount = uGlowStrength * (1.0 - pow(abs(progress * 2.0 - 1.0), 2.0));
    vec4 glowColor = softGlow(tDiffuse, warpedUV, glowAmount, ratio);
    
    // 混合效果，禁用透明度渐变
    vec3 finalRGB = mix(brightColor, glowColor.rgb, glowAmount * 0.3);
    return vec4(finalRGB, texel.a);
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