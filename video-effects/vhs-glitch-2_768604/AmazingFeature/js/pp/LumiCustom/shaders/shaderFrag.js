exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float sliceCount; // = 12.0 [4.0, 32.0] // 水平切片数量
uniform float displacement; // = 0.03 [0.0, 0.1] // 最大切片位移
uniform float channelSplit; // = 0.0025 [0.0, 0.01] // RGB通道偏移强度

varying vec2 vUv;

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

float tween(float progressValue) {
    return 1.0 - pow(1.0 - progressValue, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progressValue) {
    float p = clamp(progressValue, 0.0, 1.0);
    float effectStrength = 1.0 - p;

    float slices = max(sliceCount, 1.0);
    float sliceIdx = floor(vUv.y * slices);
    float sliceCenter = (slices - 1.0) * 0.5;
    float normalizedDistance = abs(sliceIdx - sliceCenter) / max(sliceCenter, 0.5);
    float revealDelay = normalizedDistance * 0.28;
    float visibility = smoothstep(revealDelay, revealDelay + 0.18, p);

    float sliceSeed = (sliceIdx + 1.0) / slices;

    float settle = smoothstep(0.45, 0.6, p);
    float sliceMotionMix = 1.0 - settle;
    float chaos = (1.0 - smoothstep(0.15, 0.5, p)) * sliceMotionMix;
    float alignPull = smoothstep(0.25, 0.5, p);

    float baseOffsetX = (sliceSeed - 0.5) * displacement * (1.2 + 0.8 * effectStrength);
    float baseOffsetY = (hash(sliceSeed * 91.73) - 0.5) * displacement * 0.6 * (0.5 + 0.5 * effectStrength);

    float lateralWobble = sin(sliceSeed * 83.17 + p * (60.0 + sliceSeed * 90.0));
    float verticalWobble = sin(sliceSeed * 41.31 + p * (80.0 + sliceSeed * 70.0));
    float syncBurst = sin((p + sliceSeed * 0.35) * 24.0);

    float sidewaysShift = (baseOffsetX + lateralWobble * displacement * 1.5 * chaos + syncBurst * displacement * 0.4 * chaos);
    float verticalShift = (baseOffsetY + verticalWobble * displacement * 0.8 * chaos);

    sidewaysShift *= sliceMotionMix * (1.0 - alignPull * 0.85);
    verticalShift *= sliceMotionMix * (1.0 - alignPull * 0.75);

    float lineBend = sin((vUv.y * slices + p * 12.0) * 3.14159265) * displacement * 0.6 * chaos * sliceMotionMix;

    float trackingPulse = exp(-pow((p - 0.58) / 0.07, 2.0));
    float trackingEnvelope = (1.0 - smoothstep(0.62, 0.75, p));
    vec2 trackingOffset = vec2(sin((p - 0.58) * 28.0) * trackingPulse * displacement * 2.0 * trackingEnvelope, 0.0);

    vec2 uv = vUv + vec2(sidewaysShift + lineBend, verticalShift) + trackingOffset;
    vec2 jitteredUV = handleUVBounds(uv);

    float rgbShiftAmount = channelSplit * (0.4 + 0.6 * chaos) * sliceMotionMix;
    vec2 rgbShift = vec2(rgbShiftAmount * sin(sliceSeed * 21.0 + p * 160.0), 0.0);

    vec2 uvR = handleUVBounds(jitteredUV + rgbShift);
    vec2 uvB = handleUVBounds(jitteredUV - rgbShift);

    vec4 sampleR = texture2D(tDiffuse, uvR);
    vec4 sampleG = texture2D(tDiffuse, jitteredUV);
    vec4 sampleB = texture2D(tDiffuse, uvB);

    vec3 rgb = vec3(sampleR.r, sampleG.g, sampleB.b);

    float scanlineStrength = effectStrength * (0.4 + 0.6 * chaos) * sliceMotionMix;
    float scanlinePhase = sin(vUv.y * (960.0 + ratio * 320.0) + p * 6.2831853);
    float scanline = mix(1.0, 0.92 + 0.08 * scanlinePhase, scanlineStrength);
    rgb *= scanline;

    vec4 sliceColor = vec4(rgb, sampleG.a) * visibility;

    float borderMask = getHardBoundaryMask(vUv);
    sliceColor *= borderMask;

    return sliceColor;
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