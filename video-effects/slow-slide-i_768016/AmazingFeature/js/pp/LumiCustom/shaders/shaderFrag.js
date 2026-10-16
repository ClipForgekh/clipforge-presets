exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float swipeDistance; // = 0.55 [0.2, 1.0] // 初始水平位移距离（相对屏幕长边）
uniform float blurAmount; // = 0.05 [0.0, 0.2] // 最大运动模糊采样间距
uniform float minOpacity; // = 0.25 [0.0, 1.0] // 起始最低不透明度

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    return p * p * (3.0 - 2.0 * p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float getLongSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction * ratio;
    else return fraction;
}

vec4 effect(vec4 texel, float progress) {
    float eased = clamp(progress, 0.0, 1.0);
    float motion = 1.0 - eased;
    float offset = -getLongSideRelativeSize(swipeDistance) * motion;

    vec2 shiftedUV = vUv + vec2(offset, 0.0);
    float borderMask = getHardBoundaryMask(shiftedUV);
    vec2 sampledUV = handleUVBounds(shiftedUV);
    vec4 baseColor = texture2D(tDiffuse, sampledUV);

    float velocity = 6.0 * eased * (1.0 - eased);
    float dynamicBlur = blurAmount * (0.5 * motion + velocity);

    vec4 accum = vec4(0.0);
    float totalWeight = 0.0;
    for (int i = -2; i <= 2; i++) {
        float fi = float(i);
        float weight = 1.0 - abs(fi) * 0.2;
        vec2 blurOffset = vec2(fi * dynamicBlur, 0.0);
        vec2 blurUV = handleUVBounds(shiftedUV + blurOffset);
        vec4 sampleColor = texture2D(tDiffuse, blurUV);
        accum += sampleColor * weight;
        totalWeight += weight;
    }
    vec4 blurColor = accum / max(totalWeight, 0.0001);

    vec4 mixedColor = mix(blurColor, baseColor, eased);
    float opacityFactor = mix(minOpacity, 1.0, eased);
    mixedColor.a *= opacityFactor;
    mixedColor *= borderMask;

    return mixedColor;
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