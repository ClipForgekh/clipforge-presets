exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float startScaleX; // = 0.24 [0.05, 0.8] // 初始横向缩放（窄胶片宽度）
uniform float startScaleY; // = 0.08 [0.02, 0.4] // 初始纵向缩放（窄胶片高度）
uniform vec2 startCenter; // = vec2(1.12, -0.12) // 初始中心位置（右下角外侧）

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
    vec2 centerA = startCenter;
    vec2 centerB = vec2(0.74, 0.30);
    vec2 centerC = vec2(0.54, 0.52);
    vec2 centerD = vec2(0.50, 0.50);

    vec2 scaleA = vec2(startScaleX, startScaleY);
    vec2 scaleB = vec2(0.42, 0.20);
    vec2 scaleC = vec2(0.85, 0.82);
    vec2 scaleD = vec2(1.00, 1.00);

    vec2 center;
    vec2 scale;

    if (p < 0.25) {
        float t = clamp(p / 0.25, 0.0, 1.0);
        float e = 1.0 - pow(1.0 - t, 2.0);
        center = mix(centerA, centerB, e);
        scale = mix(scaleA, scaleB, e);
    } else if (p < 0.65) {
        float t = clamp((p - 0.25) / 0.40, 0.0, 1.0);
        float e = 1.0 - pow(1.0 - t, 2.0);
        center = mix(centerB, centerC, e);
        scale = mix(scaleB, scaleC, e);
    } else {
        float t = clamp((p - 0.65) / 0.35, 0.0, 1.0);
        float e = 1.0 - pow(1.0 - t, 3.0);
        center = mix(centerC, centerD, e);
        scale = mix(scaleC, scaleD, e);
    }

    scale = max(scale, vec2(0.0001));
    vec2 localUV = (vUv - center) / scale + 0.5;

    vec2 sampleUV = handleUVBounds(localUV);
    vec4 movingTexel = texture2D(tDiffuse, sampleUV);
    float mask = getHardBoundaryMask(localUV);

    return vec4(movingTexel.rgb, movingTexel.a * mask);
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