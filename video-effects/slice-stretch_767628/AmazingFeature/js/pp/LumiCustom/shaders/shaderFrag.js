exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float weaveStrength; // = 0.75 [0.0, 1.5] // 经纬翻织强度
uniform float stripWidth; // = 0.18 [0.08, 0.35] // 斜织条宽度
uniform float slideAmount; // = 0.22 [0.0, 0.6] // 斜纬横向滑入距离

varying vec2 vUv;

float tween(float p) {
    return smoothstep(0.0, 1.0, p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float stripeMask(float coord, float width) {
    float f = abs(fract(coord) - 0.5);
    return 1.0 - smoothstep(width, width + 0.03, f);
}

float outInCubic(float p) {
    if (p < 0.5) {
        float x = p * 2.0;
        return 0.5 * (1.0 - pow(1.0 - x, 3.0));
    } else {
        float x = (p - 0.5) * 2.0;
        return 0.5 + 0.5 * x * x * x;
    }
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = vUv;
    vec2 centered = uv - 0.5;
    if (ratio > 1.0) centered.y /= ratio; else centered.x *= ratio;

    float env = sin(3.14159265 * p);
    float envSoft = env * env;

    float cA = (centered.x + centered.y) * 7.0 + 3.5;
    float cB = (centered.x - centered.y) * 7.0 + 3.5;

    float maskA = stripeMask(cA, stripWidth);
    float maskB = stripeMask(cB, stripWidth);

    float idxA = floor(clamp(cA, 0.0, 6.0));
    float idxB = floor(clamp(cB, 0.0, 6.0));

    float parityA = mod(idxA, 2.0) < 0.5 ? -1.0 : 1.0;
    float sideB = mod(idxB, 2.0) < 0.5 ? 1.0 : -1.0;

    float stagger = idxB * 0.045;
    float localP = clamp((p - stagger) / max(0.0001, 1.0 - stagger), 0.0, 1.0);
    float slideP = outInCubic(localP);

    float spring = sin(localP * 3.14159265) * (1.0 - localP) * 0.45;

    vec2 uvA = uv;
    uvA.x += parityA * (0.045 * weaveStrength * envSoft + 0.03 * spring * env) * maskA;
    uvA.y += (0.018 * weaveStrength * envSoft) * maskA;

    vec2 uvB = uv;
    uvB.x += sideB * (1.0 - slideP) * slideAmount * env * maskB;
    uvB.y -= 0.012 * envSoft * maskB;

    uvA = handleUVBounds(uvA);
    uvB = handleUVBounds(uvB);

    vec4 colA = texture2D(tDiffuse, uvA);
    vec4 colB = texture2D(tDiffuse, uvB);

    float weaveMix = clamp(maskB * (0.35 + 0.65 * envSoft), 0.0, 1.0);
    vec4 woven = mix(colA, colB, weaveMix);

    float depthPulse = 1.0 - 0.08 * envSoft + 0.06 * envSoft * maskB;
    woven.rgb *= depthPulse;

    float boundary = getHardBoundaryMask(vUv);
    vec4 outCol = vec4(clamp(woven.rgb, 0.0, 1.0), woven.a * boundary);

    return mix(texel, outCol, env);
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