exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float startZoom; // = 0.5 [0.3, 1.0] // 起始缩放（快速压缩）
uniform float peakZoom; // = 1.35 [1.0, 2.0] // 峰值放大
uniform float motionBlur; // = 0.02 [0.0, 0.08] // 运动波纹模糊强度
uniform float shakeAmount; // = 0.01 [0.0, 0.05] // 相机抖动强度
uniform float fadeStart; // = 0.55 [0.3, 0.9] // 开始淡出到暗背景的时间点
uniform vec3 backgroundColor; // = vec3(0.03, 0.03, 0.04) // 暗色背景

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float p = clamp(progress, 0.0, 1.0);

    float pre = smoothstep(0.0, 0.07, p);
    float push = smoothstep(0.07, 0.55, p);
    float pushEase = 1.0 - pow(1.0 - push, 4.0);

    float zoom = mix(1.0, startZoom, pre);
    zoom = mix(zoom, peakZoom, pushEase);

    float shakeGate = smoothstep(0.02, 0.10, p) * (1.0 - smoothstep(0.30, 0.45, p));
    vec2 shake = shakeAmount * shakeGate * vec2(
        sin(p * 170.0) + 0.5 * sin(p * 311.0 + 1.3),
        cos(p * 143.0 + 0.7) + 0.5 * cos(p * 277.0)
    );
    shake.y /= max(ratio, 0.0001);

    vec2 centered = vUv - 0.5;
    vec2 dir = normalize(centered + vec2(1e-5));
    vec2 perp = vec2(-dir.y, dir.x);

    float blurAmt = motionBlur * smoothstep(0.08, 0.55, p) * (1.0 - smoothstep(fadeStart, 1.0, p));
    float w = sin((dot(vUv, vec2(18.0, 24.0)) + p * 35.0) * 6.2831853) * 0.5 + 0.5;
    vec2 blurVec = dir * blurAmt * (0.6 + 0.4 * w);

    vec4 col = vec4(0.0);
    col += texture2D(tDiffuse, handleUVBounds(0.5 + (centered - blurVec * 2.0 + perp * blurAmt * 0.40) / zoom + shake)) * 0.10;
    col += texture2D(tDiffuse, handleUVBounds(0.5 + (centered - blurVec * 1.0 + perp * blurAmt * 0.20) / zoom + shake)) * 0.22;
    col += texture2D(tDiffuse, handleUVBounds(0.5 + (centered + perp * blurAmt * 0.00) / zoom + shake)) * 0.36;
    col += texture2D(tDiffuse, handleUVBounds(0.5 + (centered + blurVec * 1.0 - perp * blurAmt * 0.20) / zoom + shake)) * 0.22;
    col += texture2D(tDiffuse, handleUVBounds(0.5 + (centered + blurVec * 2.0 - perp * blurAmt * 0.40) / zoom + shake)) * 0.10;

    float fade = smoothstep(fadeStart, 1.0, p);
    vec3 rgb = mix(col.rgb, backgroundColor, fade);
    float alpha = col.a * (1.0 - fade);

    return vec4(rgb, alpha);
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