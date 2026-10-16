exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float maxBlur; // = 0.065 [0.01, 0.18] // 最大纵向模糊半径
uniform float grainAmount; // = 0.08 [0.0, 0.25] // 胶片颗粒强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 19.19);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 verticalStreakSample(vec2 uv, float radius, float jitter) {
    vec3 col = vec3(0.0);
    float wsum = 0.0;

    float stepY = radius * (0.7 + jitter * 0.6);

    for (int i = -4; i <= 4; i++) {
        float fi = float(i);
        float w = 1.0 - abs(fi) / 4.5;
        vec2 suv = vec2(uv.x, uv.y + fi * stepY);
        suv = handleUVBounds(suv);
        col += texture2D(tDiffuse, suv).rgb * w;
        wsum += w;
    }

    return col / max(wsum, 0.0001);
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    vec2 center = vec2(0.5);
    vec2 d = vUv - center;
    if (ratio > 1.0) d.y /= ratio;
    else d.x *= ratio;
    float distNorm = clamp(length(d) / 0.70710678, 0.0, 1.0);

    float luma = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float mx = max(texel.r, max(texel.g, texel.b));
    float mn = min(texel.r, min(texel.g, texel.b));
    float sat = mx - mn;

    float fgW = smoothstep(0.18, 0.85, sat * 0.9 + abs(luma - 0.5) * 1.1);
    float bgW = smoothstep(0.25, 0.85, 1.0 - sat) * (0.6 + 0.4 * smoothstep(0.2, 0.9, luma));
    float mgW = max(0.0, 1.0 - fgW - bgW);
    float wSum = fgW + mgW + bgW + 0.0001;
    fgW /= wSum;
    mgW /= wSum;
    bgW /= wSum;

    float pFg = 1.0 - pow(1.0 - p, 3.0);
    float pMg = 1.0 - pow(1.0 - p, 2.0);
    float pBg = 1.0 - pow(1.0 - p, 1.35);

    float endFade = 1.0 - p;
    float sFg = endFade * clamp(1.0 - pFg * (1.35 - distNorm), 0.0, 1.0);
    float sMg = endFade * clamp(1.0 - pMg * (1.25 - distNorm), 0.0, 1.0);
    float sBg = endFade * clamp(1.0 - pBg * (1.15 - distNorm), 0.0, 1.0);

    float n0 = hash12(vUv * vec2(913.1, 271.7));
    float n1 = hash12(vUv * vec2(521.3, 733.9) + 0.37);
    float jitter = (n0 + n1) * 0.5;

    vec3 fgCol = verticalStreakSample(vUv, maxBlur * sFg, jitter);
    vec3 mgCol = verticalStreakSample(vUv, maxBlur * sMg, jitter * 0.9 + 0.05);
    vec3 bgCol = verticalStreakSample(vUv, maxBlur * sBg, jitter * 0.8 + 0.1);

    vec3 layered = fgCol * fgW + mgCol * mgW + bgCol * bgW;

    float blurMix = clamp((sFg + sMg + sBg) / 3.0, 0.0, 1.0);
    float grainFade = grainAmount * blurMix;

    float gr = hash12(vUv * vec2(1280.0, 720.0) + vec2(0.13, 0.71)) - 0.5;
    float gg = hash12(vUv * vec2(1220.0, 760.0) + vec2(0.41, 0.19)) - 0.5;
    float gb = hash12(vUv * vec2(1350.0, 690.0) + vec2(0.77, 0.53)) - 0.5;
    vec3 grain = vec3(gr, gg, gb) * grainFade * 0.8;

    vec3 finalRgb = clamp(layered + grain, 0.0, 1.0);
    float borderMask = getHardBoundaryMask(vUv);

    return vec4(finalRgb, texel.a * borderMask);
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