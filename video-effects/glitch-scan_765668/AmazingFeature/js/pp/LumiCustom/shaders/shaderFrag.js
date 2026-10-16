exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float glitchAmount; // = 1.0 [0.0, 2.0] // 故障强度
uniform float glowIntensity; // = 1.2 [0.0, 3.0] // 扫描光带辉光强度
uniform float swayAmount; // = 0.012 [0.0, 0.05] // 光带横向摆动幅度（UV）
uniform float tearBlur; // = 1.0 [0.0, 2.0] // 纵向撕裂模糊强度

varying vec2 vUv;

float tween(float p) {
    return 3.0 * p * p - 2.0 * p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec4 verticalTearBlur(vec2 uv, float radiusUv, float strength) {
    if (strength <= 0.0001) return texture2D(tDiffuse, uv);
    vec2 o = vec2(0.0, radiusUv * strength);
    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv - o * 1.0)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - o * 0.6)) * 0.18;
    c += texture2D(tDiffuse, handleUVBounds(uv - o * 0.3)) * 0.20;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.20;
    c += texture2D(tDiffuse, handleUVBounds(uv + o * 0.3)) * 0.16;
    c += texture2D(tDiffuse, handleUVBounds(uv + o * 0.7)) * 0.09;
    c += texture2D(tDiffuse, handleUVBounds(uv + o * 1.1)) * 0.05;
    return c;
}

vec3 applyContrastBrightness(vec3 col, float contrast, float brightness) {
    col = (col - 0.5) * contrast + 0.5;
    col *= brightness;
    return clamp(col, 0.0, 1.0);
}

vec3 scanColor(float t) {
    vec3 purple = vec3(0.72, 0.22, 1.0);
    vec3 orange = vec3(1.0, 0.56, 0.12);
    return mix(purple, orange, clamp(t, 0.0, 1.0));
}

vec4 effect(vec4 texel, float p) {
    float p1 = p;
    float p2 = clamp((p - 0.04) / 0.96, 0.0, 1.0);
    float p3 = clamp((p - 0.08) / 0.92, 0.0, 1.0);

    float y1 = -0.0625 + p1 * 1.125;
    float y2 = -0.0625 + p2 * 1.125;
    float y3 = -0.0625 + p3 * 1.125;

    float sx1 = 0.16 + sin((p1 * 9.3 + 0.1) * 6.2831853) * swayAmount;
    float sx2 = 0.50 + sin((p2 * 8.7 + 0.4) * 6.2831853) * swayAmount;
    float sx3 = 0.84 + sin((p3 * 9.9 + 0.7) * 6.2831853) * swayAmount;

    float bandHalf = 0.0625;
    float trackHalf = 0.19;

    float by1 = 1.0 - smoothstep(bandHalf, bandHalf + 0.02, abs(vUv.y - y1));
    float by2 = 1.0 - smoothstep(bandHalf, bandHalf + 0.02, abs(vUv.y - y2));
    float by3 = 1.0 - smoothstep(bandHalf, bandHalf + 0.02, abs(vUv.y - y3));

    float bx1 = 1.0 - smoothstep(trackHalf, trackHalf + 0.12, abs(vUv.x - sx1));
    float bx2 = 1.0 - smoothstep(trackHalf, trackHalf + 0.12, abs(vUv.x - sx2));
    float bx3 = 1.0 - smoothstep(trackHalf, trackHalf + 0.12, abs(vUv.x - sx3));

    float band1 = by1 * bx1;
    float band2 = by2 * bx2;
    float band3 = by3 * bx3;
    float bandMask = clamp(band1 + band2 + band3, 0.0, 1.0);

    float clean1 = step(vUv.y, y1 - bandHalf);
    float clean2 = step(vUv.y, y2 - bandHalf);
    float clean3 = step(vUv.y, y3 - bandHalf);
    float cleanMask = clamp(max(clean1, max(clean2, clean3)), 0.0, 1.0);

    float recover = clamp(max(cleanMask, p), 0.0, 1.0);
    float glitchStrength = (1.0 - recover) * glitchAmount;

    float nearBand = 0.0;
    nearBand += (1.0 - smoothstep(bandHalf, bandHalf + 0.06, abs(vUv.y - y1))) * bx1;
    nearBand += (1.0 - smoothstep(bandHalf, bandHalf + 0.06, abs(vUv.y - y2))) * bx2;
    nearBand += (1.0 - smoothstep(bandHalf, bandHalf + 0.06, abs(vUv.y - y3))) * bx3;
    nearBand = clamp(nearBand, 0.0, 1.0);

    float lineNoise = hash(vec2(floor(vUv.y * 260.0), floor(p * 180.0)));
    float tearShift = (lineNoise - 0.5) * 0.03 * glitchStrength;
    vec2 baseUV = handleUVBounds(vUv + vec2(tearShift, 0.0));

    float blurRadiusUv = (30.0 / 1080.0) * tearBlur;
    float blurStrength = clamp(glitchStrength * (0.35 + 0.65 * nearBand), 0.0, 1.0);
    vec4 blurred = verticalTearBlur(baseUV, blurRadiusUv, blurStrength);

    float ca = 0.008 * glitchStrength;
    vec2 caVec = vec2(ca * (0.5 + lineNoise), 0.0);
    vec2 uvR = handleUVBounds(baseUV + caVec);
    vec2 uvG = baseUV;
    vec2 uvB = handleUVBounds(baseUV - caVec);

    vec3 rgbShift = vec3(
        texture2D(tDiffuse, uvR).r,
        texture2D(tDiffuse, uvG).g,
        texture2D(tDiffuse, uvB).b
    );

    vec3 glitched = mix(blurred.rgb, rgbShift, clamp(glitchStrength * 0.9, 0.0, 1.0));

    float contrast = mix(0.5, 1.0, recover);
    float brightness = mix(2.2, 1.0, recover);
    vec3 col = applyContrastBrightness(glitched, contrast, brightness);

    float glowFade = (1.0 - p);
    vec3 glowCol = vec3(0.0);
    glowCol += scanColor(vUv.x + p1 * 0.3) * band1;
    glowCol += scanColor(vUv.x + p2 * 0.35 + 0.2) * band2;
    glowCol += scanColor(vUv.x + p3 * 0.4 + 0.4) * band3;
    col += glowCol * glowIntensity * glowFade * 0.45;

    float dissolve = (1.0 - p) * smoothstep(0.85, 1.0, p);
    float px = step(0.82, hash(floor(vUv * vec2(220.0, 220.0)) + vec2(p * 40.0, p * 17.0)));
    col = mix(col, col * (0.75 + 0.25 * px), dissolve * bandMask);

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