exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurMax; // = 12.0 [0.0, 24.0] // 最大模糊半径
uniform float particleDensity; // = 0.85 [0.0, 1.0] // 粒子密度
uniform float glowStrength; // = 3.2 [0.0, 6.0] // 发光强度
uniform vec3 particleColor; // = vec3(1.0, 0.82, 0.45) // 暖金色粒子颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 34.45);
    return fract(p.x * p.y);
}

vec2 hash22(vec2 p) {
    float n = hash21(p);
    return vec2(n, hash21(p + n + 17.31));
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float radiusPx, float screenRatio) {
    float r = max(radiusPx, 0.0) * 0.001;
    vec2 stepSize = vec2(r, r / max(screenRatio, 0.0001));

    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0, -1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0, -1.0))) * 0.120;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0, -1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  0.0))) * 0.120;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  0.0))) * 0.220;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  0.0))) * 0.120;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  1.0))) * 0.120;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  1.0))) * 0.075;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float reveal = clamp(p / 0.8, 0.0, 1.0);
    float effectAmt = 1.0 - smoothstep(0.0, 0.8, p);

    vec4 blurredTexel = gaussianBlur9(tDiffuse, vUv, blurMax * effectAmt, ratio);

    float brightness = reveal;
    float saturation = mix(0.7, 1.0, reveal);
    vec3 baseColor = blurredTexel.rgb * brightness;
    float luma = dot(baseColor, vec3(0.299, 0.587, 0.114));
    baseColor = mix(vec3(luma), baseColor, saturation);

    vec2 uv = vUv;
    float sweepX = -0.25 + 1.45 * p;
    float bandWidth = mix(0.26, 0.07, p);
    float band = exp(-pow((uv.x - sweepX) / max(bandWidth, 0.0001), 2.0) * 3.0);

    vec2 flowUV = uv;
    flowUV.x -= p * 0.55;
    flowUV.y += (hash21(floor(uv * 40.0)) - 0.5) * 0.12 * (1.0 - p);

    vec2 grid = vec2(120.0, 72.0);
    vec2 cell = floor(flowUV * grid);
    vec2 f = fract(flowUV * grid);

    vec2 rnd = hash22(cell);
    float alive = step(rnd.x, particleDensity * effectAmt);
    vec2 center = rnd;
    vec2 d = (f - center) * vec2(1.0, ratio);
    float size = mix(0.12, 0.42, rnd.y);
    float spark = smoothstep(size, 0.0, length(d));
    float twinkle = 0.65 + 0.35 * sin((rnd.x * 31.0 + p * 28.0) * 6.2831853);

    float particleMask = spark * band * alive * twinkle * effectAmt;
    vec3 glowColor = mix(particleColor, vec3(1.0), smoothstep(0.75, 1.0, spark));
    vec3 particleAdd = glowColor * (glowStrength * particleMask);

    vec3 finalRgb = baseColor + particleAdd;
    float baseAlpha = texel.a * reveal;
    float particleAlpha = clamp(particleMask * 0.9, 0.0, 1.0);
    float finalAlpha = clamp(baseAlpha + particleAlpha * (1.0 - reveal), 0.0, 1.0);

    return vec4(clamp(finalRgb, 0.0, 1.0), finalAlpha);
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