exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float shakeStrength; // = 0.12 [0.02, 0.3] // 最大水平抖动幅度
uniform float shakeCycles; // = 12.0 [3.0, 24.0] // 抖动完整往返次数
uniform float echoSpread; // = 3.0 [1.0, 6.0] // 彩色回声间距倍率

varying vec2 vUv;

float tween(float p) {
    return clamp(p, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float intensity = 1.0 - p;
    float oscillation = sin(p * shakeCycles * 6.28318530718);
    float primaryOffset = oscillation * shakeStrength * intensity;

    vec2 uvMain = handleUVBounds(vUv + vec2(primaryOffset, 0.0));
    vec4 mainSample = texture2D(tDiffuse, uvMain);

    float baseSpread = shakeStrength * echoSpread * intensity;

    float offset1 = baseSpread * 0.9;
    float offset2 = baseSpread * 1.6;
    float offset3 = baseSpread * 2.4;

    vec2 uvR = handleUVBounds(vUv + vec2(primaryOffset + offset1, 0.0));
    vec2 uvG = handleUVBounds(vUv + vec2(primaryOffset - offset2, 0.0));
    vec2 uvB = handleUVBounds(vUv + vec2(primaryOffset + offset3, 0.0));

    vec3 echoR = texture2D(tDiffuse, uvR).rgb * vec3(1.0, 0.25, 0.25);
    vec3 echoG = texture2D(tDiffuse, uvG).rgb * vec3(0.25, 1.0, 0.25);
    vec3 echoB = texture2D(tDiffuse, uvB).rgb * vec3(0.25, 0.25, 1.0);

    float echoWeight = 0.5 * intensity;

    vec3 color = mainSample.rgb;
    color += (echoR + echoG + echoB) * echoWeight;

    return vec4(color, texel.a);
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