exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurRadius; // = 0.008 [0.0, 0.03] // 底层最大模糊半径（相对UV）
uniform float glowIntensity; // = 3.0 [0.0, 5.0] // 暖金粒子发光强度
uniform float zoomAmount; // = 0.02 [0.0, 0.08] // 轻微镜头缩放量
uniform float sweepJitter; // = 0.08 [0.0, 0.2] // 粒子扫过随机偏移强度
uniform vec3 glowColor; // = vec3(1.0, 0.82, 0.45) // 暖金色光斑颜色

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

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 d = uv - center;
    if (ratio > 1.0) d.y /= ratio;
    else d.x *= ratio;
    return d;
}

float hash11(float n) {
    return fract(sin(n * 127.1) * 43758.5453123);
}

vec3 adjustSaturation(vec3 color, float saturation) {
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(luma), color, saturation);
}

vec3 adjustContrast(vec3 color, float contrast) {
    return (color - 0.5) * contrast + 0.5;
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float strength) {
    vec2 stepSize = vec2(strength, strength / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(-1.0, -1.0) * stepSize)) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + vec2( 0.0, -1.0) * stepSize)) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + vec2( 1.0, -1.0) * stepSize)) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(-1.0,  0.0) * stepSize)) * 2.0;
    c += texture2D(tex, handleUVBounds(uv)) * 4.0;
    c += texture2D(tex, handleUVBounds(uv + vec2( 1.0,  0.0) * stepSize)) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + vec2(-1.0,  1.0) * stepSize)) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + vec2( 0.0,  1.0) * stepSize)) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + vec2( 1.0,  1.0) * stepSize)) * 1.0;
    return c / 16.0;
}

vec4 effect(vec4 texel, float progress) {
    float p = clamp(progress, 0.0, 1.0);
    float strength = 1.0 - p;

    float scale = 1.0 + strength * zoomAmount;
    vec2 uvRaw = 0.5 + (vUv - 0.5) * scale;
    vec2 uv = handleUVBounds(uvRaw);
    float borderMask = getHardBoundaryMask(uvRaw);

    float currentBlur = strength * blurRadius;
    vec4 baseTex = gaussianBlur9(tDiffuse, uv, currentBlur);

    float brightness = mix(0.2, 1.0, p);
    float contrast = mix(0.6, 1.0, p);
    float saturation = mix(0.8, 1.0, p);

    vec3 baseColor = baseTex.rgb * brightness;
    baseColor = adjustContrast(baseColor, contrast);
    baseColor = adjustSaturation(baseColor, saturation);

    float moveP = 1.0 - pow(1.0 - p, 2.0);
    float headX = mix(-0.15, 1.15, moveP);
    float fadeWindow = 1.0 - smoothstep(0.40, 1.0, p);
    float particleEnvelope = strength * fadeWindow;

    float spread = mix(0.10, 0.0, p) + 0.12 * sin(p * 3.14159265);
    float trailWidth = mix(0.28, 0.03, p);

    float glow = 0.0;
    for (int i = 0; i < 14; i++) {
        float fi = float(i);
        float r1 = hash11(fi + 1.23);
        float r2 = hash11(fi * 2.17 + 3.71);
        float r3 = hash11(fi * 3.11 + 9.13);

        vec2 center;
        center.x = headX - r1 * trailWidth + (r2 - 0.5) * sweepJitter * strength;
        center.y = 0.5 + (r2 - 0.5) * (spread + 0.10 * r3);

        vec2 d = getSDFCoordinate(vUv, center);
        float rad = mix(0.010, 0.003, p) * (0.7 + 0.9 * r3);
        float core = exp(-dot(d, d) / max(rad * rad, 1e-5));

        float sx = exp(-abs(d.x) / max(rad * 0.25, 1e-5));
        float sy = exp(-abs(d.y) / max(rad * 0.25, 1e-5));
        float star = sx * exp(-abs(d.y) / max(rad * 1.8, 1e-5)) + sy * exp(-abs(d.x) / max(rad * 1.8, 1e-5));

        glow += core * 1.1 + star * 0.35;
    }

    float sweepBand = exp(-pow((vUv.x - headX) / max(mix(0.30, 0.04, p), 1e-5), 2.0));
    sweepBand *= (0.65 + 0.35 * exp(-pow((vUv.y - 0.5) / 0.45, 2.0)));

    float glowAmount = (glow / 14.0 + sweepBand * 0.9) * glowIntensity * particleEnvelope;

    vec3 outColor = baseColor + glowColor * glowAmount;
    outColor = clamp(outColor, 0.0, 1.0);

    float baseAlpha = mix(0.0, 1.0, p) * borderMask;
    return vec4(outColor, baseTex.a * baseAlpha);
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