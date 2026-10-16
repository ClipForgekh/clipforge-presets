exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float streakLength; // = 0.22 [0.05, 0.6] // 初始拖尾长度
uniform float trailSharpness; // = 6.0 [2.0, 12.0] // 拖尾衰减速度
uniform float luminanceLead; // = 0.25 [0.0, 0.6] // 亮部提前量

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float totalDuration = 1.9;
    float t = progress * totalDuration;

    float racePhase = clamp(t / 1.3, 0.0, 1.0);
    float raceCurve = racePhase <= 0.0 ? 0.0 : 1.0 - pow(2.0, -6.0 * racePhase);
    raceCurve = racePhase >= 1.0 ? 1.0 : clamp(raceCurve, 0.0, 1.0);

    float collapsePhase = clamp((t - 1.15) / (1.7 - 1.15), 0.0, 1.0);
    float collapseCurve = collapsePhase <= 0.0 ? 0.0 : 1.0 - pow(1.0 - collapsePhase, 5.0);
    collapseCurve = collapsePhase >= 1.0 ? 1.0 : clamp(collapseCurve, 0.0, 1.0);
    float collapseRemnant = 1.0 - collapseCurve;

    float smearPhase = clamp((t - 1.6) / (1.85 - 1.6), 0.0, 1.0);
    float smearFade = 1.0 - smearPhase;

    float lum = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float arrivalBias = (lum - 0.5) * luminanceLead;
    float arrival = clamp(raceCurve + arrivalBias, 0.0, 1.0);
    float arrivalReveal = arrival * arrival * (3.0 - 2.0 * arrival);

    float smearPresence = (1.0 - arrivalReveal) * collapseRemnant;

    float compress = mix(0.6, 1.0, raceCurve);
    float slide = 0.45 * (1.0 - raceCurve);
    vec2 baseUV = vec2(vUv.x * compress - slide, vUv.y);

    float dynamicStreakLength = streakLength * (0.35 + (1.0 - raceCurve) * 0.85);
    dynamicStreakLength *= mix(1.0, 0.25, collapseCurve);

    vec2 smearDir = normalize(vec2(1.0, 0.18));
    vec4 accum = vec4(0.0);
    float weightSum = 0.0;
    const int sampleCount = 8;
    for (int i = 0; i < sampleCount; ++i) {
        float fi = float(i);
        float norm = fi / float(sampleCount - 1);
        float stretch = dynamicStreakLength * (0.25 + norm * norm * 1.75);
        vec2 sampleUV = handleUVBounds(baseUV - smearDir * stretch);
        vec4 sampleColor = texture2D(tDiffuse, sampleUV);
        float sampleLum = dot(sampleColor.rgb, vec3(0.299, 0.587, 0.114));
        float lumBoost = mix(0.6, 1.2, clamp(sampleLum * 1.2, 0.0, 1.0));
        float weight = exp(-trailSharpness * norm) * lumBoost;
        weight *= mix(1.0, norm, raceCurve);
        accum += sampleColor * weight;
        weightSum += weight;
    }
    vec4 streakColor = weightSum > 0.0 ? accum / weightSum : texel;
    streakColor.rgb *= mix(1.25, 1.0, raceCurve);
    streakColor.a = texel.a;

    vec3 leadingColor = streakColor.rgb * (0.2 + smearPresence);
    vec3 buildColor = mix(leadingColor, texel.rgb, arrivalReveal);

    float glowStart = 0.2;
    float glowEnd = 1.0;
    float glowPhase = clamp((t - glowStart) / (glowEnd - glowStart), 0.0, 1.0);
    float glowEnvelope = glowPhase * (1.0 - glowPhase);
    vec3 glowAdded = texel.rgb * glowEnvelope * 0.12;
    buildColor += glowAdded * (1.0 - arrivalReveal);

    vec2 residualOffset = vec2(0.004, -0.004 / max(ratio, 0.0001));
    vec3 residualSample = texture2D(tDiffuse, handleUVBounds(vUv + residualOffset)).rgb;
    float smearMixWeight = clamp(1.0 - 0.6 * smearFade, 0.0, 1.0);
    vec3 finalColor = mix(residualSample, buildColor, smearMixWeight);

    float finalAlpha = mix(0.0, texel.a, clamp(arrivalReveal + smearPresence * 0.6, 0.0, 1.0));
    float borderMask = getHardBoundaryMask(vUv);
    finalColor *= borderMask;
    finalAlpha *= borderMask;

    finalColor = clamp(finalColor, 0.0, 1.0);
    return vec4(finalColor, finalAlpha);
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