exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float flashStrength; // = 0.85 [0.0, 1.5] // 白闪强度
uniform float glowStrength; // = 0.18 [0.0, 0.6] // LumiS_Glow低强度
uniform float bwContrast; // = 1.75 [1.0, 3.0] // 黑白对比度
uniform float zoomOut; // = 0.12 [0.0, 0.4] // 后退感缩放强度
uniform float sinkOffset; // = 0.04 [0.0, 0.2] // 下沉位移
uniform float darkStart; // = 0.38 [0.1, 0.9] // 开始变暗时间点

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec3 getGlowSample(vec2 uv, float radius) {
    vec2 px = vec2(radius, radius / max(ratio, 0.0001));
    vec3 g = vec3(0.0);
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2( px.x, 0.0))).rgb;
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2(-px.x, 0.0))).rgb;
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0,  px.y))).rgb;
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, -px.y))).rgb;
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2( px.x,  px.y))).rgb;
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2(-px.x,  px.y))).rgb;
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2( px.x, -px.y))).rgb;
    g += texture2D(tDiffuse, handleUVBounds(uv + vec2(-px.x, -px.y))).rgb;
    return g / 8.0;
}

vec4 effect(vec4 texel, float progress) {
    float p = progress;

    float retreat = smoothstep(0.22, 1.0, p);
    float scale = 1.0 + zoomOut * retreat;
    vec2 rawUV = 0.5 + (vUv - 0.5) * scale + vec2(0.0, sinkOffset * retreat);
    vec2 uv = handleUVBounds(rawUV);
    float borderMask = getHardBoundaryMask(rawUV);

    vec4 movedTexel = texture2D(tDiffuse, uv);

    float gray = dot(movedTexel.rgb, vec3(0.299, 0.587, 0.114));
    vec3 bw = vec3((gray - 0.5) * bwContrast + 0.5);
    bw = clamp(bw, 0.0, 1.0);

    float bwAmount = smoothstep(0.06, 0.26, p);
    vec3 color = mix(movedTexel.rgb, bw, bwAmount);

    float flashPeak = 0.16;
    float flashWidth = 0.22;
    float flash = smoothstep(0.0, flashPeak, p) * (1.0 - smoothstep(flashPeak, flashPeak + flashWidth, p));

    vec3 glow = getGlowSample(uv, 0.0035) * glowStrength * flash;
    color = mix(color + glow, vec3(1.0), flash * flashStrength);

    float preDark = 1.0 - 0.35 * smoothstep(0.30, 0.85, p);
    float finalFade = 1.0 - smoothstep(darkStart, 1.0, p);
    color *= preDark * finalFade;

    return vec4(clamp(color, 0.0, 1.0), movedTexel.a * borderMask * finalFade);
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