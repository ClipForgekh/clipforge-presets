exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform vec3 glowColor; // = vec3(1.0, 0.78, 0.35) // 暖金色光斑颜色
uniform float glowIntensity; // = 3.0 [0.0, 5.0] // 光斑最大发光强度
uniform float maxBlur; // = 0.02 [0.0, 0.08] // 最大模糊半径（UV尺度）
uniform float sweepWidth; // = 0.22 [0.05, 0.5] // 扫光带宽
uniform float rgbSplit; // = 0.003 [0.0, 0.02] // RGB分离强度（UV尺度）
uniform float particleDensity; // = 30.0 [0.0, 80.0] // 光斑粒子密度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float radius) {
    vec2 stepSize = vec2(radius, radius / max(ratio, 0.0001));
    vec4 c = vec4(0.0);

    c += texture2D(tex, handleUVBounds(uv)) * 0.227027;
    c += texture2D(tex, handleUVBounds(uv + vec2( 1.384615, 0.0) * stepSize)) * 0.158108;
    c += texture2D(tex, handleUVBounds(uv - vec2( 1.384615, 0.0) * stepSize)) * 0.158108;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  1.384615) * stepSize)) * 0.158108;
    c += texture2D(tex, handleUVBounds(uv - vec2(0.0,  1.384615) * stepSize)) * 0.158108;
    c += texture2D(tex, handleUVBounds(uv + vec2( 3.230769, 0.0) * stepSize)) * 0.049000;
    c += texture2D(tex, handleUVBounds(uv - vec2( 3.230769, 0.0) * stepSize)) * 0.049000;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  3.230769) * stepSize)) * 0.049000;
    c += texture2D(tex, handleUVBounds(uv - vec2(0.0,  3.230769) * stepSize)) * 0.049000;

    return c;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    float reveal = smoothstep(0.0, 0.35, p);
    float earlyPhase = 1.0 - smoothstep(0.3, 1.0, p);

    float blurRadius = maxBlur * strength;
    vec4 blurred = gaussianBlur9(tDiffuse, vUv, blurRadius);

    float sweepX = -0.25 + 1.5 * p;
    float band = exp(-pow((vUv.x - sweepX) / max(sweepWidth, 0.0001), 2.0));

    float splitAmount = rgbSplit * earlyPhase * band;
    vec2 splitOffset = vec2(splitAmount, splitAmount / max(ratio, 0.0001));
    float r = texture2D(tDiffuse, handleUVBounds(vUv + splitOffset)).r;
    float g = texture2D(tDiffuse, handleUVBounds(vUv)).g;
    float b = texture2D(tDiffuse, handleUVBounds(vUv - splitOffset)).b;
    vec3 splitColor = vec3(r, g, b);

    vec2 particleUV = vec2(vUv.x * (particleDensity * 0.25), vUv.y * (particleDensity * 0.35));
    particleUV.x -= p * 6.0;
    float n = hash21(floor(particleUV));
    float spark = smoothstep(0.86, 1.0, n) * band * earlyPhase;
    spark *= (0.5 + 0.5 * hash21(floor(particleUV) + 7.13));

    vec3 baseColor = mix(blurred.rgb, splitColor, 0.35 * earlyPhase * band);
    vec3 glow = glowColor * (glowIntensity * earlyPhase) * (0.65 * band + 0.35 * spark);

    vec3 composited = baseColor + glow;
    composited = clamp(composited, 0.0, 1.0);

    vec3 finalRgb = mix(vec3(0.0), composited, reveal);
    float finalA = texel.a * reveal;

    return vec4(finalRgb, finalA);
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