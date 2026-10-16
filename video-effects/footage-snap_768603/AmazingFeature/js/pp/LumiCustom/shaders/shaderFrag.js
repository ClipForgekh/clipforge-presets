exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float chromaSeparation; // = 0.015 [0.0, 0.05] // RGB分离强度
uniform float distortionStrength; // = 0.08 [0.0, 0.2] // VHS扭曲幅度

varying vec2 vUv;

float tween(float progress) {
    float p = clamp(progress, 0.0, 1.0);
    float fastOut = 1.0 - pow(1.0 - p, 2.0);
    float elastic = fastOut + 0.08 * sin(p * 6.2831853 * 1.4) * exp(-p * 5.5);
    return clamp(mix(fastOut, elastic, smoothstep(0.15, 0.55, p)), 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float getSoftBoundaryMask(vec2 uv, float borderSize) {
    vec2 mask = smoothstep(vec2(0.0), vec2(borderSize), uv) * (1.0 - smoothstep(vec2(1.0 - borderSize), vec2(1.0), uv));
    return mask.x * mask.y;
}

vec4 effect(vec4 texel, float progress) {
    float stage1End = 0.18;
    float stage2End = 0.42;
    float stage3End = 0.65;

    float stage1 = clamp(progress / (stage1End + 1e-5), 0.0, 1.0);
    float stage2 = clamp((progress - stage1End) / (stage2End - stage1End + 1e-5), 0.0, 1.0);
    float stage3 = clamp((progress - stage2End) / (stage3End - stage2End + 1e-5), 0.0, 1.0);
    float finalPhase = clamp((progress - stage3End) / (1.0 - stage3End + 1e-5), 0.0, 1.0);

    float centerDistance = abs(vUv.y - 0.5);
    float lineWidth = mix(0.0015, 0.5, stage1);
    float lineFalloff = exp(-pow(centerDistance / (lineWidth + 1e-4), 2.0));
    float revealMask = mix(lineFalloff, 1.0, stage1);

    float baseScale = mix(0.25, 0.92, stage1);
    float stretchTarget = mix(baseScale, 1.08, stage2);
    float elasticSwing = (1.0 - stage3) * 0.07 * sin(stage2 * 6.2831853 * 1.3) * exp(-stage2 * 3.0);
    float scaleX = clamp(mix(stretchTarget + elasticSwing, 1.0, stage3), 0.05, 1.2);
    scaleX = mix(scaleX, 1.0, finalPhase);

    vec2 centered = vUv - 0.5;
    centered.x *= scaleX;
    vec2 stretchedUV = centered + 0.5;

    float distortEnvelope = clamp(1.0 - stage3 * 0.9 - finalPhase * 0.8, 0.0, 1.0);

    float waveHigh = sin((stretchedUV.y + progress * 0.6) * 150.0);
    float waveLow = sin(stretchedUV.y * 40.0 + progress * 18.0);
    float jitterNoise = fract(sin((stretchedUV.y + progress) * 350.0) * 43758.5453) - 0.5;

    float glitch1 = exp(-pow((progress - 0.22) / 0.015, 2.0));
    float glitch2 = exp(-pow((progress - 0.30) / 0.012, 2.0));
    float glitch3 = exp(-pow((progress - 0.36) / 0.017, 2.0));
    float glitchPulse = glitch1 + glitch2 + glitch3;

    float horizontalOffset = distortionStrength * distortEnvelope * (waveHigh * 0.0025 + waveLow * 0.0035 + jitterNoise * 0.002);
    horizontalOffset += (1.0 - finalPhase) * sin(progress * 70.0) * 0.004;
    horizontalOffset += glitchPulse * (0.03 + distortionStrength * 0.6);
    horizontalOffset += (1.0 - stage3) * 0.002 * sin(progress * 420.0 + stretchedUV.y * 900.0);

    vec2 warpedUV = stretchedUV + vec2(horizontalOffset, 0.0);
    warpedUV.y += distortionStrength * distortEnvelope * 0.002 * sin(stretchedUV.x * 80.0 + progress * 35.0);

    vec2 boundedUV = handleUVBounds(warpedUV);

    float separationEnvelope = (1.0 - finalPhase) * (0.6 + 0.4 * (1.0 - stage3));
    float separation = chromaSeparation * separationEnvelope + glitchPulse * 0.02;

    vec4 sampleCenter = texture2D(tDiffuse, boundedUV);
    vec4 sampleR = texture2D(tDiffuse, handleUVBounds(boundedUV + vec2(separation, 0.0)));
    vec4 sampleB = texture2D(tDiffuse, handleUVBounds(boundedUV - vec2(separation, 0.0)));
    vec3 colorRGB = vec3(sampleR.r, sampleCenter.g, sampleB.b);

    float noiseSeed = dot(boundedUV, vec2(12.9898, 78.233)) + progress * 135.123;
    float grain = fract(sin(noiseSeed) * 43758.5453) - 0.5;
    float flickerWindow = smoothstep(0.65, 0.8, progress) * (1.0 - smoothstep(0.9, 1.0, progress));
    vec3 flicker = vec3(grain) * 0.04 * flickerWindow;
    colorRGB += flicker;

    vec3 lineColor = vec3(0.7, 0.95, 1.2) * lineFalloff * (1.0 - stage1) * 0.6;

    vec3 finalColor = mix(vec3(0.0), colorRGB, revealMask);
    finalColor += lineColor;
    finalColor = clamp(finalColor, 0.0, 1.0);

    float lineAlpha = clamp(lineFalloff * (1.0 - stage1) * 0.8, 0.0, 1.0);
    float borderMask = getHardBoundaryMask(warpedUV);
    float finalAlpha = clamp((max(revealMask, lineAlpha)) * texel.a * borderMask, 0.0, 1.0);
    finalColor *= borderMask;

    return vec4(finalColor, finalAlpha);
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