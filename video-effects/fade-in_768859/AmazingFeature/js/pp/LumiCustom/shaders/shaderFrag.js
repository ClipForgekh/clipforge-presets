exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float bandDensity; // = 120.0 [40.0, 240.0] // 噪声条纹密度
uniform float glitchStrength; // = 0.8 [0.0, 2.0] // 故障强度倍率
uniform vec3 noiseTint; // = vec3(0.2, 0.8, 1.0) // 噪声高光色

varying vec2 vUv;

float tween(float progress) {
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.14159265));
}

float hash21(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float rawProgress = progress;
    float revealBase = smoothstep(0.12, 0.72, rawProgress);
    float noiseEnvelope = pow(max(1.0 - rawProgress, 0.0), 1.25);
    float density = mix(bandDensity, bandDensity * 0.35, rawProgress);
    float row = floor(vUv.y * density + 0.5);
    float stripesEnergy = 0.0;
    vec2 glitchOffset = vec2(0.0);

    for (int i = 0; i < 3; ++i) {
        float fi = float(i);
        float localDensity = density * (0.45 + 0.28 * fi);
        float speed = 0.7 + fi * 0.55;
        float phase = fract(vUv.y * localDensity - rawProgress * speed - fi * 0.37);
        float dist = abs(phase - 0.5);
        float band = exp(-dist * (95.0 + fi * 35.0));
        stripesEnergy = max(stripesEnergy, band);
        float directionSeed = hash21(vec2(row + fi * 17.0, fi * 11.0)) - 0.5;
        glitchOffset.x += directionSeed * band;
    }
    glitchOffset.x *= 0.012 * glitchStrength * noiseEnvelope;

    float jitterSeed = hash21(vec2(row, floor(rawProgress * 220.0)));
    float jitterSeedB = hash21(vec2(row + 19.0, floor(rawProgress * 260.0)));
    float jitterInterval = step(0.88, hash21(vec2(floor(rawProgress * 38.0), row * 0.37)));
    vec2 jitter = vec2(jitterSeed - 0.5, jitterSeedB - 0.5);
    glitchOffset += jitter * (0.0032 * glitchStrength * noiseEnvelope * jitterInterval);
    glitchOffset.y += (hash21(vec2(row * 0.73, 7.0)) - 0.5) * 0.0015 * glitchStrength * noiseEnvelope / max(ratio, 1.0);

    vec2 distortedUV = vUv + glitchOffset;
    distortedUV = handleUVBounds(distortedUV);

    vec4 baseSample = texture2D(tDiffuse, distortedUV);

    float pulse = stripesEnergy * noiseEnvelope * glitchStrength;
    vec2 channelShift = vec2(0.0022 * pulse / max(ratio, 1.0), 0.0);
    vec4 sampleR = texture2D(tDiffuse, handleUVBounds(distortedUV + channelShift));
    vec4 sampleB = texture2D(tDiffuse, handleUVBounds(distortedUV - channelShift));
    vec3 glitchColor = vec3(sampleR.r, baseSample.g, sampleB.b);

    float staticSeed = hash21(vec2(floor(vUv.x * density), row + floor(rawProgress * 160.0)));
    vec3 noiseColor = mix(noiseTint, vec3(staticSeed), 0.6) * (0.6 + 0.4 * staticSeed) * (noiseEnvelope * glitchStrength + 0.05);

    float stripesReveal = stripesEnergy * (1.0 - revealBase);
    float reveal = clamp(revealBase + stripesReveal, 0.0, 1.0);

    float sweepPhase = clamp((rawProgress - 0.85) / 0.15, 0.0, 1.0);
    float sweepCenter = mix(-0.2, 1.2, sweepPhase);
    float sweepLine = exp(-pow((vUv.x - sweepCenter), 2.0) * 320.0);
    float sweepStrength = sweepLine * sweepPhase * (1.0 - smoothstep(0.97, 1.0, rawProgress));
    reveal = min(1.0, reveal + sweepStrength * 0.85);
    glitchColor += noiseTint * sweepStrength * 0.45;

    vec3 combinedColor = mix(noiseColor, glitchColor, reveal);
    combinedColor = mix(combinedColor, texel.rgb, pow(reveal, 1.5));
    combinedColor = clamp(combinedColor, 0.0, 1.0);

    float alpha = texel.a * reveal;

    return vec4(combinedColor, alpha);
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