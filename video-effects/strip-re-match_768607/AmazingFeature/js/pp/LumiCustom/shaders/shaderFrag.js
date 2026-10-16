exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float cardSplit; // = 0.085 [0.0, 0.2] // 双主卡分离强度
uniform float stripTravel; // = 0.22 [0.0, 0.4] // 织帘条Y向位移强度
uniform float weaveAmount; // = 0.06 [0.0, 0.15] // 织帘条X向穿梭强度
uniform float blurAmount; // = 0.004 [0.0, 0.02] // 竖向拖影强度
uniform float warpAmount; // = 0.16 [0.0, 0.4] // 条片边缘液化扰动强度

varying vec2 vUv;

float tween(float p) {
    return 3.0 * p * p - 2.0 * p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float sineInOut(float p) {
    return 0.5 - 0.5 * cos(3.14159265 * clamp(p, 0.0, 1.0));
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = vUv;

    const float stripCount = 12.0;
    float stripId = floor(clamp(vUv.x, 0.0, 0.999999) * stripCount);
    float parity = mod(stripId, 2.0); // 0 even, 1 odd
    float oddSign = mix(1.0, -1.0, parity); // 偶数上卷(+), 奇数下坠(-)

    float apart = smoothstep(0.10, 0.316, p) * (1.0 - smoothstep(0.716, 0.933, p));
    float depthScale = 1.0 - apart * 0.18;
    uv = 0.5 + (uv - 0.5) * depthScale;

    float side = sign(vUv.x - 0.5);
    if (side == 0.0) side = 1.0;
    uv.x += side * apart * cardSplit;

    float stagger = stripId * (0.035 / 3.0);
    float dropP = clamp((p - (0.15 + stagger)) / (0.516 - 0.15), 0.0, 1.0);
    float expOut = 1.0 - exp2(-10.0 * dropP);
    float returnFade = 1.0 - smoothstep(0.716, 0.933, p);
    float yShift = oddSign * expOut * stripTravel * returnFade;

    float weaveP = sineInOut((p - 0.516) / (0.716 - 0.516));
    float xShift = mix(-1.0, 1.0, parity) * weaveP * weaveAmount * returnFade;

    uv += vec2(xShift, yShift);

    float localX = fract(vUv.x * stripCount);
    float edge = 1.0 - smoothstep(0.25, 0.5, abs(localX - 0.5) * 2.0);
    float warpEnv = smoothstep(0.266, 0.35, p) * (1.0 - smoothstep(0.716, 0.933, p));
    float n = sin((uv.y * 38.0 + stripId * 1.31) + p * 17.0) * sin((uv.x * 24.0 - p * 11.0));
    uv.x += n * 0.008 * warpAmount * warpEnv * edge;

    vec2 suv = handleUVBounds(uv);
    vec4 baseColor = texture2D(tDiffuse, suv);

    float blurUp = clamp((p - 0.15) / 0.20, 0.0, 1.0);
    float blurDown = clamp((0.533 - p) / 0.183, 0.0, 1.0);
    float blurEnv = blurUp * blurDown;
    float motionMask = min(1.0, abs(yShift) / max(stripTravel, 0.0001));
    float blurK = blurEnv * motionMask;

    vec2 off = vec2(0.0, blurAmount / max(ratio, 0.0001));
    vec4 b0 = texture2D(tDiffuse, handleUVBounds(suv - off));
    vec4 b1 = baseColor;
    vec4 b2 = texture2D(tDiffuse, handleUVBounds(suv + off));
    vec4 streak = (b0 + 2.0 * b1 + b2) * 0.25;

    vec4 col = mix(baseColor, streak, blurK * 0.4);
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