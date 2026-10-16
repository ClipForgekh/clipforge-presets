exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float spiralTurns; // = 5.0 [2.0, 12.0]
uniform float ribbonWidth; // = 0.018 [0.004, 0.06]
uniform float glowStrength; // = 1.2 [0.0, 3.0]
uniform float motionBlur; // = 0.35 [0.0, 1.0]
uniform vec3 goldColor; // = vec3(1.0, 0.82, 0.32)

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
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
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

vec4 effect(vec4 texel, float p) {
    float t = clamp(p, 0.0, 1.0);
    float strength = 1.0 - t;

    vec2 center = vec2(0.5, 0.5);
    vec2 coord = getSDFCoordinate(vUv, center);
    float r = length(coord);
    float theta = atan(coord.y, coord.x);
    float u = (theta + 3.14159265) / 6.2831853;

    float maxR = getMaxShapeSize() * 0.5;
    float headR = mix(0.006, maxR, t);

    float revealSoft = 0.012 + 0.02 * strength;
    float revealMask = 1.0 - smoothstep(headR - revealSoft, headR + revealSoft, r);

    float turns = max(spiralTurns, 0.001);
    float pitch = maxR / turns;
    float phase = t * (2.2 + motionBlur * 1.8);
    float spiralCoord = r / max(pitch, 0.0001) - (u + phase);
    float dTurn = abs(fract(spiralCoord) - 0.5) * pitch;

    float width = max(ribbonWidth * (0.85 + 0.25 * strength), 0.0008);
    float body = exp(-pow(dTurn / width, 2.0));

    float headGate = 1.0 - smoothstep(headR - (0.18 + motionBlur * 0.08), headR + 0.02, r);
    body *= headGate;

    float twist = sin(theta * 8.0 + r * 36.0 - t * 22.0);
    float metallic = 0.55 + 0.45 * pow(clamp(0.5 + 0.5 * twist, 0.0, 1.0), 10.0);

    float glow = exp(-dTurn / (width * 2.8)) * headGate;
    float headBlur = exp(-pow((r - headR) / (0.03 + motionBlur * 0.12), 2.0));
    glow += headBlur * 0.35;

    body *= strength;
    glow *= glowStrength * strength;

    vec3 ribbonCol = goldColor * metallic * (body * 1.2 + glow * 0.45);
    vec3 baseCol = texel.rgb * revealMask;
    vec3 finalRgb = clamp(baseCol + ribbonCol, 0.0, 1.0);

    float alphaMask = max(revealMask, clamp((body + glow) * 0.9, 0.0, 1.0));
    float finalA = texel.a * alphaMask;

    return vec4(finalRgb, finalA);
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