exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float zoomStart; // = 1.5 [1.0, 2.0] // 起始放大倍数
uniform float shakeAmount; // = 0.06 [0.0, 0.2] // 水平抖动幅度
uniform float shakeCycles; // = 18.0 [4.0, 40.0] // 抖动周期数
uniform float settleEnd; // = 0.919 [0.5, 1.0] // 效果结束点(约1.7s/1.85s)

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec3 thermalPalette(float t) {
    t = clamp(t, 0.0, 1.0);
    vec3 c0 = vec3(0.02, 0.05, 0.35); // deep blue
    vec3 c1 = vec3(0.35, 0.05, 0.55); // purple
    vec3 c2 = vec3(0.85, 0.08, 0.12); // red
    vec3 c3 = vec3(0.98, 0.45, 0.08); // orange
    vec3 c4 = vec3(0.98, 0.85, 0.15); // yellow
    vec3 c5 = vec3(1.00, 1.00, 1.00); // white

    if (t < 0.2) return mix(c0, c1, t / 0.2);
    if (t < 0.45) return mix(c1, c2, (t - 0.2) / 0.25);
    if (t < 0.68) return mix(c2, c3, (t - 0.45) / 0.23);
    if (t < 0.88) return mix(c3, c4, (t - 0.68) / 0.20);
    return mix(c4, c5, (t - 0.88) / 0.12);
}

vec4 effect(vec4 texel, float pRaw) {
    float p = clamp(pRaw / max(settleEnd, 0.0001), 0.0, 1.0);
    float e = sin(p * 1.57079632679);        // Sine.Out
    float strength = 1.0 - e;                // 入场：强->弱

    float zoom = mix(zoomStart, 1.0, e);

    float phase = p * shakeCycles * 6.28318530718;
    float shakeWave = sin(phase) + 0.35 * sin(phase * 2.37 + 1.2);
    float shakeX = shakeAmount * strength * shakeWave;

    vec2 uv = 0.5 + (vUv - 0.5) * zoom + vec2(shakeX, 0.0);
    uv = handleUVBounds(uv);
    vec4 moved = texture2D(tDiffuse, uv);

    float luma = dot(moved.rgb, vec3(0.299, 0.587, 0.114));
    vec3 heat = thermalPalette(luma);
    vec3 finalRgb = mix(moved.rgb, heat, strength);

    return vec4(finalRgb, moved.a);
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