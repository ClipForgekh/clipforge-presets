exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 原图像A纹理
uniform sampler2D tDiffuseB; // 图像B纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float warpStrength; // = 1.0 [0.0, 3.0] // 扭曲强度
uniform float flareIntensity; // = 0.8 [0.0, 2.0] // 光晕强度
uniform float streakFrequency; // = 14.0 [4.0, 32.0] // 光丝密度

varying vec2 vUv;

float tween(float t) {
    return t < 0.5 ? 4.0 * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 3.0) * 0.5;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 toAspectSpace(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec2 fromAspectSpace(vec2 p, vec2 center) {
    if (ratio > 1.0) p.y *= ratio;
    else p.x /= ratio;
    return p + center;
}

vec4 effect(vec4 texelA, float easedProgress) {
    float rawProgress = clamp(progress, 0.0, 1.0);
    vec2 center = vec2(0.5);
    vec2 aspectP = toAspectSpace(vUv, center);
    float dist = length(aspectP);
    float maxDist = length(toAspectSpace(vec2(1.0, 1.0), center));
    float normDist = maxDist > 0.0 ? dist / maxDist : 0.0;
    vec2 dir = dist > 1e-5 ? aspectP / dist : vec2(0.0, 1.0);
    vec2 ortho = vec2(-dir.y, dir.x);

    float holdEnd = 0.175;
    float warpFull = 0.75;
    float revealStart = 0.5;
    float revealEnd = 0.85;
    float restoreStart = 0.75;
    float restoreEnd = 1.0;

    if (rawProgress <= holdEnd) {
        vec4 originalA = texture2D(tDiffuse, handleUVBounds(vUv));
        return originalA;
    }

    float warpRamp = smoothstep(holdEnd, warpFull, rawProgress);
    float warpRelease = smoothstep(restoreStart, restoreEnd, rawProgress);
    float warpAmount = warpStrength * warpRamp * (1.0 - warpRelease);

    float ringTravel = smoothstep(holdEnd, restoreStart, rawProgress);
    float ringRadius = mix(0.0, 1.2, ringTravel);
    float ringThickness = mix(0.04, 0.18, warpAmount);
    float ringProfile = smoothstep(ringRadius - ringThickness, ringRadius - ringThickness * 0.4, normDist) - smoothstep(ringRadius, ringRadius + ringThickness * 0.6, normDist);

    float swirlPhase = easedProgress * 14.0 + normDist * streakFrequency;
    float swirl = warpAmount * 0.45 * sin(swirlPhase);
    float radialStretch = 1.0 + warpAmount * (0.8 * (1.0 - normDist) - 0.2 * normDist);
    vec2 warpedAspect = aspectP * radialStretch + ortho * swirl + dir * (warpAmount * 0.25 * sin(normDist * streakFrequency * 0.7 - easedProgress * 10.0));
    vec2 warpUV = fromAspectSpace(warpedAspect, center);
    warpUV = handleUVBounds(warpUV);
    vec4 warpedA = texture2D(tDiffuse, warpUV);

    float reveal = smoothstep(revealStart, revealEnd, rawProgress);
    float bWarpRelease = smoothstep(restoreStart, restoreEnd, rawProgress);
    float bWarpAmount = warpAmount * (1.0 - reveal * 0.5) * (1.0 - bWarpRelease);
    vec2 inwardAspect = aspectP * (1.0 - bWarpAmount * 0.35 * (1.0 - normDist));
    vec2 warpUVB = fromAspectSpace(inwardAspect + ortho * (bWarpAmount * 0.15 * sin(swirlPhase + 1.57079633)), center);
    warpUVB = handleUVBounds(warpUVB);
    vec4 warpedB = texture2D(tDiffuseB, warpUVB);
    vec4 baseB = texture2D(tDiffuseB, handleUVBounds(vUv));
    warpedB = mix(baseB, warpedB, warpAmount * (1.0 - smoothstep(restoreStart, restoreEnd, rawProgress)));

    vec3 blended = mix(warpedA.rgb, warpedB.rgb, reveal);

    float coreGlow = exp(-normDist * 12.0) * warpAmount;
    float beam = exp(-pow((normDist - ringRadius * 0.7) / (0.18 + 0.25 * (1.0 - ringTravel)), 2.0)) * warpAmount;
    float streaks = warpAmount * 0.35 * (0.5 + 0.5 * sin(swirlPhase * 1.6 - easedProgress * 20.0)) * (1.0 - smoothstep(0.5, 1.0, normDist));
    vec3 flare = flareIntensity * (ringProfile * 1.4 + coreGlow * 0.8 + beam * 0.6 + streaks * 0.5) * vec3(1.0, 0.96, 0.9);

    blended += flare;
    blended = mix(blended, baseB.rgb, smoothstep(restoreStart, restoreEnd, rawProgress));
    blended = clamp(blended, 0.0, 1.0);

    float finalAlpha = mix(warpedA.a, warpedB.a, reveal);
    return vec4(blended, finalAlpha);
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