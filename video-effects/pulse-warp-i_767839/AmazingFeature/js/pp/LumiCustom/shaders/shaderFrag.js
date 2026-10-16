exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float waveAmplitude; // = 0.04 [0.0, 0.2] // 波形位移幅度
uniform float waveFrequency; // = 4.0 [1.0, 10.0] // 波形频率
uniform float glowStrength; // = 0.25 [0.0, 1.0] // 高亮增强强度

varying vec2 vUv;

const float TWO_PI = 6.28318530;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    return 1.0 - pow(1.0 - p, 5.0);
}

float saturate(float x) {
    return clamp(x, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

vec4 effect(vec4 texel, float easedProgress) {
    float linearProgress = 1.0 - pow(max(1.0 - easedProgress, 0.0), 0.2);
    float timeSeconds = linearProgress * 2.0;

    const float expandStart = 0.1;
    const float expandEnd = 1.2;
    const float relaxEnd = 1.5;

    float expandPhase = saturate((timeSeconds - expandStart) / (expandEnd - expandStart));
    float yScale = mix(0.15, 1.0, tween(expandPhase));

    float distortionFade = 1.0 - saturate((timeSeconds - expandEnd) / (relaxEnd - expandEnd));
    float waveReach = tween(expandPhase);

    vec2 aspectUV = getAspectCorrectUV(vUv);
    vec2 aspectCenter = getAspectCorrectUV(vec2(0.5));
    float dist = length(aspectUV - aspectCenter);
    float maxDist = length(getAspectCorrectUV(vec2(0.0)) - aspectCenter);
    float distNorm = maxDist > 0.0 ? dist / maxDist : 0.0;

    float bandWidth = mix(0.5, 0.2, waveReach);
    float delta = abs(distNorm - waveReach);
    float waveEnvelope = 1.0 - smoothstep(0.0, bandWidth, delta);

    float angle = (waveReach - distNorm) * waveFrequency * TWO_PI + (vUv.x - 0.5) * TWO_PI;
    float wave = sin(angle);
    float amplitude = waveAmplitude * waveEnvelope * distortionFade;

    vec2 centered = vUv - vec2(0.5);
    centered.y *= yScale;
    centered.y += wave * amplitude;

    vec2 warpedUV = centered + vec2(0.5);
    warpedUV = handleUVBounds(warpedUV);

    vec4 warpedColor = texture2D(tDiffuse, warpedUV);

    float luminanceBoost = waveEnvelope * distortionFade * glowStrength;
    vec3 finalRGB = clamp(warpedColor.rgb + luminanceBoost, 0.0, 1.0);

    return vec4(finalRGB, warpedColor.a);
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