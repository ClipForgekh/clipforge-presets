exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float bandCount; // = 5.0 [2.0, 12.0] // 对角分带数量
uniform float splitDistance; // = 0.12 [0.0, 0.35] // RGB分离最大距离
uniform float slideDistance; // = 2.2 [0.5, 3.0] // 分带沿对角线滑出距离
uniform float exitPortion; // = 0.81 [0.1, 1.0] // 动画有效区间(1.5s/1.85s≈0.81)

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    const float PI = 3.14159265;

    float localT = clamp(p / max(exitPortion, 0.0001), 0.0, 1.0);
    float e = 0.5 - 0.5 * cos(PI * localT); // Sine.InOut

    vec2 diagDir = normalize(vec2(1.0, 1.0));   // 底左 -> 顶右
    vec2 bandNormal = normalize(vec2(1.0, -1.0));

    float c = dot(vUv, bandNormal);
    float cn = clamp((c + 0.70710678) / 1.41421356, 0.0, 0.999999);
    float idx = floor(cn * max(bandCount, 1.0));
    float signDir = mix(-1.0, 1.0, step(0.5, mod(idx, 2.0)));

    vec2 bandOffset = diagDir * signDir * (slideDistance * e);
    vec2 splitVec = bandNormal * (splitDistance * e);

    vec2 uvGRaw = vUv - bandOffset;
    vec2 uvRRaw = uvGRaw + splitVec;
    vec2 uvBRaw = uvGRaw - splitVec;

    float mR = getHardBoundaryMask(uvRRaw);
    float mG = getHardBoundaryMask(uvGRaw);
    float mB = getHardBoundaryMask(uvBRaw);

    vec2 uvR = handleUVBounds(uvRRaw);
    vec2 uvG = handleUVBounds(uvGRaw);
    vec2 uvB = handleUVBounds(uvBRaw);

    float r = texture2D(tDiffuse, uvR).r * mR;
    float g = texture2D(tDiffuse, uvG).g * mG;
    float b = texture2D(tDiffuse, uvB).b * mB;

    vec3 color = vec3(r, g, b);
    float alphaMask = max(max(mR, mG), mB);

    return vec4(color, texel.a * alphaMask);
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