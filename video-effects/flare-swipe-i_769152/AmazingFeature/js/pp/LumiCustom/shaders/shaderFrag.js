exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform vec3 flareColor; // = vec3(1.0, 0.92, 0.75) // 镜头光晕主色调
uniform float flareWidth; // = 0.18 [0.05, 0.35] // 光幕垂直厚度
uniform float flareSoftness; // = 0.06 [0.01, 0.2] // 遮罩柔和边缘
uniform float secondaryIntensity; // = 0.6 [0.0, 1.0] // 次级辉光强度
uniform float streakSharpness; // = 10.0 [4.0, 18.0] // 光幕锐度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float remapClamped(float v, float a, float b) {
    return clamp((v - a) / (b - a), 0.0, 1.0);
}

float quarticOut(float t) {
    float inv = 1.0 - t;
    return 1.0 - inv * inv * inv * inv;
}

vec4 effect(vec4 texel, float progress) {
    float normalized = progress;

    const float appearStart = 0.05; // 0.10s
    const float sweepStart = 0.175; // 0.35s
    const float sweepEnd = 0.625;   // 1.25s
    const float exitEnd = 0.825;    // 1.65s

    float startX = -0.35;
    float endX = 1.35;

    float sweepPhase = 0.0;
    if (normalized >= sweepStart) {
        if (normalized < sweepEnd) {
            sweepPhase = quarticOut(remapClamped(normalized, sweepStart, sweepEnd));
        } else {
            sweepPhase = 1.0;
        }
    }

    float centerX = startX;
    if (normalized < sweepStart) {
        centerX = startX;
    } else if (normalized < sweepEnd) {
        centerX = mix(startX, endX, sweepPhase);
    } else {
        float exitPhase = remapClamped(normalized, sweepEnd, exitEnd);
        centerX = mix(endX, endX + 0.2, exitPhase);
    }

    float reveal = 0.0;
    if (normalized >= sweepStart) {
        if (normalized < sweepEnd) reveal = sweepPhase;
        else reveal = 1.0;
    }

    float maskSoft = max(flareSoftness, 0.002);
    float maskEdge = mix(-0.1, 1.05, reveal);
    float revealMask = smoothstep(-maskSoft, maskSoft, maskEdge - vUv.x);

    float fadeIn = smoothstep(appearStart, sweepStart, normalized);
    float fadeOut = 1.0 - smoothstep(sweepEnd, exitEnd, normalized);
    float planeIntensity = clamp(fadeIn * fadeOut, 0.0, 1.0);

    float secondaryShrink = 1.0 - smoothstep(sweepEnd, exitEnd, normalized);

    vec2 flareCenter = vec2(centerX, 0.5);
    vec2 flareCoord = getSDFCoordinate(vUv, flareCenter);
    float vDist = abs(flareCoord.y);
    float hDist = abs(vUv.x - centerX);

    float width = max(flareWidth, 0.01);
    float sharp = max(streakSharpness, 1.0);

    float mainEnvelope = exp(-pow(vDist / width, sharp));
    float horizontalEnvelope = exp(-hDist * 9.0);
    float mainStreak = mainEnvelope * horizontalEnvelope;

    float coreWidth = max(width * 0.32, 0.005);
    float coreBand = exp(-pow(vDist / coreWidth, 2.0)) * exp(-hDist * 5.0);

    float edgeRim = (1.0 - smoothstep(width * 0.5, width * 1.2, vDist)) * (1.0 - smoothstep(0.0, 0.45, hDist));

    float ghostSpread = max(0.22 + 0.18 * (1.0 - secondaryShrink), 0.05);
    float ghost1 = exp(-pow((vUv.x - (centerX - 0.28 * secondaryShrink)) / ghostSpread, 2.0)) *
                   exp(-pow(vDist / (width * 2.4 + 0.0005), 2.0));
    float ghost2 = exp(-pow((vUv.x - (centerX + 0.34 * secondaryShrink)) / (ghostSpread * 1.3), 2.0)) *
                   exp(-pow(vDist / (width * 1.8 + 0.0005), 2.0));
    float lensGhosts = (ghost1 + ghost2) * secondaryIntensity;

    float flareProfile = mainStreak * 0.9 + coreBand * 1.6 + edgeRim * 0.35 + lensGhosts;
    flareProfile *= planeIntensity;

    vec3 hiddenColor = vec3(0.0);
    vec3 baseColor = mix(hiddenColor, texel.rgb, revealMask);

    vec3 flareContribution = flareColor * flareProfile;
    vec3 finalColor = baseColor + flareContribution;

    float finalAlpha = texel.a * revealMask;

    float completion = step(0.9999, progress);
    finalColor = mix(finalColor, texel.rgb, completion);
    finalAlpha = mix(finalAlpha, texel.a, completion);

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