exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float shakeAmplitude; // = 0.1 [0.05, 0.2] // 横向抖动幅度（相对于画面宽度）
uniform float shakeFrequency; // = 32.0 [8.0, 96.0] // 抖动频率（在整个动画中的周期数）

varying vec2 vUv;

float tween(float p) {
    return clamp(p, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progressValue) {
    if (progressValue <= 0.0) {
        return texel;
    }

    const float fallCompletion = 1.8 / 1.85;
    const float extraDrop = 0.08;

    float fallPhase = progressValue <= fallCompletion ? progressValue / fallCompletion : 1.0;
    float fallOffset = fallPhase;
    if (progressValue > fallCompletion) {
        float tailPhase = (progressValue - fallCompletion) / max(1.0 - fallCompletion, 1e-4);
        fallOffset += tailPhase * extraDrop;
    }

    float angle = progressValue * shakeFrequency * 6.28318530718;
    float wave1 = sin(angle);
    float wave2 = sin(angle * 3.0);
    float wave3 = sin(angle * 5.0);
    float combinedShake = (wave1 + 0.7 * wave2 + 0.5 * wave3) / (1.0 + 0.7 + 0.5);
    float horizontalOffset = combinedShake * shakeAmplitude;

    vec2 shiftedUV = vUv + vec2(horizontalOffset, fallOffset);
    vec2 boundedUV = handleUVBounds(shiftedUV);

    vec4 movedTexel = texture2D(tDiffuse, boundedUV);

    float borderMask = step(0.0, shiftedUV.x) * step(shiftedUV.x, 1.0) * step(0.0, shiftedUV.y) * step(shiftedUV.y, 1.0);

    return vec4(movedTexel.rgb * borderMask, movedTexel.a * borderMask);
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