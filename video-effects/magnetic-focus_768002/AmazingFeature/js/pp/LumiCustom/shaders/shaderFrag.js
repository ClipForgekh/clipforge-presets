exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float pullIntensity; // = 0.18 [0.05, 0.40] // 拉向中心的位移强度
uniform float radialBlurAmount; // = 0.20 [0.0, 0.60] // 径向模糊最大强度
uniform float trailLength; // = 0.035 [0.0, 0.08] // 方向拖影长度
uniform float trailStrength; // = 0.60 [0.0, 1.0] // 方向拖影混合权重
uniform float overshootAmount; // = 0.03 [0.0, 0.06] // 收束回弹比例

varying vec2 vUv;

// 自然加速再平滑收束的缓动曲线
float tween(float progress) {
    float accel = progress * progress;
    float decel = 1.0 - pow(1.0 - progress, 3.0);
    return mix(accel, decel, progress);
}

// UV边界处理：默认留黑，避免镜像拼接
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 硬边界裁切，防止缩放产生拉丝
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    vec2 center = vec2(0.5);
    float strength = 1.0 - progress;

    // 磁性吸附的核心几何变换：位移 + 缩放 + 回弹
    float baseScale = mix(0.7, 1.0, progress);
    float overshootPhase = smoothstep(0.78, 0.95, progress) - smoothstep(0.92, 1.0, progress);
    float finalScale = clamp(baseScale + overshootPhase * overshootAmount, 0.6, 1.08);

    vec2 toCenter = center - vUv;
    vec2 pulledUV = vUv + toCenter * strength * pullIntensity;
    vec2 uv = center + (pulledUV - center) * finalScale;
    vec2 boundedUV = handleUVBounds(uv);

    vec4 baseColor = texture2D(tDiffuse, boundedUV);

    // 径向模糊：逐步向外采样，强调向心速度感
    float radialStrength = radialBlurAmount * strength;
    vec4 radialAccum = vec4(0.0);
    float radialWeight = 0.0;
    for (int i = 0; i < 5; ++i) {
        float t = float(i) / 4.0;
        float weight = 1.0 - t * 0.7;
        vec2 sampleUV = center + (uv - center) * (1.0 + radialStrength * t);
        sampleUV = handleUVBounds(sampleUV);
        radialAccum += texture2D(tDiffuse, sampleUV) * weight;
        radialWeight += weight;
    }
    vec4 radialBlurred = radialAccum / radialWeight;
    vec4 radialResult = mix(baseColor, radialBlurred, clamp(radialStrength, 0.0, 1.0));

    // 方向拖影：沿运动逆向制造短促拖影
    vec2 dir = vec2(toCenter.x * ratio, toCenter.y);
    float dirLen = max(length(dir), 0.0001);
    vec2 normDir = dir / dirLen;
    vec2 sampleDir = vec2(normDir.x / max(ratio, 0.0001), normDir.y);

    float trailAmount = trailLength * strength;
    vec4 trailAccum = vec4(0.0);
    float trailWeight = 0.0;
    for (int j = 0; j < 4; ++j) {
        float t = float(j) / 3.0;
        float weight = 1.0 - 0.25 * float(j);
        vec2 sampleUV = uv - sampleDir * (trailAmount * (t + 0.3));
        sampleUV = handleUVBounds(sampleUV);
        trailAccum += texture2D(tDiffuse, sampleUV) * weight;
        trailWeight += weight;
    }
    vec4 trailColor = trailAccum / trailWeight;
    float trailMixFactor = clamp(trailStrength * strength, 0.0, 1.0);
    vec4 motionResult = mix(radialResult, trailColor, trailMixFactor);

    // 渐进回到原始画面
    vec4 finalColor = mix(motionResult, baseColor, progress);

    float borderMask = getHardBoundaryMask(uv);
    finalColor.rgb *= borderMask;
    finalColor.a = texel.a * borderMask;

    return finalColor;
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