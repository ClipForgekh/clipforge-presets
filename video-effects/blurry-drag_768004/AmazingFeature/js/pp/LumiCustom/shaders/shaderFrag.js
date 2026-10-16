exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float travelDistance; // = 0.85 [0.2, 1.5] // 从右下到中心的位移幅度
uniform float blurMax; // = 0.045 [0.0, 0.12] // 最大方向运动模糊强度
uniform float zoomBoost; // = 0.12 [0.0, 0.35] // 入场初期放大强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    vec2 startDir = normalize(vec2(1.0, -1.0)); // 指向右下（初始位置）
    vec2 move = startDir * travelDistance * pow(strength, 1.05);

    float scale = 1.0 + zoomBoost * pow(strength, 1.6);

    vec2 baseUVRaw = 0.5 + (vUv - 0.5) * scale - move;

    float blurAmount = blurMax * pow(strength, 1.15);
    vec2 blurDir = normalize(vec2(-1.0, 1.0 / max(ratio, 0.0001))); // 朝向中心方向的动态模糊轴
    vec2 blurVec = blurDir * blurAmount;

    vec4 accum = vec4(0.0);
    float totalW = 0.0;

    for (int i = -3; i <= 3; i++) {
        float fi = float(i);
        float w = 1.0 - abs(fi) / 3.5;
        vec2 suvRaw = baseUVRaw + blurVec * fi;
        vec2 suv = handleUVBounds(suvRaw);
        float m = getHardBoundaryMask(suvRaw);
        accum += texture2D(tDiffuse, suv) * (w * m);
        totalW += w * m;
    }

    vec4 motionTexel;
    if (totalW > 0.0001) motionTexel = accum / totalW;
    else motionTexel = vec4(0.0);

    return motionTexel;
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