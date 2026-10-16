exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float tendrilWidth; // = 0.03 [0.005, 0.08] // 触须宽度（相对画面高度）
uniform float liftDistance; // = 0.42 [0.1, 0.9] // 上浮距离
uniform float glowStrength; // = 0.35 [0.0, 1.0] // 软辉光强度（配合LumiDeepGlow）

varying vec2 vUv;

float tween(float p) {
    return clamp(p, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float remap01(float x, float a, float b) {
    return clamp((x - a) / max(b - a, 0.00001), 0.0, 1.0);
}

float easeExpoOut(float x) {
    x = clamp(x, 0.0, 1.0);
    return (x >= 1.0) ? 1.0 : (1.0 - pow(2.0, -10.0 * x));
}

float easeQuadIn(float x) {
    x = clamp(x, 0.0, 1.0);
    return x * x;
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

float noise2(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash21(i);
    float b = hash21(i + vec2(1.0, 0.0));
    float c = hash21(i + vec2(0.0, 1.0));
    float d = hash21(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.0) return texel;
    if (p >= 1.0) return vec4(0.0);

    float unfurl = easeExpoOut(remap01(p, 0.0, 0.5));
    float thin = easeQuadIn(remap01(p, 0.4, 0.8));
    float dissolve = remap01(p, 0.8, 0.95);
    float vanish = remap01(p, 0.95, 1.0);

    vec2 uv = vUv;
    float n0 = noise2(uv * 8.0 + vec2(0.0, p * 4.0));
    float n1 = noise2(uv * 21.0 + vec2(p * 7.0, p * 3.0));

    float curl = sin(uv.y * 18.0 + n0 * 6.2831853 + p * 9.0) * (0.018 + 0.02 * thin) * unfurl;
    vec2 flow = vec2(curl, -liftDistance * unfurl * (0.55 + 0.45 * n0));
    flow.x += (n1 - 0.5) * 0.02 * thin;
    flow.y -= noise2(uv * 13.0 + p * 6.0) * 0.10 * thin;

    vec2 srcUV = handleUVBounds(uv - flow);
    vec4 src = texture2D(tDiffuse, srcUV);

    float luma = dot(src.rgb, vec3(0.299, 0.587, 0.114));
    float hold = 1.0 - luma;
    float breakupSeed = smoothstep(0.12, 0.95, unfurl * 1.25 - hold * 0.9 + (noise2(uv * 30.0 + p * 11.0) - 0.5) * 0.35);
    float breakup = breakupSeed * unfurl;

    float sheetAlpha = 1.0 - smoothstep(0.08, 0.92, breakup);

    float lanes = mix(9.0, 52.0, thin);
    float sway = 0.10 * sin(srcUV.y * 15.0 + n0 * 10.0 + p * 6.0);
    float lane = fract((srcUV.x + sway) * lanes);

    float w = tendrilWidth * lanes * (ratio > 1.0 ? 1.0 : ratio);
    w = clamp(w, 0.01, 0.42);
    w *= mix(1.0, 0.22, thin);

    float dMain = abs(lane - 0.5);
    float mainThread = 1.0 - smoothstep(w, w * 1.8, dMain);

    float subLane = fract((srcUV.x + sway * 1.2 + noise2(srcUV * 40.0 + p * 20.0) * 0.02) * lanes * mix(1.0, 3.6, thin));
    float dSub = abs(subLane - 0.5);
    float splitThread = 1.0 - smoothstep(w * 0.55, w * 1.25, dSub);

    float threadMask = mix(mainThread, mainThread * splitThread, thin);
    float threadAlpha = smoothstep(0.15, 0.9, breakup) * threadMask;

    float threadFade = 1.0 - dissolve;
    float alpha = sheetAlpha + threadAlpha * threadFade;
    alpha *= (1.0 - vanish);

    float hazeNoise = noise2(uv * 55.0 + p * 25.0);
    float haze = dissolve * (1.0 - vanish) * 0.28 * hazeNoise;

    vec3 threadColor = src.rgb * (0.95 + 0.12 * noise2(srcUV * 33.0 + p * 13.0));
    vec3 color = mix(src.rgb, threadColor, threadAlpha);

    float bright = max(dot(color, vec3(0.2126, 0.7152, 0.0722)) - 0.58, 0.0);
    color += bright * threadAlpha * glowStrength * 0.22;

    float finalAlpha = clamp(alpha + haze * (1.0 - alpha), 0.0, 1.0);
    return vec4(clamp(color, 0.0, 1.0), finalAlpha);
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