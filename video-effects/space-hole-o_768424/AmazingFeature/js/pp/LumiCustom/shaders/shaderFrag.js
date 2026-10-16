exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float pullStrength; // = 1.2 [0.2, 2.5] // 引力拉扯强度
uniform float spinStrength; // = 1.0 [0.2, 2.0] // 旋转扭曲强度
uniform float coreSize; // = 0.09 [0.02, 0.2] // 奇点核心大小

varying vec2 vUv;

float easeInOutQuad(float x) {
    return x < 0.5 ? 2.0 * x * x : 1.0 - pow(-2.0 * x + 2.0, 2.0) * 0.5;
}

float tween(float p) {
    return easeInOutQuad(clamp(p, 0.0, 1.0));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float kf(float t, float t0, float t1, float v0, float v1) {
    float u = clamp((t - t0) / max(t1 - t0, 0.00001), 0.0, 1.0);
    u = easeInOutQuad(u);
    return mix(v0, v1, u);
}

float envVignette(float t) {
    if (t < 0.125) return kf(t, 0.0, 0.125, 0.0, 0.65);
    if (t < 0.55) return kf(t, 0.125, 0.55, 0.65, 1.0);
    return kf(t, 0.55, 1.0, 1.0, 0.0);
}

float envColorama(float t) {
    if (t < 0.125) return kf(t, 0.0, 0.125, 0.0, 0.5);
    if (t < 0.55) return kf(t, 0.125, 0.55, 0.5, 0.9);
    return kf(t, 0.55, 1.0, 0.9, 0.0);
}

float envSpinBlur(float t) {
    if (t < 0.45) return kf(t, 0.0, 0.45, 0.0, 1.0);
    if (t < 0.6) return kf(t, 0.45, 0.6, 1.0, 0.55);
    return kf(t, 0.6, 1.0, 0.55, 0.0);
}

float envGlow(float t) {
    if (t < 0.125) return kf(t, 0.0, 0.125, 0.0, 0.5);
    if (t < 0.55) return kf(t, 0.125, 0.55, 0.5, 0.9);
    return kf(t, 0.55, 1.0, 0.9, 0.0);
}

float envExposure(float t) {
    if (t < 0.45) return kf(t, 0.0, 0.45, 0.0, 0.8);
    if (t < 0.75) return kf(t, 0.45, 0.75, 0.8, 0.0);
    return 0.0;
}

vec4 sampleSpinBlur(vec2 uv, vec2 center, float amount, float pull) {
    vec4 acc = vec4(0.0);
    float total = 0.0;
    vec2 d = uv - center;
    float ang = atan(d.y, d.x);
    float r = length(d);
    const int TAP = 8;
    for (int i = 0; i < TAP; i++) {
        float fi = float(i) / float(TAP - 1);
        float ofs = (fi - 0.5);
        float a = ang + ofs * amount * 2.2;
        float rr = max(0.0, r - abs(ofs) * pull * 0.08);
        vec2 suv = center + vec2(cos(a), sin(a)) * rr;
        suv = handleUVBounds(suv);
        float w = 1.0 - abs(ofs) * 1.4;
        acc += texture2D(tDiffuse, suv) * w;
        total += w;
    }
    return acc / max(total, 0.0001);
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, 0.5);

    float openPhase = kf(p, 0.0, 0.15, 0.0, 1.0);
    float spiralPhase = kf(p, 0.125, 0.55, 0.0, 1.0);
    float suckPhase = kf(p, 0.45, 0.55, 0.0, 1.0);
    float collapsePhase = kf(p, 0.6, 0.8, 0.0, 1.0);
    float blackPhase = kf(p, 0.75, 1.0, 0.0, 1.0);

    vec2 q = vUv - center;
    vec2 n = q;
    if (ratio > 1.0) n.y /= ratio; else n.x *= ratio;

    float r = length(n);
    float a = atan(n.y, n.x);

    float pull = pullStrength * (0.65 * spiralPhase + 1.5 * suckPhase);
    float spin = spinStrength * (5.0 * spiralPhase + 18.0 * suckPhase) * (1.0 - smoothstep(0.0, 0.9, r));

    float nr = max(0.0, r - pull * (1.0 - r) * 0.22 - suckPhase * (1.0 - r) * (1.0 - r) * 0.55);
    float na = a + spin;

    vec2 n2 = vec2(cos(na), sin(na)) * nr;
    vec2 q2 = n2;
    if (ratio > 1.0) q2.y *= ratio; else q2.x /= ratio;
    vec2 uv = center + q2;

    float borderMask = getHardBoundaryMask(vUv);
    vec4 warped = texture2D(tDiffuse, handleUVBounds(uv));

    float spinBlurAmt = envSpinBlur(p) * (0.2 + 1.8 * suckPhase);
    vec4 blurred = sampleSpinBlur(handleUVBounds(uv), center, spinBlurAmt, pull);
    vec4 col = mix(warped, blurred, clamp(spinBlurAmt, 0.0, 1.0));

    float holeR = coreSize * (openPhase * (1.0 - collapsePhase));
    float core = 1.0 - smoothstep(holeR, holeR + 0.02, r);
    float ring = exp(-abs(r - (holeR + 0.035)) * 55.0) * (0.3 + 0.7 * spiralPhase);

    float colorama = envColorama(p);
    vec3 purple = vec3(0.55, 0.15, 0.95);
    col.rgb = mix(col.rgb, col.rgb * (0.65 + purple * 0.9), colorama * 0.65);

    float glow = envGlow(p);
    col.rgb += purple * ring * glow * 0.8;

    float exposure = envExposure(p);
    col.rgb *= (1.0 + 0.55 * exposure);

    float vignette = envVignette(p);
    float v = smoothstep(0.2, 0.95, length(vUv - center));
    col.rgb *= (1.0 - vignette * v * 0.92);

    col.rgb *= (1.0 - core);

    float vanish = max(kf(p, 0.5, 0.62, 0.0, 1.0), blackPhase);
    col.rgb = mix(col.rgb, vec3(0.0), blackPhase);
    float alpha = texel.a * (1.0 - vanish) * borderMask;

    return vec4(clamp(col.rgb, 0.0, 1.0), clamp(alpha, 0.0, 1.0));
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