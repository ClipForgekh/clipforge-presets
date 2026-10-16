exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float zoomStart; // = 1.5 [1.0, 2.0] // 起始缩放倍数（150%）
uniform float lineThickness; // = 1.0 [0.5, 3.0] // 蓝图线条粗细
uniform float edgeThreshold; // = 0.2 [0.05, 0.6] // 线条阈值
uniform vec3 blueprintBgColor; // = vec3(0.0, 0.55, 1.0) // 蓝图背景色
uniform float completeAt; // = 0.973 [0.5, 1.0] // 在总进度中的完成点（1.8/1.85≈0.973）

varying vec2 vUv; // 纹理坐标

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float animP = clamp(p / max(completeAt, 0.0001), 0.0, 1.0);

    float zoomFactor = mix(zoomStart, 1.0, animP);
    vec2 uvRaw = 0.5 + (vUv - 0.5) / zoomFactor;
    float borderMask = getHardBoundaryMask(uvRaw);
    vec2 uv = handleUVBounds(uvRaw);

    vec4 src = texture2D(tDiffuse, uv);

    float px = 0.0015 * lineThickness;
    vec2 dx = vec2(px, 0.0);
    vec2 dy = vec2(0.0, px / max(ratio, 0.0001));

    vec3 cL = texture2D(tDiffuse, handleUVBounds(uv - dx)).rgb;
    vec3 cR = texture2D(tDiffuse, handleUVBounds(uv + dx)).rgb;
    vec3 cD = texture2D(tDiffuse, handleUVBounds(uv - dy)).rgb;
    vec3 cU = texture2D(tDiffuse, handleUVBounds(uv + dy)).rgb;

    float lL = dot(cL, vec3(0.299, 0.587, 0.114));
    float lR = dot(cR, vec3(0.299, 0.587, 0.114));
    float lD = dot(cD, vec3(0.299, 0.587, 0.114));
    float lU = dot(cU, vec3(0.299, 0.587, 0.114));

    float edge = length(vec2(lR - lL, lU - lD));
    float lines = smoothstep(edgeThreshold, edgeThreshold + 0.12, edge);

    vec3 blueprint = mix(blueprintBgColor, vec3(1.0), lines);

    vec3 finalRgb = mix(blueprint, src.rgb, animP);
    return vec4(finalRgb, src.a * borderMask);
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