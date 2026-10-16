exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float motionBlur; // = 0.6 [0.0, 1.5]
uniform float pathCurvature; // = 0.35 [0.0, 1.0]

varying vec2 vUv;

float tween(float p) {
    return p;
}

float circularOut(float t) {
    t = clamp(t, 0.0, 1.0);
    float k = t - 1.0;
    return sqrt(max(0.0, 1.0 - k * k));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 rotate2D(vec2 p, float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c) * p;
}

vec2 bezier2(vec2 a, vec2 b, vec2 c, float t) {
    float u = 1.0 - t;
    return u * u * a + 2.0 * u * t * b + t * t * c;
}

vec4 sampleImage(vec2 uv, vec2 offset, float angleDeg, float scale) {
    float ang = radians(angleDeg);
    vec2 p = uv - 0.5 - offset;
    if (ratio > 1.0) p.x *= ratio; else p.y /= ratio;
    p = rotate2D(p, -ang);
    p /= max(scale, 0.0001);
    if (ratio > 1.0) p.x /= ratio; else p.y *= ratio;
    vec2 src = p + 0.5;
    float mask = getHardBoundaryMask(src);
    src = handleUVBounds(src);
    vec4 col = texture2D(tDiffuse, src);
    col.a *= mask;
    return col;
}

vec4 softSpinBlur(vec2 uv, vec2 offset, float angleDeg, float scale, float blurAmount) {
    vec4 acc = vec4(0.0);
    float wsum = 0.0;
    for (int i = -2; i <= 2; i++) {
        float fi = float(i) / 2.0;
        float w = 1.0 - abs(fi) * 0.22;
        float a = angleDeg + fi * 14.0 * blurAmount;
        float s = scale * (1.0 + abs(fi) * 0.015 * blurAmount);
        acc += sampleImage(uv, offset, a, s) * w;
        wsum += w;
    }
    return acc / max(wsum, 0.0001);
}

vec4 effect(vec4 texel, float p) {
    float tMoveStart = 0.05;
    float tMoveEnd = 0.75;

    vec2 startPos = vec2(-1.2, 0.0);
    vec2 endPos = vec2(0.0, 0.0);
    vec2 ctrlPos = vec2(-0.55, pathCurvature);

    float angle = -120.0;
    float scale = 0.7;
    vec2 pos = startPos;
    float blurAmt = 0.0;

    if (p < tMoveStart) {
        pos = startPos;
        angle = -120.0;
        scale = 0.7;
        blurAmt = motionBlur;
    } else if (p < tMoveEnd) {
        float t = circularOut((p - tMoveStart) / (tMoveEnd - tMoveStart));
        pos = bezier2(startPos, ctrlPos, endPos, t);
        angle = mix(-120.0, 0.0, t);
        scale = mix(0.7, 1.0, t);
        blurAmt = motionBlur * (1.0 - t);
    } else {
        float t = circularOut((p - tMoveEnd) / (1.0 - tMoveEnd));
        float damp = (1.0 - t);
        pos = endPos + vec2(0.015, -0.01) * damp * damp;
        angle = 4.0 * damp * damp;
        scale = 1.0 + 0.02 * damp * damp;
        blurAmt = motionBlur * 0.25 * damp;
    }

    vec4 col = softSpinBlur(vUv, pos, angle, scale, blurAmt);
    return col;
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