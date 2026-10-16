exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float lockPoint; // = 0.18 [0.05, 0.6] // 同步锁定时刻
uniform float jitterAmount; // = 0.03 [0.0, 0.12] // 不稳定阶段水平抖动强度
uniform float rgbSplit; // = 0.002 [0.0, 0.01] // RGB分离强度
uniform float noiseAmount; // = 0.06 [0.0, 0.2] // 模拟噪声强度
uniform float tearWidth; // = 0.018 [0.004, 0.08] // 同步瞬间撕裂持续宽度

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
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 effect(vec4 texel, float p) {
    float lockT = clamp(lockPoint, 0.05, 0.9);
    float unstable = 1.0 - smoothstep(lockT - 0.05, lockT + 0.015, p);

    float bandCount = 90.0;
    float band = floor(vUv.y * bandCount);
    float centerSign = sign(vUv.y - 0.5);
    float bandRnd = hash21(vec2(band, 0.17));
    float vis = step(0.38, bandRnd + 0.35 * (1.0 - abs(vUv.y - 0.5) * 2.0));
    float bandPhase = band * 0.23 + p * 37.0;
    float bandOffset = (sin(bandPhase) + 0.5 * sin(bandPhase * 1.73)) * jitterAmount;
    bandOffset *= unstable * (0.45 + 0.55 * abs(centerSign));

    vec2 uvRaw = vUv;
    uvRaw.x += bandOffset;

    float tearPulse = step(lockT, p) * (1.0 - step(lockT + tearWidth, p));
    float tearBand = smoothstep(0.10, 0.0, abs(vUv.y - 0.5));
    float tearShift = (0.02 + 0.015 * hash21(vec2(floor(vUv.y * 240.0), p * 113.0))) * tearPulse * tearBand;
    uvRaw.x += tearShift;

    float post = clamp((p - lockT) / max(1e-4, 1.0 - lockT), 0.0, 1.0);
    float settle = smoothstep(0.0, 1.0, post);
    float scale;
    if (settle < 0.55) {
        scale = mix(0.98, 1.01, smoothstep(0.0, 0.55, settle));
    } else {
        scale = mix(1.01, 1.0, smoothstep(0.55, 1.0, settle));
    }
    vec2 centered = uvRaw - 0.5;
    uvRaw = centered / scale + 0.5;

    vec2 uv = handleUVBounds(uvRaw);
    float borderMask = getHardBoundaryMask(uvRaw);

    float split = rgbSplit * unstable;
    vec3 col;
    col.r = texture2D(tDiffuse, handleUVBounds(uv + vec2(split, 0.0))).r;
    col.g = texture2D(tDiffuse, uv).g;
    col.b = texture2D(tDiffuse, handleUVBounds(uv - vec2(split, 0.0))).b;

    float n = hash21(vec2(floor(vUv.y * 420.0), floor(vUv.x * 320.0) + p * 997.0)) - 0.5;
    col += n * noiseAmount * unstable;

    float lineFlicker = (hash21(vec2(floor(vUv.y * 300.0), p * 431.0)) - 0.5) * 0.06 * unstable;
    col *= 1.0 + lineFlicker;

    float reveal = mix(vis, 1.0, 1.0 - unstable);
    float alpha = texel.a * reveal * borderMask;

    return vec4(clamp(col, 0.0, 1.0), alpha);
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