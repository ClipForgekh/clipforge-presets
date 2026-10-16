exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float blurLow; // = 0.18 [0.0, 0.6]
uniform float borderWidth; // = 0.03 [0.0, 0.1]
uniform float confettiDensity; // = 0.75 [0.1, 1.0]

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

float bounceOut(float x) {
    if (x < 1.0 / 2.75) {
        return 7.5625 * x * x;
    } else if (x < 2.0 / 2.75) {
        x -= 1.5 / 2.75;
        return 7.5625 * x * x + 0.75;
    } else if (x < 2.5 / 2.75) {
        x -= 2.25 / 2.75;
        return 7.5625 * x * x + 0.9375;
    } else {
        x -= 2.625 / 2.75;
        return 7.5625 * x * x + 0.984375;
    }
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 confettiColor(float h) {
    vec3 a = vec3(0.98, 0.30, 0.45);
    vec3 b = vec3(0.20, 0.75, 1.00);
    vec3 c = vec3(0.98, 0.90, 0.25);
    vec3 d = vec3(0.55, 0.95, 0.45);
    if (h < 0.25) return a;
    if (h < 0.5) return b;
    if (h < 0.75) return c;
    return d;
}

vec4 sampleDirectionalLowBlur(vec2 uv, vec2 dir, float amount) {
    vec2 d = dir * amount * 0.01;
    vec2 uv0 = handleUVBounds(uv - d * 2.0);
    vec2 uv1 = handleUVBounds(uv - d);
    vec2 uv2 = handleUVBounds(uv);
    vec2 uv3 = handleUVBounds(uv + d);
    vec2 uv4 = handleUVBounds(uv + d * 2.0);
    vec4 c0 = texture2D(tDiffuse, uv0);
    vec4 c1 = texture2D(tDiffuse, uv1);
    vec4 c2 = texture2D(tDiffuse, uv2);
    vec4 c3 = texture2D(tDiffuse, uv3);
    vec4 c4 = texture2D(tDiffuse, uv4);
    return c0 * 0.1 + c1 * 0.2 + c2 * 0.4 + c3 * 0.2 + c4 * 0.1;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    float t0 = 0.1 / 1.8;
    float t1 = 1.2 / 1.8;

    float yOff = 0.75;
    float sc = 0.8;
    float ang = radians(-8.0);

    if (p <= t0) {
        yOff = 0.75;
        sc = 0.8;
        ang = radians(-8.0);
    } else if (p < t1) {
        float q = clamp((p - t0) / (t1 - t0), 0.0, 1.0);
        float e = 1.0 - pow(1.0 - q, 3.0);
        yOff = mix(0.75, -0.06, e);
        sc = mix(0.8, 0.985, e);
        ang = radians(mix(-8.0, 1.0, e));
    } else {
        float q2 = clamp((p - t1) / (1.0 - t1), 0.0, 1.0);
        float e2 = mix(smoothstep(0.0, 1.0, q2), bounceOut(q2), 0.45);
        yOff = mix(-0.06, 0.0, e2);
        sc = mix(0.985, 1.0, e2);
        ang = radians(mix(1.0, 0.0, e2));
    }

    vec2 offset = vec2(0.0, yOff);
    float s = sin(-ang);
    float c = cos(-ang);

    vec2 pLocal = vUv - 0.5 - offset;
    vec2 rLocal = vec2(
        pLocal.x * c - pLocal.y * s,
        pLocal.x * s + pLocal.y * c
    ) / max(sc, 0.0001);

    vec2 uv = rLocal + 0.5;
    float mask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);

    vec4 baseCol;
    float dropBlurPhase = 1.0 - smoothstep(t1 - 0.05, t1, p);
    float blurAmt = blurLow * dropBlurPhase;
    if (blurAmt > 0.0001) {
        baseCol = sampleDirectionalLowBlur(uv, vec2(0.0, 1.0 / max(ratio, 0.0001)), blurAmt);
    } else {
        baseCol = texture2D(tDiffuse, uv);
    }
    baseCol.a *= mask;

    float edgeDist = min(min(vUv.x, 1.0 - vUv.x), min(vUv.y, 1.0 - vUv.y));
    float borderMask = 1.0 - step(borderWidth, edgeDist);

    vec2 grid = vec2(vUv.x * 110.0, vUv.y * (110.0 / max(ratio, 0.0001)));
    vec2 cell = floor(grid);
    vec2 f = fract(grid) - 0.5;
    float rnd = hash12(cell);
    float spawn = step(1.0 - confettiDensity * 0.35, rnd);
    float r = 0.18 + 0.26 * hash12(cell + 7.13);
    float chip = spawn * (1.0 - smoothstep(r, r + 0.03, length(f)));
    vec3 bCol = mix(vec3(1.0), confettiColor(hash12(cell + 3.71)), chip);

    float borderFade = 1.0 - smoothstep(0.9, 1.0, p);
    float borderAlpha = borderMask * borderFade * (0.55 + 0.45 * chip);

    vec3 outRgb = mix(baseCol.rgb, bCol, borderAlpha);
    float outA = max(baseCol.a, borderAlpha * 0.9);

    return vec4(clamp(outRgb, 0.0, 1.0), clamp(outA, 0.0, 1.0));
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