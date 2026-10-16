exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float stripMinHeight; // = 0.08 [0.01, 0.2] // 初始水平条带高度占比
uniform float roughEdgeIntensity; // = 1.0 [0.0, 1.5] // 边缘粗糙强度倍率
uniform float waveAmplitude; // = 0.08 [0.0, 0.2] // 波浪形变幅度
uniform float waveFrequency; // = 8.0 [2.0, 16.0] // 波浪水平频率

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    return 3.0 * progress * progress - 2.0 * progress * progress * progress;
}

// 预定义辅助函数
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float getSoftBoundaryMask(vec2 uv, float borderSize) {
    vec2 mask = smoothstep(vec2(0.0), vec2(borderSize), uv) * (1.0 - smoothstep(vec2(1.0 - borderSize), vec2(1.0), uv));
    return mask.x * mask.y;
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

float circleSDF(vec2 uv, vec2 center, float radius) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    return length(aspectUV - center) - radius;
}

float rectSDF(vec2 uv, vec2 center, vec2 size) {
    vec2 aspectUV = getAspectCorrectUV(uv);
    vec2 dist = abs(aspectUV - center) - size * 0.5;
    return length(max(dist, 0.0)) + min(max(dist.x, dist.y), 0.0);
}

float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0)
        return sqrt(dot(p - vec2(0.25, 0.75), p - vec2(0.25, 0.75))) - sqrt(2.0) / 4.0;
    return sqrt(min(dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00)),
                    dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50)))) * sign(p.x - p.y);
}

float heartSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p /= max(size, 0.0001);
    p.y += 0.45;
    return sdHeart(p) * size;
}

float generateHeartMask(vec2 uv, vec2 center, float size, float blurEdge) {
    float dist = heartSDF(uv, center, size);
    return 1.0 - smoothstep(-blurEdge, blurEdge, dist);
}

float createFullScreenHeartMask(vec2 uv, vec2 center, float progress) {
    float maxSize = getMaxShapeSize();
    float acceleratedProgress = progress * progress;
    float currentSize = acceleratedProgress * maxSize;
    float dist = heartSDF(uv, center, currentSize);
    return smoothstep(0.01, -0.01, dist);
}

float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction;
    else return fraction * ratio;
}

float getLongSideRelativeSize(float fraction) {
    if (ratio > 1.0) return fraction * ratio;
    else return fraction;
}

// 噪声函数
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    for (int i = 0; i < 4; i++) {
        value += noise(p * frequency) * amplitude;
        frequency *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;
    vec2 uv = vUv;

    float stage1 = clamp(progress / 0.3, 0.0, 1.0);
    float stage2 = clamp((progress - 0.3) / 0.3, 0.0, 1.0);
    float stage3 = clamp((progress - 0.6) / 0.2, 0.0, 1.0);
    float stage4 = clamp((progress - 0.8) / 0.2, 0.0, 1.0);

    float stage1Ease = 1.0 - pow(1.0 - stage1, 2.0);
    float revealHeight = mix(stripMinHeight, 0.45, stage1Ease);
    revealHeight = mix(revealHeight, 0.9, stage2);
    float stage3Ease = stage3 * stage3;
    revealHeight = mix(revealHeight, 0.96, stage3Ease);
    float stage4Ease = 1.0 - pow(1.0 - stage4, 2.0);
    revealHeight = mix(revealHeight, 1.0, stage4Ease);
    revealHeight = clamp(revealHeight, stripMinHeight, 1.0);

    float waveUpEase = 1.0 - pow(1.0 - stage2, 2.0);
    float waveAmp = waveAmplitude * waveUpEase;
    waveAmp *= (1.0 - stage3Ease);
    float waveFadeEase = 1.0 - pow(1.0 - stage4, 2.0);
    waveAmp *= (1.0 - waveFadeEase);
    waveAmp *= effectStrength;

    float phase = uv.x * (waveFrequency * 6.2831853) + progress * 6.2831853;
    float waveOffsetY = sin(phase) * waveAmp;
    float waveOffsetX = cos(phase) * waveAmp * 0.25;

    vec2 warpedUv = vec2(uv.x + waveOffsetX, uv.y + waveOffsetY);
    vec2 sampleUV = handleUVBounds(warpedUv);
    vec4 warpedTexel = texture2D(tDiffuse, sampleUV);

    float roughFadeEase = 1.0 - pow(1.0 - stage4, 2.0);
    float roughAmount = roughEdgeIntensity * (1.0 - roughFadeEase) * (0.6 + 0.4 * effectStrength);

    float freqBase = mix(6.0, 14.0, clamp(roughEdgeIntensity, 0.0, 1.0));
    float roughScale = 0.35 * revealHeight * roughAmount;

    float topNoise = fbm(vec2(uv.x * freqBase, progress * 6.0 + 3.0));
    float bottomNoise = fbm(vec2(uv.x * freqBase, progress * 6.0 + 11.0));
    float offsetTop = (topNoise - 0.5) * 2.0 * roughScale;
    float offsetBottom = (bottomNoise - 0.5) * 2.0 * roughScale;

    float halfHeight = revealHeight * 0.5;
    float baseBottom = 0.5 - halfHeight;
    float baseTop = 0.5 + halfHeight;

    float bottomEdge = clamp(baseBottom + offsetBottom, 0.0, 1.0);
    float topEdge = clamp(baseTop + offsetTop, 0.0, 1.0);

    float span = max(topEdge - bottomEdge, 0.001);
    float centerY = bottomEdge + span * 0.5;
    bottomEdge = centerY - span * 0.5;
    topEdge = centerY + span * 0.5;

    float feather = mix(0.05, 0.004, progress);
    float maskCoord = warpedUv.y;
    float sdf = max(maskCoord - topEdge, bottomEdge - maskCoord);
    float mask = 1.0 - smoothstep(0.0, feather, sdf);
    mask *= getHardBoundaryMask(vUv);

    vec3 color = mix(vec3(0.0), warpedTexel.rgb, mask);
    float alpha = mix(0.0, warpedTexel.a, mask);

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