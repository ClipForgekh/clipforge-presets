exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurMax; // = 0.03 [0.005, 0.08] // 起始最大模糊强度
uniform float whiteWash; // = 0.92 [0.0, 1.0] // 起始白雾强度
uniform float haloStrength; // = 0.6 [0.0, 2.0] // 边缘光晕强度
uniform float glowStrength; // = 0.18 [0.0, 1.0] // LumiS_Glow低预设强度
uniform float edgeSensitivity; // = 1.2 [0.2, 3.0] // 边缘检测灵敏度

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 blur9(sampler2D tex, vec2 uv, float r) {
    vec2 stepUV = vec2(r, r / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2(-1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 0.0, -1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2(-1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 0.0,  0.0))) * 4.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2(-1.0,  1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 0.0,  1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 1.0,  1.0))) * 1.0;
    return c / 16.0;
}

float easeOutSine(float p) {
    return sin(p * 1.57079632679);
}

float easeOutQuint(float p) {
    float x = 1.0 - p;
    return 1.0 - x * x * x * x * x;
}

float luma(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

float edgeMask(vec2 uv) {
    vec2 e = vec2(0.0012 * edgeSensitivity, 0.0012 * edgeSensitivity / max(ratio, 0.0001));
    float lC = luma(texture2D(tDiffuse, handleUVBounds(uv)).rgb);
    float lL = luma(texture2D(tDiffuse, handleUVBounds(uv - vec2(e.x, 0.0))).rgb);
    float lR = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2(e.x, 0.0))).rgb);
    float lU = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, e.y))).rgb);
    float lD = luma(texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, e.y))).rgb);
    float g = length(vec2(lR - lL, lU - lD)) + abs(lC - 0.25 * (lL + lR + lU + lD));
    return clamp(g * 4.0, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float p = clamp(progress, 0.0, 1.0);

    float tFocusEnd = 1.3 / 1.9;
    float tClearStart = 1.15 / 1.9;
    float tClearEnd = 1.7 / 1.9;
    float tHaloFadeStart = 1.6 / 1.9;
    float tHaloFadeEnd = 1.85 / 1.9;
    float tGlowStart = 0.2 / 1.9;
    float tGlowEnd = 1.0 / 1.9;

    float focusP = clamp(p / tFocusEnd, 0.0, 1.0);
    float clearP = clamp((p - tClearStart) / (tClearEnd - tClearStart), 0.0, 1.0);

    float focusEase = easeOutSine(focusP);
    float clearEase = easeOutQuint(clearP);

    float eMask = edgeMask(vUv);
    float sharpMix = clamp(mix(clearEase, focusEase, eMask), 0.0, 1.0);
    float blurAmt = blurMax * (1.0 - sharpMix);

    vec4 bWide = blur9(tDiffuse, vUv, blurAmt);
    vec4 bTight = blur9(tDiffuse, vUv, blurAmt * 0.35);

    float whiteAmt = whiteWash * (1.0 - focusEase) * (1.0 - clearEase);
    vec3 col = mix(bWide.rgb, vec3(1.0), clamp(whiteAmt, 0.0, 1.0));

    float ringPulse = exp(-pow((focusP - 0.45) / 0.22, 2.0)) * (1.0 - smoothstep(0.9, 1.0, focusP));
    vec3 highFreq = max(texel.rgb - bTight.rgb, 0.0);
    vec3 ringHalo = highFreq * eMask * haloStrength * ringPulse;

    float faintHalo = (1.0 - smoothstep(tHaloFadeStart, tHaloFadeEnd, p)) * smoothstep(0.75, 0.88, p);
    vec3 tailHalo = highFreq * eMask * haloStrength * 0.22 * faintHalo;

    float glowWin = smoothstep(tGlowStart, tGlowStart + 0.03, p) * (1.0 - smoothstep(tGlowEnd - 0.03, tGlowEnd, p));
    vec3 bright = max(texel.rgb - vec3(0.7), vec3(0.0));
    vec3 glow = blur9(tDiffuse, vUv, 0.01).rgb * bright * glowStrength * glowWin;

    vec3 resolved = mix(col, texel.rgb, sharpMix);
    vec3 finalRgb = clamp(resolved + ringHalo + tailHalo + glow, 0.0, 1.0);

    return vec4(finalRgb, texel.a);
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