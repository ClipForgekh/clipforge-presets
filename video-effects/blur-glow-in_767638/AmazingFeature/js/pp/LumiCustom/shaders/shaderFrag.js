exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float maxBlur; // = 0.08 [0.0, 0.2] // 最大方向模糊半径
uniform float glowStrength; // = 1.2 [0.0, 3.0] // 发光强度
uniform float zoomStrength; // = 0.28 [0.0, 0.8] // 推拉缩放强度
uniform vec2 blurDirection; // = vec2(1.0, 0.35) // 方向模糊方向
uniform vec3 glowColor; // = vec3(1.0, 0.86, 0.62) // 发光颜色，范围[0,1]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 directionalBlur(sampler2D tex, vec2 uv, vec2 dir, float radius) {
    vec4 col = vec4(0.0);
    float wsum = 0.0;

    float w0 = 0.227027;
    float w1 = 0.1945946;
    float w2 = 0.1216216;
    float w3 = 0.054054;
    float w4 = 0.016216;

    vec2 stepDir = dir * radius;

    col += texture2D(tex, handleUVBounds(uv)) * w0;
    wsum += w0;

    col += texture2D(tex, handleUVBounds(uv + stepDir * 1.0)) * w1;
    col += texture2D(tex, handleUVBounds(uv - stepDir * 1.0)) * w1;
    wsum += 2.0 * w1;

    col += texture2D(tex, handleUVBounds(uv + stepDir * 2.0)) * w2;
    col += texture2D(tex, handleUVBounds(uv - stepDir * 2.0)) * w2;
    wsum += 2.0 * w2;

    col += texture2D(tex, handleUVBounds(uv + stepDir * 3.0)) * w3;
    col += texture2D(tex, handleUVBounds(uv - stepDir * 3.0)) * w3;
    wsum += 2.0 * w3;

    col += texture2D(tex, handleUVBounds(uv + stepDir * 4.0)) * w4;
    col += texture2D(tex, handleUVBounds(uv - stepDir * 4.0)) * w4;
    wsum += 2.0 * w4;

    return col / max(wsum, 0.0001);
}

vec4 effect(vec4 texel, float progress) {
    float strength = 1.0 - progress;

    float scale = 1.0 + zoomStrength * strength;
    vec2 uv = 0.5 + (vUv - 0.5) * scale;
    float borderMask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);

    vec2 dir = normalize(vec2(blurDirection.x, blurDirection.y / max(ratio, 0.0001)));
    float blurRadius = maxBlur * strength;

    vec4 baseCol = texture2D(tDiffuse, uv);
    vec4 blurCol = directionalBlur(tDiffuse, uv, dir, blurRadius);

    float luma = dot(blurCol.rgb, vec3(0.299, 0.587, 0.114));
    vec3 glow = glowColor * luma * glowStrength * strength;

    vec3 mixed = mix(baseCol.rgb, blurCol.rgb, clamp(strength * 0.95, 0.0, 1.0));
    vec3 finalRgb = clamp(mixed + glow, 0.0, 1.0);

    return vec4(finalRgb, baseCol.a * borderMask);
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