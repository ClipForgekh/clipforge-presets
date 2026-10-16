exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float glitchGain; // = 1.0 [0.0, 2.0] // 故障总强度增益
uniform float noiseScale; // = 220.0 [64.0, 512.0] // 噪声尺度
uniform float stripShift; // = 0.22 [0.0, 0.6] // 条带最大水平位移

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    float k = 6.0;
    return (exp(k * p) - 1.0) / (exp(k) - 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float luma(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

float ramp(float t, float a, float b) {
    return clamp((t - a) / max(b - a, 1e-5), 0.0, 1.0);
}

float keyL2H2M2Z(float t, float t0, float t1, float t2, float t3, float lowV, float highV, float midV) {
    if (t < t0 || t >= t3) return 0.0;
    if (t < t1) return mix(lowV, highV, tween(ramp(t, t0, t1)));
    if (t < t2) return mix(highV, midV, tween(ramp(t, t1, t2)));
    return mix(midV, 0.0, tween(ramp(t, t2, t3)));
}

float keyFlicker(float t, float t0, float t1, float t2, float highV) {
    if (t < t0 || t >= t2) return 0.0;
    if (t < t1) return mix(0.0, highV, tween(ramp(t, t0, t1)));
    return mix(highV, 0.0, tween(ramp(t, t1, t2)));
}

vec3 applyChromatic(vec2 uv, float amt) {
    vec2 off = vec2(amt, 0.0);
    vec2 uvr = handleUVBounds(uv + off);
    vec2 uvb = handleUVBounds(uv - off);
    float r = texture2D(tDiffuse, uvr).r;
    float g = texture2D(tDiffuse, uv).g;
    float b = texture2D(tDiffuse, uvb).b;
    return vec3(r, g, b);
}

vec4 effect(vec4 texel, float p) {
    float t = clamp(progress, 0.0, 1.0);

    if (t < 0.10) {
        return texel;
    }

    if (t >= 0.75) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    float pixSort = keyL2H2M2Z(t, 0.10, 0.60, 0.75, 0.75, 0.15, 1.0, 0.55) * glitchGain;
    float chroma = keyL2H2M2Z(t, 0.10, 0.60, 0.75, 0.75, 0.10, 1.0, 0.5) * glitchGain;
    float crt = keyL2H2M2Z(t, 0.10, 0.60, 0.75, 0.75, 0.12, 1.0, 0.45) * glitchGain;
    float flick = keyFlicker(t, 0.10, 0.60, 0.75, 1.0) * glitchGain;

    float accel = tween(ramp(t, 0.60, 0.75));
    float row = floor(vUv.y * (120.0 + noiseScale * 0.25));
    float rowRnd = hash12(vec2(row, floor(t * 480.0)));
    float rowMask = step(0.45, rowRnd);

    vec2 uv = vUv;
    float shiftA = (rowRnd - 0.5) * stripShift * (0.25 + 0.75 * pixSort);
    float shiftB = sign(rowRnd - 0.5) * stripShift * 1.8 * accel * rowMask;
    uv.x += shiftA + shiftB;

    float lum = luma(texture2D(tDiffuse, handleUVBounds(vUv)).rgb);
    float sortGate = smoothstep(0.25, 0.85, lum + (hash12(vec2(row, t * 37.0)) - 0.5) * 0.3);
    uv.x += (sortGate - 0.5) * stripShift * 0.6 * pixSort;

    vec2 blockUV = floor(vUv * vec2(noiseScale * 0.7, noiseScale * 0.45)) / vec2(noiseScale * 0.7, noiseScale * 0.45);
    float blockN = hash12(blockUV + vec2(floor(t * 300.0), 17.0));
    float corrupt = step(0.82 - 0.45 * pixSort, blockN);

    vec3 col = applyChromatic(handleUVBounds(uv), 0.0065 * chroma + 0.018 * accel);

    float scan = sin((vUv.y * (420.0 / max(ratio, 0.2)) + t * 200.0) * 3.14159265);
    float scanline = 1.0 - (0.18 + 0.35 * crt) * (0.5 + 0.5 * scan);
    col *= scanline;

    float rnd = hash12(vUv * noiseScale + vec2(t * 911.0, t * 613.0));
    float n = (rnd - 0.5) * (0.08 + 0.42 * pixSort + 0.5 * accel);
    col += vec3(n);

    vec2 cell = floor(vUv * vec2(64.0, 36.0));
    float glyphRnd = hash12(cell + vec2(floor(t * 120.0), 3.0));
    float glyphMask = step(0.92 - 0.55 * crt, glyphRnd);
    vec3 glyphColor = vec3(0.1, 1.0, 0.35) * (0.4 + 0.6 * hash12(cell + 19.7));
    col = mix(col, glyphColor, glyphMask * (0.35 * crt));

    vec3 corruptColor = vec3(
        hash12(blockUV + 1.7),
        hash12(blockUV + 9.1),
        hash12(blockUV + 21.3)
    );
    col = mix(col, corruptColor, corrupt * (0.35 + 0.55 * accel));

    float flickPulse = (hash12(vec2(floor(t * 180.0), 7.0)) - 0.5) * 2.0;
    float flickerMul = 1.0 + flick * 0.22 * flickPulse;
    col *= flickerMul;

    col = clamp(col, 0.0, 1.0);
    return vec4(col, texel.a);
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