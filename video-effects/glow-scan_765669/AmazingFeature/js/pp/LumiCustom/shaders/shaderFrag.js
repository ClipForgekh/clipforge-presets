exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float blurMax; // = 0.04 [0.0, 0.12] // 纵向最大模糊半径（UV）
uniform float glowStrength; // = 3.0 [0.0, 6.0] // 扫描光强度
uniform vec3 glowColor; // = vec3(0.35, 0.7, 1.0) // 冷蓝光颜色
uniform float bandHeight; // = 0.17 [0.05, 0.4] // 扫描带高度
uniform float feather; // = 0.02 [0.001, 0.08] // 线性擦除羽化
uniform float stretchStrength; // = 1.0 [0.0, 2.0] // 纵向拉伸强度

varying vec2 vUv;

float tween(float p) {
    return p < 0.5
        ? 4.0 * p * p * p
        : 1.0 - pow(-2.0 * p + 2.0, 3.0) * 0.5;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlur(sampler2D tex, vec2 uv, float radius) {
    vec2 stepV = vec2(0.0, radius / 6.0);
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv - 3.0 * stepV)) * 0.08;
    c += texture2D(tex, handleUVBounds(uv - 2.0 * stepV)) * 0.12;
    c += texture2D(tex, handleUVBounds(uv - 1.0 * stepV)) * 0.17;
    c += texture2D(tex, handleUVBounds(uv)) * 0.26;
    c += texture2D(tex, handleUVBounds(uv + 1.0 * stepV)) * 0.17;
    c += texture2D(tex, handleUVBounds(uv + 2.0 * stepV)) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + 3.0 * stepV)) * 0.08;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;
    float scanY = 1.0 - p;

    float wipeMask = 1.0 - smoothstep(scanY - feather, scanY + feather, vUv.y);

    float d = abs(vUv.y - scanY);
    float band = exp(-d * d / max(0.0001, bandHeight * bandHeight));

    float stretchAmt = stretchStrength * strength * band * 0.18;
    vec2 uv = vUv;
    uv.y += (vUv.y - scanY) * stretchAmt;
    uv = handleUVBounds(uv);

    vec4 stretched = texture2D(tDiffuse, uv);

    float blurRadius = blurMax * strength * (0.35 + 0.65 * wipeMask);
    vec4 blurred = verticalBlur(tDiffuse, uv, blurRadius);

    float blurMix = clamp(strength * wipeMask, 0.0, 1.0);
    vec3 color = mix(stretched.rgb, blurred.rgb, blurMix);

    float brightness = mix(2.0, 1.0, p);
    float contrast = mix(0.6, 1.0, p);
    color = ((color - 0.5) * contrast + 0.5) * brightness;

    float glowAlpha = strength * band * (0.4 + 0.6 * wipeMask);
    color += glowColor * glowStrength * glowAlpha;

    color = clamp(color, 0.0, 1.0);
    return vec4(color, texel.a);
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