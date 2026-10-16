exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float maxBlur; // = 0.06 [0.0, 0.2] // 初始纵向模糊半径（UV尺度）
uniform float curtainIntensity; // = 4.0 [0.0, 6.0] // 金色光幕强度
uniform float curtainThickness; // = 0.22 [0.02, 0.6] // 光幕厚度
uniform float upwardDrift; // = 0.12 [0.0, 0.5] // 光幕向上滚动幅度
uniform vec3 goldColor; // = vec3(1.0, 0.82, 0.45) // 暖金色雾光颜色

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

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 verticalBlur(vec2 uv, float radius) {
    if (radius <= 0.00001) return texture2D(tDiffuse, uv);

    vec4 c = vec4(0.0);
    float w = 0.0;

    for (int i = -4; i <= 4; i++) {
        float fi = float(i);
        float k = exp(-0.5 * fi * fi / 4.0);
        vec2 suv = handleUVBounds(uv + vec2(0.0, fi * radius));
        c += texture2D(tDiffuse, suv) * k;
        w += k;
    }
    return c / w;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    float strength = 1.0 - p;

    float blurRadius = maxBlur * strength;
    vec4 blurred = verticalBlur(vUv, blurRadius);

    float zPush = p;
    float curtainY = mix(-0.35, 1.25, zPush) + upwardDrift * p;
    float dy = abs(vUv.y - curtainY);

    float thickness = max(curtainThickness * (0.65 + 0.35 * strength), 0.0001);
    float core = exp(-dy / thickness);
    float soft = exp(-dy / (thickness * 2.4));

    float grainBase = hash21(vUv * vec2(420.0, 900.0) + vec2(p * 17.0, p * 29.0));
    float grainFine = hash21(vUv * vec2(1200.0, 1800.0) + vec2(p * 53.0, p * 71.0));
    float tScatter = (grainBase * 0.65 + grainFine * 0.35);

    float edgeBand = exp(-abs(dy - thickness * 0.85) / (thickness * 0.35));
    float particle = edgeBand * smoothstep(0.45, 1.0, tScatter) * strength;

    float glow = (core * 0.75 + soft * 0.25) * curtainIntensity * strength;
    vec3 fogGold = goldColor * glow * (0.55 + 0.45 * tScatter);

    vec3 base = blurred.rgb;
    base += fogGold;
    base += goldColor * particle * 0.6;

    base = mix(base, texel.rgb, p);

    return vec4(clamp(base, 0.0, 1.0), texel.a * getHardBoundaryMask(vUv));
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