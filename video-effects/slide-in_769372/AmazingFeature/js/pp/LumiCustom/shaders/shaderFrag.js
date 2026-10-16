exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float slideStartX; // = 1.15 [0.6, 2.0] // 初始从右侧进入的偏移距离
uniform float startRotationDeg; // = 6.0 [0.0, 20.0] // 初始逆时针旋转角度
uniform float settleStartScale; // = 0.97 [0.85, 1.0] // 收尾阶段起始缩放

varying vec2 vUv;

float tween(float p) {
    return p;
}

float easeOutCubic(float x) {
    float t = 1.0 - x;
    return 1.0 - t * t * t;
}

float easeOutSine(float x) {
    return sin((x * 3.14159265) * 0.5);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float xOffset = 0.0;
    float rotDeg = 0.0;
    float scaleVal = 1.0;
    float alphaMul = 1.0;

    float phase1EndX = 0.04;
    float phase1EndRot = 1.2;

    if (p < 0.3) {
        float t = p / 0.3;
        float e = easeOutCubic(t);
        xOffset = mix(slideStartX, phase1EndX, e);
        rotDeg = mix(startRotationDeg, phase1EndRot, e);
        alphaMul = e;
    } else if (p < 0.7) {
        float t = (p - 0.3) / 0.4;
        float e = easeOutSine(t);
        xOffset = mix(phase1EndX, 0.0, e);
        rotDeg = mix(phase1EndRot, 0.0, e);
        alphaMul = 1.0;
    } else {
        float t = (p - 0.7) / 0.3;
        float e = smoothstep(0.0, 1.0, t);
        xOffset = 0.0;
        rotDeg = 0.0;
        scaleVal = mix(settleStartScale, 1.0, e);
        alphaMul = 1.0;
    }

    float angle = rotDeg * 3.14159265 / 180.0;
    float c = cos(angle);
    float s = sin(angle);

    vec2 offset = vec2(xOffset, 0.0);
    vec2 q = vUv - 0.5 - offset;
    vec2 invRot = vec2(c * q.x + s * q.y, -s * q.x + c * q.y);
    vec2 uvRaw = invRot / max(scaleVal, 0.0001) + 0.5;

    float borderMask = getHardBoundaryMask(uvRaw);
    vec2 uv = handleUVBounds(uvRaw);
    vec4 movedTexel = texture2D(tDiffuse, uv);

    return vec4(movedTexel.rgb, movedTexel.a * alphaMul * borderMask);
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