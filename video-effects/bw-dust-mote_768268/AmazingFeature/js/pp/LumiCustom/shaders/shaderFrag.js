exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float echoScale; // = 0.7 [0.2, 1.5] // 时域残影的空间扩散系数

varying vec2 vUv;

float tween(float t) {
    if (t < 0.5) {
        return 4.0 * t * t * t;
    }
    float u = -2.0 * t + 2.0;
    return 1.0 - 0.5 * u * u * u;
}

float cubicInOutInverse(float y) {
    float u = clamp(y, 0.0, 1.0);
    if (u < 0.5) {
        return pow(u * 0.25, 1.0 / 3.0);
    }
    float k = pow(2.0 * (1.0 - u), 1.0 / 3.0);
    return 1.0 - 0.5 * k;
}

float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

vec3 adjustSaturation(vec3 color, float saturation) {
    float gray = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(gray), color, saturation);
}

float remapClamped(float value, float inMin, float inMax) {
    float d = max(inMax - inMin, 0.0001);
    float t = (value - inMin) / d;
    return clamp(t, 0.0, 1.0);
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

vec4 effect(vec4 texel, float easedProgress) {
    float linearProgress = cubicInOutInverse(easedProgress);

    vec4 baseColor = texel;

    float fragmentSync = remapClamped(linearProgress, 0.166667, 0.611111);
    float coverage = remapClamped(linearProgress, 0.02, 0.611111);
    float desync = 1.0 - fragmentSync;
    float collapse = remapClamped(linearProgress, 0.611111, 0.861111);
    float stability = remapClamped(linearProgress, 0.861111, 1.0);
    float saturationFactor = remapClamped(linearProgress, 0.305556, 0.694444);
    float reveal = clamp(smoothstep(0.02, 0.12, linearProgress) + coverage * 0.65, 0.0, 1.0);

    vec4 accumulated = vec4(0.0);
    float totalWeight = 0.0;

    for (int i = 0; i < 4; ++i) {
        float fi = float(i);
        float angleSeed = hash21(vec2(fi * 37.2 + 13.1, linearProgress * 91.7 + 7.3));
        float angle = angleSeed * 6.2831853;
        vec2 dir = vec2(cos(angle), sin(angle));
        float radialSeed = hash21(vec2(fi * 17.0 + 5.0, linearProgress * 59.0 + 19.0));
        float desyncFactor = 0.25 + 0.75 * desync;
        float jitterStrength = echoScale * (0.008 + 0.07 * radialSeed) * desyncFactor;
        vec2 offset = dir * jitterStrength;
        vec2 sampleUV = handleUVBounds(vUv + offset);

        vec4 tap = texture2D(tDiffuse, sampleUV);

        float noiseCell = hash21(floor(vUv * (18.0 + desync * 80.0) + fi * 3.97) + linearProgress * 127.0 + fi * 11.0);
        float threshold = clamp(0.92 - coverage * 0.9, 0.02, 0.92);
        float softness = 0.06 + desync * 0.12;
        float fragmentMask = smoothstep(threshold - softness, threshold + softness, noiseCell);
        fragmentMask = mix(fragmentMask, 1.0, remapClamped(linearProgress, 0.45, 0.7));

        float echoAge = (3.0 - float(i)) / 3.0;
        float baseWeight = 0.35 + 0.65 * echoAge;
        float collapseWeight = mix(1.0, 1.0 - echoAge, collapse);
        float weight = baseWeight * collapseWeight * fragmentMask;

        vec3 tinted = adjustSaturation(tap.rgb, saturationFactor);
        float syncBlend = clamp(fragmentSync * 0.35 + collapse * 0.45, 0.0, 1.0);
        tinted = mix(tinted, baseColor.rgb, syncBlend);

        accumulated.rgb += tinted * weight;
        accumulated.a += tap.a * weight;
        totalWeight += weight;
    }

    vec4 fusedColor = totalWeight > 0.0 ? accumulated / totalWeight : vec4(0.0);

    vec3 stageColor = fusedColor.rgb;
    stageColor = mix(stageColor, baseColor.rgb, fragmentSync * 0.35 + collapse * 0.45);

    vec3 finalRGB = mix(vec3(0.0), stageColor, reveal);
    finalRGB = mix(finalRGB, baseColor.rgb, stability);

    float finalAlpha = mix(0.0, fusedColor.a, reveal);
    finalAlpha = mix(finalAlpha, baseColor.a, stability);

    return vec4(finalRGB, finalAlpha);
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