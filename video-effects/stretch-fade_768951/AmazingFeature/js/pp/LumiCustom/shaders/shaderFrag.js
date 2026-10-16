exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float startOffset; // = 0.5 [0.2, 1.0] // 初始水平偏移距离（画面宽度的比例）
uniform float initialScale; // = 0.94 [0.5, 1.0] // 初始缩放比例
uniform float overshootAmount; // = 0.05 [0.0, 0.2] // 终点的轻微超冲距离

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

vec4 effect(vec4 texel, float progress) {
    float easedProgress = progress;
    float effectStrength = 1.0 - easedProgress;

    float scale = mix(1.0, initialScale, effectStrength);

    float overshootWindow = smoothstep(0.88, 0.995, easedProgress) - smoothstep(0.995, 1.0, easedProgress);
    float translation = mix(-startOffset, 0.0, easedProgress) + overshootAmount * overshootWindow;

    vec2 center = vec2(0.5);
    vec2 uv = center + (vUv - center - vec2(translation, 0.0)) / max(scale, 0.0001);
    uv = handleUVBounds(uv);

    vec4 sampled = texture2D(tDiffuse, uv);

    float fade = easedProgress;
    vec4 color = sampled * fade;
    float borderMask = getHardBoundaryMask(vUv);
    color *= borderMask;

    return color;
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