exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform vec2 center; // = vec2(0.5, 0.5) // 局部曝光中心
uniform vec2 size; // = vec2(0.22, 0.32) // 局部作用区域半尺寸
uniform float edgeSoftness; // = 0.12 [0.0, 1.0] // 边缘软化
uniform float exposureMin; // = 0.04 [0.0, 1.0] // 最低曝光增益
uniform float exposurePeak; // = 0.10 [0.0, 1.0] // 峰值曝光增益
uniform float maskFeather; // = 0.18 [0.0, 1.0] // 遮罩羽化
uniform vec4 tintColor; // = vec4(1.0, 1.0, 1.0, 1.0) // 局部高光色调

varying vec2 vUv; // 纹理坐标

float trianglePulse(float x) {
    return 1.0 - abs(2.0 * x - 1.0);
}

float rectMask(vec2 uv, vec2 c, vec2 halfSize, float feather) {
    vec2 p = uv - c;
    p.x *= ratio;
    vec2 hs = max(halfSize, vec2(0.0001));
    float px = 1.0 - smoothstep(hs.x, hs.x + feather, abs(p.x));
    float py = 1.0 - smoothstep(hs.y, hs.y + feather, abs(p.y));
    return px * py;
}

vec3 applyExposureLocal(vec3 color, float exposureBoost, vec3 tint) {
    vec3 lifted = color * (1.0 + exposureBoost);
    vec3 mixedTint = mix(lifted, lifted * tint, 0.18 * exposureBoost / max(0.0001, exposureBoost + 0.18));
    return clamp(mixedTint, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float pulse = trianglePulse(progress);
    float localExposure = mix(exposureMin, exposurePeak, pulse);

    float feather = mix(0.001, 0.35, maskFeather);
    float localMask = rectMask(vUv, center, size, feather);

    vec2 delta = vUv - center;
    delta.x *= ratio;
    float radial = length(delta) / max(length(size), 0.0001);
    float centerWeight = 1.0 - smoothstep(0.0, 1.0 + edgeSoftness, radial);

    float mask = clamp(localMask * centerWeight, 0.0, 1.0);

    vec3 enhanced = applyExposureLocal(texel.rgb, localExposure * mask, tintColor.rgb);

    return vec4(enhanced, texel.a);
}

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);

    const float fadeInEnd = 0.1;
    const float fadeOutStart = 0.9;

    float effectProgress = clamp((progress - fadeInEnd) / (fadeOutStart - fadeInEnd), 0.0, 1.0);
    vec4 effectColor = effect(texel, effectProgress);

    float fadeInStrength = smoothstep(0.0, fadeInEnd, progress);
    float fadeOutStrength = 1.0 - smoothstep(fadeOutStart, 1.0, progress);
    float effectStrength = min(fadeInStrength, fadeOutStrength);

    vec4 finalColor = mix(texel, effectColor, effectStrength);

    gl_FragColor = finalColor;
}
//===end_frag_code===
`;