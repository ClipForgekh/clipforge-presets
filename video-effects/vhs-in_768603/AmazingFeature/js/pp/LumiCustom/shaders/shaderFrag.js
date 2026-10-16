exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float bandCompression; // = 0.035 [0.01, 0.2] // 初始频带压缩高度
uniform float overshootAmount; // = 0.16 [0.0, 0.35] // 横向过冲强度
uniform float chromaAmount; // = 0.01 [0.0, 0.05] // 色散强度
uniform float scanlineAmount; // = 0.015 [0.0, 0.05] // 扫描线抖动强度
uniform float frequencySeparation; // = 0.03 [0.0, 0.1] // 频段横向分离强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float expandPhase = smoothstep(0.08, 0.22, p);
    float correctPhase = smoothstep(0.38, 0.72, p);
    float finalRelax = 1.0 - smoothstep(0.75, 1.0, p);

    float yScale = mix(bandCompression, 1.0, expandPhase);
    yScale = yScale + (1.12 - yScale) * expandPhase * (1.0 - correctPhase);
    yScale = mix(yScale, 1.0, correctPhase);

    float xScale = 1.0 + overshootAmount * expandPhase * (1.0 - correctPhase);
    xScale = mix(xScale, 1.0, correctPhase);

    vec2 uv = vUv - 0.5;
    uv.x /= xScale;
    uv.y /= max(yScale, 0.0001);
    uv += 0.5;

    float sep = frequencySeparation * expandPhase * (1.0 - correctPhase) * finalRelax;
    float stripe = sin((vUv.y * 420.0 / max(ratio, 0.0001)) + p * 36.0);
    float jitter = stripe * scanlineAmount * (1.0 - p) * finalRelax;

    uv.x += sep * sin((vUv.y - 0.5) * 90.0 + p * 20.0);
    uv.x += jitter;

    float bandHalf = mix(0.04, 0.5, expandPhase);
    float bandMask = smoothstep(bandHalf + 0.02, bandHalf - 0.02, abs(vUv.y - 0.5));
    bandMask = mix(bandMask, 1.0, correctPhase);

    float chroma = chromaAmount * (1.0 - p) * finalRelax;
    vec2 uvR = handleUVBounds(uv + vec2(chroma, 0.0));
    vec2 uvG = handleUVBounds(uv);
    vec2 uvB = handleUVBounds(uv - vec2(chroma, 0.0));

    float borderMask = getHardBoundaryMask(uv);

    vec4 rS = texture2D(tDiffuse, uvR);
    vec4 gS = texture2D(tDiffuse, uvG);
    vec4 bS = texture2D(tDiffuse, uvB);

    vec3 col = vec3(rS.r, gS.g, bS.b);
    col *= (0.96 + 0.04 * stripe * finalRelax);

    vec4 outColor = vec4(col, texel.a * bandMask * borderMask);
    return mix(outColor, texel, smoothstep(0.94, 1.0, p));
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