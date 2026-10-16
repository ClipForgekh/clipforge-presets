exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float glitchAmount; // = 0.35 [0.0, 1.0] // 数字噪声偏移强度
uniform float bandComplexity; // = 18.0 [6.0, 40.0] // 水平噪声带密度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec2 hash2(vec2 p) {
    float n = hash(p);
    float m = hash(p + 19.19);
    return vec2(n, m);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float reveal = smoothstep(0.0, 0.85, progress);
    float noiseStrength = pow(1.0 - progress, 1.2);
    float density = mix(bandComplexity * 1.4, bandComplexity * 0.7, progress);

    float phaseA = fract(vUv.y * density + progress * mix(6.5, 1.2, progress));
    float phaseB = fract(vUv.y * density * 0.6 + progress * mix(3.8, 0.9, progress) + 0.23);
    float phaseC = fract(vUv.y * density * 1.8 - progress * mix(9.0, 1.5, progress * progress));

    float bandA = smoothstep(0.0, 0.04, phaseA) * smoothstep(1.0, 0.96, phaseA);
    float bandB = smoothstep(0.0, 0.05, phaseB) * smoothstep(1.0, 0.95, phaseB);
    float bandC = smoothstep(0.0, 0.03, phaseC) * smoothstep(1.0, 0.97, phaseC);

    float bandPattern = clamp(bandA + bandB * 0.8 + bandC * 0.6, 0.0, 1.0);
    float sync = smoothstep(0.7, 1.0, progress);
    float alignedPhase = fract(vUv.y * density * 0.9 + progress * 0.8);
    float alignedBand = smoothstep(0.0, 0.07, alignedPhase) * smoothstep(1.0, 0.93, alignedPhase);
    bandPattern = mix(bandPattern, alignedBand, sync);

    float screenNoise = hash(vec2(floor(vUv.y * 720.0), floor(progress * 360.0)));
    screenNoise = mix(screenNoise, hash(vec2(floor(vUv.x * 960.0), floor(progress * 540.0))), 0.4);

    float segment = floor(progress * 6.0);
    float pulsePhase = fract(progress * 6.0);
    float pulseWindow = smoothstep(0.0, 0.25, pulsePhase) * smoothstep(1.0, 0.75, pulsePhase);
    float pulseRandom = hash(vec2(segment, 9.37));
    float majorPulse = pulseWindow * pulseRandom * (1.0 - progress);

    vec2 jitterSeed = vec2(floor(vUv.y * (density * 1.5)), floor(progress * 120.0));
    vec2 jitter = hash2(jitterSeed) - 0.5;
    float jitterWindow = smoothstep(0.0, 0.2, fract(progress * 12.0)) * smoothstep(1.0, 0.6, fract(progress * 12.0));

    vec2 glitchOffset = vec2(
        jitter.x * noiseStrength * glitchAmount * (1.5 + bandPattern * 3.0 + majorPulse * 4.0) +
        (hash(vec2(segment, floor(vUv.y * density * 0.5))) - 0.5) * jitterWindow * glitchAmount * 0.12,
        (jitter.y - 0.5) * noiseStrength * 0.03
    );

    vec2 distortedUV = vUv + glitchOffset;
    vec2 safeUV = handleUVBounds(distortedUV);

    vec2 channelSeed = vec2(segment + 13.7, floor(vUv.y * 24.0));
    vec2 channelShift = (hash2(channelSeed) - 0.5) * 0.012 * glitchAmount * (noiseStrength + majorPulse * 3.0);
    vec2 uvR = handleUVBounds(distortedUV + channelShift);
    vec2 uvB = handleUVBounds(distortedUV - channelShift);

    vec4 sampleBase = texture2D(tDiffuse, safeUV);
    vec4 sampleR = texture2D(tDiffuse, uvR);
    vec4 sampleB = texture2D(tDiffuse, uvB);

    vec3 channelColor = vec3(sampleR.r, sampleBase.g, sampleB.b);

    vec3 noiseTint = mix(vec3(0.01, 0.05, 0.10), vec3(0.15, 0.65, 0.95), screenNoise + bandPattern * 0.5);
    float bandReveal = clamp(reveal + bandPattern * (1.0 - reveal) * 0.8, 0.0, 1.0);
    vec3 mixedColor = mix(noiseTint, channelColor, bandReveal);

    float waveProgress = smoothstep(0.82, 1.0, progress);
    float waveFade = 1.0 - smoothstep(0.98, 1.0, progress);
    float waveY = mix(-0.2, 1.2, waveProgress);
    float waveLine = exp(-abs(vUv.y - waveY) * 180.0) * waveFade;
    mixedColor += waveLine * vec3(0.25, 0.45, 0.8) * waveFade;

    float clarity = smoothstep(0.9, 1.0, progress);
    mixedColor = mix(mixedColor, channelColor, clarity);
    mixedColor = clamp(mixedColor, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(vUv);
    float finalAlpha = texel.a * borderMask;

    return vec4(mixedColor, finalAlpha);
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