exports.source=`
//===begin_frag_code===
precision highp float;

// 预定义uniform
uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

// 自定义uniform
uniform float glitchStrength; // = 0.6 [0.0, 1.0] // 整体故障强度
uniform float saturationTarget; // = 0.78 [0.5, 1.0] // 最低饱和度

varying vec2 vUv;

// Cubic.In 缓动
float tween(float p) {
    return p * p * p;
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float easedProgress) {
    float linearProgress = pow(max(easedProgress, 0.0), 1.0 / 3.0);

    const float segment1End = 0.26666668; // 0.8s
    const float segment2End = 0.6;        // 1.8s
    const float segment3End = 0.8333333;  // 2.5s

    float stage1 = clamp(linearProgress / segment1End, 0.0, 1.0);
    float stage2 = clamp((linearProgress - segment1End) / (segment2End - segment1End), 0.0, 1.0);
    float stage3 = clamp((linearProgress - segment2End) / (segment3End - segment2End), 0.0, 1.0);
    float stage4 = clamp((linearProgress - segment3End) / (1.0 - segment3End), 0.0, 1.0);

    float easedStage3 = smoothstep(0.0, 1.0, stage3);
    float easedStage4 = smoothstep(0.0, 1.0, stage4);

    vec2 distortedUV = vUv;
    float timeFactor = linearProgress * 120.0;
    float lineHash = hash(vec2(floor(distortedUV.y * 600.0), floor(timeFactor)));

    float baseWave = sin((distortedUV.y + linearProgress * 2.5) * 600.0);
    float baseOffset = (lineHash - 0.5) * (0.02 * glitchStrength * stage1 + 0.05 * glitchStrength * stage2);
    baseOffset += baseWave * 0.0025 * glitchStrength * stage1;

    float framePhase = floor(linearProgress * 120.0);
    float frameRand = hash(vec2(framePhase, 91.7));
    float tearGate = step(0.8, frameRand) * stage2;
    float bandRand = hash(vec2(framePhase, floor(distortedUV.y * 90.0)));
    float tearMask = step(0.88, bandRand) * tearGate;
    float tearOffset = (hash(vec2(framePhase, floor(distortedUV.y * 160.0))) - 0.5) * 0.18 * glitchStrength * tearMask;

    float signalDrift = (hash(vec2(framePhase, 17.3)) - 0.5) * 0.03 * glitchStrength * stage2;

    distortedUV.x += baseOffset + tearOffset + signalDrift;

    float verticalJitter = (hash(vec2(framePhase, 77.0)) - 0.5) * 0.04 * glitchStrength * stage2;
    distortedUV.y += verticalJitter;

    distortedUV = 0.5 + (distortedUV - 0.5) * (1.0 + (hash(vec2(framePhase, 131.0)) - 0.5) * 0.04 * stage2);
    distortedUV = handleUVBounds(distortedUV);

    float compressionFactor = mix(1.0, 0.06, easedStage3);
    float finalCompression = mix(compressionFactor, 0.001, easedStage4);

    vec2 centered = distortedUV - 0.5;
    centered.y *= finalCompression;
    vec2 compressedUV = handleUVBounds(centered + 0.5);

    vec4 baseColor = texture2D(tDiffuse, compressedUV);

    float gray = dot(baseColor.rgb, vec3(0.299, 0.587, 0.114));
    float stageSat = mix(1.0, saturationTarget, stage1);
    stageSat = mix(stageSat, saturationTarget * 0.6, stage2);
    baseColor.rgb = mix(vec3(gray), baseColor.rgb, stageSat);

    float signalStrength = 1.0 - (0.05 * stage1 + 0.25 * stage2 + 0.65 * easedStage3);
    signalStrength = max(signalStrength, 0.0);
    float signalVariation = mix(0.92, 1.08, hash(vec2(framePhase, 3.13)));
    baseColor.rgb *= signalStrength * signalVariation;

    float lineWidth = mix(0.4, 0.015, easedStage3);
    lineWidth = mix(lineWidth, 0.003, easedStage4);
    float lineMask = exp(-pow(abs(vUv.y - 0.5) / max(lineWidth, 0.0001), 1.3));

    vec3 lineColor = baseColor.rgb * (1.2 + 2.2 * easedStage3);
    vec3 collapsedColor = mix(baseColor.rgb, lineColor * lineMask, easedStage3);
    collapsedColor *= mix(1.0, lineMask, easedStage3);

    float blackout = easedStage4;
    collapsedColor *= (1.0 - blackout);

    float borderMask = getHardBoundaryMask(distortedUV) * (1.0 - blackout);

    vec3 finalRGB = clamp(collapsedColor, 0.0, 1.0) * borderMask;
    float finalAlpha = clamp(baseColor.a, 0.0, 1.0) * borderMask * (1.0 - blackout);

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