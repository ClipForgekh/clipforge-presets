exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float neonIntensity; // = 0.85 [0.0, 2.0] // 霓虹扫光强度
uniform float blurStrength; // = 1.2 [0.0, 3.0] // 斜向模糊强度
uniform float splitStrength; // = 0.004 [0.0, 0.02] // RGB分离强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float bandMask(float d, float front, float offset, float width) {
    float center = front + offset;
    return smoothstep(width, 0.0, abs(d - center));
}

vec4 sampleDirectionalBlur(vec2 uv, vec2 dir, float strength) {
    vec2 o1 = dir * strength * 0.6;
    vec2 o2 = dir * strength * 1.2;
    vec4 c0 = texture2D(tDiffuse, handleUVBounds(uv));
    vec4 c1 = texture2D(tDiffuse, handleUVBounds(uv + o1));
    vec4 c2 = texture2D(tDiffuse, handleUVBounds(uv - o1));
    vec4 c3 = texture2D(tDiffuse, handleUVBounds(uv + o2));
    vec4 c4 = texture2D(tDiffuse, handleUVBounds(uv - o2));
    return c0 * 0.34 + (c1 + c2) * 0.24 + (c3 + c4) * 0.09;
}

vec4 effect(vec4 texel, float p) {
    float e = 1.0 - p;

    float zoom = 1.0 - 0.06 * e;
    vec2 uvZoom = 0.5 + (vUv - 0.5) * zoom;
    uvZoom = handleUVBounds(uvZoom);

    vec2 dir = normalize(vec2(1.0, 1.0 / max(ratio, 0.0001)));
    float d = dot(vUv - 0.5, dir);
    float dMin = -0.72;
    float dMax = 0.72;

    float sweep = clamp(p / 0.8, 0.0, 1.0);
    float frontA = mix(dMin - 0.25, dMax + 0.25, sweep);
    float frontB = mix(dMax + 0.25, dMin - 0.25, sweep);

    float bA =
        bandMask(d, frontA, -0.24, 0.050) +
        bandMask(d, frontA, -0.11, 0.082) +
        bandMask(d, frontA,  0.01, 0.058) +
        bandMask(d, frontA,  0.13, 0.096) +
        bandMask(d, frontA,  0.26, 0.066);

    float bB =
        bandMask(d, frontB, -0.21, 0.054) +
        bandMask(d, frontB, -0.08, 0.090) +
        bandMask(d, frontB,  0.04, 0.056) +
        bandMask(d, frontB,  0.16, 0.102) +
        bandMask(d, frontB,  0.28, 0.070);

    float activeBand = clamp(max(bA, bB), 0.0, 1.0);

    float sweptA = smoothstep(-0.02, 0.08, frontA - d);
    float sweptB = smoothstep(-0.02, 0.08, d - frontB);
    float reveal = clamp(max(sweptA, sweptB), 0.0, 1.0);

    float ageA = clamp((frontA - d) / (dMax - dMin + 0.5), 0.0, 1.0);
    float ageB = clamp((d - frontB) / (dMax - dMin + 0.5), 0.0, 1.0);
    float frontInfluence = max(exp(-ageA * 7.0), exp(-ageB * 7.0));

    float distort = e * (0.25 + 0.75 * frontInfluence) * activeBand;

    vec2 stretchUV = uvZoom - dir * (0.03 * blurStrength * distort);
    stretchUV = handleUVBounds(stretchUV);

    vec4 stretched = texture2D(tDiffuse, stretchUV);
    vec4 blurred = sampleDirectionalBlur(stretchUV, dir, 0.01 * blurStrength * distort);

    float split = splitStrength * distort;
    vec3 rgbSplit;
    rgbSplit.r = texture2D(tDiffuse, handleUVBounds(stretchUV + dir * split)).r;
    rgbSplit.g = texture2D(tDiffuse, handleUVBounds(stretchUV)).g;
    rgbSplit.b = texture2D(tDiffuse, handleUVBounds(stretchUV - dir * split)).b;

    vec3 baseFx = mix(stretched.rgb, blurred.rgb, clamp(0.55 * distort, 0.0, 1.0));
    baseFx = mix(baseFx, rgbSplit, clamp(0.45 * distort, 0.0, 1.0));

    vec3 neonA = vec3(1.0, 0.25, 0.85);
    vec3 neonB = vec3(0.65, 0.35, 1.0);
    float g = clamp(vUv.x * 0.65 + vUv.y * 0.35, 0.0, 1.0);
    vec3 neonColor = mix(neonA, neonB, g);
    float travelFade = 1.0 - 0.55 * sweep;
    vec3 neonAdd = neonColor * activeBand * neonIntensity * travelFade * e * 0.9;

    vec3 revealedColor = baseFx + neonAdd;
    vec3 finalRgb = mix(vec3(0.0), revealedColor, reveal);

    return vec4(finalRgb, texel.a * reveal);
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