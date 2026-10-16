exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float blurRadius; // = 0.03 [0.0, 0.12] // 纵向最大模糊半径（UV单位）
uniform float glowStrength; // = 2.5 [0.0, 4.0] // 发光强度
uniform vec3 glowColor; // = vec3(0.9, 0.95, 1.0) // 冷白色发光颜色
uniform float brightnessBoost; // = 0.8 [0.0, 1.5] // 初始额外亮度增益

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    float holdEnd = 0.1;
    float effectEnd = 0.8;
    if (p <= holdEnd) return 0.0;
    if (p >= effectEnd) return 1.0;
    float x = (p - holdEnd) / (effectEnd - holdEnd);
    return smoothstep(0.0, 1.0, x);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlur9(sampler2D tex, vec2 uv, float radiusUV) {
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -4.0 * radiusUV))) * 0.05;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -3.0 * radiusUV))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -2.0 * radiusUV))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -1.0 * radiusUV))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv)) * 0.18;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  1.0 * radiusUV))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  2.0 * radiusUV))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  3.0 * radiusUV))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  4.0 * radiusUV))) * 0.05;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float effectStrength = 1.0 - clamp(p, 0.0, 1.0);

    float radius = blurRadius * effectStrength / max(ratio, 0.0001);
    vec4 blurred = verticalBlur9(tDiffuse, vUv, radius);

    vec3 blurMix = mix(texel.rgb, blurred.rgb, effectStrength);

    float lum = dot(blurred.rgb, vec3(0.299, 0.587, 0.114));
    vec3 glow = glowColor * lum * glowStrength * effectStrength;

    float gain = 1.0 + brightnessBoost * effectStrength;
    vec3 finalRgb = blurMix * gain + glow;
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