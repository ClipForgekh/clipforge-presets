exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float startScale; // = 0.7 [0.5, 0.9] // 起始缩放比例
uniform float blurStrength; // = 6.0 [0.0, 20.0] // 最大模糊强度
uniform float overshootAmount; // = 0.02 [0.0, 0.1] // 超调比例

varying vec2 vUv;

float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 applyBlur(vec2 uv, float strength) {
    if (strength <= 0.0001) {
        return texture2D(tDiffuse, handleUVBounds(uv));
    }
    vec2 stepSize = vec2(0.0015 * strength, 0.0015 * strength / max(ratio, 0.0001));
    vec4 color = vec4(0.0);
    float totalWeight = 0.0;
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            float weight = 1.0;
            if (x == 0 && y == 0) weight = 4.0;
            else if (x == 0 || y == 0) weight = 2.0;
            vec2 offset = vec2(float(x) * stepSize.x, float(y) * stepSize.y);
            vec2 sampleUV = handleUVBounds(uv + offset);
            color += texture2D(tDiffuse, sampleUV) * weight;
            totalWeight += weight;
        }
    }
    return color / totalWeight;
}

vec4 effect(vec4 texel, float progress) {
    float eased = progress;
    float strength = 1.0 - eased;

    float scaleBase = mix(1.0, startScale, strength);
    float overshootStart = 0.85;
    float overshootMid = 0.97;
    float overshootPulse = smoothstep(overshootStart, overshootMid, eased) * (1.0 - smoothstep(overshootMid, 1.0, eased));
    float finalScale = scaleBase + overshootAmount * overshootPulse;

    vec2 centered = vUv - 0.5;
    vec2 scaled = centered * finalScale;
    vec2 sampleUV = handleUVBounds(scaled + 0.5);

    float currentBlur = strength * blurStrength;
    vec4 sampled = applyBlur(sampleUV, currentBlur);

    float opacity = eased;
    float borderMask = getHardBoundaryMask(scaled + 0.5);

    vec3 finalRGB = sampled.rgb * opacity * borderMask;
    float finalAlpha = sampled.a * opacity * borderMask;

    return vec4(finalRGB, finalAlpha);
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