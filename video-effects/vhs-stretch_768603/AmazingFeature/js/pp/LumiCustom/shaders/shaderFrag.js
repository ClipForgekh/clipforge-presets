exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float stretchAmount; // = 1.1 [1.0, 1.4] // 横向超拉伸峰值
uniform float peakPoint; // = 0.38 [0.1, 0.7] // 拉伸峰值出现时机
uniform float warpStrength; // = 0.012 [0.0, 0.05] // VHS扭曲强度
uniform float rgbSplit; // = 0.006 [0.0, 0.02] // RGB分离强度
uniform float scanlineStrength; // = 0.03 [0.0, 0.15] // 稳定阶段扫描线闪烁强度

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

vec4 effect(vec4 texel, float progress) {
    float p = tween(progress);
    if (p >= 0.9999) return texel;

    float rise = smoothstep(0.0, peakPoint, p);
    float settle = smoothstep(peakPoint, 1.0, p);

    float xScale = mix(0.12, stretchAmount, rise);
    xScale = mix(xScale, 1.0, settle);

    float yScale = mix(0.88, 1.0, smoothstep(0.22, 1.0, p));

    float strength = 1.0 - p;
    float warpEnvelope = (1.0 - smoothstep(peakPoint, 0.9, p));
    float warp = sin(vUv.y * (220.0 / max(ratio, 0.0001)) + p * 70.0) * warpStrength * warpEnvelope * strength;

    vec2 uvRaw = vec2(
        0.5 + (vUv.x - 0.5) / max(xScale, 0.0001) + warp,
        0.5 + (vUv.y - 0.5) / max(yScale, 0.0001)
    );

    float borderMask = getHardBoundaryMask(uvRaw);
    vec2 uv = handleUVBounds(uvRaw);

    float splitPulse = exp(-pow((p - peakPoint * 0.65) / 0.12, 2.0));
    float splitAmount = rgbSplit * splitPulse * strength;

    vec2 uvR = handleUVBounds(uv + vec2(splitAmount, 0.0));
    vec2 uvB = handleUVBounds(uv - vec2(splitAmount, 0.0));

    vec4 cG = texture2D(tDiffuse, uv);
    float r = texture2D(tDiffuse, uvR).r;
    float b = texture2D(tDiffuse, uvB).b;
    vec3 rgb = vec3(r, cG.g, b);

    float stabilizeWindow = smoothstep(0.72, 0.9, p) * (1.0 - smoothstep(0.96, 1.0, p));
    float flicker = sin(vUv.y * 700.0 + p * 140.0) * scanlineStrength * stabilizeWindow;
    rgb *= (1.0 + flicker);

    return vec4(clamp(rgb, 0.0, 1.0), cG.a * borderMask);
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