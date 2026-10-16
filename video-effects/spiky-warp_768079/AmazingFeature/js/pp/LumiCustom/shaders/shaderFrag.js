exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] 
uniform float ratio; // = 1.0 [0.1, 2]
uniform float twistStrength; // = 0.42 [0.0, 1.2]
uniform float tubeDepth; // = 0.18 [0.0, 0.5]
uniform float coreBulgeStrength; // = 0.10 [0.0, 0.4]
uniform float vignetteStrength; // = 0.12 [0.0, 0.4]

varying vec2 vUv;

float tween(float p) {
    return smoothstep(0.0, 1.0, p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float segmentPulse(float a, float b, float p) {
    return smoothstep(a, b, p);
}

vec4 effect(vec4 texel, float p) {
    const float T = 3.1;
    const float t0 = 0.24 / T;
    const float t1 = 1.30 / T;
    const float t2 = 2.32 / T;
    const float t3 = 2.92 / T;

    const float v0 = 0.40 / T;
    const float v1 = 1.30 / T;
    const float v2 = 2.20 / T;

    const float b0 = 0.56 / T;
    const float b1 = 0.90 / T;
    const float b2 = 1.50 / T;
    const float b3 = 2.00 / T;

    float buildIn = segmentPulse(t0, t1, p);
    float holdMid = segmentPulse(t1, t2, p);
    float returnOut = 1.0 - segmentPulse(t2, t3, p);
    float mortiseEnvelope = clamp((buildIn * returnOut) + (holdMid * returnOut), 0.0, 1.0);

    vec2 c = vUv - 0.5;
    vec2 ca = vec2(c.x * ratio, c.y);
    float r = length(ca) + 1e-6;
    float ang = atan(ca.y, ca.x);

    float facets = sin(ang * 11.0 + p * 6.2831853 * 0.55);
    float facetMask = (1.0 - smoothstep(0.22, 1.0, r));

    float theta = twistStrength * mortiseEnvelope * facets * facetMask;
    float s = sin(theta);
    float co = cos(theta);
    vec2 rc = vec2(co * c.x - s * c.y, s * c.x + co * c.y);

    float radialTube = tubeDepth * mortiseEnvelope * (0.35 + 0.65 * facetMask);
    float scale = 1.0 + radialTube * (0.35 + 0.65 * facets);
    vec2 uv = 0.5 + rc * scale;

    float coreRise = smoothstep(b0, b1, p);
    float coreFall = 1.0 - smoothstep(b2, b3, p);
    float coreEnv = min(coreRise, coreFall);
    float coreMask = exp(-r * r * 18.0);
    float coreBulge = coreBulgeStrength * coreEnv * coreMask;
    uv = 0.5 + (uv - 0.5) * (1.0 - coreBulge);

    uv = handleUVBounds(uv);
    vec4 col = texture2D(tDiffuse, uv);

    float vigRise = smoothstep(v0, v1, p);
    float vigFall = 1.0 - smoothstep(v1, v2, p);
    float vigEnv = vigRise * vigFall * 4.0;
    float edge = smoothstep(0.38, 1.08, r);
    float vig = vignetteStrength * vigEnv * edge;
    col.rgb *= (1.0 - vig);

    return vec4(clamp(col.rgb, 0.0, 1.0), col.a);
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