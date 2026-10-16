exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float maxBlur; // = 0.02 [0.0, 0.08] // 最大模糊半径（UV空间）
uniform float maxExposure; // = 3.0 [1.0, 4.0] // 最大曝光倍率
uniform float maxSaturation; // = 1.8 [1.0, 3.0] // 最大饱和度
uniform float glowStrength; // = 2.5 [0.0, 4.0] // 暖光强度
uniform vec3 glowColor; // = vec3(1.0, 0.72, 0.35) // 暖橙黄色柔光
uniform float noiseStrength; // = 1.0 [0.0, 2.0] // 颗粒强度
uniform float startAlpha; // = 0.3 [0.0, 1.0] // 起始透明度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 adjustSaturation(vec3 color, float sat) {
    float l = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(l), color, sat);
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float radius) {
    vec2 stepSize = vec2(radius, radius / max(ratio, 0.0001));
    vec4 c = vec4(0.0);

    c += texture2D(tex, handleUVBounds(uv + vec2(-1.0, -1.0) * stepSize)) * 0.0625;
    c += texture2D(tex, handleUVBounds(uv + vec2( 0.0, -1.0) * stepSize)) * 0.1250;
    c += texture2D(tex, handleUVBounds(uv + vec2( 1.0, -1.0) * stepSize)) * 0.0625;

    c += texture2D(tex, handleUVBounds(uv + vec2(-1.0,  0.0) * stepSize)) * 0.1250;
    c += texture2D(tex, handleUVBounds(uv)) * 0.2500;
    c += texture2D(tex, handleUVBounds(uv + vec2( 1.0,  0.0) * stepSize)) * 0.1250;

    c += texture2D(tex, handleUVBounds(uv + vec2(-1.0,  1.0) * stepSize)) * 0.0625;
    c += texture2D(tex, handleUVBounds(uv + vec2( 0.0,  1.0) * stepSize)) * 0.1250;
    c += texture2D(tex, handleUVBounds(uv + vec2( 1.0,  1.0) * stepSize)) * 0.0625;

    return c;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) {
        return texel;
    }

    float strength = 1.0 - p;

    float blurAmount = maxBlur * strength;
    vec4 blurred = gaussianBlur9(tDiffuse, vUv, blurAmount);

    float exposure = mix(1.0, maxExposure, strength);
    float saturation = mix(1.0, maxSaturation, strength);

    vec3 color = adjustSaturation(blurred.rgb, saturation) * exposure;

    float lum = dot(blurred.rgb, vec3(0.299, 0.587, 0.114));
    float glowMask = smoothstep(0.2, 1.0, lum);
    vec3 glow = glowColor * glowStrength * strength * (0.6 + 0.4 * glowMask);

    color += glow;
    
    float grain = (hash12(vUv * vec2(1280.0, 720.0)) - 0.5) * 2.0;
    color += vec3(grain * 0.08 * noiseStrength * strength);

    color = clamp(color, 0.0, 1.0);

    float alphaFactor = mix(1.0, startAlpha, strength);
    return vec4(color, texel.a * alphaFactor);
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