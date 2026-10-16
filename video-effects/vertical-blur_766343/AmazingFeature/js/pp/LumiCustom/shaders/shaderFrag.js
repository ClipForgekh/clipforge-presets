exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float maxBlur; // = 0.08 [0.0, 0.25] // 最大纵向模糊强度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float blurStrength = (1.0 - progress) * maxBlur;

    vec2 o1 = vec2(0.0, 1.0 * blurStrength);
    vec2 o2 = vec2(0.0, 2.0 * blurStrength);
    vec2 o3 = vec2(0.0, 3.0 * blurStrength);
    vec2 o4 = vec2(0.0, 4.0 * blurStrength);

    vec4 c0 = texture2D(tDiffuse, handleUVBounds(vUv));
    vec4 c1p = texture2D(tDiffuse, handleUVBounds(vUv + o1));
    vec4 c1n = texture2D(tDiffuse, handleUVBounds(vUv - o1));
    vec4 c2p = texture2D(tDiffuse, handleUVBounds(vUv + o2));
    vec4 c2n = texture2D(tDiffuse, handleUVBounds(vUv - o2));
    vec4 c3p = texture2D(tDiffuse, handleUVBounds(vUv + o3));
    vec4 c3n = texture2D(tDiffuse, handleUVBounds(vUv - o3));
    vec4 c4p = texture2D(tDiffuse, handleUVBounds(vUv + o4));
    vec4 c4n = texture2D(tDiffuse, handleUVBounds(vUv - o4));

    vec4 blurred =
          c0  * 0.24
        + (c1p + c1n) * 0.18
        + (c2p + c2n) * 0.12
        + (c3p + c3n) * 0.08
        + (c4p + c4n) * 0.00;

    return blurred;
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