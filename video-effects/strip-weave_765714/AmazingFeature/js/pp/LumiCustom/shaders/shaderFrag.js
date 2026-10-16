exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float sliceCount; // = 12.0 [2.0, 24.0] // 垂直切片数量
uniform float stagger; // = 0.06 [0.0, 0.2] // 相邻切片启动延迟（归一化）
uniform float stretchAmount; // = 2.4 [1.0, 4.0] // 初始垂直拉伸强度
uniform float blurAmount; // = 0.02 [0.0, 0.08] // 初始垂直模糊半径
uniform float glowIntensity; // = 0.8 [0.0, 2.0] // 霓虹辉光强度
uniform float glitchAmount; // = 0.018 [0.0, 0.08] // 横向Glitch强度
uniform float startAlpha; // = 0.3 [0.0, 1.0] // 起始透明度
uniform vec3 colorNeonA; // = vec3(1.0, 0.15, 0.85) // 霓虹颜色A（粉）
uniform vec3 colorNeonB; // = vec3(0.55, 0.25, 1.0) // 霓虹颜色B（紫）

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

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec4 verticalBlur(sampler2D tex, vec2 uv, float radius) {
    vec2 off = vec2(0.0, radius);
    vec4 c0 = texture2D(tex, handleUVBounds(uv - off * 2.0)) * 0.12;
    vec4 c1 = texture2D(tex, handleUVBounds(uv - off)) * 0.23;
    vec4 c2 = texture2D(tex, handleUVBounds(uv)) * 0.30;
    vec4 c3 = texture2D(tex, handleUVBounds(uv + off)) * 0.23;
    vec4 c4 = texture2D(tex, handleUVBounds(uv + off * 2.0)) * 0.12;
    return c0 + c1 + c2 + c3 + c4;
}

vec4 effect(vec4 texel, float p) {
    float sc = max(2.0, floor(sliceCount + 0.5));
    float idx = floor(vUv.x * sc);
    float localX = fract(vUv.x * sc);

    float maxDelay = (sc - 1.0) * stagger;
    float denom = max(0.0001, 1.0 - maxDelay);
    float startAt = idx * stagger;
    float lp = clamp((p - startAt) / denom, 0.0, 1.0);
    float eased = tween(lp);
    float strength = 1.0 - eased;

    float parity = mod(idx, 2.0);
    float dir = mix(-1.0, 1.0, parity);

    float moveDistance = 1.15 * strength;
    float shiftY = dir * moveDistance;

    float stretch = 1.0 + (stretchAmount - 1.0) * strength;
    float yStretched = 0.5 + (vUv.y - 0.5) / stretch;

    float glitchPulse = step(0.94, sin((p * 180.0 + idx * 11.7)) * 0.5 + 0.5);
    float glitchLine = step(0.75, hash21(vec2(floor(vUv.y * 140.0), idx + floor(p * 120.0))));
    float glitchOffset = (hash21(vec2(idx, floor(p * 200.0))) - 0.5) * 2.0 * glitchAmount * strength * glitchPulse * glitchLine;

    vec2 srcUVRaw = vec2(vUv.x + glitchOffset, yStretched - shiftY);
    float srcMask = getHardBoundaryMask(srcUVRaw);
    vec2 srcUV = handleUVBounds(srcUVRaw);

    float blurR = blurAmount * strength;
    vec4 col = verticalBlur(tDiffuse, srcUV, blurR);
    col.a *= srcMask;

    float edgeDist = min(localX, 1.0 - localX);
    float edgeGlow = smoothstep(0.10, 0.0, edgeDist) * glowIntensity * strength;
    vec3 neon = mix(colorNeonA, colorNeonB, vUv.y);
    col.rgb += neon * edgeGlow * 0.55;

    float alphaMix = mix(startAlpha, 1.0, eased);
    col.a *= alphaMix;

    if (p >= 0.9999) {
        return texel;
    }
    return col;
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