exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurStrength; // = 0.09 [0.0, 0.2] // 纵向层叠模糊强度
uniform float sliceJitter; // = 0.018 [0.0, 0.08] // 切片微晃动强度
uniform float leakIntensity; // = 0.55 [0.0, 1.2] // 暖光漏光强度
uniform float grainIntensity; // = 0.12 [0.0, 0.4] // 胶片颗粒强度
uniform vec3 leakColor; // = vec3(1.0, 0.72, 0.35) // 暖金漏光颜色，范围[0.0, 1.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 effect(vec4 texel, float p) {
    const int LAYERS = 8;
    float remain = 1.0 - p;

    float sliceCount = 36.0;
    float stripId = floor(vUv.x * sliceCount);
    float edgeCell = abs(fract(vUv.x * sliceCount) - 0.5);
    float gapMask = smoothstep(0.24, 0.5, edgeCell);

    vec4 accum = vec4(0.0);
    float wsum = 0.0;
    float remainDepthSum = 0.0;

    for (int i = 0; i < LAYERS; i++) {
        float fi = float(i);
        float layerStart = fi / float(LAYERS);
        float layerSettle = clamp((p - layerStart) * float(LAYERS), 0.0, 1.0);
        float layerRemain = 1.0 - layerSettle;
        remainDepthSum += layerRemain;

        float base = (fi - 3.5) / 3.5;
        float n = hash12(vec2(stripId + fi * 13.17, fi * 2.71 + floor(p * 120.0)));
        float wobble = (n - 0.5) * sliceJitter * layerRemain * remain;
        float yOffset = base * blurStrength * layerRemain * remain + wobble;
        float xOffset = wobble * 0.25;

        vec2 suv = handleUVBounds(vUv + vec2(xOffset, yOffset));
        vec4 c = texture2D(tDiffuse, suv);

        float w = 1.0;
        accum += c * w;
        wsum += w;
    }

    vec4 layered = accum / max(wsum, 0.0001);
    float remainDepth = remainDepthSum / float(LAYERS);

    float leakFlow = 0.75 + 0.25 * sin((vUv.y * 20.0 + vUv.x * 9.0 + p * 6.2831853) * 1.2);
    float leak = leakIntensity * remainDepth * remain * gapMask * leakFlow;

    float grainSeed = floor(p * 180.0);
    float grain = (hash12(vUv * vec2(420.0, 420.0 / max(ratio, 0.001)) + grainSeed) - 0.5) * grainIntensity * remain;

    vec3 rgb = layered.rgb;
    rgb += leakColor * leak;
    rgb += grain;
    rgb = clamp(rgb, 0.0, 1.0);

    return vec4(rgb, layered.a);
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