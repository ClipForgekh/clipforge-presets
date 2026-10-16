exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float layerDelay; // = 0.18 [0.0, 0.4] // 相邻图层的进场延迟
uniform float depthScale; // = 0.12 [0.0, 0.3] // 图层缩放差异强度
uniform vec2 driftDirection; // = vec2(0.25, -0.18) // 图层漂移基准方向

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

float computeLayerProgress(float baseProgress, float delay, float duration) {
    return clamp((baseProgress - delay) / max(duration, 0.0001), 0.0, 1.0);
}

vec2 aspectAware(vec2 dir) {
    vec2 adjusted = dir;
    if (ratio > 1.0) {
        adjusted.y /= max(ratio, 0.0001);
    } else {
        adjusted.x *= ratio;
    }
    return adjusted;
}

vec4 sampleLayerColor(float layerProgress, float depthIndex, vec2 extraShift, float effectStrength) {
    float inv = 1.0 - layerProgress;
    float depthFactor = 0.35 + depthIndex * 0.55;
    float scale = 1.0 - depthScale * depthFactor * effectStrength * (0.5 + 0.5 * inv);
    vec2 baseDir = aspectAware(driftDirection + extraShift);
    vec2 offset = baseDir * effectStrength * (0.6 + depthIndex * 0.4) * (0.4 + 0.6 * inv);
    vec2 uv = 0.5 + (vUv - 0.5) * scale + offset;
    uv = handleUVBounds(uv);
    vec4 color = texture2D(tDiffuse, uv);
    float luma = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 stylized = mix(vec3(luma), color.rgb, 0.5 + 0.25 * (1.0 - depthIndex));
    color.rgb = mix(stylized, color.rgb, layerProgress);
    return color;
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;

    float totalDelay = layerDelay * 2.0;
    float layerDuration = max(0.0001, 1.0 - totalDelay);

    float backProgress = computeLayerProgress(progress, 0.0, layerDuration);
    float midProgress = computeLayerProgress(progress, layerDelay, layerDuration);
    float frontProgress = computeLayerProgress(progress, layerDelay * 2.0, layerDuration);

    vec4 backLayer = sampleLayerColor(backProgress, 1.0, vec2(-0.06, 0.08), effectStrength);
    vec4 midLayer = sampleLayerColor(midProgress, 0.5, vec2(0.04, -0.03), effectStrength);
    vec4 frontLayer = sampleLayerColor(frontProgress, 0.0, vec2(0.015, -0.01), effectStrength);

    vec4 color = mix(vec4(0.0), backLayer, backProgress);
    color = mix(color, midLayer, midProgress);
    color = mix(color, frontLayer, frontProgress);
    color = mix(color, texel, progress);

    float borderMask = getHardBoundaryMask(vUv);
    color.a *= borderMask;

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