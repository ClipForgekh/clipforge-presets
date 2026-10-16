exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform vec3 neonColor; // = vec3(1.0, 0.25, 0.95) // 霓虹主色（粉紫）
uniform float blurRadius; // = 0.028 [0.0, 0.08] // 初始方向模糊半径（UV尺度）
uniform float glowIntensity; // = 3.5 [0.0, 6.0] // 初始发光强度
uniform float glowPeak; // = 4.0 [0.0, 8.0] // 脉冲峰值强度
uniform float brightnessStart; // = 2.2 [0.5, 3.0] // 初始亮度
uniform float contrastStart; // = 0.5 [0.0, 2.0] // 初始对比度
uniform float neonWidth; // = 0.035 [0.005, 0.12] // 扫光带宽度
uniform float dispersion; // = 0.006 [0.0, 0.03] // RGB色散强度

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    return smoothstep(0.0, 1.0, progress);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 sampleDispersion(vec2 uv, vec2 off) {
    vec2 uvR = handleUVBounds(uv + off);
    vec2 uvG = handleUVBounds(uv);
    vec2 uvB = handleUVBounds(uv - off);
    return vec4(texture2D(tDiffuse, uvR).r, texture2D(tDiffuse, uvG).g, texture2D(tDiffuse, uvB).b, texture2D(tDiffuse, uvG).a);
}

vec3 directionalBlur(vec2 uv, vec2 dir, float radius) {
    vec2 stepV = vec2(dir.x * radius, dir.y * radius / max(ratio, 0.0001));
    vec3 c = vec3(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv - stepV * 2.0)).rgb * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - stepV * 1.0)).rgb * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv)).rgb * 0.30;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepV * 1.0)).rgb * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepV * 2.0)).rgb * 0.12;
    return c;
}

vec3 applyBC(vec3 color, float brightness, float contrast) {
    vec3 cc = (color - 0.5) * contrast + 0.5;
    return clamp(cc * brightness, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float p = clamp(progress, 0.0, 1.0);

    float wipe = pow(p, 1.8);

    float s1 = vUv.x + vUv.y;
    float s2 = (1.0 - vUv.x) + vUv.y;
    float s3 = vUv.x + (1.0 - vUv.y);
    float s4 = (1.0 - vUv.x) + (1.0 - vUv.y);
    float minS = min(min(s1, s2), min(s3, s4));

    float edgeSoft = 0.002;
    float revealed = 1.0 - smoothstep(wipe - edgeSoft, wipe + edgeSoft, minS);
    float unrevealed = 1.0 - revealed;

    float curBlur = blurRadius * (1.0 - p);
    vec3 blurA = directionalBlur(vUv, normalize(vec2(1.0, 1.0)), curBlur);
    vec3 blurB = directionalBlur(vUv, normalize(vec2(-1.0, 1.0)), curBlur);
    vec3 blurred = mix(blurA, blurB, 0.5);

    float curBrightness = mix(brightnessStart, 1.0, p);
    float curContrast = mix(contrastStart, 1.0, p);
    vec3 styled = applyBC(blurred, curBrightness, curContrast);

    float w = max(mix(neonWidth, 0.002, p), 0.0001);
    float b1 = exp(-pow(abs(s1 - wipe) / w, 2.0));
    float b2 = exp(-pow(abs(s2 - wipe) / w, 2.0));
    float b3 = exp(-pow(abs(s3 - wipe) / w, 2.0));
    float b4 = exp(-pow(abs(s4 - wipe) / w, 2.0));
    float edgeBand = max(max(b1, b2), max(b3, b4));

    float pulseShape = exp(-pow((p - 0.32) / 0.16, 2.0));
    float glow = mix(glowIntensity, glowPeak, pulseShape) * (1.0 - p);

    vec2 dispDir = normalize(vec2(1.0, -1.0));
    vec2 dispOff = vec2(dispDir.x * dispersion, dispDir.y * dispersion / max(ratio, 0.0001)) * (1.0 - p);
    vec3 dispCol = sampleDispersion(vUv, dispOff).rgb;

    vec3 neon = (neonColor + dispCol * 0.35) * edgeBand * glow;

    vec3 fxLayer = clamp(styled + neon, 0.0, 1.0);
    vec3 finalRgb = mix(fxLayer, texel.rgb, revealed);

    return vec4(finalRgb, texel.a);
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