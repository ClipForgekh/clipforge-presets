exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

// 自定义uniform
uniform float echoSpacing; // = 0.12 [0.05, 0.4] // 回声间距（按画面宽度比例）
uniform float echoOpacity; // = 0.55 [0.0, 1.0] // 回声不透明度
uniform float echoFalloff; // = 0.65 [0.2, 1.0] // 回声逐级衰减

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float getDisplacement(float p) {
    float totalDuration = 1.8;
    float t = clamp(p, 0.0, 1.0) * totalDuration;
    if (t < 0.45) {
        float local = t / 0.45;
        return mix(0.7, 0.5, local);
    } else if (t < 0.9) {
        float local = (t - 0.45) / 0.45;
        return mix(0.5, 0.3, local);
    } else if (t < 1.35) {
        float local = (t - 0.9) / 0.45;
        return mix(0.3, 0.15, local);
    } else {
        float local = (t - 1.35) / 0.45;
        return mix(0.15, 0.0, local);
    }
}

vec4 effect(vec4 texel, float progress) {
    float displacement = getDisplacement(progress);
    vec2 shift = vec2(displacement, 0.0);
    vec2 mainUVRaw = vUv + shift;
    vec2 mainUV = handleUVBounds(mainUVRaw);
    float mainMask = getHardBoundaryMask(mainUVRaw);
    vec4 mainSample = texture2D(tDiffuse, mainUV) * mainMask;

    vec3 accumulatedColor = mainSample.rgb;
    float accumulatedAlpha = mainSample.a;
    float strength = 1.0 - tween(progress);

    for (int i = 0; i < 3; i++) {
        float idx = float(i) + 1.0;
        float extraOffset = echoSpacing * strength * idx;
        vec2 echoUVRaw = vUv + vec2(displacement + extraOffset, 0.0);
        vec2 echoUV = handleUVBounds(echoUVRaw);
        float echoMask = getHardBoundaryMask(echoUVRaw);
        vec4 echoSample = texture2D(tDiffuse, echoUV) * echoMask;

        vec3 tint = vec3(0.0);
        if (i == 0) tint = vec3(1.0, 0.25, 0.25);
        else if (i == 1) tint = vec3(0.25, 1.0, 0.25);
        else tint = vec3(0.25, 0.25, 1.0);

        float fade = echoOpacity * strength * pow(echoFalloff, float(i));
        vec3 tintedEcho = echoSample.rgb * tint * fade;
        accumulatedColor += tintedEcho;
        float echoAlpha = echoSample.a * fade;
        accumulatedAlpha = clamp(accumulatedAlpha + echoAlpha * (1.0 - accumulatedAlpha), 0.0, 1.0);
    }

    accumulatedColor = clamp(accumulatedColor, 0.0, 1.0);
    return vec4(accumulatedColor, accumulatedAlpha);
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