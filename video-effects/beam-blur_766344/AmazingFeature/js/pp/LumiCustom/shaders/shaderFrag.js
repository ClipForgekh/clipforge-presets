exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float maxBlurUV; // = 0.04 [0.0, 0.2] // 最大纵向模糊半径（UV单位）
uniform float maxScale; // = 1.8 [1.0, 2.5] // 最大缩放倍数
uniform float maxBrightness; // = 1.5 [1.0, 2.0] // 最大亮度增益
uniform float maxSaturation; // = 1.2 [1.0, 2.0] // 最大饱和度增益
uniform float glowPeak; // = 2.2 [1.0, 3.0] // Deep Glow峰值强度
uniform vec3 glowColor; // = vec3(1.0, 0.86, 0.45) // 暖黄色发光颜色，RGB范围[0.0,1.0]

varying vec2 vUv;

float tween(float p) {
    return p < 0.5
        ? 4.0 * p * p * p
        : 1.0 - pow(-2.0 * p + 2.0, 3.0) * 0.5;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec3 applySaturation(vec3 color, float sat) {
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(luma), color, sat);
}

vec4 verticalBlur9Tap(sampler2D tex, vec2 uv, float radiusUV) {
    vec2 stepV = vec2(0.0, radiusUV / 4.0);
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv - 4.0 * stepV)) * 0.05;
    c += texture2D(tex, handleUVBounds(uv - 3.0 * stepV)) * 0.09;
    c += texture2D(tex, handleUVBounds(uv - 2.0 * stepV)) * 0.12;
    c += texture2D(tex, handleUVBounds(uv - 1.0 * stepV)) * 0.15;
    c += texture2D(tex, handleUVBounds(uv)) * 0.18;
    c += texture2D(tex, handleUVBounds(uv + 1.0 * stepV)) * 0.15;
    c += texture2D(tex, handleUVBounds(uv + 2.0 * stepV)) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + 3.0 * stepV)) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + 4.0 * stepV)) * 0.05;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    float zoom = mix(1.0, maxScale, strength);
    vec2 uv = 0.5 + (vUv - 0.5) / zoom;
    uv = handleUVBounds(uv);

    float blurR = maxBlurUV * strength;
    vec4 col = verticalBlur9Tap(tDiffuse, uv, blurR);

    float bright = mix(1.0, maxBrightness, strength);
    float sat = mix(1.0, maxSaturation, strength);
    col.rgb *= bright;
    col.rgb = applySaturation(col.rgb, sat);

    float glowAmt = (glowPeak - 1.0) * strength;
    float xBand = exp(-pow((vUv.x - 0.5) / 0.22, 2.0));
    float yBand = exp(-pow((vUv.y - 0.5) / 0.65, 2.0));
    float glowMask = xBand * (0.6 + 0.4 * yBand);
    col.rgb += glowColor * glowMask * glowAmt * 0.35;

    col.rgb = clamp(col.rgb, 0.0, 1.0);
    return vec4(col.rgb, texel.a);
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