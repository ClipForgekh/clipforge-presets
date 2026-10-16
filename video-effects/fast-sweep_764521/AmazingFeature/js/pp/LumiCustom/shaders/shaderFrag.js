exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurRadius; // = 20.0 [0.0, 30.0] // 纵向模糊半径（近似像素）
uniform float glowStrength; // = 3.0 [0.0, 5.0] // 冷蓝光效强度
uniform vec3 glowColor; // = vec3(0.35, 0.7, 1.0) // 冷蓝色光效颜色，范围[0.0, 1.0]
uniform float bandSoftness; // = 0.22 [0.05, 0.5] // 扫光边缘柔和范围
uniform float grainAmount; // = 0.1 [0.0, 0.3] // 光效颗粒强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 verticalBlur(sampler2D tex, vec2 uv, float radiusPx) {
    float r = radiusPx * 0.001;
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -4.0 * r))) * 0.05;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -3.0 * r))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -2.0 * r))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -1.0 * r))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv)) * 0.18;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  1.0 * r))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  2.0 * r))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  3.0 * r))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  4.0 * r))) * 0.05;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float inv = 1.0 - p;

    float sweepPhase = min(p / 0.7, 1.0);
    float head = -0.25 + 1.5 * sweepPhase;

    float clearMask = smoothstep(-bandSoftness, bandSoftness, head - vUv.y);
    float remainMask = 1.0 - clearMask;

    float localBlurFactor = inv * remainMask;
    vec4 blurTex = verticalBlur(tDiffuse, vUv, blurRadius * localBlurFactor);
    vec3 baseCol = mix(texel.rgb, blurTex.rgb, clamp(localBlurFactor * 1.2, 0.0, 1.0));

    float d = abs(vUv.y - head);
    float band = exp(-(d * d) / max(0.0001, bandSoftness * bandSoftness * 0.35));
    float glowFade = inv * (0.65 + 0.35 * remainMask);
    float grain = (hash12(vUv * vec2(128.0, 256.0)) - 0.5) * 2.0 * grainAmount;
    float glow = max(0.0, band * glowStrength * glowFade * (1.0 + grain));

    vec3 col = baseCol;

    float exposure = 1.0 + glow * 0.45;
    col *= exposure;

    float satKeep = 1.0 - 0.3 * clamp(glowFade, 0.0, 1.0);
    float luma = dot(col, vec3(0.299, 0.587, 0.114));
    col = mix(vec3(luma), col, satKeep);

    col += glowColor * glow * 0.35;
    col = clamp(col, 0.0, 1.0);

    float alphaRamp = smoothstep(0.0, 0.2, p);
    float outAlpha = texel.a * alphaRamp;

    return vec4(col, outAlpha);
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