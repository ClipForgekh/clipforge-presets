exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float stripCount; // = 12.0 [4.0, 24.0] // 竖条数量
uniform float stripDelay; // = 0.0556 [0.0, 0.12] // 相邻竖条延迟(归一化进度，0.05/0.9≈0.0556)
uniform float maxBlurPx; // = 24.0 [0.0, 48.0] // 初始最大垂直模糊像素
uniform float pixelToUv; // = 0.0010 [0.0002, 0.0030] // 像素到UV步长换算
uniform float tintStrength; // = 0.06 [0.0, 0.2] // 青蓝色偏强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlur9(sampler2D tex, vec2 uv, float radiusUV) {
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -4.0 * radiusUV))) * 0.05;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -3.0 * radiusUV))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -2.0 * radiusUV))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, -1.0 * radiusUV))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv)) * 0.18;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, 1.0 * radiusUV))) * 0.15;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, 2.0 * radiusUV))) * 0.12;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, 3.0 * radiusUV))) * 0.09;
    c += texture2D(tex, handleUVBounds(uv + vec2(0.0, 4.0 * radiusUV))) * 0.05;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float n = max(stripCount, 1.0);
    float idx = floor(vUv.x * n);
    idx = clamp(idx, 0.0, n - 1.0);

    float totalDelay = stripDelay * max(n - 1.0, 0.0);
    float duration = max(1.0 - totalDelay, 0.0001);
    float start = idx * stripDelay;

    float lp = clamp((p - start) / duration, 0.0, 1.0);
    float lpWarp = sqrt(lp);
    float clearK = smoothstep(0.0, 1.0, lpWarp);
    float blurK = 1.0 - clearK;

    float radiusUV = maxBlurPx * pixelToUv * blurK;
    vec4 blurred = verticalBlur9(tDiffuse, vUv, radiusUV);

    float tintGate = 1.0 - smoothstep(0.96, 1.0, p);
    float scan = 0.5 + 0.5 * sin(vUv.y * 900.0 + idx * 0.7);
    float tint = tintStrength * tintGate * (0.85 + 0.15 * scan);

    vec3 color = blurred.rgb + vec3(-0.35, 0.22, 0.45) * tint;
    color = clamp(color, 0.0, 1.0);

    return vec4(color, blurred.a);
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