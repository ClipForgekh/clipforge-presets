exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float stripDensity; // = 84.0 [24.0, 180.0] // 条纹密度
uniform float jitterStrength; // = 0.08 [0.0, 0.3] // 条纹抖动幅度
uniform float noiseAmount; // = 0.35 [0.0, 1.0] // 数字噪声强度

varying vec2 vUv;

float hash11(float p) {
    return fract(sin(p * 127.1) * 43758.5453123);
}

float hash12(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;
    float strips = max(stripDensity, 1.0);
    float scaledX = vUv.x * strips;
    float stripIndex = floor(scaledX);
    float local = fract(scaledX);
    float stripCenter = (stripIndex + 0.5) / strips;

    float compress = mix(0.03, 1.0, progress);
    float sampleX = stripCenter + (vUv.x - stripCenter) * compress;

    float baseJitter = (hash11(stripIndex * 1.37 + 0.11) - 0.5) * jitterStrength * effectStrength;
    float timeSlice = floor(progress * 30.0);
    float dynamicShift = (hash11(stripIndex * 5.17 + timeSlice * 2.91) - 0.5) * 0.06 * effectStrength;

    float groupIndex = floor(stripIndex / 2.5);
    float glitchPhase = progress * 7.0 + groupIndex * 0.37;
    float wave = sin(glitchPhase * 12.0) * 0.5 + 0.5;
    float glitchWindow = smoothstep(0.92, 0.98, wave) * (1.0 - smoothstep(0.82, 1.0, progress));
    float glitchOffset = (hash11((stripIndex + groupIndex) * 9.13 + 1.7) - 0.5) * 0.35 * glitchWindow * effectStrength;

    vec2 sampleUV = vec2(sampleX + baseJitter + dynamicShift + glitchOffset, vUv.y);
    sampleUV = handleUVBounds(sampleUV);
    vec4 stripColor = texture2D(tDiffuse, sampleUV);

    float edgeFactor = smoothstep(0.25, 0.95, abs(local - 0.5) * 2.0);
    vec2 noiseCoord = floor(vec2(vUv.x * strips * 1.3, vUv.y * (strips * 0.35 + 12.0)));
    float digitalNoise = hash12(noiseCoord + vec2(progress * 24.0, progress * 48.0));
    float noiseStrength = noiseAmount * effectStrength;
    vec3 noisyColor = stripColor.rgb + (digitalNoise - 0.5) * noiseStrength * (0.6 + edgeFactor);

    float stripVisibility = mix(0.3, 1.0, progress);
    vec3 blendedColor = mix(vec3(digitalNoise), noisyColor, stripVisibility);
    blendedColor = clamp(blendedColor, 0.0, 1.0);

    float ratioSafe = max(ratio, 0.0001);
    float scanPhase = clamp((progress - 0.9) / 0.08, 0.0, 1.0);
    float scanCenter = mix(-0.15, 1.15, scanPhase);
    float scanProfile = exp(-pow((vUv.y - scanCenter) * (ratio > 1.0 ? ratio : 1.0 / ratioSafe), 2.0) * 120.0);
    float scanEnvelope = smoothstep(0.0, 1.0, scanPhase) * (1.0 - progress);
    blendedColor += stripColor.rgb * scanProfile * scanEnvelope * 0.18;
    blendedColor = clamp(blendedColor, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(vUv);
    return vec4(blendedColor, stripColor.a * borderMask);
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