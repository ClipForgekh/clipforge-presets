exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float uBrightness; // = 1.0 [0.0, 2.0]
uniform float uTwirlMax; // = 0.16 [0.0, 1.0]
uniform float uBokehMax; // = 0.18 [0.0, 1.0]
uniform float uSpiralTightness; // = 2.4 [0.5, 6.0]
uniform float uRingStart; // = 0.38 [0.0, 1.0]
uniform int uSectionCount; // = 12 [1, 24]

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 q = uv - center;
    if (ratio > 1.0) q.x *= ratio;
    else q.y /= ratio;
    return q;
}

vec4 sampleHexBlur(vec2 uv, float amount) {
    vec2 d0 = vec2(1.0, 0.0) * amount;
    vec2 d1 = vec2(0.5, 0.8660254) * amount;
    vec2 d2 = vec2(-0.5, 0.8660254) * amount;
    vec2 d3 = vec2(-1.0, 0.0) * amount;
    vec2 d4 = vec2(-0.5, -0.8660254) * amount;
    vec2 d5 = vec2(0.5, -0.8660254) * amount;

    vec4 c = texture2D(tDiffuse, handleUVBounds(uv)) * 0.4;
    c += texture2D(tDiffuse, handleUVBounds(uv + d0)) * 0.1;
    c += texture2D(tDiffuse, handleUVBounds(uv + d1)) * 0.1;
    c += texture2D(tDiffuse, handleUVBounds(uv + d2)) * 0.1;
    c += texture2D(tDiffuse, handleUVBounds(uv + d3)) * 0.1;
    c += texture2D(tDiffuse, handleUVBounds(uv + d4)) * 0.1;
    c += texture2D(tDiffuse, handleUVBounds(uv + d5)) * 0.1;
    return c;
}

vec4 effect(vec4 texel, float p) {
    const float PI = 3.14159265;
    const float TAU = 6.2831853;

    vec2 center = vec2(0.5, 0.5);
    vec2 q = getSDFCoordinate(vUv, center);
    float r = length(q);
    float a = atan(q.y, q.x);

    float cyc = sin(PI * p);
    float envelope = cyc * cyc;
    float sections = float(uSectionCount);

    float spiral = (a + log(max(r, 0.001)) * uSpiralTightness) / TAU;
    float phase = spiral * sections - p * sections;
    float band = fract(phase);
    float bandMask = smoothstep(0.08, 0.25, band) * (1.0 - smoothstep(0.75, 0.92, band));

    float curl = 0.18 * sin(TAU * p + a) * bandMask;
    vec2 dir = (r > 0.0001) ? (q / r) : vec2(1.0, 0.0);

    float twirl = uTwirlMax * envelope * bandMask * (1.0 - smoothstep(0.0, 0.95, r));
    float ang = twirl * (0.6 + 0.4 * sin(TAU * p + a * 2.0));
    float s = sin(ang);
    float c = cos(ang);

    vec2 uq = q;
    uq += dir * curl * 0.03;
    uq = vec2(c * uq.x - s * uq.y, s * uq.x + c * uq.y);

    vec2 uv2 = center;
    if (ratio > 1.0) uv2 += vec2(uq.x / ratio, uq.y);
    else uv2 += vec2(uq.x, uq.y * ratio);
    uv2 = handleUVBounds(uv2);

    vec4 baseCol = texture2D(tDiffuse, uv2);

    float outer = smoothstep(uRingStart, uRingStart + 0.12, r);
    float bokehAmt = uBokehMax * envelope * outer * bandMask * 0.03;
    vec4 blurCol = sampleHexBlur(uv2, bokehAmt);
    vec4 col = mix(baseCol, blurCol, clamp(outer * envelope, 0.0, 1.0));

    float sid = floor(mod(floor(phase) + sections, sections));
    float secBright = 0.7 + 0.02 * (sid + 1.0);
    float localBright = mix(1.0, secBright, bandMask * smoothstep(0.15, 1.2, r));
    col.rgb *= localBright * uBrightness;
    col.rgb = clamp(col.rgb, 0.0, 1.0);

    return vec4(col.rgb, texel.a);
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