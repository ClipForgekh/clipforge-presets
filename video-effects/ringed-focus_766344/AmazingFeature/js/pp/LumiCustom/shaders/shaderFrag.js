exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurSize; // = 0.028 [0.0, 0.08] // 初始垂直模糊半径（22px近似）
uniform float grainAmount; // = 0.08 [0.0, 0.3] // 胶片颗粒强度
uniform vec3 warmColor; // = vec3(1.0, 0.78, 0.42) // 暖金胶片色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float getMaxRadius() {
    if (ratio > 1.0) return sqrt(0.25 + 0.25 / (ratio * ratio));
    return sqrt(0.25 * ratio * ratio + 0.25);
}

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453123);
}

float easeOutCubic(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec3 applyContrast(vec3 color, float c) {
    return (color - 0.5) * c + 0.5;
}

vec4 verticalBlur(vec2 uv, float amount) {
    vec2 stepV = vec2(0.0, amount / max(ratio, 0.0001));
    vec4 col = vec4(0.0);
    col += texture2D(tDiffuse, handleUVBounds(uv - 4.0 * stepV)) * 0.05;
    col += texture2D(tDiffuse, handleUVBounds(uv - 3.0 * stepV)) * 0.09;
    col += texture2D(tDiffuse, handleUVBounds(uv - 2.0 * stepV)) * 0.12;
    col += texture2D(tDiffuse, handleUVBounds(uv - 1.0 * stepV)) * 0.15;
    col += texture2D(tDiffuse, handleUVBounds(uv)) * 0.18;
    col += texture2D(tDiffuse, handleUVBounds(uv + 1.0 * stepV)) * 0.15;
    col += texture2D(tDiffuse, handleUVBounds(uv + 2.0 * stepV)) * 0.12;
    col += texture2D(tDiffuse, handleUVBounds(uv + 3.0 * stepV)) * 0.09;
    col += texture2D(tDiffuse, handleUVBounds(uv + 4.0 * stepV)) * 0.05;
    return col;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    const float ringCount = 8.0;
    const float totalT = 0.54;
    const float stepDelay = 0.06 / totalT;
    const float layerDur = 0.12 / totalT;

    vec2 center = vec2(0.5, 0.5);
    vec2 pc = getSDFCoordinate(vUv, center);
    float maxR = getMaxRadius();
    float rNorm = clamp(length(pc) / maxR, 0.0, 0.999999);

    float ringIndex = floor(rNorm * ringCount);
    float ringPos = fract(rNorm * ringCount);

    float startT = ringIndex * stepDelay;
    float local = clamp((p - startT) / layerDur, 0.0, 1.0);
    float k = easeOutCubic(local);

    float blurFactor = 1.0 - k;
    float contrast = mix(0.4, 1.0, k);

    float exposure;
    if (local < 0.5) {
        float a = easeOutCubic(local * 2.0);
        exposure = mix(2.8, 3.2, a);
    } else {
        float b = easeOutCubic((local - 0.5) * 2.0);
        exposure = mix(3.2, 1.0, b);
    }

    vec4 base = verticalBlur(vUv, blurSize * blurFactor);
    vec3 col = applyContrast(base.rgb, contrast);
    col *= exposure;

    float edge = 1.0 - smoothstep(0.0, 0.14, min(ringPos, 1.0 - ringPos));
    float leak = smoothstep(0.50, 0.62, local) * (1.0 - smoothstep(0.62, 0.92, local));
    col += warmColor * (0.16 * leak * edge);

    float globalRemain = 1.0 - p;
    float g = (rand(vUv * vec2(1280.0, 720.0) + p * 37.0) - 0.5) * 2.0;
    col += g * grainAmount * globalRemain * 0.12;

    col = mix(col, texel.rgb, smoothstep(0.97, 1.0, p));
    col = clamp(col, 0.0, 1.0);

    return vec4(col, texel.a);
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