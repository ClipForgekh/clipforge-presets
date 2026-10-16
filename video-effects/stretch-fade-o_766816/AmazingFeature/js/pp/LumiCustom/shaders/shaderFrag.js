exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float blurStrength; // = 0.85 [0.1, 1.5] // 纵向拉伸模糊强度

varying vec2 vUv;

float tween(float progress) {
    return progress * progress * progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float p = clamp(progress, 0.0, 1.0);
    float stretch = blurStrength * p;

    vec4 col = vec4(0.0);
    float wsum = 0.0;

    for (int i = -6; i <= 6; i++) {
        float fi = float(i) / 6.0;
        float w = 1.0 - abs(fi);
        vec2 suv = handleUVBounds(vUv + vec2(0.0, fi * stretch));
        col += texture2D(tDiffuse, suv) * w;
        wsum += w;
    }

    vec4 blurred = col / max(wsum, 0.0001);

    float vanish = 1.0 - p;
    return vec4(blurred.rgb * vanish, texel.a * vanish);
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