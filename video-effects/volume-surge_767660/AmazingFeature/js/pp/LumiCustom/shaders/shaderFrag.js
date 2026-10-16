exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float stripCount; // = 50.0 [10.0, 100.0] // 垂直条带数量
uniform float stripDelayRange; // = 0.35 [0.0, 0.8] // 条带下落随机延迟占比
uniform float fallOvershoot; // = 0.25 [0.0, 0.6] // 条带下落超出屏幕的比例

varying vec2 vUv;

float tween(float p) {
    if (p < 0.5) {
        float t = 2.0 * p;
        return 0.5 * (1.0 - sqrt(max(0.0, 1.0 - t * t)));
    } else {
        float t = -2.0 * p + 2.0;
        return 0.5 * (sqrt(max(0.0, 1.0 - t * t)) + 1.0);
    }
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash11(float p) {
    return fract(sin(p * 127.1) * 43758.5453123);
}

vec4 effect(vec4 texel, float easedProgress) {
    float blankThreshold = tween(0.05);
    float fillThreshold = tween(0.95);

    if (easedProgress <= blankThreshold) {
        return vec4(0.0);
    }

    if (easedProgress >= fillThreshold) {
        return texel;
    }

    float stageProgress = (easedProgress - blankThreshold) / max(fillThreshold - blankThreshold, 0.0001);
    stageProgress = clamp(stageProgress, 0.0, 1.0);

    float clampedX = min(vUv.x, 0.999999);
    float stripIndex = floor(clampedX * stripCount);
    float baseSeed = hash11(stripIndex + 0.5);

    float delay = baseSeed * stripDelayRange;
    float localProgress = clamp((stageProgress - delay) / max(1.0 - delay, 0.0001), 0.0, 1.0);

    float speedVariance = mix(0.85, 1.2, hash11(baseSeed * 91.7 + 3.1));
    float drop = (1.0 - localProgress) * (1.0 + fallOvershoot) * speedVariance;

    float wavePhase = hash11(baseSeed * 37.0 + 7.0) * 6.2831853;
    float wave = (1.0 - localProgress) * 0.015 * sin(vUv.y * 60.0 + wavePhase + stageProgress * 4.0);

    vec2 rawUV = vec2(vUv.x + wave, vUv.y + drop);
    vec2 sampleUV = handleUVBounds(rawUV);
    vec4 stripColor = texture2D(tDiffuse, sampleUV);

    float feather = 0.05;
    float topMask = 1.0 - smoothstep(1.0, 1.0 + feather, rawUV.y);
    float bottomMask = smoothstep(-feather, 0.0, rawUV.y);
    float appearMask = smoothstep(0.02, 0.12, localProgress);
    float visibility = topMask * bottomMask * appearMask;

    return stripColor * visibility;
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