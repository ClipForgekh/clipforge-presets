exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float rippleStrength; // = 0.18 [0.05, 0.4] // 最大环形推挤强度
uniform float ringRadius; // = 0.38 [0.2, 0.6] // 环形中心半径
uniform float ringWidth; // = 0.28 [0.1, 0.5] // 环形厚度控制
uniform float ringSharpness; // = 1.4 [0.5, 3.0] // 环形边缘锐利度
uniform float shakeStrength; // = 0.06 [0.01, 0.2] // 水平抖动强度

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float progress) {
    float strength = 1.0 - progress;
    vec2 center = vec2(0.5);
    vec2 p = getSDFCoordinate(vUv, center);
    float dist = length(p);
    vec2 direction = dist > 0.0 ? p / dist : vec2(0.0);

    float normalizedDelta = (dist - ringRadius) / max(ringWidth, 0.0001);
    float ringEnvelope = exp(-normalizedDelta * normalizedDelta * ringSharpness);
    float outwardPush = strength * rippleStrength * (0.45 + 1.55 * ringEnvelope);

    vec2 displacedP = p + direction * outwardPush;

    vec2 aspectAdjusted = displacedP;
    if (ratio > 1.0) aspectAdjusted.y *= ratio;
    else aspectAdjusted.x /= ratio;

    vec2 uv = aspectAdjusted + center;

    float primaryPhase = progress * 90.0 + 1.57079633;
    float secondaryPhase = progress * 150.0 + 0.78539816;
    float shakeWave = sin(primaryPhase) + 0.5 * sin(secondaryPhase);
    float horizontalShake = shakeWave * shakeStrength * strength;

    uv.x += horizontalShake;
    uv = handleUVBounds(uv);

    vec4 sampled = texture2D(tDiffuse, uv);
    return sampled;
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