exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float refractionStrength; // = 0.02 [0.0, 0.08] // 轻微金属折射强度
uniform float glowStrength; // = 0.35 [0.0, 1.0] // 斜向高光强度
uniform float highlightWidth; // = 0.10 [0.02, 0.30] // 高光扫光宽度

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

float expoOut01(float x) {
    x = clamp(x, 0.0, 1.0);
    return (x >= 1.0) ? 1.0 : (1.0 - pow(2.0, -10.0 * x));
}

vec4 effect(vec4 texel, float p) {
    const float t0 = 0.0666667; // 0.2s
    const float t1 = 0.3333333; // 1.0s
    const float t2 = 0.4666667; // 1.4s
    const float t3 = 0.6000000; // 1.8s
    const float t4 = 0.7666667; // 2.3s

    float scale = 1.0;
    float alpha = 1.0;

    if (p < t0) {
        scale = 0.7;
        alpha = 0.0;
    } else if (p < t2) {
        float k = expoOut01((p - t0) / (t2 - t0));
        scale = mix(0.7, 1.08, k);
        alpha = k;
    } else if (p < t3) {
        scale = 1.08;
        alpha = 1.0;
    } else if (p < t4) {
        float k2 = smoothstep(0.0, 1.0, (p - t3) / (t4 - t3));
        scale = mix(1.08, 1.0, k2);
        alpha = 1.0;
    } else {
        scale = 1.0;
        alpha = 1.0;
    }

    vec2 baseUV = 0.5 + (vUv - 0.5) * scale;

    float refrIn = smoothstep(t0, t1, p);
    float refrOut = 1.0 - smoothstep(t2, t3, p);
    float refractAmt = refractionStrength * refrIn * refrOut;

    vec2 centered = vUv - 0.5;
    vec2 radialDir = normalize(centered + vec2(1e-5, 1e-5));
    vec2 sweepDir = normalize(vec2(1.0, 0.35 / max(ratio, 0.0001)));
    float wave = sin((vUv.y * 12.0 + vUv.x * 8.0) * 3.14159265);
    vec2 refrOffset = (radialDir * 0.6 + sweepDir * 0.4) * refractAmt * (0.5 + 0.5 * wave);

    vec2 uvR = handleUVBounds(baseUV + refrOffset * 1.6);
    vec2 uvG = handleUVBounds(baseUV + refrOffset * 1.0);
    vec2 uvB = handleUVBounds(baseUV + refrOffset * 0.4);

    vec4 cR = texture2D(tDiffuse, uvR);
    vec4 cG = texture2D(tDiffuse, uvG);
    vec4 cB = texture2D(tDiffuse, uvB);

    vec3 lensColor = vec3(cR.r, cG.g, cB.b);
    float lensA = (cR.a + cG.a + cB.a) / 3.0;

    float highlightWindow = smoothstep(t1, t2, p) * (1.0 - smoothstep(t2, t3, p));
    float sweepP = clamp((p - t1) / (t3 - t1), 0.0, 1.0);
    float sweepPos = mix(-1.2, 1.2, sweepP);

    vec2 aspectUV = (vUv - 0.5) * vec2(ratio, 1.0);
    float lineCoord = dot(aspectUV, normalize(vec2(1.0, -0.55)));
    float d = abs(lineCoord - sweepPos);
    float glowLine = exp(-pow(d / max(highlightWidth, 0.0001), 2.0));

    float edgeBoost = pow(clamp(1.0 - abs(dot(radialDir, sweepDir)), 0.0, 1.0), 2.0);
    vec3 glow = vec3(1.0, 0.98, 0.90) * glowLine * glowStrength * highlightWindow * (0.7 + 0.3 * edgeBoost);

    vec3 finalRgb = lensColor + glow;
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(vUv);
    float finalA = clamp(lensA * alpha * borderMask, 0.0, 1.0);

    return vec4(finalRgb * alpha, finalA);
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