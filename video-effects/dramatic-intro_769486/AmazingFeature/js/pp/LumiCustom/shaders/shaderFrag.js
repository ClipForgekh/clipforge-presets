exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float edgeSoftness; // = 0.003 [0.0001, 0.02]

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

float easeOutCubic(float x) {
    float t = 1.0 - x;
    return 1.0 - t * t * t;
}

float easeInOutCubic(float x) {
    return x < 0.5 ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) * 0.5;
}

vec4 effect(vec4 texel, float progress) {
    const float p1End = 0.225;
    const float p2End = 0.75;

    float front01 = 0.0;
    float halfWidth = 0.0;

    float w1 = 0.035;
    float w2 = 0.30;
    float w3 = 0.72;

    if (progress <= p1End) {
        float t = clamp(progress / p1End, 0.0, 1.0);
        float e = easeOutCubic(t);
        front01 = e;
        halfWidth = w1 * e;
    } else if (progress <= p2End) {
        float t = clamp((progress - p1End) / (p2End - p1End), 0.0, 1.0);
        float e = easeInOutCubic(t);
        front01 = 1.0;
        halfWidth = mix(w1, w2, e);
    } else {
        float t = clamp((progress - p2End) / (1.0 - p2End), 0.0, 1.0);
        float e = easeOutCubic(t);
        front01 = 1.0;
        halfWidth = mix(w2, w3, e);
    }

    vec2 centered = vUv - 0.5;
    vec2 dir = normalize(vec2(1.0, 1.0));
    vec2 nrm = normalize(vec2(1.0, -1.0));

    float axis = (dot(centered, dir) + 0.70710678) / 1.41421356;
    float perp = abs(dot(centered, nrm));

    float axisSoft = edgeSoftness;
    float widthSoft = edgeSoftness;

    float sweepMask = 1.0 - smoothstep(front01, front01 + axisSoft, axis);
    float slitMask = 1.0 - smoothstep(halfWidth, halfWidth + widthSoft, perp);

    float mask = sweepMask * slitMask;
    mask = max(mask, step(0.9999, progress));

    return vec4(texel.rgb, texel.a * mask);
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