exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float glitchAmount; // = 1.0 [0.0, 2.0]
uniform float radialBlurMax; // = 0.035 [0.0, 0.12]
uniform float decodeContrast; // = 1.15 [0.5, 2.0]

varying vec2 vUv;

float saturate01(float x) {
    return clamp(x, 0.0, 1.0);
}

float cubicInOut(float t) {
    t = saturate01(t);
    return t < 0.5 ? 4.0 * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 3.0) * 0.5;
}

float quintOut(float t) {
    t = saturate01(t);
    return 1.0 - pow(1.0 - t, 5.0);
}

float tween(float p) {
    return saturate01(p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec4 radialZoomBlur(sampler2D tex, vec2 uv, float amount) {
    vec2 c = vec2(0.5);
    vec2 d = uv - c;
    vec4 col = vec4(0.0);
    float w = 0.0;
    for (int i = 0; i < 6; i++) {
        float t = float(i) / 5.0;
        float k = (t - 0.5) * 2.0;
        vec2 suv = handleUVBounds(uv + d * k * amount);
        float ww = 1.0 - abs(k);
        col += texture2D(tex, suv) * ww;
        w += ww;
    }
    return col / max(w, 0.0001);
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.1) {
        return vec4(0.0);
    }

    float revealT = saturate01((p - 0.1) / 0.7);
    float revealE = cubicInOut(revealT);

    float burst = smoothstep(0.425, 0.52, p) * (1.0 - smoothstep(0.55, 0.62, p));
    float radius = mix(0.015, getMaxShapeSize() * 0.55, revealE) + burst * 0.35;

    float dist = length(getSDFCoordinate(vUv, vec2(0.5)));
    float revealMask = 1.0 - smoothstep(radius - 0.012, radius + 0.012, dist);

    float negMix = 0.0;
    negMix += 0.8 * saturate01((p - 0.1) / 0.15);
    negMix += 0.2 * saturate01((p - 0.25) / 0.175);
    negMix -= 0.75 * saturate01((p - 0.55) / 0.125);
    negMix -= 0.25 * saturate01((p - 0.8) / 0.2);
    negMix = saturate01(negMix);

    float glitchMix = 0.0;
    glitchMix += 0.25 * saturate01((p - 0.1) / 0.15);
    glitchMix += 0.75 * saturate01((p - 0.25) / 0.175);
    glitchMix -= 0.6 * saturate01((p - 0.55) / 0.125);
    glitchMix -= 0.4 * saturate01((p - 0.8) / 0.2);
    glitchMix = saturate01(glitchMix);

    float radialMix = smoothstep(0.425, 0.55, p) * (1.0 - smoothstep(0.675, 0.8, p));

    float settle = quintOut(saturate01((p - 0.8) / 0.2));
    negMix *= (1.0 - settle);
    glitchMix *= (1.0 - settle);
    radialMix *= (1.0 - settle);

    float lineId = floor(vUv.y * 320.0);
    float jump = (hash21(vec2(lineId, floor(p * 140.0))) - 0.5);
    float wave = sin(vUv.y * 420.0 + p * 80.0) * 0.5 + 0.5;
    float xOffset = glitchAmount * glitchMix * (jump * 0.02 + (wave - 0.5) * 0.006);

    vec2 uv = vUv + vec2(xOffset, 0.0);
    float borderMask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);

    vec4 src = texture2D(tDiffuse, uv);
    vec4 blurCol = radialZoomBlur(tDiffuse, uv, radialBlurMax * radialMix);
    vec3 base = mix(src.rgb, blurCol.rgb, radialMix);

    vec3 negative = vec3(1.0) - base;
    negative = clamp((negative - 0.5) * decodeContrast + 0.5, 0.0, 1.0);

    float impulse = step(0.93, hash21(vec2(lineId * 1.37, floor(p * 180.0))));
    float noise = (hash21(vUv * vec2(800.0, 460.0) + p * 37.0) - 0.5) * 0.18 * glitchMix;
    vec3 glitchRGB = vec3(noise + impulse * 0.28 * glitchMix);

    vec3 decoded = mix(base, negative, negMix);
    decoded += glitchRGB;
    decoded = clamp(decoded, 0.0, 1.0);

    float mask = revealMask * borderMask;
    return vec4(decoded * mask, texel.a * mask);
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