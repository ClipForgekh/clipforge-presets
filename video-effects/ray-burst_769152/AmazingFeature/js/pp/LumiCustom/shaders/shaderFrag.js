exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform vec3 flareColor; // = vec3(1.0, 0.92, 0.75) // 电影感暖色闪光
uniform float flareBrightness; // = 2.2 [0.5, 4.0] // 闪光整体亮度
uniform float streakSharpness; // = 3.5 [1.0, 8.0] // 径向光束锐度
uniform float ringIntensity; // = 1.1 [0.0, 3.0] // 镜头光环强度

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float progress) {
    float p = clamp(progress, 0.0, 1.0);
    return 1.0 - pow(1.0 - p, 3.0);
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

float remap01(float value, float minVal, float maxVal) {
    return clamp((value - minVal) / max(maxVal - minVal, 1e-5), 0.0, 1.0);
}

float expoOut(float x) {
    if (x <= 0.0) return 0.0;
    if (x >= 1.0) return 1.0;
    return 1.0 - pow(2.0, -10.0 * x);
}

float cubicOut(float x) {
    float f = clamp(x, 0.0, 1.0);
    return 1.0 - pow(1.0 - f, 3.0);
}

vec4 effect(vec4 texel, float effectProgress) {
    float t = clamp(progress, 0.0, 1.0);

    vec2 center = vec2(0.5);
    vec2 aspectUV = getAspectCorrectUV(vUv);
    vec2 rel = aspectUV - center;
    float dist = length(rel);
    float distSafe = max(dist, 1e-4);
    vec2 dir = rel / distSafe;
    float angle = atan(rel.y, rel.x);

    float expansionStage = expoOut(remap01(t, 0.05, 0.4));
    float coverageStage = cubicOut(remap01(t, 0.4, 0.625));
    float contractionStage = remap01(t, 0.625, 0.85);
    float settleStage = remap01(t, 0.85, 1.0);

    float radiusExpansion = 0.02 + expansionStage * 1.4;
    float radiusHold = mix(radiusExpansion, 1.6, coverageStage);
    float radiusContract = mix(radiusHold, 0.35, contractionStage);
    float radius = max(radiusContract, 0.05);

    float baseStrength = 1.0 - effectProgress;
    float flareEnvelope = baseStrength * (1.0 - settleStage * 0.9);

    float coreSize = mix(0.004, 0.028, expansionStage);
    float centerPulse = exp(-pow(dist / max(coreSize, 0.0008), 2.0));
    float holdingGlow = exp(-pow(dist / 0.12, 2.0)) * coverageStage;
    float radialExtent = clamp(1.0 - dist / (radius + 0.0005), 0.0, 1.0);

    float streakCount = 6.0 + coverageStage * 6.0;
    float streakPattern = pow(abs(cos(angle * streakCount)), streakSharpness);
    float streaks = streakPattern * pow(radialExtent, 1.4);

    float planeMask = pow(abs(dir.x) + abs(dir.y), 2.2) * exp(-dist * 4.5);
    float lensRing1 = exp(-pow((dist - radiusHold * 0.55) / 0.09, 2.0)) * coverageStage;
    float lensRing2 = exp(-pow((dist - radiusHold * 0.85) / 0.05, 2.0)) * coverageStage;
    float subtleRings = (lensRing1 * 0.9 + lensRing2 * 0.7) * ringIntensity;
    float wash = pow(radialExtent, 2.0) * (0.3 + 0.7 * coverageStage);

    float flareScalar = (centerPulse * 3.0 + holdingGlow * 1.4 + streaks * 1.6 + subtleRings + planeMask * 0.8 + wash) * flareEnvelope;
    vec3 flare = flareColor * flareBrightness * flareScalar;

    float revealEase = cubicOut(remap01(t, 0.4, 0.625));
    float secondaryReveal = remap01(t, 0.625, 0.85);
    float finalSettle = remap01(t, 0.85, 1.0);
    float imageVisibility = clamp(0.6 * revealEase + 0.35 * secondaryReveal + finalSettle, 0.0, 1.0);

    vec3 baseImage = texel.rgb;
    vec3 revealed = baseImage * imageVisibility;
    vec3 color = revealed + flare;
    color = clamp(color, 0.0, 1.0);

    float finalAlpha = mix(1.0, texel.a, imageVisibility);
    return vec4(color, finalAlpha);
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