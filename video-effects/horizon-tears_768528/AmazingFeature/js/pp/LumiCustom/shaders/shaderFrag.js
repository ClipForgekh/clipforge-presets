exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float bandDensity; // = 9.0 [4.0, 20.0] // 撕裂带密度
uniform float tearAmplitude; // = 0.05 [0.01, 0.12] // 撕裂位移幅度
uniform float chromaStrength; // = 0.6 [0.0, 2.0] // 色散强度调节

varying vec2 vUv;

float tween(float p) {
    return p * p * p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash11(float p) {
    return fract(sin(p * 127.1) * 43758.5453123);
}

vec4 effect(vec4 texel, float effectProgress) {
    float rawProgress = clamp(progress, 0.0, 1.0);

    const float tearStart = 0.0666667;
    const float tearEnd = 0.6;
    const float chromaStart = 0.3333333;
    const float chromaEnd = 0.6333333;
    const float vanishStart = 0.6;
    const float vanishEnd = 0.7666667;
    const float blackoutStart = 0.7666667;

    float tearStrength = clamp((rawProgress - tearStart) / (tearEnd - tearStart), 0.0, 1.0);
    float vanishPhase = clamp((rawProgress - vanishStart) / (vanishEnd - vanishStart), 0.0, 1.0);
    float blackout = clamp((rawProgress - blackoutStart) / (1.0 - blackoutStart), 0.0, 1.0);

    float dynamicSlice = floor(rawProgress * 90.0);
    float bandIndex = floor(vUv.y * bandDensity + tearStrength * bandDensity * 0.5);
    float seed = bandIndex + dynamicSlice;

    float baseNoise = hash11(seed * 1.37);
    float secondaryNoise = hash11(seed * 3.17);
    float tertiaryNoise = hash11(seed * 5.71);

    float horizontalShift = (baseNoise - 0.5) * tearAmplitude * tearStrength;
    horizontalShift += (secondaryNoise - 0.5) * 0.012 * tearStrength;

    float bandPhase = fract(vUv.y * bandDensity);
    float separationStrength = smoothstep(0.2, 1.0, tearStrength);
    float aspectComp = mix(1.0, 1.0 / max(ratio, 0.0001), step(1.0, ratio));
    float verticalShift = (tertiaryNoise - 0.5) * (0.02 + 0.04 * smoothstep(0.2, 0.8, bandPhase)) * separationStrength * tearAmplitude * 1.2 * aspectComp;

    vec2 displacedUV = vUv + vec2(horizontalShift, verticalShift);

    float digitalPulse = (hash11(seed * 7.93) - 0.5) * 0.006 * tearStrength;
    digitalPulse += sin((bandPhase + rawProgress * 3.5) * 18.0) * 0.0015 * tearStrength;
    displacedUV.x += digitalPulse;

    displacedUV = handleUVBounds(displacedUV);

    vec4 baseSample = texture2D(tDiffuse, displacedUV);

    float chromaDuration = chromaEnd - chromaStart;
    float chromaNorm = clamp((rawProgress - chromaStart) / chromaDuration, 0.0, 1.0);
    float chromaPhase = chromaNorm * (1.0 - chromaNorm) * 4.0;
    float chromaMix = chromaPhase * (0.2 + 0.8 * tearStrength);

    vec2 caOffset = vec2(0.0025 * chromaMix * chromaStrength, 0.0);
    vec3 aberratedColor = vec3(
        texture2D(tDiffuse, handleUVBounds(displacedUV + caOffset)).r,
        texture2D(tDiffuse, displacedUV).g,
        texture2D(tDiffuse, handleUVBounds(displacedUV - caOffset)).b
    );
    vec3 sampleColor = mix(baseSample.rgb, aberratedColor, chromaMix);

    float dropoutNoise = hash11(seed * 9.41);
    float dropout = smoothstep(0.55, 1.05, tearStrength + dropoutNoise * 0.4 * tearStrength);
    float structuralPattern = smoothstep(0.2, 0.8, bandPhase);
    float linePattern = 0.5 + 0.5 * sin((bandPhase + baseNoise) * 31.4159 + rawProgress * 18.0);
    float bandMask = 1.0 - dropout * structuralPattern;
    bandMask *= 1.0 - smoothstep(0.45, 0.95, linePattern) * tearStrength;
    bandMask = clamp(bandMask, 0.0, 1.0);

    bandMask *= 1.0 - vanishPhase;
    bandMask = clamp(bandMask, 0.0, 1.0);

    vec3 fragmentedColor = sampleColor * bandMask;

    vec3 finalColor = mix(fragmentedColor, vec3(0.0), blackout);
    float visibleAlpha = texel.a * bandMask;
    float finalAlpha = mix(visibleAlpha, 1.0, blackout);

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