exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurRadius; // = 0.02 [0.0, 0.08] // 最大模糊半径（近似25px，随分辨率变化）
uniform float glowIntensity; // = 2.5 [0.0, 4.0] // 暖金发光强度
uniform float scaleBoost; // = 0.1 [0.0, 0.3] // 初始放大强度（1.0 + scaleBoost）
uniform float brightnessBoost; // = 2.2 [1.0, 3.0] // 初始亮度增强
uniform float saturationBoost; // = 1.8 [1.0, 3.0] // 初始饱和度增强
uniform float ringDelay; // = 0.0667 [0.0, 0.2] // 每环延迟（归一化时间）
uniform float particleSpread; // = 0.06 [0.0, 0.2] // 粒子外散距离（UV）
uniform vec3 goldColor; // = vec3(1.0, 0.82, 0.45) // 暖金色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
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

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float radius) {
    vec2 stepSize = vec2(radius, radius / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0, -1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0, -1.0))) * 0.100;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0, -1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  0.0))) * 0.100;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  0.0))) * 0.300;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  0.0))) * 0.100;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  1.0))) * 0.100;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  1.0))) * 0.075;
    return c;
}

float ringStrength(float p, float ringIndex) {
    float startT = ringIndex * ringDelay;
    float localP = clamp((p - startT) / max(1.0 - startT, 0.0001), 0.0, 1.0);
    float eased = 1.0 - pow(1.0 - localP, 2.0);
    return 1.0 - eased;
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5);
    vec2 ap = getSDFCoordinate(vUv, center);
    float r = length(ap);

    float maxR = length(getSDFCoordinate(vec2(1.0, 1.0), center));
    float ringW = maxR / 8.0;
    float idx = min(7.0, floor(r / max(ringW, 0.0001)));

    float k = ringStrength(p, idx);

    float scale = 1.0 + scaleBoost * k;
    vec2 uv = center + (vUv - center) * scale;
    float borderMask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);

    float b = blurRadius * k;
    vec4 blurred = gaussianBlur9(tDiffuse, uv, b);

    float luma = dot(blurred.rgb, vec3(0.299, 0.587, 0.114));
    float satMul = 1.0 + (saturationBoost - 1.0) * k;
    vec3 saturated = vec3(luma) + (blurred.rgb - vec3(luma)) * satMul;
    vec3 bright = saturated * mix(1.0, brightnessBoost, k);

    float grain = (hash12(vUv * 700.0 + vec2(p * 31.7, p * 13.1)) - 0.5) * 0.12 * k;
    vec3 metallic = goldColor * glowIntensity * k * (0.65 + 0.35 * hash12(vUv * 320.0 + idx * 7.17));
    vec3 stylized = clamp(bright + metallic + grain, 0.0, 1.0);

    float decayPhase = 1.0 - k;
    float travel = decayPhase * particleSpread;
    float trailR = max(r - travel, 0.0);
    float cell = trailR / max(ringW, 0.0001);
    float edgeDist = min(fract(cell), 1.0 - fract(cell));
    float edgeMask = 1.0 - smoothstep(0.0, 0.10, edgeDist);
    float ringActivity = smoothstep(0.02, 0.2, decayPhase) * (1.0 - smoothstep(0.75, 1.0, decayPhase));
    float sparkleNoise = hash12(vUv * 900.0 + vec2(idx * 5.3, decayPhase * 41.2));
    float spark = step(0.84, sparkleNoise) * edgeMask * ringActivity;
    vec3 particles = goldColor * glowIntensity * 0.9 * spark;

    vec3 finalRgb = mix(texel.rgb, stylized + particles, k);
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    return vec4(finalRgb, texel.a * borderMask);
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