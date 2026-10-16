exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float uBaseBrightness; // = 0.8 [0.0, 2.0] // 基础亮度（主卡可设为1.0，副片建议0.8）
uniform float uQuadrantPhase; // = 0.0 [0.0, 6.2831853] // 四象限亮度相位偏移
uniform float uSpinStrength; // = 0.03 [0.0, 0.12] // 周向旋转UV扰动强度
uniform float uWeaveStrength; // = 0.015 [0.0, 0.08] // 编织错位强度
uniform float uWingStrength; // = 0.012 [0.0, 0.08] // 翼拍扰动强度
uniform float uPullStrength; // = 0.018 [0.0, 0.08] // 法线抽拉感强度
uniform float uMotionBlurMax; // = 0.13 [0.0, 0.3] // 周向运动模糊最大强度
uniform float uBokehMax; // = 0.10 [0.0, 0.3] // 远端景深模糊最大强度
uniform float uDeepLayerMask; // = 0.0 [0.0, 1.0] // 深层片遮罩（P12-P16设为1）

varying vec2 vUv;

const float PI = 3.14159265;
const float TAU = 6.2831853;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectCorrectOffset(vec2 p) {
    vec2 q = p;
    if (ratio > 1.0) q.y /= ratio;
    else q.x *= ratio;
    return q;
}

vec4 sampleVortexBlur(vec2 uv, vec2 center, float blurAmount) {
    vec2 d = uv - center;
    vec2 dd = getAspectCorrectOffset(d);
    float r = max(length(dd), 0.0001);
    vec2 tangent = vec2(-dd.y, dd.x) / r;

    if (ratio > 1.0) tangent.y *= ratio;
    else tangent.x /= ratio;

    vec2 ofs = tangent * blurAmount;
    vec2 uv0 = handleUVBounds(uv - ofs * 1.5);
    vec2 uv1 = handleUVBounds(uv - ofs * 0.75);
    vec2 uv2 = handleUVBounds(uv);
    vec2 uv3 = handleUVBounds(uv + ofs * 0.75);
    vec2 uv4 = handleUVBounds(uv + ofs * 1.5);

    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, uv0) * 0.12;
    c += texture2D(tDiffuse, uv1) * 0.23;
    c += texture2D(tDiffuse, uv2) * 0.30;
    c += texture2D(tDiffuse, uv3) * 0.23;
    c += texture2D(tDiffuse, uv4) * 0.12;
    return c;
}

vec4 sampleHexBokeh(vec2 uv, float amount) {
    vec2 stepXY = vec2(amount, amount / max(ratio, 0.0001));
    vec2 d0 = vec2(1.0, 0.0) * stepXY;
    vec2 d1 = vec2(0.5, 0.8660254) * stepXY;
    vec2 d2 = vec2(-0.5, 0.8660254) * stepXY;
    vec2 d3 = vec2(-1.0, 0.0) * stepXY;
    vec2 d4 = vec2(-0.5, -0.8660254) * stepXY;
    vec2 d5 = vec2(0.5, -0.8660254) * stepXY;

    vec4 c = texture2D(tDiffuse, handleUVBounds(uv)) * 0.34;
    c += texture2D(tDiffuse, handleUVBounds(uv + d0)) * 0.11;
    c += texture2D(tDiffuse, handleUVBounds(uv + d1)) * 0.11;
    c += texture2D(tDiffuse, handleUVBounds(uv + d2)) * 0.11;
    c += texture2D(tDiffuse, handleUVBounds(uv + d3)) * 0.11;
    c += texture2D(tDiffuse, handleUVBounds(uv + d4)) * 0.11;
    c += texture2D(tDiffuse, handleUVBounds(uv + d5)) * 0.11;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float cyc = TAU * p;
    float s = sin(cyc);
    float c = cos(cyc);

    vec2 center = vec2(0.5, 0.5);
    vec2 uv = vUv;

    vec2 rel = uv - center;
    vec2 relA = getAspectCorrectOffset(rel);
    float r = length(relA);

    float wing = uWingStrength * sin(cyc + relA.y * 8.0);
    float weave = uWeaveStrength * sin(cyc + relA.x * 10.0 + relA.y * 6.0);
    float pull = uPullStrength * sin(cyc + r * 18.0);
    float spin = uSpinStrength * (0.65 + 0.35 * cos(cyc));

    vec2 tangent = vec2(-relA.y, relA.x);
    uv += tangent * spin;
    uv += vec2(weave, wing + pull * 0.6);

    uv = handleUVBounds(uv);

    float motionBlur = uMotionBlurMax * (s * s);
    vec4 col = sampleVortexBlur(uv, center, motionBlur);

    float bokehWave = 0.5 * (1.0 - cos(cyc));
    float bokehAmount = uBokehMax * bokehWave * clamp(uDeepLayerMask, 0.0, 1.0);
    vec4 bokehCol = sampleHexBokeh(uv, bokehAmount);
    col = mix(col, bokehCol, clamp(uDeepLayerMask, 0.0, 1.0) * 0.85);

    float brightness = uBaseBrightness + 0.10 * sin(cyc + uQuadrantPhase);
    col.rgb *= clamp(brightness, 0.0, 2.0);

    col.rgb = clamp(col.rgb, 0.0, 1.0);
    col.a = texel.a;
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