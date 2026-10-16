exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float bandThickness; // = 0.18 [0.05, 0.35] // 跟踪扰动带宽度
uniform float warpStrength; // = 0.06 [0.0, 0.2] // 最大水平形变强度
uniform float noiseIntensity; // = 0.4 [0.0, 1.0] // 磁带噪声强度

varying vec2 vUv;

float tween(float progress) {
    return 3.0 * progress * progress - 2.0 * progress * progress * progress;
}

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float sweepProgress = clamp(progress / 0.75, 0.0, 1.0);
    float settlePhase = smoothstep(0.75, 1.0, progress);
    float bandFeather = bandThickness * 0.35;
    float front = mix(-bandFeather, 1.0 + bandFeather, sweepProgress);
    float revealMask = smoothstep(-bandFeather, bandFeather, front - vUv.y);
    float bandCenter = front - bandThickness * 0.5;
    float bandBlend = clamp(1.0 - abs(vUv.y - bandCenter) / max(bandThickness, 0.0001), 0.0, 1.0);
    float bandProfile = smoothstep(0.0, 1.0, bandBlend);
    float travelDecay = mix(1.0, 0.2, sweepProgress);
    float dynamicEnvelope = 1.0 - settlePhase;
    float trackingStrength = bandProfile * travelDecay * dynamicEnvelope;
    float fineWave = sin(vUv.y * 240.0 + progress * 24.0);
    float midWave = sin(vUv.y * 48.0 - progress * 14.0);
    float lowWave = sin(vUv.y * 6.0 + progress * 6.2831853);
    float residualWaveStrength = 0.008 * (1.0 - settlePhase);
    float combinedWarp = fineWave * warpStrength * trackingStrength;
    combinedWarp += midWave * warpStrength * 0.35 * trackingStrength;
    combinedWarp += lowWave * residualWaveStrength;
    vec2 warpedUV = vUv + vec2(combinedWarp, 0.0);
    warpedUV = handleUVBounds(warpedUV);
    float chromaAmount = (warpStrength * 1.4 * trackingStrength + residualWaveStrength * 4.0) * 0.5;
    vec2 chromaOffset = vec2(chromaAmount, 0.0);
    vec4 sampleR = texture2D(tDiffuse, handleUVBounds(warpedUV + chromaOffset));
    vec4 sampleG = texture2D(tDiffuse, warpedUV);
    vec4 sampleB = texture2D(tDiffuse, handleUVBounds(warpedUV - chromaOffset));
    vec3 color = vec3(sampleR.r, sampleG.g, sampleB.b);
    float ratioFactor = ratio > 1.0 ? ratio : 1.0;
    vec2 coarseCoord = vec2(floor(vUv.x * 960.0 * ratioFactor), floor((vUv.y + progress * 0.35) * 720.0));
    float blockNoise = hash(coarseCoord);
    float lineNoise = hash(floor(vUv.y * 320.0 + progress * 960.0));
    float streakNoise = hash(vec2(floor(progress * 480.0), floor(vUv.y * 400.0)));
    float jitter = (blockNoise - 0.5) * 2.0;
    float flicker = (lineNoise - 0.5) * 2.0;
    float streak = (streakNoise - 0.5) * 2.0;
    float noiseEnvelope = (trackingStrength * 0.8 + (1.0 - progress) * 0.25) * noiseIntensity;
    vec3 noiseColor = vec3(jitter * 0.12 + flicker * 0.08 + streak * 0.05);
    color += noiseColor * noiseEnvelope;
    color = clamp(color, 0.0, 1.0);
    float scanLight = trackingStrength * 0.4;
    vec3 hiddenColor = vec3(scanLight * 0.6);
    vec3 finalRGB = mix(hiddenColor, color, revealMask);
    float finalAlpha = texel.a * revealMask;
    return vec4(finalRGB, finalAlpha);
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