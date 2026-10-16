exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float startScale; // = 0.82 [0.5, 1.0] // 初始缩放比例
uniform float minOpacity; // = 0.15 [0.0, 1.0] // 初始透明度
uniform float blurStrength; // = 0.015 [0.0, 0.05] // 前向动感模糊强度

varying vec2 vUv;

float tween(float progress) {
    progress = clamp(progress, 0.0, 1.0);
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 applyRadialBlur(vec2 uv, float amount) {
    vec4 accum = vec4(0.0);
    float totalWeight = 0.0;
    vec2 center = vec2(0.5);
    vec2 offset = uv - center;
    vec2 aspectOffset = offset;
    if (ratio > 1.0) {
        aspectOffset.x *= ratio;
    } else {
        float safeRatio = max(ratio, 0.0001);
        aspectOffset.y /= safeRatio;
    }
    float len = length(aspectOffset);
    vec2 dir = len > 0.0 ? offset / len : vec2(0.0);
    vec2 stepDir = dir * amount;
    for (int i = -2; i <= 2; i++) {
        float f = float(i);
        float weight = 1.0 - abs(f) * 0.2;
        weight = max(weight, 0.0);
        vec2 sampleUV = handleUVBounds(uv + stepDir * f);
        accum += texture2D(tDiffuse, sampleUV) * weight;
        totalWeight += weight;
    }
    return totalWeight > 0.0 ? accum / totalWeight : texture2D(tDiffuse, uv);
}

vec4 effect(vec4 texel, float progress) {
    float easedProgress = progress;
    float effectStrength = 1.0 - easedProgress;
    vec2 center = vec2(0.5);
    float zoom = mix(1.0, startScale, effectStrength);
    zoom = max(zoom, 0.001);
    vec2 rawUV = center + (vUv - center) / zoom;
    vec2 boundedUV = handleUVBounds(rawUV);
    vec4 scaledTexel = texture2D(tDiffuse, boundedUV);
    float blurAmount = blurStrength * effectStrength;
    vec4 blurredTexel = applyRadialBlur(boundedUV, blurAmount);
    vec4 cinematicTexel = mix(blurredTexel, scaledTexel, easedProgress);
    vec4 blendedTexel = mix(cinematicTexel, texel, easedProgress);
    float opacity = mix(texel.a * minOpacity, texel.a, easedProgress);
    float borderMask = getHardBoundaryMask(rawUV);
    vec3 finalRgb = blendedTexel.rgb * borderMask;
    float finalAlpha = opacity * borderMask;
    return vec4(finalRgb, finalAlpha);
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