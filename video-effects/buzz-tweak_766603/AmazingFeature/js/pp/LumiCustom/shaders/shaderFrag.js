exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurMax; // = 0.035 [0.005, 0.08] // 最大纵向模糊强度
uniform float grainStart; // = 0.15 [0.0, 0.4] // 初始胶片颗粒强度
uniform float warmStrength; // = 0.22 [0.0, 0.5] // 暖黄胶片色调强度
uniform float pullStrength; // = 0.08 [0.0, 0.2] // 分层轻微拉近强度
uniform float slideUp; // = 0.015 [0.0, 0.05] // 轻微上滑幅度（UV单位）

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

float layerWindow(float p, float s, float e) {
    float a = smoothstep(s, e, p);
    float b = 1.0 - smoothstep(e, min(1.0, e + 0.22), p);
    return a * b;
}

vec4 verticalBlur(sampler2D tex, vec2 uv, float amount) {
    vec2 off = vec2(0.0, amount);
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv - off * 4.0)) * 0.06;
    c += texture2D(tex, handleUVBounds(uv - off * 3.0)) * 0.09;
    c += texture2D(tex, handleUVBounds(uv - off * 2.0)) * 0.12;
    c += texture2D(tex, handleUVBounds(uv - off * 1.0)) * 0.15;
    c += texture2D(tex, handleUVBounds(uv)) * 0.16;
    c += texture2D(tex, handleUVBounds(uv + off * 1.0)) * 0.15;
    c += texture2D(tex, handleUVBounds(uv + off * 2.0)) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + off * 3.0)) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + off * 4.0)) * 0.06;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float inv = 1.0 - p;

    float bgBlurF = 1.0 - smoothstep(0.00, 0.45, p);
    float mdBlurF = 1.0 - smoothstep(0.20, 0.75, p);
    float fgBlurF = 1.0 - smoothstep(0.45, 1.00, p);

    float bgW = layerWindow(p, 0.02, 0.42);
    float mdW = layerWindow(p, 0.22, 0.72);
    float fgW = layerWindow(p, 0.48, 0.98);

    float zBg = 1.0 + pullStrength * bgW;
    float zMd = 1.0 + pullStrength * 0.75 * mdW;
    float zFg = 1.0 + pullStrength * 0.55 * fgW;

    float yBg = -slideUp * bgW;
    float yMd = -slideUp * mdW;
    float yFg = -slideUp * fgW;

    vec2 uvBg = vec2(0.5) + (vUv - vec2(0.5)) * zBg + vec2(0.0, yBg);
    vec2 uvMd = vec2(0.5) + (vUv - vec2(0.5)) * zMd + vec2(0.0, yMd);
    vec2 uvFg = vec2(0.5) + (vUv - vec2(0.5)) * zFg + vec2(0.0, yFg);

    uvBg = handleUVBounds(uvBg);
    uvMd = handleUVBounds(uvMd);
    uvFg = handleUVBounds(uvFg);

    vec4 colBg = verticalBlur(tDiffuse, uvBg, blurMax * bgBlurF);
    vec4 colMd = verticalBlur(tDiffuse, uvMd, blurMax * 0.75 * mdBlurF);
    vec4 colFg = verticalBlur(tDiffuse, uvFg, blurMax * 0.5 * fgBlurF);

    float luma = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float center = 1.0 - clamp(length(vUv - vec2(0.5)) * 1.8, 0.0, 1.0);

    float fgMask = smoothstep(0.52, 0.95, luma) * smoothstep(0.20, 0.95, center);
    float mdMask = smoothstep(0.22, 0.75, luma) * (1.0 - fgMask * 0.7);
    float bgMask = clamp(1.0 - fgMask - mdMask, 0.0, 1.0);

    float sumMask = max(fgMask + mdMask + bgMask, 0.0001);
    fgMask /= sumMask;
    mdMask /= sumMask;
    bgMask /= sumMask;

    vec4 layered = colBg * bgMask + colMd * mdMask + colFg * fgMask;

    float warm = warmStrength * inv;
    vec3 warmTint = vec3(1.10, 1.03, 0.90);
    layered.rgb = mix(layered.rgb, layered.rgb * warmTint, warm);

    float grainAmount = grainStart * inv;
    float g = hash21(vUv * vec2(1280.0, 720.0) + p * 13.17) - 0.5;
    layered.rgb += g * grainAmount;

    layered.rgb = clamp(layered.rgb, 0.0, 1.0);
    return vec4(layered.rgb, texel.a);
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