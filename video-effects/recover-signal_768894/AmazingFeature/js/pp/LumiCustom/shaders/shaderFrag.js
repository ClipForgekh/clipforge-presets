exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float glitchStrength; // = 1.0 [0.0, 2.0] // 故障强度

varying vec2 vUv;

float tween(float p) {
    return clamp(p, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash11(float n) {
    return fract(sin(n) * 43758.5453123);
}

float remap01(float p, float a, float b) {
    return clamp((p - a) / max(b - a, 1e-5), 0.0, 1.0);
}

float easeCubicOut(float t) {
    t = clamp(t, 0.0, 1.0);
    float inv = 1.0 - t;
    return 1.0 - inv * inv * inv;
}

float easeCubicInOut(float t) {
    t = clamp(t, 0.0, 1.0);
    return t < 0.5 ? 4.0 * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 3.0) * 0.5;
}

float easeExpoOut(float t) {
    t = clamp(t, 0.0, 1.0);
    return t >= 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

vec4 effect(vec4 texel, float p) {
    float k0 = 0.0;
    float k1 = 0.128571;
    float k2 = 0.271429;
    float k3 = 0.428571;
    float kd = 0.464286;
    float k4 = 0.485714;
    float k5 = 0.642857;
    float k6 = 0.821429;
    float k7 = 1.0;

    float sx = 1.0;
    if (p < k2) {
        sx = mix(0.92, 1.06, easeCubicOut(remap01(p, k1, k2)));
    } else if (p < k4) {
        sx = 1.06;
    } else if (p < k5) {
        sx = mix(1.06, 0.98, easeCubicInOut(remap01(p, k4, k5)));
    } else if (p < k6) {
        sx = mix(0.98, 1.0, easeCubicOut(remap01(p, k5, k6)));
    }

    vec2 uvBase = vUv;
    uvBase.x = 0.5 + (vUv.x - 0.5) * sx;

    float tearY = 0.5 + 0.12 * sin(p * 83.0);
    float tearMask = smoothstep(0.012, 0.0, abs(vUv.y - tearY));
    float tearShift = (hash11(floor(p * 700.0)) * 2.0 - 1.0) * 0.08 * glitchStrength;
    uvBase.x += tearMask * tearShift * (1.0 - smoothstep(k5, k6, p));

    vec2 uv = handleUVBounds(uvBase);

    float split = 0.0;
    split += 0.03 * glitchStrength * smoothstep(k4, k4 + 0.01, p) * (1.0 - smoothstep(k5, k6, p));
    split += 0.006 * glitchStrength * (1.0 - smoothstep(k1, k2, p));
    float lineJitter = (hash11(floor(vUv.y * 260.0) + floor(p * 180.0)) - 0.5) * 0.004 * glitchStrength;
    vec2 splitVec = vec2(split + lineJitter, 0.0);

    vec4 rTex = texture2D(tDiffuse, handleUVBounds(uv + splitVec));
    vec4 gTex = texture2D(tDiffuse, uv);
    vec4 bTex = texture2D(tDiffuse, handleUVBounds(uv - splitVec));
    vec4 rgbTex = vec4(rTex.r, gTex.g, bTex.b, gTex.a);

    float lineThin = step(0.93, fract(vUv.y * 190.0 + sin(p * 210.0) * 2.0));
    float lineRand = step(0.58, hash11(floor(vUv.y * 280.0) + floor(p * 120.0)));
    float bandSize = mix(0.02, 0.24, easeCubicOut(remap01(p, k0, k1)));
    float centerBand = 1.0 - smoothstep(bandSize, bandSize + 0.02, abs(vUv.y - 0.5));
    float earlyFragments = lineThin * lineRand * centerBand;

    float flicker = step(0.5, hash11(floor(p * 900.0) + floor(vUv.y * 300.0)));
    float alpha = 1.0;

    if (p < k1) {
        float t = easeCubicOut(remap01(p, k0, k1));
        alpha = earlyFragments * mix(0.0, 0.4, t) * flicker;
    } else if (p < k2) {
        float t = easeCubicOut(remap01(p, k1, k2));
        float flick = 0.6 + 0.4 * step(0.35, hash11(floor(p * 500.0) + floor(vUv.x * 120.0)));
        alpha = mix(0.35, 0.75, t) * flick;
    } else if (p < k3) {
        alpha = mix(0.75, 0.9, easeCubicOut(remap01(p, k2, k3)));
    } else if (p < kd) {
        alpha = 0.0;
    } else if (p < k4) {
        alpha = 0.12;
    } else if (p < k6) {
        alpha = mix(0.88, 1.0, easeExpoOut(remap01(p, k4, k6)));
    } else {
        alpha = 1.0;
    }

    float dropoutWindow = step(k3, p) * (1.0 - step(kd, p));
    vec4 tearTex = texture2D(tDiffuse, handleUVBounds(vec2(uv.x + tearShift * 0.5, uv.y)));
    vec4 mixedTex = mix(rgbTex, tearTex, tearMask * 0.5 * (1.0 - smoothstep(k5, k6, p)));

    float borderMask = getHardBoundaryMask(vUv);
    float finalAlpha = mixedTex.a * alpha * borderMask;

    vec3 finalRgb = mixedTex.rgb;
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    vec4 outColor = vec4(finalRgb, finalAlpha);
    vec4 tearOnly = vec4(tearTex.rgb, tearTex.a * tearMask * 0.16 * glitchStrength);
    outColor = mix(outColor, tearOnly, dropoutWindow);

    if (p >= k7) {
        return texel;
    }
    return outColor;
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