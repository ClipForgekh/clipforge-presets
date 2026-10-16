exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform int panelIndex; // = 1 [1, 9] // 面片索引：1主卡，2-9子卡
uniform float depthToUv; // = 0.015 [0.001, 0.05] // Z深度到UV的投影系数
uniform float panelOffsetScale; // = 0.03 [0.0, 0.12] // 子面片位置偏移缩放

varying vec2 vUv;

float tween(float p) {
    return clamp(p, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float easeExpOut(float p) {
    p = clamp(p, 0.0, 1.0);
    float d = 1.0 - exp2(-10.0);
    return (1.0 - exp2(-10.0 * p)) / d;
}

float easeCubicOut(float p) {
    p = clamp(p, 0.0, 1.0);
    float q = 1.0 - p;
    return 1.0 - q * q * q;
}

float easeQuadInOut(float p) {
    p = clamp(p, 0.0, 1.0);
    return (p < 0.5) ? (2.0 * p * p) : (1.0 - pow(-2.0 * p + 2.0, 2.0) * 0.5);
}

float getPanelStartSec(int idx) {
    if (idx <= 1) return 0.0;
    return 0.15 + float(idx - 2) * 0.07;
}

vec3 getPanelInitPos(int idx) {
    if (idx == 2) return vec3(6.5, 6.5, -2.0);
    if (idx == 3) return vec3(-6.5, 6.5, -3.0);
    if (idx == 4) return vec3(6.5, -6.5, -4.0);
    if (idx == 5) return vec3(-6.5, -6.5, -5.0);
    if (idx == 6) return vec3(9.2, 0.0, -6.0);
    if (idx == 7) return vec3(-9.2, 0.0, -7.0);
    if (idx == 8) return vec3(0.0, 9.2, -8.0);
    if (idx == 9) return vec3(0.0, -9.2, -9.0);
    return vec3(0.0, 0.0, 0.0);
}

mat2 rot2(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    float totalSec = 1.9;
    float t = clamp(p, 0.0, 1.0) * totalSec;

    float parentP = clamp(t / 1.4, 0.0, 1.0);
    float parentEase = easeExpOut(parentP);

    float parentZ = mix(-200.0, 0.0, parentEase);
    float parentRotZ = radians(mix(1080.0, 0.0, parentEase));

    float fovP = clamp((t - 1.0) / 0.9, 0.0, 1.0);
    float fov = mix(88.0, 53.13, easeQuadInOut(fovP));
    float focal = 1.0 / tan(radians(fov * 0.5));

    float parentScale = focal / (focal + abs(parentZ) * depthToUv);
    parentScale = max(parentScale, 0.0001);

    int idx = panelIndex;
    float panelStart = getPanelStartSec(idx);
    float panelDur = (idx == 1) ? 1.10 : 0.95;
    float panelP = clamp((t - panelStart) / panelDur, 0.0, 1.0);
    float panelEase = easeCubicOut(panelP);

    vec3 initPos = getPanelInitPos(idx);
    float localZ = mix(initPos.z, 0.0, panelEase);

    float scaleAll = max(parentScale * max(panelEase, 0.00001), 0.00001);

    vec2 posUV = initPos.xy * panelOffsetScale;
    float depthAtten = 1.0 / (1.0 + abs(parentZ + localZ) * depthToUv * 2.0);
    vec2 currentOffset = posUV * depthAtten * panelEase;

    vec2 pUv = vUv - 0.5;
    pUv = rot2(parentRotZ) * pUv;
    vec2 warped = pUv / scaleAll + 0.5 - currentOffset;

    float maskGeom = getHardBoundaryMask(warped) * step(0.0001, panelEase);
    vec2 sampleUV = handleUVBounds(warped);
    vec4 col = texture2D(tDiffuse, sampleUV);

    return vec4(col.rgb * maskGeom, texel.a);
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