exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float bandCount; // = 56.0 [8.0, 180.0] // 水平数据带数量
uniform float maxShift; // = 0.12 [0.0, 0.35] // 最大水平位移
uniform float snapStrength; // = 0.03 [0.0, 0.12] // 数字对齐瞬时抖动强度
uniform float chromaShift; // = 0.01 [0.0, 0.05] // 色彩通道分离强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash11(float n) {
    return fract(sin(n) * 43758.5453123);
}

vec4 effect(vec4 texel, float p) {
    p = clamp(p, 0.0, 1.0);
    float t = 1.0 - pow(max(1.0 - p, 0.0), 1.0 / 3.0);

    if (t >= 0.9999) {
        return texel;
    }

    float bands = max(8.0, bandCount);
    float bandId = floor(vUv.y * bands);

    float seedA = hash11(bandId * 1.37 + 2.11);
    float seedB = hash11(bandId * 7.91 + 0.73);
    float dir = seedA > 0.5 ? 1.0 : -1.0;
    float speed = mix(1.5, 9.0, seedB);
    float phase = hash11(bandId * 13.17 + 4.2) * 6.2831853;

    float syncFactor = 1.0 - smoothstep(0.5, 0.8, t);
    float baseStrength = (1.0 - t) * syncFactor;
    float wave = sin(phase + t * speed * 6.2831853);
    float offsetX = wave * maxShift * (0.55 + 0.45 * seedA) * dir * baseStrength;

    float snapWindow = exp(-pow((t - 0.9111111) / 0.012, 2.0));
    float snapDir = hash11(bandId * 5.21 + 8.0) > 0.5 ? 1.0 : -1.0;
    offsetX += snapDir * snapStrength * snapWindow;

    vec2 uvBase = vUv + vec2(offsetX, 0.0);
    float ca = chromaShift * (baseStrength + snapWindow * 0.6);

    vec2 uvR = handleUVBounds(uvBase + vec2(ca, 0.0));
    vec2 uvG = handleUVBounds(uvBase);
    vec2 uvB = handleUVBounds(uvBase - vec2(ca, 0.0));

    vec3 glitchRgb;
    glitchRgb.r = texture2D(tDiffuse, uvR).r;
    glitchRgb.g = texture2D(tDiffuse, uvG).g;
    glitchRgb.b = texture2D(tDiffuse, uvB).b;

    float glitchMix = clamp((1.0 - t) + snapWindow * 0.35, 0.0, 1.0);
    vec3 finalRgb = mix(texel.rgb, glitchRgb, glitchMix);

    float alphaIn = smoothstep(0.0, 0.9, t);
    return vec4(finalRgb, texel.a * alphaIn);
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