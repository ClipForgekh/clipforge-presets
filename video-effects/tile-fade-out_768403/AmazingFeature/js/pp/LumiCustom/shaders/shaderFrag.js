exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float tileScale; // = 3.0 [1.0, 6.0] // 平铺扩展倍率
uniform float exposureFalloff; // = 3.0 [0.5, 6.0] // 远景曝光衰减控制
uniform float collapseSoftness; // = 0.08 [0.02, 0.2] // 收缩边缘柔化

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

float remap01(float value, float start, float end) {
    return clamp((value - start) / (end - start), 0.0, 1.0);
}

float exponentialOut(float t) {
    return t >= 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

float cubicIn(float t) {
    return t * t * t;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction;
    else return fraction * ratio;
}

vec4 effect(vec4 texel, float progress) {
    float p = progress;
    vec2 center = vec2(0.5);
    vec2 offset = vUv - center;

    float expandPhase1 = exponentialOut(remap01(p, 0.15, 0.55));
    float expandPhase2 = exponentialOut(remap01(p, 0.55, 0.8));
    float tileBlend = clamp(expandPhase1 * 0.7 + expandPhase2 * 0.6, 0.0, 1.0);

    float zoomPrimary = mix(1.0, 1.0 / tileScale, expandPhase1);
    float zoomExtended = mix(zoomPrimary, 1.0 / (tileScale * 1.5), expandPhase2);
    float zoom = clamp(zoomExtended, 0.05, 1.0);

    vec2 drift = offset * (0.25 * expandPhase1 + 0.65 * expandPhase2);
    vec2 scaledUV = offset / zoom + center + drift;

    vec2 clampedUV = handleUVBounds(scaledUV);
    vec2 tiledUV = fract(scaledUV);
    vec2 sampleUV = mix(clampedUV, tiledUV, tileBlend);

    vec4 color = texture2D(tDiffuse, sampleUV);

    float exposurePhase = remap01(p, 0.25, 0.675);
    float exposureStrength = exposurePhase;
    vec2 tileIndex = floor(scaledUV);
    float tileDistance = length(tileIndex);
    vec2 fractional = fract(scaledUV);
    vec2 exposureCoord = getSDFCoordinate(fractional, vec2(0.5));
    float radialDistance = length(exposureCoord);

    float tileFade = exp(-tileDistance * (1.0 + exposureStrength * exposureFalloff));
    float radialFade = exp(-radialDistance * (1.0 + exposureStrength * 2.0));
    float exposureMask = clamp(tileFade * radialFade, 0.0, 1.0);
    color.rgb *= mix(1.0, exposureMask, exposureStrength);

    float collapsePhase = remap01(p, 0.55, 0.8);
    float collapseEase = exponentialOut(collapsePhase);
    float baseRadius = getShortSideRelativeSize(0.45);
    float collapseRadius = mix(baseRadius, 0.0, collapseEase);
    vec2 collapseCoord = getSDFCoordinate(vUv, center);
    float collapseDistance = length(collapseCoord);
    float collapseMask = 1.0 - smoothstep(collapseRadius, collapseRadius + collapseSoftness, collapseDistance);
    float collapseMix = mix(1.0, collapseMask, collapsePhase);
    color *= collapseMix;

    float disappearPhase = remap01(p, 0.8, 1.0);
    float disappearance = cubicIn(disappearPhase);
    color = mix(color, vec4(0.0), disappearance);

    float borderMask = getHardBoundaryMask(vUv);
    color *= borderMask;

    return color;
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