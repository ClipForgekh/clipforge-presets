exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

// 自定义uniform
uniform float glitchStrength; // = 1.0 [0.2, 2.5] // 整体故障位移强度
uniform float sliceDensity; // = 90.0 [30.0, 220.0] // 水平切片密度
uniform float rgbOffset; // = 0.02 [0.0, 0.08] // RGB通道最大偏移

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash12(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 78.233);
    return fract(p.x * p.y);
}

vec4 effect(vec4 texel, float progress) {
    float raw = progress;
    float earlyPhase = 1.0 - smoothstep(0.0, 0.2, raw);
    float surgePhase = smoothstep(0.2, 0.35, raw) * (1.0 - smoothstep(0.5, 0.65, raw));
    float settlePhase = smoothstep(0.5, 0.65, raw) * (1.0 - smoothstep(0.75, 0.85, raw));
    float cleanupPhase = smoothstep(0.75, 1.0, raw);
    float finalTear = exp(-pow((raw - 0.65) * 32.0, 2.0)) * settlePhase;

    float amplitude = (earlyPhase * 1.35 + surgePhase * 1.1 + settlePhase * 0.35) * glitchStrength;
    float channelSpread = (earlyPhase * 1.4 + surgePhase * 1.0 + settlePhase * 0.2 + finalTear * 1.5) * rgbOffset;
    float reductionFactor = mix(1.0, 0.12, cleanupPhase);
    amplitude *= reductionFactor;
    channelSpread *= reductionFactor;

    float bandDensity = mix(sliceDensity, sliceDensity * 0.35, raw);
    float bandIndex = floor(vUv.y * bandDensity);
    float frameSeed = floor(raw * 240.0);
    float bandNoise = hash12(vec2(bandIndex, frameSeed));
    float jitterY = (hash12(vec2(bandIndex + 1.7, frameSeed + 2.9)) - 0.5) * amplitude * 0.35;
    float offsetX = (bandNoise - 0.5) * amplitude;
    offsetX += (hash12(vec2(frameSeed + 7.3, bandIndex + 4.1)) - 0.5) * finalTear * 2.0;

    float sliceSnapStrength = clamp(earlyPhase * 0.8 + surgePhase * 1.0, 0.0, 1.0);
    float sliceStep = mix(0.06, 0.006, raw);
    float snappedX = floor((vUv.x + bandNoise * 0.03) / sliceStep) * sliceStep + sliceStep * 0.5;
    vec2 slicedUV = vec2(mix(vUv.x, snappedX, sliceSnapStrength), vUv.y);

    vec2 baseOffset = vec2(offsetX, jitterY);
    vec2 baseUV = slicedUV;

    vec2 uvR = handleUVBounds(baseUV + baseOffset + vec2(channelSpread, 0.0));
    vec2 uvG = handleUVBounds(baseUV + baseOffset - vec2(channelSpread, 0.0));
    vec2 uvB = handleUVBounds(baseUV + baseOffset);

    float r = texture2D(tDiffuse, uvR).r;
    float g = texture2D(tDiffuse, uvG).g;
    float b = texture2D(tDiffuse, uvB).b;
    vec3 imageColor = vec3(r, g, b);

    float imageReveal = clamp(smoothstep(0.18, 0.6, raw) + settlePhase * 0.5, 0.0, 1.0);

    vec3 glitchColor = mix(vec3(0.0), imageColor, imageReveal);

    float staticWeight = clamp(earlyPhase * 0.9 + surgePhase * 0.4, 0.0, 1.0);
    vec3 baseNoise = vec3(hash12(vec2(vUv.x * bandDensity * 1.8 + frameSeed, bandIndex + 0.27)));
    baseNoise = (baseNoise - 0.5) * (0.6 + 0.4 * bandNoise);
    glitchColor += baseNoise * staticWeight;

    float barSeed = hash12(vec2(frameSeed + 11.0, bandIndex));
    float barMask = step(0.88, barSeed) * (earlyPhase * 0.8 + surgePhase * 0.5);
    vec3 barColor = vec3(
        hash12(vec2(frameSeed + 0.1, bandIndex + 0.37)),
        hash12(vec2(frameSeed + 1.1, bandIndex + 0.79)),
        hash12(vec2(frameSeed + 2.1, bandIndex + 1.23))
    );
    barColor = clamp(barColor * vec3(1.6, 1.2, 1.8), 0.0, 1.0);
    glitchColor += barMask * barColor;

    glitchColor += finalTear * 0.35 * vec3(1.0, 0.6, 0.9);
    glitchColor = clamp(glitchColor, 0.0, 1.0);

    float stabilization = smoothstep(0.7, 1.0, raw);
    vec3 finalRgb = mix(glitchColor, texel.rgb, stabilization);
    float borderMask = getHardBoundaryMask(vUv);

    return vec4(finalRgb, texel.a * borderMask);
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