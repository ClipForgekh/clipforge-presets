exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float rgbOffset; // = 0.032 [0.0, 0.08] // RGB分离强度（约0.032接近35px@1080短边）
uniform float curveStrength; // = 0.018 [0.0, 0.08] // 通道弧线轨迹强度
uniform float blurAmount; // = 0.006 [0.0, 0.03] // 方向模糊强度
uniform float overshootAmount; // = 0.12 [0.0, 0.35] // 过冲幅度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float quintOut(float t) {
    return 1.0 - pow(1.0 - t, 5.0);
}

float cubicOut(float t) {
    return 1.0 - pow(1.0 - t, 3.0);
}

float backOut(float t) {
    float c1 = 1.70158;
    float c3 = c1 + 1.0;
    float x = t - 1.0;
    return 1.0 + c3 * x * x * x + c1 * x * x;
}

vec4 sampleDirectional(vec2 uv, vec2 dir, float amt) {
    if (amt <= 0.000001) return texture2D(tDiffuse, handleUVBounds(uv));
    vec2 d = normalize(vec2(dir.x, dir.y / max(ratio, 0.0001))) * amt;

    vec4 c0 = texture2D(tDiffuse, handleUVBounds(uv - 2.0 * d));
    vec4 c1 = texture2D(tDiffuse, handleUVBounds(uv - 1.0 * d));
    vec4 c2 = texture2D(tDiffuse, handleUVBounds(uv));
    vec4 c3 = texture2D(tDiffuse, handleUVBounds(uv + 1.0 * d));
    vec4 c4 = texture2D(tDiffuse, handleUVBounds(uv + 2.0 * d));

    return (c0 * 0.08 + c1 * 0.22 + c2 * 0.40 + c3 * 0.22 + c4 * 0.08);
}

vec4 effect(vec4 texel, float p) {
    float t1 = 0.16 / 0.70;
    float t2 = 0.38 / 0.70;
    float t3 = 0.52 / 0.70;

    float align = 0.0;
    if (p < t1) {
        align = 0.0;
    } else if (p < t2) {
        float u = (p - t1) / (t2 - t1);
        align = quintOut(u);
    } else if (p < t3) {
        float u = (p - t2) / (t3 - t2);
        align = 1.0 + overshootAmount * (backOut(u) - u);
    } else {
        float u = (p - t3) / (1.0 - t3);
        align = 1.0 + overshootAmount * 0.08 * (1.0 - cubicOut(u));
    }

    float sep = 1.0 - align;
    float scale = 1.2 - 0.2 * quintOut(p);
    vec2 uvBase = 0.5 + (vUv - 0.5) / scale;

    vec2 pullDir = normalize(vec2(1.0, 0.2));
    vec2 perp = vec2(-pullDir.y, pullDir.x);

    float pathPhase = clamp(p / max(t2, 0.0001), 0.0, 1.0);
    float arcBase = sin(pathPhase * 3.14159265) * curveStrength * (1.0 - min(align, 1.0));

    vec2 offR = vec2(-rgbOffset * sep, 0.0);
    vec2 offG = vec2(0.0, 0.0);
    vec2 offB = vec2(rgbOffset * sep, 0.0);

    offR += perp * (arcBase * 1.00 + 0.004 * sep);
    offG += perp * (-arcBase * 0.55);
    offB += perp * (arcBase * 0.85 - 0.003 * sep);

    offR.y /= max(ratio, 0.0001);
    offG.y /= max(ratio, 0.0001);
    offB.y /= max(ratio, 0.0001);

    float curBlur = blurAmount * max(0.0, 1.0 - min(align, 1.0));

    vec4 rTex = sampleDirectional(uvBase + offR, pullDir, curBlur);
    vec4 gTex = sampleDirectional(uvBase + offG, pullDir, curBlur * 0.9);
    vec4 bTex = sampleDirectional(uvBase + offB, pullDir, curBlur);

    vec3 rgb = vec3(rTex.r, gTex.g, bTex.b);
    float alphaBase = texture2D(tDiffuse, handleUVBounds(uvBase)).a;
    float opacity = cubicOut(p);

    return vec4(rgb, alphaBase * opacity);
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