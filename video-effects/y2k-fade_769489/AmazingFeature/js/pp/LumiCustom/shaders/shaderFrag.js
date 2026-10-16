exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float stripCount; // = 8.0 [4.0, 16.0] // 横向条带数量
uniform float maxBlur; // = 0.08 [0.0, 0.2] // 最大方向模糊半径(UV)
uniform float glowPeak; // = 3.8 [1.0, 6.0] // Deep Glow峰值强度
uniform float bandHeight; // = 0.012 [0.002, 0.05] // 顶底收束光带高度(UV)
uniform float glitchAmount; // = 0.003 [0.0, 0.02] // RGB故障偏移强度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 directionalBlur(vec2 uv, float dir, float radius) {
    vec4 acc = vec4(0.0);
    float wsum = 0.0;
    for (int i = -4; i <= 4; i++) {
        float fi = float(i);
        float w = 1.0 - abs(fi) / 4.0;
        vec2 suv = uv + vec2(0.0, dir * radius * (fi / 4.0));
        suv = handleUVBounds(suv);
        acc += texture2D(tDiffuse, suv) * w;
        wsum += w;
    }
    return acc / max(wsum, 0.0001);
}

vec4 effect(vec4 texel, float p) {
    float borderMask = getHardBoundaryMask(vUv);

    if (p < 0.3) {
        return vec4(texel.rgb, texel.a * borderMask);
    }

    float sc = max(1.0, floor(stripCount + 0.5));
    float stripY = vUv.y * sc;
    float stripIdxBottom = floor(stripY);
    float stripFrac = fract(stripY);
    float stripCenterY = (stripIdxBottom + 0.5) / sc;

    float stripIdxTop = floor((1.0 - vUv.y) * sc);
    float isOddFromTop = 1.0 - step(0.5, mod(stripIdxTop, 2.0)); // 1,3,5,7...
    float dir = mix(-1.0, 1.0, isOddFromTop); // odd向上(+1), even向下(-1)

    float edgeDist = min(stripFrac, 1.0 - stripFrac);
    float splitEdgeMask = smoothstep(0.08, 0.0, edgeDist);
    vec3 splitEdgeCyan = vec3(0.10, 0.95, 1.0);

    vec3 purple = vec3(0.78, 0.25, 1.0);
    vec3 cyan = vec3(0.0, 0.95, 1.0);
    vec3 neonColor = mix(cyan, purple, isOddFromTop);

    if (p < 0.8) {
        float t = clamp((p - 0.3) / 0.5, 0.0, 1.0);
        float blurR = maxBlur * t;

        float flicker = 0.5 + 0.5 * sin((vUv.x * 90.0 + stripIdxBottom * 4.7) + t * 55.0);
        float gAmp = glitchAmount * t * (0.6 + 0.4 * flicker);

        vec2 uvR = handleUVBounds(vUv + vec2(gAmp, 0.0));
        vec2 uvB = handleUVBounds(vUv - vec2(gAmp, 0.0));
        vec4 blurBase = directionalBlur(vUv, dir, blurR);
        float r = directionalBlur(uvR, dir, blurR).r;
        float g = blurBase.g;
        float b = directionalBlur(uvB, dir, blurR).b;
        vec4 glitchBlur = vec4(r, g, b, blurBase.a);

        float contentKeep = 1.0 - smoothstep(0.0, 1.0, t);

        float topBandY = 1.0 - bandHeight * 0.5;
        float bottomBandY = bandHeight * 0.5;
        float targetY = mix(stripCenterY, mix(bottomBandY, topBandY, isOddFromTop), t);
        float bandMask = smoothstep(0.06, 0.0, abs(vUv.y - targetY));

        float glowStrength = mix(1.0, glowPeak, t);
        float glowCore = bandMask * glowStrength * (0.7 + 0.3 * flicker);

        vec3 color = glitchBlur.rgb * contentKeep;
        color += neonColor * glowCore;
        color += splitEdgeCyan * splitEdgeMask * (0.10 + 0.18 * t);

        float alpha = max(glitchBlur.a * contentKeep, bandMask * (0.55 + 0.45 * t));
        return vec4(clamp(color, 0.0, 1.0), clamp(alpha, 0.0, 1.0) * borderMask);
    }

    float topBandY2 = 1.0 - bandHeight * 0.5;
    float bottomBandY2 = bandHeight * 0.5;
    float topMask = smoothstep(bandHeight * 1.5, 0.0, abs(vUv.y - topBandY2));
    float bottomMask = smoothstep(bandHeight * 1.5, 0.0, abs(vUv.y - bottomBandY2));
    float bands = max(topMask, bottomMask);

    float fade = 1.0 - smoothstep(0.8, 0.9, p);
    fade *= step(p, 0.9);

    float peakPulse = 0.9 + 0.1 * sin(vUv.x * 120.0);
    vec3 bandColor = mix(vec3(0.0, 0.95, 1.0), vec3(0.78, 0.25, 1.0), topMask);
    vec3 finalRGB = bandColor * (glowPeak * 0.55) * peakPulse * fade;
    float finalA = bands * fade;

    return vec4(clamp(finalRGB, 0.0, 1.0), clamp(finalA, 0.0, 1.0) * borderMask);
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