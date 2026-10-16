exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float maxBlurPx; // = 25.0 [0.0, 40.0] // 最大模糊半径（像素近似）
uniform float maxExposure; // = 3.0 [1.0, 4.0] // 最大曝光倍率
uniform float maxSaturation; // = 1.8 [1.0, 2.5] // 最大饱和度
uniform float maxScale; // = 1.1 [1.0, 1.3] // 最大缩放倍率
uniform vec3 warmColor; // = vec3(1.0, 0.82, 0.62) // 暖色调颜色

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

vec3 adjustSaturation(vec3 color, float sat) {
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(luma), color, sat);
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float blurPx) {
    if (blurPx <= 0.0001) {
        return texture2D(tex, uv);
    }

    float stepBase = blurPx * 0.0012;
    vec2 delta = vec2(stepBase, stepBase / max(ratio, 0.0001));

    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(-delta.x, -delta.y))) * 0.0625;
    c += texture2D(tex, handleUVBounds(uv + vec2( 0.0,      -delta.y))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + vec2( delta.x, -delta.y))) * 0.0625;
    c += texture2D(tex, handleUVBounds(uv + vec2(-delta.x,  0.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv)) * 0.25;
    c += texture2D(tex, handleUVBounds(uv + vec2( delta.x,  0.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + vec2(-delta.x,  delta.y))) * 0.0625;
    c += texture2D(tex, handleUVBounds(uv + vec2( 0.0,       delta.y))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + vec2( delta.x,  delta.y))) * 0.0625;

    return c;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    float scale = mix(1.0, maxScale, strength);
    float invScale = 1.0 / max(scale, 0.0001);
    vec2 uv = 0.5 + (vUv - 0.5) * invScale;
    vec2 boundedUV = handleUVBounds(uv);

    float blurPx = maxBlurPx * strength;
    vec4 col = gaussianBlur9(tDiffuse, boundedUV, blurPx);

    float exposure = mix(1.0, maxExposure, strength);
    col.rgb *= exposure;

    float warmAmount = 0.45 * strength;
    col.rgb = mix(col.rgb, col.rgb * warmColor, warmAmount);

    float sat = mix(1.0, maxSaturation, strength);
    col.rgb = adjustSaturation(col.rgb, sat);

    col.rgb = clamp(col.rgb, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(vUv);
    return vec4(col.rgb, col.a * borderMask);
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