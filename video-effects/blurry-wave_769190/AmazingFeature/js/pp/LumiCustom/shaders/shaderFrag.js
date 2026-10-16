exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float zoomMax; // = 1.35 [1.1, 2.0] // 峰值放大倍数
uniform float zoomMin; // = 0.5 [0.3, 0.9] // 初始缩放倍数
uniform float shakeStrength; // = 0.015 [0.0, 0.05] // 相机震动强度
uniform float blurStrength; // = 0.02 [0.0, 0.08] // 波浪模糊强度
uniform float fadeStart; // = 0.65 [0.4, 0.9] // 淡出起始进度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    vec2 center = vec2(0.5);
    float punchSpeed = 1.6;
    float fastProgress = clamp(progress * punchSpeed, 0.0, 1.0);

    float preStage = smoothstep(0.0, 0.22, fastProgress);
    float zoomStage = mix(1.0, zoomMin, preStage);
    float midStage = smoothstep(0.28, 0.6, fastProgress);
    float targetZoom = mix(zoomStage, zoomMax, midStage);

    vec2 offset = vUv - center;
    vec2 uv = center + offset / max(targetZoom, 0.0001);

    float shakeWindow = smoothstep(0.05, 0.18, fastProgress) * (1.0 - smoothstep(0.35, 0.6, fastProgress));
    vec2 shakeWave = vec2(
        sin(progress * 80.0) + sin(progress * 140.0) * 0.5,
        cos(progress * 90.0) + sin(progress * 130.0) * 0.4
    );
    vec2 aspectComp = ratio > 1.0 ? vec2(1.0 / ratio, 1.0) : vec2(1.0, ratio);
    vec2 shakeOffset = shakeWave * shakeStrength * shakeWindow * aspectComp;
    uv += shakeOffset;

    float blurEnvelope = smoothstep(0.1, 0.55, fastProgress);
    float directionalBlur = blurStrength * blurEnvelope;
    vec2 blurDir = normalize(vec2(0.6, 1.0 / max(ratio, 0.0001)));
    vec4 accumulated = vec4(0.0);
    float totalWeight = 0.0;
    const int kernelRadius = 2;

    for (int i = -kernelRadius; i <= kernelRadius; i++) {
        float fi = float(i);
        float weight = exp(-0.5 * fi * fi);
        float wave = sin((uv.x + fi * 0.03) * 18.0 + progress * 28.0);
        vec2 waveOffset = vec2(0.0, wave * directionalBlur * 0.6 / max(ratio, 0.0001));
        vec2 sampleUV = uv + blurDir * fi * directionalBlur + waveOffset;
        sampleUV = handleUVBounds(sampleUV);
        accumulated += texture2D(tDiffuse, sampleUV) * weight;
        totalWeight += weight;
    }

    vec4 blurred = accumulated / totalWeight;
    float fade = smoothstep(fadeStart, 1.0, progress);
    vec4 faded = mix(blurred, vec4(0.0), fade);
    float borderMask = getHardBoundaryMask(vUv);
    faded.a *= borderMask;

    return faded;
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