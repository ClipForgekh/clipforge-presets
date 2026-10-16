exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float blurStrength; // = 1.0 [0.2, 2.0] // 垂直模糊强度
uniform float glowStrength; // = 1.2 [0.0, 3.0] // 霓虹辉光强度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlur(vec2 uv, float strength) {
    vec4 sum = vec4(0.0);
    float w0 = 0.227027;
    float w1 = 0.1945946;
    float w2 = 0.1216216;
    float w3 = 0.054054;
    float w4 = 0.016216;

    float stepY = 0.006 * strength / max(ratio, 0.0001);

    sum += texture2D(tDiffuse, handleUVBounds(uv)) * w0;
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, stepY * 1.0))) * w1;
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, stepY * 1.0))) * w1;
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, stepY * 2.0))) * w2;
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, stepY * 2.0))) * w2;
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, stepY * 3.0))) * w3;
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, stepY * 3.0))) * w3;
    sum += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, stepY * 4.0))) * w4;
    sum += texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, stepY * 4.0))) * w4;

    return sum;
}

vec4 effect(vec4 texel, float progress) {
    float t = progress;
    float inv = 1.0 - t;

    const float stripeCount = 7.0;
    float sx = vUv.x * stripeCount;
    float stripeId = floor(sx);
    float localX = fract(sx);

    float speed = 0.85 + stripeId * 0.08;
    float startOffset = stripeId * 0.10;
    float scanFront = -startOffset + t * speed * 1.35;

    float scanned = smoothstep(-0.02, 0.02, scanFront - vUv.y);

    float halfWidth = mix(0.28, 0.5, t);
    float coreDist = abs(localX - 0.5);
    float stripeCoreMask = 1.0 - smoothstep(halfWidth - 0.02, halfWidth + 0.02, coreDist);

    float revealMask = scanned * stripeCoreMask;

    float blurLevelByStripe = 1.0 - 0.2 * mod(stripeId, 3.0);
    float currentBlur = inv * blurStrength * blurLevelByStripe;
    vec4 blurred = verticalBlur(vUv, currentBlur);

    vec3 holoStripe = 0.5 + 0.5 * cos(vec3(0.0, 2.1, 4.2) + vUv.x * 90.0 + stripeId * 0.7);
    vec3 stretchedColor = mix(blurred.rgb, blurred.rgb * holoStripe * 1.35, inv * 0.85);

    float edgeGlowY = exp(-abs(vUv.y - scanFront) * 75.0);
    float edgeGlowX = 1.0 - smoothstep(halfWidth - 0.03, halfWidth + 0.01, coreDist);
    vec3 glowColor = mix(vec3(1.0, 0.15, 0.75), vec3(0.1, 1.0, 1.0), localX);
    vec3 glow = glowColor * edgeGlowY * edgeGlowX * inv * glowStrength;

    vec3 baseRGB = stretchedColor * revealMask;
    float baseAlpha = revealMask * mix(0.45, 1.0, t);

    vec3 finalRGB = baseRGB + glow;
    float finalAlpha = clamp(baseAlpha + max(glow.r, max(glow.g, glow.b)) * 0.35, 0.0, 1.0);

    vec4 holo = vec4(clamp(finalRGB, 0.0, 1.0), finalAlpha);

    return mix(holo, texel, smoothstep(0.92, 1.0, t));
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