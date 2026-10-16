exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float stripMinOffset; // = 0.12 [0.05, 0.30] // 第一阶段条带最小位移（UV）
uniform float stripMaxOffset; // = 0.16 [0.08, 0.35] // 第一阶段条带最大位移（UV）
uniform float farMinOffset; // = 1.30 [0.80, 2.50] // 第二阶段条带最小远离位移（UV）
uniform float farMaxOffset; // = 1.90 [1.00, 3.00] // 第二阶段条带最大远离位移（UV）
uniform float maxBlur; // = 0.020 [0.0, 0.08] // 最大模糊强度
uniform float splitStrength; // = 0.012 [0.0, 0.05] // LumiSplit强度（leftWide）
uniform float chromaStrength; // = 0.003 [0.0, 0.02] // 色差强度（低）

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash1(float n) {
    return fract(sin(n * 127.1) * 43758.5453123);
}

float easeExpoInOut(float x) {
    if (x <= 0.0) return 0.0;
    if (x >= 1.0) return 1.0;
    return (x < 0.5)
        ? 0.5 * pow(2.0, 20.0 * x - 10.0)
        : 1.0 - 0.5 * pow(2.0, -20.0 * x + 10.0);
}

float easeQuadOut(float x) {
    x = clamp(x, 0.0, 1.0);
    return 1.0 - (1.0 - x) * (1.0 - x);
}

vec4 blur5(vec2 uv, float amount, float dir) {
    vec2 o = vec2(amount * dir, 0.0);
    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv - 2.0 * o)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - 1.0 * o)) * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.30;
    c += texture2D(tDiffuse, handleUVBounds(uv + 1.0 * o)) * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv + 2.0 * o)) * 0.12;
    return c;
}

vec4 effect(vec4 texel, float p) {
    const float sMoveStart = 0.1 / 1.8;
    const float sMoveMid   = 0.9 / 1.8;
    const float sSplitStart= 0.4 / 1.8;
    const float sSplitEnd  = 1.0 / 1.8;
    const float sAccelEnd  = 1.5 / 1.8;
    const float sEnd       = 1.0;

    float idx = floor(vUv.y * 6.0);
    float dir = (mod(idx, 2.0) < 0.5) ? -1.0 : 1.0;

    float hA = hash1(idx + 1.31);
    float hB = hash1(idx + 4.77);
    float hS1 = hash1(idx + 2.19);
    float hS2 = hash1(idx + 6.03);

    float nearAmp = mix(stripMinOffset, stripMaxOffset, hA);
    float farAmp  = mix(farMinOffset, farMaxOffset, hB);

    float tA = easeExpoInOut(clamp((p - sMoveStart) / (sMoveMid - sMoveStart), 0.0, 1.0));
    float tB = easeExpoInOut(clamp((p - sMoveMid) / (sAccelEnd - sMoveMid), 0.0, 1.0));

    tA = clamp(tA * mix(0.92, 1.14, hS1), 0.0, 1.0);
    tB = clamp(tB * mix(0.95, 1.22, hS2), 0.0, 1.0);

    float offsetX = dir * (nearAmp * tA + (farAmp - nearAmp) * tB);

    vec2 srcUV = vUv;
    srcUV.x -= offsetX;

    float inBounds = getHardBoundaryMask(srcUV);

    float blurT = easeQuadOut(clamp((p - sMoveMid) / (sAccelEnd - sMoveMid), 0.0, 1.0));
    float blurAmount = maxBlur * blurT;

    vec4 col = blur5(srcUV, blurAmount, dir);

    float splitActive = smoothstep(sSplitStart, sSplitStart + 0.04, p) * (1.0 - smoothstep(sSplitEnd - 0.04, sSplitEnd, p));
    float splitAmt = splitStrength * splitActive;
    float caAmt = chromaStrength * splitActive;

    if (splitActive > 0.0) {
        float leftWide = -splitAmt * 1.5;
        vec2 rUV = handleUVBounds(srcUV + vec2(leftWide + caAmt * dir, 0.0));
        vec2 gUV = handleUVBounds(srcUV + vec2(leftWide * 0.6, 0.0));
        vec2 bUV = handleUVBounds(srcUV + vec2(leftWide - caAmt * dir, 0.0));

        float r = texture2D(tDiffuse, rUV).r;
        float g = texture2D(tDiffuse, gUV).g;
        float b = texture2D(tDiffuse, bUV).b;

        col.rgb = mix(col.rgb, vec3(r, g, b), 0.7);
    }

    float fadeOut = 1.0 - smoothstep(sAccelEnd, sEnd, p);
    float alpha = col.a * inBounds * fadeOut;

    return vec4(col.rgb, alpha);
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