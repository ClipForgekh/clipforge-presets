exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float flareStrength; // = 1.2 [0.2, 2.5] // 镜头光晕整体亮度
uniform float revealSoftness; // = 0.08 [0.02, 0.2] // 画面揭示柔化范围

varying vec2 vUv;

float tween(float progress) {
    return 3.0 * progress * progress - 2.0 * progress * progress * progress;
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) {
        p.y /= ratio;
    } else {
        p.x *= ratio;
    }
    return p;
}

float easeExpoOut(float t) {
    return t >= 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

float easeSineOut(float t) {
    return sin(t * 1.57079632679);
}

float saturate(float v) {
    return clamp(v, 0.0, 1.0);
}

vec3 buildAnamorphicFlare(vec2 uv, float centerX, float primaryWidth, float secondaryStrength, float presence) {
    vec2 center = vec2(centerX, 0.5);
    vec2 p = getSDFCoordinate(uv, center);

    float longAxis = exp(-pow(abs(p.x) / primaryWidth, 0.72)) * exp(-pow(abs(p.y) * 28.0, 1.35));
    float core = exp(-dot(p, p) / (0.0018));
    float sparkle = exp(-abs(p.x) * 34.0) * exp(-abs(p.y) * 36.0);

    float halo = exp(-pow(length(p) / (primaryWidth * 1.8), 1.4)) * 0.45;

    vec2 pOffsetR = p - vec2(primaryWidth * 3.0, 0.0);
    vec2 pOffsetL = p + vec2(primaryWidth * 3.0, 0.0);
    float secondary = exp(-pow(abs(pOffsetR.x) / (primaryWidth * 0.75), 1.4)) * exp(-abs(pOffsetR.y) * 10.0);
    secondary += exp(-pow(abs(pOffsetL.x) / (primaryWidth * 0.75), 1.4)) * exp(-abs(pOffsetL.y) * 10.0);
    secondary *= secondaryStrength * 0.45;

    float intensity = longAxis * 0.6 + core * 1.35 + sparkle * 0.4 + halo + secondary;
    intensity *= presence;

    vec3 tint = vec3(1.0, 0.96, 0.85);
    return tint * intensity;
}

vec4 effect(vec4 texel, float p) {
    float rawHoldStart = 0.05;
    float rawHoldEnd = 0.2;
    float rawSweepEnd = 0.575;
    float rawExitEnd = 0.775;

    float stageHoldStart = tween(rawHoldStart);
    float stageHoldEnd = tween(rawHoldEnd);
    float stageSweepEnd = tween(rawSweepEnd);
    float stageExitEnd = tween(rawExitEnd);

    float holdNorm = (p - stageHoldStart) / max(stageHoldEnd - stageHoldStart, 0.0001);
    holdNorm = clamp(holdNorm, 0.0, 1.0);

    float sweepNorm = (p - stageHoldEnd) / max(stageSweepEnd - stageHoldEnd, 0.0001);
    sweepNorm = clamp(sweepNorm, 0.0, 1.0);

    float exitNorm = (p - stageSweepEnd) / max(stageExitEnd - stageSweepEnd, 0.0001);
    exitNorm = clamp(exitNorm, 0.0, 1.0);

    float centerX;
    if (p < stageHoldStart) {
        centerX = -0.42;
    } else if (p < stageHoldEnd) {
        centerX = mix(-0.42, -0.24, holdNorm);
    } else if (p < stageSweepEnd) {
        centerX = mix(-0.24, 1.18, easeExpoOut(sweepNorm));
    } else if (p < stageExitEnd) {
        centerX = mix(1.18, 1.32, easeSineOut(exitNorm));
    } else {
        centerX = 1.32;
    }

    float presenceRise = smoothstep(tween(0.04), tween(0.12), p);
    float presenceFall = 1.0 - smoothstep(stageExitEnd, 1.0, p);
    float presence = presenceRise * presenceFall;

    float secondaryFade = mix(1.0, 0.1, easeSineOut(exitNorm));
    float primaryWidth = mix(0.07, 0.05, easeExpoOut(sweepNorm));

    float revealGate = smoothstep(stageHoldEnd, tween(0.26), p);
    float revealMask = 1.0 - smoothstep(centerX - revealSoftness, centerX + revealSoftness, vUv.x);
    revealMask = saturate(revealMask) * revealGate;
    float reveal = saturate(revealMask);

    vec3 baseColor = texel.rgb * reveal;
    float baseAlpha = texel.a * reveal;

    vec3 flare = buildAnamorphicFlare(vUv, centerX, primaryWidth, secondaryFade, presence);
    flare *= flareStrength;

    vec3 finalRGB = baseColor + flare;
    finalRGB = min(finalRGB, vec3(1.0));

    float finalAlpha = clamp(baseAlpha + presence * 0.15, 0.0, 1.0);
    return vec4(finalRGB, finalAlpha);
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