exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float maxRotation; // = 6.2831853 [3.1415926, 12.5663706] // 最大基础旋转角度（弧度）
uniform float swirlIntensity; // = 1.0 [0.0, 3.0] // 中心额外扭曲强度

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 applyAspect(vec2 offset) {
    vec2 result = offset;
    if (ratio > 1.0) {
        result.x *= ratio;
    } else {
        result.y /= ratio;
    }
    return result;
}

vec2 removeAspect(vec2 offset) {
    vec2 result = offset;
    if (ratio > 1.0) {
        result.x /= ratio;
    } else {
        result.y *= ratio;
    }
    return result;
}

vec4 effect(vec4 texel, float progress) {
    float scale = 1.0 - progress;
    if (scale <= 0.0) {
        return vec4(0.0);
    }
    float safeScale = max(scale, 0.0001);
    vec2 center = vec2(0.5);
    vec2 destOffset = vUv - center;
    vec2 aspectDest = applyAspect(destOffset);
    vec2 unscaledAspect = aspectDest / safeScale;
    float radius = length(unscaledAspect);
    float angle = atan(unscaledAspect.y, unscaledAspect.x);
    vec2 corner = applyAspect(vec2(0.5, 0.5));
    float maxRadius = max(length(corner), 0.0001);
    float radiusNorm = clamp(radius / maxRadius, 0.0, 1.0);
    float baseRotation = progress * maxRotation;
    float twist = baseRotation * swirlIntensity * (1.0 - radiusNorm);
    float sourceAngle = angle - baseRotation - twist;
    vec2 sourceAspect = vec2(cos(sourceAngle), sin(sourceAngle)) * radius;
    vec2 sourceOffset = removeAspect(sourceAspect);
    vec2 sourceUv = center + sourceOffset;
    vec2 boundedUv = handleUVBounds(sourceUv);
    vec4 sampled = texture2D(tDiffuse, boundedUv);
    float borderMask = getHardBoundaryMask(sourceUv);
    return vec4(sampled.rgb * borderMask, sampled.a * borderMask);
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