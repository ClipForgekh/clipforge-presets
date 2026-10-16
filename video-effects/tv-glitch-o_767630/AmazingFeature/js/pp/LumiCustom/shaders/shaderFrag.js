exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float waveAmplitude; // = 0.045 [0.0, 0.2] // 极光波浪强度
uniform float upwardDrift; // = 0.28 [0.0, 1.0] // 向上漂移距离
uniform vec3 auroraColor; // = vec3(0.35, 0.9, 0.75) // 极光主色

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    if (p < 0.5) {
        return 0.5 * (1.0 - sqrt(1.0 - 4.0 * p * p));
    }
    return 0.5 * (sqrt(1.0 - pow(-2.0 * p + 2.0, 2.0)) + 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

float auroraWave(vec2 uv, float p) {
    float w1 = sin(uv.y * 16.0 + uv.x * 7.0 + p * 9.0);
    float w2 = sin(uv.y * 11.0 - uv.x * 13.0 + p * 6.5);
    float w3 = sin((uv.y * 20.0 + uv.x * 3.0) - p * 12.0);
    return 0.5 + 0.5 * (w1 * 0.45 + w2 * 0.35 + w3 * 0.20);
}

vec4 effect(vec4 texel, float easedProgress) {
    float rawProgress = progress;
    if (rawProgress >= 0.9) {
        return vec4(0.0);
    }

    float phase = clamp(rawProgress / 0.9, 0.0, 1.0);
    float p = tween(phase);

    vec2 rawUV = vUv;
    float wave = (
        sin(vUv.y * 18.0 + p * 10.0) * 0.55 +
        sin(vUv.y * 33.0 - p * 7.0) * 0.30 +
        sin(vUv.y * 52.0 + p * 14.0) * 0.15
    ) * waveAmplitude * p;

    rawUV.x += wave;
    rawUV.y -= upwardDrift * p;

    float boundaryMask = getHardBoundaryMask(rawUV);
    vec2 uv = handleUVBounds(rawUV);
    vec4 movedTexel = texture2D(tDiffuse, uv);

    float n = hash21(floor(vUv * vec2(220.0, 140.0)) + p * 31.0);
    float dissolve = smoothstep(0.0, 1.0, p * 1.2 - n * 0.9);

    float curtain = auroraWave(vUv + vec2(wave * 3.0, 0.0), p);
    float curtainBoost = smoothstep(0.25, 0.9, curtain) * p;

    float upwardFade = smoothstep(0.0, 1.0, (vUv.y + p * 0.95 - 1.0) * 4.0);
    float globalFade = 1.0 - p;

    float visibility = (1.0 - dissolve);
    visibility *= (1.0 - upwardFade);
    visibility *= globalFade;
    visibility *= boundaryMask;
    visibility = clamp(visibility, 0.0, 1.0);

    float glowMix = clamp((1.0 - visibility) * (0.35 + curtainBoost * 0.65), 0.0, 1.0);
    vec3 auroraTint = mix(movedTexel.rgb * 0.55, auroraColor, 0.7);
    vec3 finalRgb = mix(movedTexel.rgb, auroraTint, glowMix);

    return vec4(finalRgb, movedTexel.a * visibility);
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