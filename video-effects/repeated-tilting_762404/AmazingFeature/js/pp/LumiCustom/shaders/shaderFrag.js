exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float swayAmount; // = 0.03 [0.0, 0.2] // 水平摇摆幅度
uniform float tiltAmount; // = 0.05 [0.0, 0.3] // 倾斜角幅度
uniform float perspectiveAmount; // = 0.10 [0.0, 0.5] // 透视倾斜强度

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 rotateAspect(vec2 p, float angle) {
    vec2 q = p;
    q.x *= ratio;
    float s = sin(angle);
    float c = cos(angle);
    q = mat2(c, -s, s, c) * q;
    q.x /= ratio;
    return q;
}

vec4 effect(vec4 texel, float progress) {
    float phase = progress * 6.28318530718 - 1.57079632679;
    float swing = sin(phase);

    vec2 p = vUv - 0.5;

    p = rotateAspect(p, swing * tiltAmount);
    p.x += p.y * perspectiveAmount * swing;
    p.x += swayAmount * swing;

    vec2 uvRaw = p + 0.5;
    float borderMask = getHardBoundaryMask(uvRaw);
    vec2 uv = handleUVBounds(uvRaw);

    vec4 swungTexel = texture2D(tDiffuse, uv);
    return vec4(swungTexel.rgb, swungTexel.a * borderMask);
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