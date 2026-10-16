exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float shakeStrength; // = 0.10 [0.0, 0.25] // 最大左右抖动强度（UV空间）

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
    if (p <= 0.0) {
        return texel;
    }

    const float totalSeconds = 1.85;
    const float actionEnd = 1.80;

    float t = min(p * totalSeconds, actionEnd);
    float actionN = clamp(t / actionEnd, 0.0, 1.0);

    float zoom = 1.0 + 0.3 * actionN;

    float shakeEnvelope = actionN;
    float shakeHz = 12.0;
    float shake = sin(t * 6.28318530718 * shakeHz) * shakeStrength * shakeEnvelope;

    vec2 uv = vUv;
    uv.x += shake;
    uv = 0.5 + (uv - 0.5) / zoom;

    float borderMask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);

    vec4 col = texture2D(tDiffuse, uv);

    float slotPhase = fract(t / 0.3);
    float negativeOn = step(slotPhase, 0.5);
    vec3 negativeColor = 1.0 - col.rgb;
    col.rgb = mix(col.rgb, negativeColor, negativeOn);

    float darken = clamp((t - 1.5) / 0.3, 0.0, 1.0);
    col.rgb *= (1.0 - darken);

    return vec4(col.rgb, col.a * borderMask);
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