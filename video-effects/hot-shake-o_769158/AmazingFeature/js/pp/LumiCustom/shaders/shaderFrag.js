exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float shakeStrength; // = 1.8 [0.5, 3.0] // 抖动强度
uniform float shakeFrequency; // = 34.0 [8.0, 80.0] // 抖动频率
uniform float heatBlend; // = 1.0 [0.0, 1.0] // 热成像混合强度
uniform float zoomAmount; // = 1.7 [1.0, 2.2] // 最大缩放倍数

varying vec2 vUv;

float tween(float p) {
    return clamp(p, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec3 thermalMap(float t) {
    t = clamp(t, 0.0, 1.0);

    vec3 c0 = vec3(0.01, 0.03, 0.30);
    vec3 c1 = vec3(0.22, 0.00, 0.45);
    vec3 c2 = vec3(0.75, 0.05, 0.08);
    vec3 c3 = vec3(0.98, 0.42, 0.02);
    vec3 c4 = vec3(1.00, 0.88, 0.10);
    vec3 c5 = vec3(1.00, 1.00, 1.00);

    if (t < 0.20) return mix(c0, c1, t / 0.20);
    if (t < 0.45) return mix(c1, c2, (t - 0.20) / 0.25);
    if (t < 0.65) return mix(c2, c3, (t - 0.45) / 0.20);
    if (t < 0.85) return mix(c3, c4, (t - 0.65) / 0.20);
    return mix(c4, c5, (t - 0.85) / 0.15);
}

vec4 effect(vec4 texel, float p) {
    const float PI = 3.14159265;
    const float cutToBlack = 1.6 / 1.85;
    const float darkenStart = 1.3 / 1.85;

    if (p <= 0.0) return texel;
    if (p >= cutToBlack) return vec4(0.0, 0.0, 0.0, texel.a);

    float fxOn = smoothstep(0.0, 0.003, p);

    float zoomT = clamp(p / cutToBlack, 0.0, 1.0);
    float sineInOut = 0.5 - 0.5 * cos(PI * zoomT);
    float zoom = mix(1.0, zoomAmount, sineInOut);

    float shakeGrow = smoothstep(0.03, 0.55, zoomT);
    float amp = fxOn * shakeStrength * mix(0.010, 0.085, shakeGrow);

    float phase = p * 6.2831853 * shakeFrequency;
    float shakeX = (sin(phase) + 0.45 * sin(phase * 2.37 + 1.2)) * amp;

    vec2 uv = vec2(
        0.5 + (vUv.x - 0.5) / zoom + shakeX,
        0.5 + (vUv.y - 0.5) / zoom
    );
    uv = handleUVBounds(uv);

    vec4 src = texture2D(tDiffuse, uv);

    float luma = dot(src.rgb, vec3(0.299, 0.587, 0.114));
    vec3 heat = thermalMap(luma);
    vec3 color = mix(src.rgb, heat, fxOn * heatBlend);

    float darkT = smoothstep(darkenStart, cutToBlack, p);
    float darken = 1.0 - pow(darkT, 0.55);
    color *= clamp(darken, 0.0, 1.0);

    return vec4(color, src.a);
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