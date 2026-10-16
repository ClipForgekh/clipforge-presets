exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float coarseCellCount; // = 32.0 [8.0, 96.0] // 粗像素网格的基准行数
uniform float detailMultiplier; // = 8.0 [2.0, 32.0] // 像素块细化的倍增系数

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 2.0);
}

float saturate(float x) {
    return clamp(x, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 78.233);
    return fract(p.x * p.y);
}

vec4 effect(vec4 texel, float progress) {
    float stage1End = tween(0.25 / 3.0);
    float stage2End = tween(2.0 / 3.0);
    float stage3End = tween(2.5 / 3.0);

    if (progress <= stage1End) {
        return vec4(0.0, 0.0, 0.0, texel.a);
    }

    if (progress < stage2End) {
        float stage2Progress = saturate((progress - stage1End) / (stage2End - stage1End));

        float baseCount = max(coarseCellCount, 1.0);
        vec2 gridResolution = vec2(baseCount * ratio, baseCount);
        vec2 scaledUV = vUv * gridResolution;
        vec2 cellId = floor(scaledUV);
        vec2 cellCenterUV = (cellId + 0.5) / gridResolution;

        float noise = hash21(cellId);
        float density = smoothstep(0.0, 0.6, stage2Progress);
        float activation = step(1.0 - density, noise);
        float flicker = step(0.5, fract(noise * 37.0 + stage2Progress * 25.0));
        float stabilization = smoothstep(0.8, 1.0, stage2Progress);
        float cellMask = activation * mix(flicker, 1.0, stabilization);

        vec4 coarseSample = texture2D(tDiffuse, cellCenterUV);
        vec3 binaryColor = vec3(cellMask);
        vec3 glitchColor = 0.5 + 0.5 * sin((coarseSample.rgb * 6.2831853 + vec3(0.0, 2.0943951, 4.1887902)) + (stage2Progress * 40.0 + noise * 12.0));
        float glitchMix = smoothstep(0.12, 0.45, stage2Progress);
        vec3 transitionColor = mix(binaryColor, glitchColor, glitchMix);
        float precisionMix = smoothstep(0.55, 1.0, stage2Progress);
        transitionColor = mix(transitionColor, coarseSample.rgb, precisionMix);

        vec3 finalColor = transitionColor * cellMask;
        float alphaMask = mix(cellMask, 1.0, smoothstep(0.85, 1.0, stage2Progress));
        float alpha = texel.a * alphaMask;

        return vec4(finalColor, alpha);
    }

    if (progress < stage3End) {
        float stage3Progress = saturate((progress - stage2End) / (stage3End - stage2End));

        float baseCount = max(coarseCellCount, 1.0);
        vec2 coarseResolution = vec2(baseCount * ratio, baseCount);
        vec2 coarseCellId = floor(vUv * coarseResolution);
        vec2 coarseCenterUV = (coarseCellId + 0.5) / coarseResolution;
        vec3 coarseColor = texture2D(tDiffuse, coarseCenterUV).rgb;

        float detailCountValue = max(baseCount * mix(1.0, detailMultiplier, stage3Progress), 1.0);
        vec2 detailResolution = vec2(detailCountValue * ratio, detailCountValue);
        vec2 detailCenterUV = (floor(vUv * detailResolution) + 0.5) / detailResolution;
        vec3 detailColor = texture2D(tDiffuse, detailCenterUV).rgb;

        vec3 mixedColor = mix(coarseColor, detailColor, smoothstep(0.0, 0.6, stage3Progress));
        mixedColor = mix(mixedColor, texel.rgb, smoothstep(0.5, 1.0, stage3Progress));

        return vec4(mixedColor, texel.a);
    }

    return texel;
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