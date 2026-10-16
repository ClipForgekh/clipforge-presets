exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float minHeight; // = 0.2 [0.05, 0.5] // 首阶段的目标高度比例
uniform float edgeFeather; // = 0.01 [0.0, 0.05] // 垂直边缘柔化宽度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float invertTween(float easedProgress) {
    return 1.0 - pow(max(1.0 - easedProgress, 0.0), 0.33333334);
}

vec4 effect(vec4 texel, float progress) {
    float rawProgress = invertTween(progress);
    float stageSplit = 0.25;
    float stage1Progress = clamp(rawProgress / stageSplit, 0.0, 1.0);
    float stage2Progress = clamp((rawProgress - stageSplit) / (1.0 - stageSplit), 0.0, 1.0);

    float stage1Ease = smoothstep(0.0, 1.0, stage1Progress);
    float stage2Ease = stage2Progress > 0.0 ? (1.0 - pow(1.0 - stage2Progress, 3.0)) : 0.0;

    float targetHeight;
    float visibility;
    if (rawProgress < stageSplit) {
        targetHeight = max(minHeight * stage1Ease, 0.0001);
        visibility = stage1Ease;
    } else {
        targetHeight = mix(minHeight, 1.0, stage2Ease);
        visibility = 1.0;
    }
    targetHeight = clamp(targetHeight, 0.0001, 1.0);

    float halfHeight = targetHeight * 0.5;
    float lower = 0.5 - halfHeight;
    float upper = 0.5 + halfHeight;

    float normalizedY = (vUv.y - lower) / max(targetHeight, 0.0001);
    vec2 sampleUV = handleUVBounds(vec2(vUv.x, normalizedY));
    vec4 scaledTexel = texture2D(tDiffuse, sampleUV);

    float bandMask;
    if (targetHeight < 0.999) {
        float feather = max(min(edgeFeather, targetHeight * 0.5), 0.00001);
        float bottom = smoothstep(lower - feather, lower + feather, vUv.y);
        float top = 1.0 - smoothstep(upper - feather, upper + feather, vUv.y);
        bandMask = bottom * top;
    } else {
        bandMask = 1.0;
    }

    float borderMask = getHardBoundaryMask(vUv);
    float finalMask = bandMask * visibility * borderMask;

    vec3 color = scaledTexel.rgb;
    float alpha = scaledTexel.a * finalMask;

    return vec4(color, alpha);
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