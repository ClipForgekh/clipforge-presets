exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float refractionStrength; // = 0.045 [0.0, 0.12] // 水体折射强度
uniform float waveWidth; // = 0.18 [0.05, 0.45] // 压力波厚度
uniform float rippleStrength; // = 0.015 [0.0, 0.04] // 终态余波强度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float progress) {
    float intensity = 1.0 - progress;
    vec2 center = vec2(0.5);
    vec2 sdfCoord = getSDFCoordinate(vUv, center);
    float dist = length(sdfCoord);
    float maxDist = length(getSDFCoordinate(vec2(1.0, 1.0), center));
    maxDist = max(maxDist, 0.0001);
    float normalizedDist = dist / maxDist;

    float frontWidth = max(waveWidth, 0.0001);
    float waveFront = progress;
    float signedDistance = normalizedDist - waveFront;
    float gaussian = exp(-pow(signedDistance / frontWidth, 2.0));
    float waveFrequency = 10.0 + intensity * 6.0;

    vec2 radialDir = dist > 1e-5 ? sdfCoord / dist : vec2(0.0);
    vec2 tangentDir = vec2(-radialDir.y, radialDir.x);

    float amplitudeBase = refractionStrength * (0.6 + 1.8 * intensity);
    vec2 waveOffset = radialDir * sin(signedDistance * waveFrequency) * gaussian * amplitudeBase * 1.8 * intensity;
    vec2 compressionOffset = tangentDir * cos(signedDistance * waveFrequency * 0.6) * gaussian * amplitudeBase * 0.6 * intensity;

    float claritySpread = frontWidth * 3.0 + 1e-4;
    float postWaveClarity = clamp((waveFront - normalizedDist) / claritySpread, 0.0, 1.0);

    vec2 causticCoord = vUv * (6.0 + intensity * 5.0);
    float causticPhase = progress * 4.0;
    vec2 causticOffset = vec2(
        sin(causticCoord.y + causticPhase) + cos(causticCoord.x * 0.6 - causticPhase),
        cos(causticCoord.x + causticPhase * 1.3) - sin(causticCoord.y * 0.8 + causticPhase * 0.6)
    ) * amplitudeBase * 0.35 * intensity * (1.0 - 0.7 * postWaveClarity);

    float finalRippleWindow = smoothstep(0.6, 0.85, progress) * (1.0 - progress);
    float finalRipple = sin(normalizedDist * 12.0 - progress * 8.0) * finalRippleWindow * rippleStrength;
    vec2 finalRippleOffset = radialDir * finalRipple;

    vec2 totalOffset = waveOffset + compressionOffset + causticOffset + finalRippleOffset;
    vec2 warpedUV = handleUVBounds(vUv + totalOffset);

    float blurMagnitude = 0.0015 + 0.0045 * intensity;
    vec2 blurStep = vec2(blurMagnitude, blurMagnitude / ratio);
    vec4 sharpSample = texture2D(tDiffuse, warpedUV);
    vec4 softSample = (
        sharpSample +
        texture2D(tDiffuse, handleUVBounds(warpedUV + blurStep)) +
        texture2D(tDiffuse, handleUVBounds(warpedUV - blurStep)) +
        texture2D(tDiffuse, handleUVBounds(warpedUV + vec2(blurStep.x, -blurStep.y))) +
        texture2D(tDiffuse, handleUVBounds(warpedUV - vec2(blurStep.x, -blurStep.y)))
    ) * 0.2;

    float clarityFactor = max(progress, postWaveClarity);
    vec4 color = mix(softSample, sharpSample, clarityFactor);
    float highlight = clamp(gaussian * intensity * 0.45, 0.0, 1.0);
    vec3 causticTint = vec3(0.05, 0.09, 0.12);
    color.rgb = mix(color.rgb, color.rgb + causticTint, highlight);
    color.a = texel.a;

    return color;
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