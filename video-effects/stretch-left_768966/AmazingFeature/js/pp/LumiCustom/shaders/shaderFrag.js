exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float overshootAmount; // = 0.3 [0.0, 0.6] // 末端超越比例
uniform float startOffset; // = 0.5 [0.2, 1.0] // 初始水平偏移（占屏幕宽度比例）
uniform float startScale; // = 0.5 [0.3, 1.0] // 初始缩放比例

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float p) {
    float clamped = clamp(p, 0.0, 1.0);
    return 1.0 - pow(1.0 - clamped, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float overshootMotion(float t, float overshoot) {
    float normalized = clamp((t - 0.65) / 0.35, 0.0, 1.0);
    float smoothNormalized = normalized * normalized * (3.0 - 2.0 * normalized);
    float overshootWave = sin(smoothNormalized * PI);
    return t + overshoot * overshootWave;
}

vec4 effect(vec4 texel, float effectProgress) {
    vec2 centered = vUv - 0.5;
    float scale = mix(startScale, 1.0, effectProgress);
    vec2 scaled = centered * scale;

    float travel = overshootMotion(effectProgress, overshootAmount);
    float offsetX = startOffset * (1.0 - travel);
    vec2 uv = 0.5 + scaled - vec2(offsetX, 0.0);
    uv = handleUVBounds(uv);

    vec4 movedTexel = texture2D(tDiffuse, uv);

    float fade = clamp(effectProgress * 1.4, 0.0, 1.0);
    float borderMask = getHardBoundaryMask(vUv);

    vec3 color = movedTexel.rgb;
    float alpha = movedTexel.a * fade * borderMask;

    return vec4(color, alpha);
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