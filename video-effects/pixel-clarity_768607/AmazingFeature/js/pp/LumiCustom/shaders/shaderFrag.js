exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float particleDensity; // = 35.0 [10.0, 80.0] // 焦散颗粒密度（约 density^2）
uniform float blurRadius; // = 0.02 [0.0, 0.08] // 初始模糊半径
uniform float glowStrength; // = 4.0 [0.0, 6.0] // 复古暖色光晕强度
uniform float grainAmount; // = 0.22 [0.0, 1.0] // 胶片颗粒强度
uniform float leakIntensity; // = 0.22 [0.0, 1.0] // 漏光条纹强度
uniform float scalePeak; // = 1.3 [1.0, 2.0] // 初始整体缩放峰值
uniform float brightnessBoost; // = 2.6 [1.0, 4.0] // 初始亮度增强
uniform float saturationBoost; // = 2.1 [1.0, 3.0] // 初始饱和度增强
uniform float depthParallax; // = 0.08 [0.0, 0.2] // 三维纵深视差强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.2);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec2 hash22(vec2 p) {
    float n = hash21(p);
    return vec2(n, hash21(p + n + 13.7));
}

vec4 blur9(vec2 uv, float r) {
    vec2 stepUV = vec2(r, r / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2(-1.0, -1.0))) * 1.0;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2( 0.0, -1.0))) * 2.0;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2( 1.0, -1.0))) * 1.0;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2(-1.0,  0.0))) * 2.0;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 4.0;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2( 1.0,  0.0))) * 2.0;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2(-1.0,  1.0))) * 1.0;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2( 0.0,  1.0))) * 2.0;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV * vec2( 1.0,  1.0))) * 1.0;
    return c / 16.0;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    float sc = mix(scalePeak, 1.0, p);
    vec2 scaledUv = 0.5 + (vUv - 0.5) * sc;

    vec2 uvAspect = vec2(scaledUv.x * ratio, scaledUv.y);
    vec2 cell = floor(uvAspect * particleDensity);

    float rnd = hash21(cell);
    vec2 rnd2 = hash22(cell + 7.13);
    float depth = hash21(cell + 19.7);

    vec2 cellCenterA = (cell + 0.5 + (rnd2 - 0.5) * 0.6) / particleDensity;
    vec2 targetUv = vec2(cellCenterA.x / max(ratio, 0.0001), cellCenterA.y);

    float ang = hash21(cell + 31.5) * 6.2831853;
    vec2 dir = vec2(cos(ang), sin(ang));

    float travel = (0.06 + 0.42 * depth + 0.18 * rnd) * strength;
    vec2 parallax = vec2((depth - 0.5) * depthParallax, (0.5 - depth) * depthParallax * 0.6) * strength;
    vec2 scatteredUv = targetUv + dir * travel + parallax;

    vec2 sampleUv = mix(handleUVBounds(scaledUv), scatteredUv, strength);
    sampleUv = handleUVBounds(sampleUv);

    float localBlur = blurRadius * strength * (0.7 + 0.6 * depth);
    vec4 col = blur9(sampleUv, localBlur);

    float luma = dot(col.rgb, vec3(0.299, 0.587, 0.114));
    float sat = 1.0 + (saturationBoost - 1.0) * strength;
    vec3 rgb = mix(vec3(luma), col.rgb, sat);

    float bri = 1.0 + (brightnessBoost - 1.0) * strength;
    rgb *= bri;

    vec3 bloom = max(rgb - 0.55, 0.0) * vec3(1.0, 0.72, 0.36) * glowStrength * strength * 0.22;
    rgb += bloom;

    float grain = (hash21(vUv * vec2(987.1, 613.7) + p * 173.0) - 0.5) * grainAmount * strength;
    rgb += grain;

    float flicker = step(0.988, sin(p * 220.0) * 0.5 + 0.5);
    float stripe = smoothstep(0.72, 1.0, sin((vUv.y + rnd * 0.03) * 130.0 + p * 37.0) * 0.5 + 0.5);
    float leakWindow = smoothstep(0.0, 0.08, p) * (1.0 - smoothstep(0.75, 1.0, p));
    rgb += vec3(1.0, 0.30, 0.12) * leakIntensity * stripe * flicker * leakWindow * strength;

    rgb = clamp(rgb, 0.0, 1.0);

    return vec4(rgb, col.a);
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