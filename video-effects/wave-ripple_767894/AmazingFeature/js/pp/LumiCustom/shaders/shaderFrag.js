exports.source=`
//===begin_frag_code===
precision highp float;

#define PI 3.141592653589793

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float uBrightness; // = 1.0 [0.0, 2.0] // 亮度控制
uniform float uColumnIndex; // = 0.0 [0.0, 15.0] // 立柱编号0-15
uniform int uIsMainCard; // = 0 [0, 1] // 是否为主卡(1=主卡 0=立柱)
uniform float uRippleMaxStrength; // = 0.16 [0.0, 0.5] // 最大波纹强度
uniform float uGrainMaxStrength; // = 0.22 [0.0, 0.5] // 最大颗粒强度

varying vec2 vUv;

// 循环专用tween曲线: 0和1值相同, 中间平滑过渡
float tween(float progress) {
    return 0.5 * (1.0 - cos(progress * 2.0 * PI));
}

// 伪随机函数 用于颗粒效果
float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453);
}

// 波纹扭曲效果
vec2 rippleWarp(vec2 uv, float strength, float phase) {
    float warp = strength * sin(uv.y * 10.0 + phase * 2.0 * PI);
    return vec2(uv.x + warp, uv.y);
}

// 35mm胶片颗粒效果
vec3 filmGrain(vec3 color, float strength, vec2 uv) {
    float grain = random(uv + progress * 100.0) * strength;
    return color + (grain - 0.5 * strength);
}

vec4 effect(vec4 texel, float progress) {
    // 主卡无特效 直接返回
    if (uIsMainCard == 1) {
        return vec4(texel.rgb * uBrightness, 1.0);
    }

    // 计算动态参数
    float tweenVal = tween(progress);
    float columnPhase = uColumnIndex * PI / 16.0; // 11.25度 = PI/16
    
    // 波纹强度随时间变化 首尾为0
    float rippleStrength = uRippleMaxStrength * tweenVal * tweenVal;
    vec2 warpedUV = rippleWarp(vUv, rippleStrength, progress + columnPhase);
    vec4 warpedTexel = texture2D(tDiffuse, warpedUV);
    
    // 颗粒强度随时间变化 首尾为0
    float grainStrength = uGrainMaxStrength * tweenVal * tweenVal;
    vec3 grainedColor = filmGrain(warpedTexel.rgb, grainStrength, vUv);
    
    // 亮度控制 周期变化
    float brightnessMod = 0.18 * pow(sin(PI * progress + columnPhase), 2.0);
    float finalBrightness = uBrightness + brightnessMod;
    
    return vec4(grainedColor * finalBrightness, 1.0);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    const float fadeInEnd = 0.0;
    const float fadeOutStart = 1.0;
    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    effectProgress = tween(effectProgress);
    vec4 effectColor = effect(texel, progress);
    vec4 finalColor = effectColor;
    gl_FragColor = finalColor;
}
//===end_frag_code===
`;