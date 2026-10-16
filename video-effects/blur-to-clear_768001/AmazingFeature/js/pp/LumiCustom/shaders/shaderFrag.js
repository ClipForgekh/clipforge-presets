exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float minScale; // = 0.78 [0.5, 1.0] // 起始主体视觉比例
uniform float maxOvershoot; // = 1.03 [1.0, 1.1] // 超尺度峰值
uniform float blurMax; // = 8.0 [0.0, 15.0] // 最大柔化强度
uniform float depthParallax; // = 0.02 [0.0, 0.1] // 背景景深偏移幅度
uniform float baseOpacity; // = 0.25 [0.0, 0.8] // 起始主体不透明度

varying vec2 vUv;

float tween(float p) {
    return 3.0 * p * p - 2.0 * p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 gaussianBlur(sampler2D tex, vec2 uv, float amount, float ratio) {
    if (amount <= 0.0001) {
        return texture2D(tex, handleUVBounds(uv));
    }
    float spread = 0.0008 + amount * 0.0025;
    vec2 stepVec = vec2(spread, spread / max(ratio, 0.0001));
    vec4 sum = vec4(0.0);
    vec2 offsetX = vec2(stepVec.x, 0.0);
    vec2 offsetY = vec2(0.0, stepVec.y);
    vec2 diag = vec2(stepVec.x, stepVec.y);

    sum += texture2D(tex, handleUVBounds(uv)) * 0.204164;
    sum += texture2D(tex, handleUVBounds(uv + offsetX)) * 0.123317;
    sum += texture2D(tex, handleUVBounds(uv - offsetX)) * 0.123317;
    sum += texture2D(tex, handleUVBounds(uv + offsetY)) * 0.123317;
    sum += texture2D(tex, handleUVBounds(uv - offsetY)) * 0.123317;
    sum += texture2D(tex, handleUVBounds(uv + diag)) * 0.075113;
    sum += texture2D(tex, handleUVBounds(uv + vec2(-diag.x, diag.y))) * 0.075113;
    sum += texture2D(tex, handleUVBounds(uv + vec2(diag.x, -diag.y))) * 0.075113;
    sum += texture2D(tex, handleUVBounds(uv - diag)) * 0.075113;

    return sum;
}

vec4 effect(vec4 texel, float progress) {
    float invProgress = 1.0 - progress;
    vec2 centered = vUv - 0.5;

    float rise = smoothstep(0.0, 0.7, progress);
    float overshootBlend = smoothstep(0.7, 0.85, progress);
    float settle = smoothstep(0.82, 1.0, progress);

    float scaleUp = mix(minScale, maxOvershoot, rise);
    float scaleDown = mix(maxOvershoot, 1.0, settle);
    float displayScale = mix(scaleUp, scaleDown, overshootBlend);

    float uvScale = max(displayScale, 0.0001);
    vec2 rawSubjectUV = 0.5 + centered / uvScale;
    float subjectMask = getHardBoundaryMask(rawSubjectUV);
    vec2 subjectUV = handleUVBounds(rawSubjectUV);

    float blurAmount = blurMax * pow(invProgress, 1.2);
    vec4 blurredSubject = gaussianBlur(tDiffuse, subjectUV, blurAmount, ratio);
    vec4 crispSubject = texture2D(tDiffuse, subjectUV);
    float focusBlend = smoothstep(0.15, 0.95, progress);
    vec4 focusColor = mix(blurredSubject, crispSubject, focusBlend);

    vec3 premiumTone = focusColor.rgb * vec3(0.96, 0.98, 1.02) + vec3(0.02) * invProgress;
    float polish = smoothstep(0.4, 1.0, progress);
    vec3 gradedSubject = mix(premiumTone, focusColor.rgb, polish);

    float backgroundScale = mix(1.0 + depthParallax, 1.0, progress);
    vec2 rawBackgroundUV = 0.5 + centered / backgroundScale - centered * depthParallax * invProgress;
    vec2 backgroundUV = handleUVBounds(rawBackgroundUV);
    float backgroundBlurAmount = blurAmount * 0.6 + depthParallax * 40.0 * invProgress;
    vec4 backgroundColor = gaussianBlur(tDiffuse, backgroundUV, backgroundBlurAmount, ratio);
    backgroundColor.rgb = mix(backgroundColor.rgb * 0.92, backgroundColor.rgb, progress);

    float opacityCurve = mix(baseOpacity, 1.0, smoothstep(0.1, 0.85, progress));
    float finalSubjectMix = clamp(opacityCurve * subjectMask, 0.0, 1.0);

    vec3 compositeRGB = mix(backgroundColor.rgb, gradedSubject, finalSubjectMix);
    float compositeA = mix(backgroundColor.a, focusColor.a, finalSubjectMix);

    return vec4(compositeRGB, compositeA);
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