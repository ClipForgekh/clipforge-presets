exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 全局动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float maxZoom; // = 1.5 [1.1, 2.0] // 入场初始放大倍率
uniform float shakeMagnitude; // = 0.12 [0.02, 0.4] // 初始水平抖动幅度（按屏幕宽度比例）
uniform float chromaSpread; // = 0.10 [0.02, 0.30] // 初始RGB分离距离（按屏幕宽度比例）

varying vec2 vUv;

const float PI = 3.14159265;
const float HALF_PI = 1.57079633;
const float settlePoint = 1.7 / 1.85;

float tween(float p) {
    float normalized = min(p / settlePoint, 1.0);
    return sin(normalized * HALF_PI);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float easedProgress) {
    float residual = max(1.0 - easedProgress, 0.0);
    float effectStrength = pow(residual, 0.35);
    float timeline = min(progress, settlePoint) / settlePoint;

    float freqHigh = mix(320.0, 42.0, timeline);
    float freqMid = mix(180.0, 26.0, timeline);
    float freqLow = mix(110.0, 14.0, timeline);

    float phaseHigh = sin(timeline * freqHigh + 1.04719755);
    float phaseMid = sin(timeline * freqMid + 2.35619449);
    float phaseLow = sin(timeline * freqLow + 0.52359878);

    float horizontalShake = (phaseHigh * 0.55 + phaseMid * 0.30 + phaseLow * 0.15) * shakeMagnitude * effectStrength;

    float zoomFactor = mix(1.0, maxZoom, residual);
    vec2 centered = vUv - 0.5;
    centered /= zoomFactor;
    vec2 shaken = centered + vec2(horizontalShake, 0.0);
    vec2 baseUV = handleUVBounds(shaken + 0.5);

    float persistentStrength = pow(residual, 0.28);
    float separation = chromaSpread * persistentStrength;
    vec2 offset = vec2(separation, 0.0);

    vec4 sampleR = texture2D(tDiffuse, handleUVBounds(baseUV + offset));
    vec4 sampleG = texture2D(tDiffuse, handleUVBounds(baseUV));
    vec4 sampleB = texture2D(tDiffuse, handleUVBounds(baseUV - offset));

    vec3 recombined = vec3(sampleR.r, sampleG.g, sampleB.b);
    vec3 tintedCopies = sampleR.rgb * vec3(1.0, 0.0, 0.0) +
                        sampleG.rgb * vec3(0.0, 1.0, 0.0) +
                        sampleB.rgb * vec3(0.0, 0.0, 1.0);

    float tintMix = pow(effectStrength, 0.6);
    vec3 color = mix(recombined, tintedCopies, tintMix);
    color = clamp(color, 0.0, 1.0);

    return vec4(color, sampleG.a);
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