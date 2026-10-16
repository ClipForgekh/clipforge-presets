exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float maxBlurRadius; // = 0.03 [0.005, 0.08] // 最大纵向模糊半径（UV空间，约等效22px可按项目分辨率微调）
uniform float glowIntensity; // = 3.2 [0.0, 5.0] // 霓虹扫光强度
uniform float rgbShift; // = 0.004 [0.0, 0.02] // RGB色偏强度
uniform float noiseAmount; // = 0.08 [0.0, 0.3] // 霓虹噪点强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec3 adjustSaturation(vec3 color, float sat) {
    float l = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(l), color, sat);
}

vec4 directionalVerticalBlur(vec2 uv, float radius, float dirSign) {
    vec4 sum = vec4(0.0);
    float wsum = 0.0;
    for (int i = 0; i < 7; i++) {
        float t = float(i) / 6.0;
        float w = 1.0 - abs(t - 0.5) * 1.6;
        vec2 offset = vec2(0.0, t * radius * dirSign);
        vec2 suv = handleUVBounds(uv + offset);
        sum += texture2D(tDiffuse, suv) * w;
        wsum += w;
    }
    return sum / max(wsum, 0.0001);
}

float lightHeadY(float t, float delay, float speed) {
    float y0 = 0.04;
    float p1 = clamp((t - delay) / 0.3, 0.0, 1.0);
    float p2 = clamp((t - delay - 0.3) / 0.7, 0.0, 1.0);
    float yMid = y0 + 0.78 * speed * p1;
    float y = mix(yMid, 1.06, p2);
    return y;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    float yL = lightHeadY(p, 0.00, 1.00);
    float yM = lightHeadY(p, 0.05, 0.86);
    float yR = lightHeadY(p, 0.10, 0.72);

    float fadeL = 1.0 - smoothstep(0.3, 1.0, max(0.0, p - 0.00));
    float fadeM = 1.0 - smoothstep(0.3, 1.0, max(0.0, p - 0.05));
    float fadeR = 1.0 - smoothstep(0.3, 1.0, max(0.0, p - 0.10));

    float bandW = 1.0 / 3.0;
    float mXL = 1.0 - smoothstep(bandW * 0.45, bandW * 0.52, abs(vUv.x - 1.0 / 6.0));
    float mXM = 1.0 - smoothstep(bandW * 0.45, bandW * 0.52, abs(vUv.x - 0.5));
    float mXR = 1.0 - smoothstep(bandW * 0.45, bandW * 0.52, abs(vUv.x - 5.0 / 6.0));

    float headL = exp(-pow((vUv.y - yL) / 0.06, 2.0)) * mXL * fadeL;
    float headM = exp(-pow((vUv.y - yM) / 0.06, 2.0)) * mXM * fadeM;
    float headR = exp(-pow((vUv.y - yR) / 0.06, 2.0)) * mXR * fadeR;

    float trailL = smoothstep(-0.22, 0.03, yL - vUv.y) * mXL * fadeL;
    float trailM = smoothstep(-0.22, 0.03, yM - vUv.y) * mXM * fadeM;
    float trailR = smoothstep(-0.22, 0.03, yR - vUv.y) * mXR * fadeR;

    float sweepCoverage = clamp(max(max(trailL, trailM), trailR), 0.0, 1.0);

    float residualDecay = 1.0 - pow(p, 1.6);
    float localBlurFactor = clamp(residualDecay * (1.0 - 0.85 * sweepCoverage), 0.0, 1.0);
    float blurRadius = maxBlurRadius * strength * localBlurFactor;

    float dirSign = (vUv.y >= 0.5) ? 1.0 : -1.0;
    vec4 blurred = directionalVerticalBlur(vUv, blurRadius, dirSign);

    float shift = rgbShift * strength;
    float r = texture2D(tDiffuse, handleUVBounds(vUv + vec2(shift, 0.0))).r;
    float g = texture2D(tDiffuse, handleUVBounds(vUv)).g;
    float b = texture2D(tDiffuse, handleUVBounds(vUv - vec2(shift, 0.0))).b;
    vec3 shifted = vec3(r, g, b);

    vec3 base = mix(blurred.rgb, shifted, 0.35 * strength);

    float brightness = 1.0 + 2.2 * strength;
    float saturation = 1.0 - 0.25 * strength;
    base = adjustSaturation(base * brightness, saturation);

    vec3 neonL = vec3(1.0, 0.15, 0.20) * (headL + trailL * 0.35);
    vec3 neonM = vec3(0.15, 0.35, 1.0) * (headM + trailM * 0.35);
    vec3 neonR = vec3(0.65, 0.20, 1.0) * (headR + trailR * 0.35);
    vec3 neonGlow = (neonL + neonM + neonR) * glowIntensity * strength;

    float n = hash21(vUv * vec2(360.0, 640.0) + vec2(p * 37.0, p * 19.0));
    float n2 = hash21(vUv * vec2(640.0, 280.0) + vec2(p * 13.0, p * 51.0));
    vec3 neonNoise = vec3(n, n2, 1.0 - n) - 0.5;
    float noiseMask = (headL + headM + headR) * 0.6 + 0.4;
    neonNoise *= noiseAmount * strength * noiseMask;

    vec3 finalRgb = base + neonGlow + neonNoise;
    finalRgb = mix(finalRgb, texel.rgb, p);
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    return vec4(finalRgb, texel.a);
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