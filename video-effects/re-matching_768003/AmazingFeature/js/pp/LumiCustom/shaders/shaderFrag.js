exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float splitPoint; // = 0.45 [0.2, 0.8] // 主体与副元素分界位置
uniform float slideDistance; // = 0.12 [0.02, 0.3] // 水平方向滑入距离
uniform float stagger; // = 0.18 [0.0, 0.5] // 副层开始延迟
uniform float blurStrength; // = 0.007 [0.0, 0.03] // 运动模糊强度
uniform float scaleRange; // = 0.04 [0.0, 0.15] // 入场阶段缩放振幅

varying vec2 vUv;

float tween(float p) {
    float clamped = clamp(p, 0.0, 1.0);
    float cubicEase = 1.0 - pow(1.0 - clamped, 3.0);
    float sineEase = sin(clamped * 1.57079633);
    float smooth = smoothstep(0.0, 1.0, clamped);
    float editorialMix = mix(cubicEase, sineEase, 0.45);
    return mix(editorialMix, mix(clamped, smooth, 0.35), 0.5);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 sampleWithMotionBlur(vec2 uv, vec2 direction, float amount) {
    float weights[5];
    weights[0] = 1.0;
    weights[1] = 4.0;
    weights[2] = 6.0;
    weights[3] = 4.0;
    weights[4] = 1.0;

    float dirLength = length(direction);
    vec2 dirNorm = dirLength > 0.0 ? direction / dirLength : vec2(0.0);
    vec2 stepDir = dirNorm * amount;
    stepDir.y /= max(ratio, 0.0001);

    vec4 color = vec4(0.0);
    float totalWeight = 0.0;

    for (int i = -2; i <= 2; ++i) {
        float weight = weights[i + 2];
        vec2 sampleUV = uv + stepDir * float(i);
        float mask = getHardBoundaryMask(sampleUV);
        if (mask > 0.0) {
            vec4 sampleColor = texture2D(tDiffuse, handleUVBounds(sampleUV));
            color += sampleColor * weight * mask;
            totalWeight += weight * mask;
        }
    }

    if (totalWeight > 0.0) {
        return color / totalWeight;
    }

    return texture2D(tDiffuse, handleUVBounds(uv));
}

vec4 effect(vec4 texel, float easedProgress) {
    float baseIntensity = 1.0 - easedProgress;

    float mainEnd = max(0.0001, 1.0 - stagger);
    float mainProgress = smoothstep(0.0, mainEnd, easedProgress);
    float secondaryStart = clamp(stagger, 0.0, 0.95);
    float secondaryProgress = smoothstep(secondaryStart, 1.0, easedProgress);

    float mainOffset = (1.0 - mainProgress) * slideDistance;
    float secondaryOffset = (1.0 - secondaryProgress) * slideDistance;

    float scaleFactor = 1.0 + baseIntensity * scaleRange;
    vec2 scaledUV = 0.5 + (vUv - 0.5) * scaleFactor;
    float borderMask = getHardBoundaryMask(scaledUV);

    float feather = 0.06;
    float leftEdge = clamp(splitPoint - feather, 0.0, 1.0);
    float rightEdge = clamp(splitPoint + feather, 0.0, 1.0);
    rightEdge = max(rightEdge, leftEdge + 0.0001);
    float mainMask = 1.0 - smoothstep(leftEdge, rightEdge, vUv.x);
    float secondaryMask = 1.0 - mainMask;

    vec2 mainUV = scaledUV + vec2(mainOffset, 0.0);
    vec2 secondaryUV = scaledUV - vec2(secondaryOffset, 0.0);

    float mainBlurAmount = blurStrength * (1.0 - mainProgress);
    float secondaryBlurAmount = blurStrength * (1.0 - secondaryProgress);

    vec4 mainColor = sampleWithMotionBlur(mainUV, vec2(1.0, 0.0), mainBlurAmount);
    vec4 secondaryColor = sampleWithMotionBlur(secondaryUV, vec2(-1.0, 0.0), secondaryBlurAmount);

    vec4 combined = mainColor * mainMask + secondaryColor * secondaryMask;

    float stageReveal = smoothstep(0.02, 0.25, easedProgress);
    vec4 staged = mix(vec4(0.0), combined, stageReveal);
    staged.a = texel.a * stageReveal;

    vec4 finalLayer = mix(texel, staged, baseIntensity);
    finalLayer.a *= borderMask;

    return finalLayer;
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