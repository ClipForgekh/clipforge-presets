exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float stripCount; // = 12.0 [2.0, 32.0] // 竖向条块数量
uniform float staggerStep; // = 0.0556 [0.0, 0.2] // 相邻条块触发延迟（归一化进度）
uniform float maxBlurUV; // = 0.032 [0.0, 0.08] // 初始垂直模糊半径（UV单位，约35px@1080p）
uniform float startBrightness; // = 1.3 [0.8, 1.6] // 初始亮度
uniform float startContrast; // = 0.5 [0.2, 1.2] // 初始对比度
uniform float sweepWidth; // = 0.06 [0.01, 0.2] // 扫光带宽度
uniform float sweepIntensity; // = 0.12 [0.0, 0.4] // 扫光强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec3 applyContrastBrightness(vec3 color, float contrast, float brightness) {
    color = (color - 0.5) * contrast + 0.5;
    color *= brightness;
    return clamp(color, 0.0, 1.0);
}

vec4 verticalBlur(sampler2D tex, vec2 uv, float radius) {
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -4.0 * radius))) * 0.05;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -3.0 * radius))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -2.0 * radius))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -1.0 * radius))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv)) * 0.18;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  1.0 * radius))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  2.0 * radius))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  3.0 * radius))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  4.0 * radius))) * 0.05;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float xScaled = vUv.x * stripCount;
    float idx = floor(xScaled);
    float f = smoothstep(0.0, 1.0, fract(xScaled));

    float d0 = idx * staggerStep;
    float d1 = min(stripCount - 1.0, idx + 1.0) * staggerStep;
    float delay = mix(d0, d1, f);

    float localP = clamp((p - delay) / max(1.0 - delay, 0.0001), 0.0, 1.0);

    float sweepCenter = p;
    float sweep = exp(-pow((vUv.x - sweepCenter) / max(sweepWidth, 0.0001), 2.0));
    sweep *= (1.0 - p);

    localP = clamp(localP + sweep * 0.35 * (1.0 - localP), 0.0, 1.0);

    float blurAmt = (1.0 - localP) * maxBlurUV;
    vec4 blurred = verticalBlur(tDiffuse, vUv, blurAmt);

    float brightness = mix(startBrightness, 1.0, localP);
    float contrast = mix(startContrast, 1.0, localP);

    vec3 color = applyContrastBrightness(blurred.rgb, contrast, brightness);

    vec3 warmLight = vec3(1.0, 0.97, 0.90);
    color += warmLight * (sweep * sweepIntensity);

    return vec4(clamp(color, 0.0, 1.0), texel.a);
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