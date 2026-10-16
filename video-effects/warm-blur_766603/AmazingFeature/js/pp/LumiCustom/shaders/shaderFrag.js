exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurRadius; // = 30.0 [0.0, 60.0] // 最大模糊半径（像素感知）
uniform float glowStrength; // = 2.5 [0.0, 5.0] // 暖光发光强度
uniform float glowAlpha; // = 0.8 [0.0, 1.0] // 发光层混合强度
uniform float brightnessBoost; // = 2.2 [1.0, 3.0] // 初始亮度增益
uniform float saturationBoost; // = 1.8 [1.0, 3.0] // 初始饱和度增益
uniform float peakGlowBoost; // = 0.2 [0.0, 1.0] // 前段额外暖光提升
uniform vec3 glowColor; // = vec3(1.0, 0.78, 0.45) // 暖金色光效颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec3 adjustSaturation(vec3 color, float sat) {
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(luma), color, sat);
}

vec3 screenBlend(vec3 base, vec3 blend) {
    return 1.0 - (1.0 - base) * (1.0 - blend);
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float radiusPx) {
    if (radiusPx <= 0.0001) {
        return texture2D(tex, handleUVBounds(uv));
    }

    float r = radiusPx / 1000.0;
    vec2 stepUV = vec2(r, r / max(ratio, 0.0001));

    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv)) * 0.227027;
    c += texture2D(tex, handleUVBounds(uv + vec2(stepUV.x, 0.0))) * 0.1945946;
    c += texture2D(tex, handleUVBounds(uv - vec2(stepUV.x, 0.0))) * 0.1945946;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, stepUV.y))) * 0.1945946;
    c += texture2D(tex, handleUVBounds(uv - vec2(0.0, stepUV.y))) * 0.1945946;
    c += texture2D(tex, handleUVBounds(uv + stepUV)) * 0.060606;
    c += texture2D(tex, handleUVBounds(uv - stepUV)) * 0.060606;
    c += texture2D(tex, handleUVBounds(uv + vec2(stepUV.x, -stepUV.y))) * 0.060606;
    c += texture2D(tex, handleUVBounds(uv + vec2(-stepUV.x, stepUV.y))) * 0.060606;

    return c / 1.2472664;
}

vec4 effect(vec4 texel, float progress) {
    float p = clamp(progress, 0.0, 1.0);
    float strength = 1.0 - p;

    float blurFactor;
    if (p < 0.3) {
        float t = smoothstep(0.0, 0.3, p);
        blurFactor = mix(1.0, 0.5, t);
    } else {
        float t = smoothstep(0.3, 1.0, p);
        blurFactor = mix(0.5, 0.0, t);
    }

    float currentBlur = blurRadius * blurFactor;
    vec4 blurredTexel = gaussianBlur9(tDiffuse, vUv, currentBlur);

    float earlyBoost = 1.0 + peakGlowBoost * (1.0 - smoothstep(0.0, 0.2, p));
    float currentGlow = glowStrength * strength * earlyBoost;
    float currentGlowAlpha = glowAlpha * strength;

    vec3 glowLayer = blurredTexel.rgb * glowColor * currentGlow;
    vec3 litColor = screenBlend(blurredTexel.rgb, glowLayer);
    vec3 color = mix(blurredTexel.rgb, litColor, clamp(currentGlowAlpha, 0.0, 1.0));

    float currentBrightness = mix(1.0, brightnessBoost, strength);
    float currentSaturation = mix(1.0, saturationBoost, strength);

    color *= currentBrightness;
    color = adjustSaturation(color, currentSaturation);
    color = clamp(color, 0.0, 1.0);

    return vec4(color, texel.a);
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