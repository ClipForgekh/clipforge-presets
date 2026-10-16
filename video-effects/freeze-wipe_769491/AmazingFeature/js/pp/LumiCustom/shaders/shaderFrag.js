exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurRadius; // = 0.023 [0.0, 0.08] // 初始垂直模糊半径（约25px感知）
uniform float stripDelay; // = 0.08 [0.02, 0.2] // 分栏启动间隔
uniform float neonStrength; // = 0.9 [0.0, 2.0] // 霓虹边强度
uniform vec3 neonColor; // = vec3(0.78, 0.55, 1.0) // 淡紫色霓虹颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlur9(sampler2D tex, vec2 uv, float radius) {
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -4.0 * radius))) * 0.06;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -3.0 * radius))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -2.0 * radius))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -1.0 * radius))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv)) * 0.16;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  1.0 * radius))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  2.0 * radius))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  3.0 * radius))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0,  4.0 * radius))) * 0.06;
    return c;
}

vec3 applyContrast(vec3 col, float contrast) {
    return (col - 0.5) * contrast + 0.5;
}

vec3 applySaturation(vec3 col, float sat) {
    float g = dot(col, vec3(0.299, 0.587, 0.114));
    return mix(vec3(g), col, sat);
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    const float PI = 3.14159265;
    const float stripCount = 8.0;
    const float startTime = 0.10;
    const float endTime = 0.90;

    float stripIndex = floor(clamp(vUv.x, 0.0, 0.999999) * stripCount);
    float localStart = startTime + stripIndex * stripDelay;
    float localDuration = max(endTime - localStart, 0.0001);

    float tStrip = clamp((p - localStart) / localDuration, 0.0, 1.0);
    float forceClean = smoothstep(endTime, 1.0, p);
    tStrip = max(tStrip, forceClean);

    float blurNow = blurRadius * (1.0 - tStrip);
    vec4 sharp = texel;
    vec4 blurred = verticalBlur9(tDiffuse, vUv, blurNow);
    vec3 baseCol = mix(blurred.rgb, sharp.rgb, tStrip);

    float brightnessBase = mix(0.6, 1.0, tStrip);
    float flash = 0.72 * sin(clamp(tStrip * 1.2, 0.0, 1.0) * PI) * (1.0 - tStrip);
    float brightness = min(brightnessBase + flash, 1.3);

    float contrast = mix(0.5, 1.0, tStrip);
    float saturation = mix(0.7, 1.0, tStrip);

    vec3 col = baseCol * brightness;
    col = applyContrast(col, contrast);
    col = applySaturation(col, saturation);

    float edge = clamp(length(blurred.rgb - sharp.rgb) * 2.2, 0.0, 1.0);
    float neonAmt = (1.0 - tStrip) * neonStrength;
    col += neonColor * edge * neonAmt;

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