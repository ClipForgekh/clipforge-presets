exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurAmount; // = 1.0 [0.0, 2.0] // 垂直模糊强度
uniform float glowIntensity; // = 2.0 [0.0, 4.0] // 扫光发光强度
uniform vec3 glowColor; // = vec3(0.75, 0.9, 1.0) // 冷白蓝光颜色，分量范围[0.0,1.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float inv = 1.0 - p;
    float blurStrength = inv * blurAmount;
    float yStep = 0.004 * blurStrength / max(ratio, 0.5);

    vec2 uv0 = handleUVBounds(vUv);
    vec2 uv1 = handleUVBounds(vUv + vec2(0.0, yStep));
    vec2 uv2 = handleUVBounds(vUv - vec2(0.0, yStep));
    vec2 uv3 = handleUVBounds(vUv + vec2(0.0, yStep * 2.0));
    vec2 uv4 = handleUVBounds(vUv - vec2(0.0, yStep * 2.0));
    vec2 uv5 = handleUVBounds(vUv + vec2(0.0, yStep * 3.0));
    vec2 uv6 = handleUVBounds(vUv - vec2(0.0, yStep * 3.0));
    vec2 uv7 = handleUVBounds(vUv + vec2(0.0, yStep * 4.0));
    vec2 uv8 = handleUVBounds(vUv - vec2(0.0, yStep * 4.0));

    vec4 blurred =
        texture2D(tDiffuse, uv0) * 0.22 +
        texture2D(tDiffuse, uv1) * 0.19 +
        texture2D(tDiffuse, uv2) * 0.19 +
        texture2D(tDiffuse, uv3) * 0.12 +
        texture2D(tDiffuse, uv4) * 0.12 +
        texture2D(tDiffuse, uv5) * 0.07 +
        texture2D(tDiffuse, uv6) * 0.07 +
        texture2D(tDiffuse, uv7) * 0.01 +
        texture2D(tDiffuse, uv8) * 0.01;

    vec4 base = mix(blurred, texel, p);

    float wipeY = p;
    float edgeSoft = mix(0.16, 0.01, p);
    float reveal = smoothstep(-edgeSoft, edgeSoft, wipeY - vUv.y + edgeSoft);

    float bandWidth = mix(0.12, 0.02, p);
    float edgeBand = exp(-abs(vUv.y - wipeY) / max(bandWidth, 0.0001));
    float glowMask = edgeBand * inv;

    vec3 glow = glowColor * glowIntensity * glowMask;
    vec3 rgb = 1.0 - (1.0 - base.rgb) * (1.0 - clamp(glow, 0.0, 1.5));
    rgb = clamp(rgb * reveal, 0.0, 1.0);

    return vec4(rgb, base.a * reveal);
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