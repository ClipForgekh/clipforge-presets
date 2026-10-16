exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurMax; // = 0.04 [0.0, 0.12] // 最大垂直模糊半径
uniform float chromaAmount; // = 0.03 [0.0, 0.12] // RGB纵向分离强度
uniform float glowStrength; // = 1.2 [0.0, 3.0] // 发光强度
uniform float wipeSoftness; // = 0.08 [0.001, 0.3] // 从下往上展开的柔边宽度
uniform vec3 glowColor; // = vec3(0.35, 0.65, 1.0) // 冷蓝发光颜色

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlurRGB(vec2 uv, float radius, float chromaOffset) {
    vec2 stepY = vec2(0.0, radius);
    vec2 offR = vec2(0.0, chromaOffset);
    vec2 offB = vec2(0.0, -chromaOffset);

    float w0 = 0.227027;
    float w1 = 0.1945946;
    float w2 = 0.1216216;
    float w3 = 0.054054;
    float w4 = 0.016216;

    vec3 c = vec3(0.0);

    vec2 uv0 = handleUVBounds(uv);
    vec2 uv1p = handleUVBounds(uv + stepY * 1.0);
    vec2 uv1n = handleUVBounds(uv - stepY * 1.0);
    vec2 uv2p = handleUVBounds(uv + stepY * 2.0);
    vec2 uv2n = handleUVBounds(uv - stepY * 2.0);
    vec2 uv3p = handleUVBounds(uv + stepY * 3.0);
    vec2 uv3n = handleUVBounds(uv - stepY * 3.0);
    vec2 uv4p = handleUVBounds(uv + stepY * 4.0);
    vec2 uv4n = handleUVBounds(uv - stepY * 4.0);

    c.r += texture2D(tDiffuse, handleUVBounds(uv0 + offR)).r * w0;
    c.r += texture2D(tDiffuse, handleUVBounds(uv1p + offR)).r * w1;
    c.r += texture2D(tDiffuse, handleUVBounds(uv1n + offR)).r * w1;
    c.r += texture2D(tDiffuse, handleUVBounds(uv2p + offR)).r * w2;
    c.r += texture2D(tDiffuse, handleUVBounds(uv2n + offR)).r * w2;
    c.r += texture2D(tDiffuse, handleUVBounds(uv3p + offR)).r * w3;
    c.r += texture2D(tDiffuse, handleUVBounds(uv3n + offR)).r * w3;
    c.r += texture2D(tDiffuse, handleUVBounds(uv4p + offR)).r * w4;
    c.r += texture2D(tDiffuse, handleUVBounds(uv4n + offR)).r * w4;

    c.g += texture2D(tDiffuse, uv0).g * w0;
    c.g += texture2D(tDiffuse, uv1p).g * w1;
    c.g += texture2D(tDiffuse, uv1n).g * w1;
    c.g += texture2D(tDiffuse, uv2p).g * w2;
    c.g += texture2D(tDiffuse, uv2n).g * w2;
    c.g += texture2D(tDiffuse, uv3p).g * w3;
    c.g += texture2D(tDiffuse, uv3n).g * w3;
    c.g += texture2D(tDiffuse, uv4p).g * w4;
    c.g += texture2D(tDiffuse, uv4n).g * w4;

    c.b += texture2D(tDiffuse, handleUVBounds(uv0 + offB)).b * w0;
    c.b += texture2D(tDiffuse, handleUVBounds(uv1p + offB)).b * w1;
    c.b += texture2D(tDiffuse, handleUVBounds(uv1n + offB)).b * w1;
    c.b += texture2D(tDiffuse, handleUVBounds(uv2p + offB)).b * w2;
    c.b += texture2D(tDiffuse, handleUVBounds(uv2n + offB)).b * w2;
    c.b += texture2D(tDiffuse, handleUVBounds(uv3p + offB)).b * w3;
    c.b += texture2D(tDiffuse, handleUVBounds(uv3n + offB)).b * w3;
    c.b += texture2D(tDiffuse, handleUVBounds(uv4p + offB)).b * w4;
    c.b += texture2D(tDiffuse, handleUVBounds(uv4n + offB)).b * w4;

    float a = texture2D(tDiffuse, uv0).a;
    return vec4(c, a);
}

vec4 effect(vec4 texel, float progress) {
    if (progress >= 0.9999) {
        return texel;
    }

    float strength = 1.0 - progress;

    float bottomBias = pow(1.0 - vUv.y, 1.6);
    float blurRadius = blurMax * strength * (0.75 + 0.25 * bottomBias);
    float chroma = chromaAmount * strength * (0.6 + 0.4 * bottomBias);

    vec4 blurred = verticalBlurRGB(vUv, blurRadius, chroma);

    float glowMask = bottomBias * (0.5 + 0.5 * strength);
    vec3 glow = blurred.rgb * glowColor * glowStrength * strength * glowMask;

    vec3 combined = blurred.rgb + glow;
    combined = mix(combined, texel.rgb, progress);

    float reveal = progress;
    float edge = max(0.001, wipeSoftness * (0.3 + 0.7 * strength));
    float wipe = smoothstep(vUv.y - edge, vUv.y + edge, reveal);

    vec3 finalRgb = mix(vec3(0.0), combined, wipe);
    float finalA = texel.a * wipe;

    return vec4(clamp(finalRgb, 0.0, 1.0), finalA);
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