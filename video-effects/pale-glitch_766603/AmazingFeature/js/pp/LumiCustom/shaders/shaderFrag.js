exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float bandCount; // = 12.0 [6.0, 24.0] // 横向条带数量
uniform float maxBlur; // = 0.03 [0.0, 0.08] // 最大模糊半径（UV空间）
uniform float maxOffset; // = 0.08 [0.0, 0.2] // 条带最大水平错位
uniform float leakStrength; // = 0.85 [0.0, 1.5] // 暖橙漏光强度

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

vec3 adjustSaturation(vec3 color, float sat) {
    float l = dot(color, vec3(0.299, 0.587, 0.114));
    return mix(vec3(l), color, sat);
}

vec4 fastBlur9(sampler2D tex, vec2 uv, float radius) {
    vec2 stepSize = vec2(radius, radius / max(ratio, 0.0001));
    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0, -1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0, -1.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0, -1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  0.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv))                                  * 0.200;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  0.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  1.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  1.0))) * 0.075;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float bands = max(2.0, floor(bandCount + 0.5));
    float b = floor(vUv.y * bands);
    float fromEdge = min(b, bands - 1.0 - b);
    float edgeNorm = abs((b + 0.5) / bands - 0.5) * 2.0;

    float pairDelay = 0.05;
    float neighborDelay = mod(b, 2.0) * 0.025;
    float delay = fromEdge * pairDelay + neighborDelay;
    delay = min(delay, 0.85);

    float localP = clamp((p - delay) / (1.0 - delay), 0.0, 1.0);
    float localEase = tween(localP);
    float strength = 1.0 - localEase;

    float wave = sin((b * 1.7 + p * 10.0) * 3.14159265);
    float xOffset = maxOffset * strength * edgeNorm * wave;
    float scale = 1.0 + 0.2 * strength * (0.65 + 0.35 * edgeNorm);

    vec2 uv = 0.5 + (vUv - 0.5) * scale;
    uv.x += xOffset;
    float borderMask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);

    float blurR = maxBlur * strength * (0.8 + 0.2 * edgeNorm);
    vec4 col = fastBlur9(tDiffuse, uv, blurR);

    float brightness = mix(1.0, 2.1, strength);
    float saturation = mix(1.0, 1.9, strength);
    vec3 graded = adjustSaturation(col.rgb * brightness, saturation);

    vec3 warm = vec3(1.0, 0.56, 0.20);
    float leak = leakStrength * strength * (0.55 + 0.45 * edgeNorm);
    graded = mix(graded, min(vec3(1.0), graded + warm * 0.75), clamp(leak, 0.0, 1.0));

    float f = fract(vUv.y * bands);
    float edgeLine = 1.0 - smoothstep(0.0, 0.08, min(f, 1.0 - f));
    float scratch = sin((vUv.x * 420.0 + b * 31.7) * 1.17) * 0.5 + 0.5;
    float scratchMask = edgeLine * scratch * strength * 0.25;
    graded += vec3(0.12, 0.08, 0.03) * scratchMask;

    graded = clamp(graded, 0.0, 1.0);

    return vec4(graded, col.a * borderMask);
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