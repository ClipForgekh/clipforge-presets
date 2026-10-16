exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float flareWidth; // = 0.18 [0.05, 0.35] // 主光带宽度
uniform float revealFeather; // = 0.25 [0.05, 0.4] // 光扫羽化宽度
uniform float flareIntensity; // = 1.2 [0.2, 3.0] // 光带强度
uniform float coreIntensity; // = 2.0 [0.5, 4.0] // 核心亮度
uniform float secondaryStrength; // = 0.6 [0.0, 2.0] // 次级光晕强度
uniform vec3 flareColor; // = vec3(1.0, 0.95, 0.85) // 主光颜色

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    return 1.0 - pow(1.0 - p, 3.0);
}

float saturate(float x) {
    return clamp(x, 0.0, 1.0);
}

float cubicOut(float t) {
    t = clamp(t, 0.0, 1.0);
    return 1.0 - pow(1.0 - t, 3.0);
}

float gaussian(float x, float sigma) {
    sigma = max(sigma, 1e-4);
    float v = x / sigma;
    return exp(-0.5 * v * v);
}

vec4 effect(vec4 texel, float easedProgress) {
    float time = 1.0 - pow(1.0 - clamp(easedProgress, 0.0, 1.0), 0.33333333);

    vec2 screenPos = vec2((vUv.x - 0.5) * ratio, vUv.y - 0.5);
    vec2 diagDir = normalize(vec2(ratio, 1.0));
    vec2 diagPerp = vec2(-diagDir.y, diagDir.x);
    float diagExtent = dot(vec2(0.5 * ratio, 0.5), diagDir);
    float diagStart = -diagExtent - 0.6;
    float diagEnd = diagExtent + 0.1;

    float pathT;
    if (time < 0.175) {
        pathT = 0.0;
    } else if (time < 0.6) {
        float seg = (time - 0.175) / (0.6 - 0.175);
        pathT = cubicOut(seg) * 0.85;
    } else if (time < 0.8) {
        float seg = (time - 0.6) / (0.8 - 0.6);
        pathT = mix(0.85, 1.0, cubicOut(seg));
    } else {
        pathT = 1.0;
    }

    float diagHead = mix(diagStart, diagEnd, pathT);
    float diagCoord = dot(screenPos, diagDir);
    float orthoCoord = dot(screenPos, diagPerp);

    float revealMask = 1.0 - smoothstep(0.0, revealFeather, diagCoord - diagHead);
    revealMask *= smoothstep(0.05, 0.2, time);
    revealMask = saturate(revealMask);

    float flareScale = 1.0;
    if (time >= 0.6) {
        float shrinkT = (time - 0.6) / (0.8 - 0.6);
        flareScale = mix(1.0, 0.65, cubicOut(saturate(shrinkT)));
    }

    float overlayPresence = smoothstep(0.05, 0.175, time) * (1.0 - smoothstep(0.8, 1.0, time));

    float streak = gaussian(orthoCoord, flareWidth * flareScale);
    float longitudinal = gaussian(diagCoord - diagHead, (diagExtent + 0.7) * 0.35 * flareScale);
    float mainFlare = streak * longitudinal;

    float core = gaussian(orthoCoord, flareWidth * 0.25 * flareScale) *
                 gaussian(diagCoord - diagHead, (diagExtent + 0.7) * 0.12 * flareScale);

    float secondary1 = gaussian(length(vec2(diagCoord - (diagHead - 0.18), orthoCoord * 0.7)), 0.18 * flareScale);
    float secondary2 = gaussian(length(vec2(diagCoord - (diagHead + 0.24), orthoCoord * 0.9)), 0.22 * flareScale);

    float flareAmount = overlayPresence * (
        flareIntensity * mainFlare +
        coreIntensity * core +
        secondaryStrength * (secondary1 + 0.8 * secondary2)
    );

    vec3 flareLight = flareColor * flareAmount;

    vec3 baseColor = texel.rgb * revealMask;
    float baseAlpha = texel.a * revealMask;

    vec3 finalRGB = clamp(baseColor + flareLight, 0.0, 1.0);
    float finalAlpha = clamp(baseAlpha, 0.0, 1.0);

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