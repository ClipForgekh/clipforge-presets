exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;

uniform float flameEdgeSoftness; // = 0.18 [0.05, 0.35] // Flame edge softness controlling reveal width
uniform float glowStrength; // = 1.2 [0.5, 2.0] // Glow intensity multiplier
uniform vec3 flameColor; // = vec3(1.0, 0.56, 0.24) // Warm flame color

varying vec2 vUv;

float tween(float p) {
    if (p < 0.5) {
        return 16.0 * p * p * p * p * p;
    }
    return 1.0 - 0.5 * pow(-2.0 * p + 2.0, 5.0);
}

float untween(float eased) {
    if (eased < 0.5) {
        return pow(eased / 16.0, 0.2);
    }
    return (2.0 - pow(2.0 * (1.0 - eased), 0.2)) * 0.5;
}

float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) {
        return fraction;
    }
    return fraction * ratio;
}

vec4 effect(vec4 texel, float easedProgress) {
    float clampedEased = clamp(easedProgress, 0.0, 1.0);
    float linearProgress = untween(clampedEased);

    const float revealEnd = 0.64;
    const float flameFadeStart = 0.64;
    const float flameFadeEnd = 0.88;
    const float glowFadeStart = 0.88;

    float revealPhase = clamp(linearProgress / revealEnd, 0.0, 1.0);
    float flameVisibility = 1.0 - smoothstep(flameFadeStart, flameFadeEnd, linearProgress);
    float effectStrength = 1.0 - clampedEased;

    const float diagNorm = 0.70710678;
    vec2 diagVec = vec2(diagNorm, diagNorm);
    float diagCoord = dot(vUv, diagVec);
    float diagLength = 1.41421356;

    float softness = max(flameEdgeSoftness, 0.01);
    float lead = softness * 3.0 + 0.08;
    float flameHead = mix(-lead, diagLength + lead, revealPhase);
    float distToFront = diagCoord - flameHead;

    float revealAmount = smoothstep(-softness, softness, flameHead - diagCoord);

    vec3 hiddenColor = flameColor * 0.05;
    vec3 baseColor = mix(hiddenColor, texel.rgb, revealAmount);

    float perpendicular = (vUv.x - vUv.y) * diagNorm;
    float flameField = exp(
        -pow(distToFront / (softness * 0.45 + 0.0001), 2.0)
        -pow(perpendicular / (softness * 1.2 + 0.0001), 2.0)
    );
    flameField *= flameVisibility;

    float glowFade = smoothstep(glowFadeStart, 1.0, linearProgress);
    float lowGlow = glowStrength * 0.25;
    float glowLevel = mix(glowStrength, lowGlow, glowFade);
    float flameGlow = flameField * glowLevel;

    vec3 color = baseColor;
    float brightnessBoost = clamp(flameGlow * 0.6, 0.0, 1.5);
    color *= 1.0 + brightnessBoost;
    color += flameColor * (flameGlow * 0.5);

    float borderWidth = getShortSideRelativeSize(0.03);
    float edgeDist = min(min(vUv.x, 1.0 - vUv.x), min(vUv.y, 1.0 - vUv.y));
    float borderMask = 1.0 - smoothstep(0.0, borderWidth, edgeDist);
    float borderGlow = borderMask * effectStrength;
    color += flameColor * glowLevel * 0.35 * borderGlow;

    color = clamp(color, 0.0, 1.0);

    float baseAlpha = texel.a * revealAmount;
    float flameAlpha = clamp(flameGlow * 0.2, 0.0, 1.0);
    float finalAlpha = clamp(baseAlpha + flameAlpha, 0.0, 1.0);

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