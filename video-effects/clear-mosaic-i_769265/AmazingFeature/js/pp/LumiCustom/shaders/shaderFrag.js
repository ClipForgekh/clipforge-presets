exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float baseBlockCount; // = 6.0 [2.0, 12.0] // 初始横向方块数量
uniform float blockGrowthSteps; // = 4.0 [1.0, 6.0] // 方块倍增阶段数

varying vec2 vUv;

float tween(float progress) {
    return clamp(progress, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float easedProgress) {
    float effectStrength = 1.0 - easedProgress;
    float safeBase = max(baseBlockCount, 1.0);
    float growthExponent = easedProgress * blockGrowthSteps;
    float horizontalBlocks = safeBase * pow(2.0, growthExponent);
    float verticalBlocks = horizontalBlocks / max(ratio, 0.0001);
    vec2 blockCount = vec2(horizontalBlocks, max(verticalBlocks, 1.0));
    vec2 snappedUV = floor(vUv * blockCount) / blockCount + 0.5 / blockCount;
    snappedUV = handleUVBounds(snappedUV);
    vec4 pixelatedColor = texture2D(tDiffuse, snappedUV);
    vec3 mixedRGB = mix(pixelatedColor.rgb, texel.rgb, 1.0 - effectStrength);
    float mixedAlpha = mix(pixelatedColor.a, texel.a, 1.0 - effectStrength);
    return vec4(mixedRGB, mixedAlpha);
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