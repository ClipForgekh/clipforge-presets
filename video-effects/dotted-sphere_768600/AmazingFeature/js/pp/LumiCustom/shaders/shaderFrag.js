exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float dotMaxSize; // = 0.22 [0.08, 0.35] // 初始最大网格尺寸（大圆点）
uniform float dotMinSize; // = 0.02 [0.006, 0.06] // 末期最小网格尺寸（细腻半调）
uniform float glowStrength; // = 0.18 [0.0, 0.5] // LumiS_Glow低强度

varying vec2 vUv;

float cubicInOut(float x) {
    x = clamp(x, 0.0, 1.0);
    return x < 0.5
        ? 4.0 * x * x * x
        : 1.0 - pow(-2.0 * x + 2.0, 3.0) * 0.5;
}

float tween(float p) {
    return cubicInOut(p);
}

float inverseCubicInOut(float y) {
    y = clamp(y, 0.0, 1.0);
    if (y < 0.5) {
        return pow(y * 0.25, 1.0 / 3.0);
    }
    return 1.0 - pow((2.0 - 2.0 * y) * 0.25, 1.0 / 3.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float easedProgress) {
    float t = inverseCubicInOut(easedProgress);

    float blackEnd = 0.35 / 3.0;
    float revealEnd = 1.9 / 3.0;
    float cleanupStart = 1.7 / 3.0;
    float cleanupEnd = 2.4 / 3.0;

    if (t <= blackEnd) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    float revealPhase = cubicInOut(clamp((t - blackEnd) / max(revealEnd - blackEnd, 0.0001), 0.0, 1.0));
    float cleanupPhase = cubicInOut(clamp((t - cleanupStart) / max(cleanupEnd - cleanupStart, 0.0001), 0.0, 1.0));

    vec2 p = getSDFCoordinate(vUv, vec2(0.5));
    float dist = length(p);
    float maxDist = length(getSDFCoordinate(vec2(1.0, 1.0), vec2(0.5)));

    float revealRadius = mix(0.02, maxDist * 1.03, revealPhase);
    float radialMask = 1.0 - smoothstep(revealRadius - 0.025, revealRadius + 0.025, dist);

    float centerWeight = 1.0 - smoothstep(0.0, maxDist, dist);
    float cellSize = mix(dotMaxSize, dotMinSize, revealPhase);
    cellSize *= 1.0 + centerWeight * (1.4 * (1.0 - revealPhase));

    vec2 gridUV = (vUv - 0.5) / max(cellSize, 0.0001);
    vec2 cellId = floor(gridUV);
    vec2 jitter = vec2(
        sin(cellId.y * 1.7 + cellId.x * 0.9 + revealPhase * 5.0),
        cos(cellId.x * 1.3 - cellId.y * 1.1 + revealPhase * 4.0)
    ) * (0.06 * (1.0 - revealPhase));
    vec2 gv = fract(gridUV + jitter) - 0.5;

    float dotRadius = mix(0.49, 0.18, revealPhase);
    float dotEdge = mix(0.12, 0.05, revealPhase);
    float dotMask = 1.0 - smoothstep(dotRadius, dotRadius + dotEdge, length(gv));

    float halftoneMask = radialMask * dotMask;
    float revealMask = mix(halftoneMask, radialMask, cleanupPhase);

    float cleanHold = step(cleanupEnd, t);
    revealMask = mix(revealMask, 1.0, cleanHold);

    vec3 color = texel.rgb * revealMask;

    float glowStart = 1.0 / 3.0;
    float glowEnd = 2.1 / 3.0;
    float glowIn = smoothstep(glowStart, glowStart + 0.12, t);
    float glowOut = 1.0 - smoothstep(glowEnd - 0.10, glowEnd, t);
    float glow = glowStrength * glowIn * glowOut;

    vec3 glowColor = texel.rgb * (0.16 * glow) + vec3(0.04, 0.04, 0.05) * glow;
    color += glowColor * revealMask;

    color = clamp(color, 0.0, 1.0);

    if (t >= 0.9999) {
        return texel;
    }

    return vec4(color, 1.0);
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