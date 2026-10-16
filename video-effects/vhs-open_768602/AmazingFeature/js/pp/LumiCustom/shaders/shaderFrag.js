exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float rippleCount; // = 10.0 [3.0, 20.0]
uniform float distortStrength; // = 0.02 [0.0, 0.08]
uniform float aberration; // = 0.003 [0.0, 0.02]
uniform float lineSoftness; // = 0.015 [0.001, 0.08]
uniform float mergePoint; // = 0.62 [0.3, 0.9]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float centerDist = abs(vUv.y - 0.5);
    float maxDist = 0.5;
    float dn = centerDist / maxDist;

    float front = smoothstep(0.0, mergePoint, p) * maxDist * 1.05;

    float freq = mix(rippleCount * 2.2, rippleCount * 0.9, dn);
    float speed = mix(48.0, 14.0, dn);
    float phase = (front - centerDist) * freq * 6.2831853 - p * speed;

    float trail = exp(-max(front - centerDist, 0.0) * 7.0);
    float damping = 1.0 - smoothstep(mergePoint, 1.0, p);
    float ripple = sin(phase) * trail * damping;

    float revealEdge = front + ripple * 0.028;
    float revealMask = smoothstep(-lineSoftness, lineSoftness, revealEdge - centerDist);

    float pulseLife = 1.0 - smoothstep(0.0, 0.08, p);
    float pulse = pulseLife * exp(-centerDist * 260.0);
    revealMask = max(revealMask, pulse);

    float fullFrame = smoothstep(mergePoint - 0.06, mergePoint + 0.04, p);
    revealMask = max(revealMask, fullFrame);

    float boundary = exp(-abs(centerDist - front) / (lineSoftness * 2.8));

    float vhsJitter = sin(vUv.x * 140.0 + p * 65.0) * 0.5 + 0.5;
    float yOffset = ripple * distortStrength * boundary * (0.65 + 0.35 * vhsJitter);
    vec2 uv = handleUVBounds(vUv + vec2(0.0, yOffset));

    float ca = aberration * boundary * damping;
    vec3 col;
    col.r = texture2D(tDiffuse, handleUVBounds(uv + vec2(ca, 0.0))).r;
    col.g = texture2D(tDiffuse, uv).g;
    col.b = texture2D(tDiffuse, handleUVBounds(uv - vec2(ca, 0.0))).b;

    return vec4(col, texel.a * revealMask);
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