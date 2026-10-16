exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float maxBlurPx; // = 25.0 [0.0, 40.0] // 初始最大模糊半径（像素近似）
uniform float maxExposure; // = 2.5 [1.0, 3.0] // 初始最大曝光
uniform float maxSaturation; // = 1.8 [1.0, 2.5] // 初始最大饱和度
uniform float maxGlowIntensity; // = 3.0 [0.0, 4.0] // 初始暖光强度
uniform vec3 warmTemperatureColor; // = vec3(1.0, 0.82, 0.58) // 暖色温偏移，范围[0.0,1.0]
uniform vec3 warmGlowColor; // = vec3(1.0, 0.78, 0.45) // 暖金发光颜色，范围[0.0,1.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec3 adjustSaturation(vec3 color, float sat) {
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(luma), color, sat);
}

vec3 screenBlend(vec3 base, vec3 blend) {
    return 1.0 - (1.0 - base) * (1.0 - blend);
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float blurPx) {
    float baseStep = blurPx * 0.0015;
    vec2 stepSize = ratio > 1.0
        ? vec2(baseStep / ratio, baseStep)
        : vec2(baseStep, baseStep * ratio);

    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0, -1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv))                                * 4.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  1.0))) * 1.0;
    return c / 16.0;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    float blurNow = maxBlurPx * strength;
    vec4 blurred = gaussianBlur9(tDiffuse, vUv, blurNow);

    float exposureNow = 1.0 + (maxExposure - 1.0) * strength;
    float saturationNow = 1.0 + (maxSaturation - 1.0) * strength;

    vec3 baseColor = blurred.rgb * exposureNow;
    baseColor = adjustSaturation(baseColor, saturationNow);

    vec3 tempTint = mix(vec3(1.0), warmTemperatureColor, strength);
    baseColor *= tempTint;

    float glowAlpha = strength;
    vec3 glowLayer = blurred.rgb * warmGlowColor * (maxGlowIntensity * strength);
    vec3 screened = screenBlend(baseColor, glowLayer);
    vec3 finalRgb = mix(baseColor, screened, glowAlpha);

    finalRgb = clamp(finalRgb, 0.0, 1.0);
    return vec4(finalRgb, texel.a);
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