exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float bands; // = 18.0 [6.0, 48.0] // 水平分段数量
uniform float displacementStrength; // = 0.08 [0.01, 0.2] // 初始水平错位强度
uniform float magneticPull; // = 0.22 [0.0, 0.5] // 向中心磁吸强度
uniform float overshootAmount; // = 0.006 [0.0, 0.02] // 临近对齐时的超调量
uniform float ghostAmount; // = 0.003 [0.0, 0.01] // RGB拖影强度
uniform float tapeAmount; // = 0.012 [0.0, 0.04] // 模拟磁带扭曲强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    float b = max(1.0, floor(bands));
    float bandId = floor(vUv.y * b);

    float rndA = hash(bandId * 13.17 + 1.23);
    float rndB = hash(bandId * 7.91 + 9.71);
    float rndC = hash(bandId * 5.33 + 3.57);

    float delay = 0.16 * rndB;
    float t = clamp((p - delay) / max(0.0001, 1.0 - delay), 0.0, 1.0);
    float response = mix(0.7, 1.45, rndC);
    float localP = pow(t, response);

    float initShift = (rndA * 2.0 - 1.0) * displacementStrength;
    float baseShift = initShift * (1.0 - localP);

    float overWin = smoothstep(0.74, 0.88, localP) * (1.0 - smoothstep(0.88, 1.0, localP));
    float overshoot = -sign(initShift) * overshootAmount * overWin;

    float tapeWindow = smoothstep(0.80, 0.84, p) * (1.0 - smoothstep(0.90, 0.94, p));
    float lineRnd = hash(floor(vUv.y * 320.0) + bandId * 1.7);
    float tapeJitter = ((lineRnd - 0.5) * 2.0 + sin(vUv.y * 420.0 + bandId * 0.9) * 0.5) * tapeAmount * tapeWindow;

    float shift = baseShift + overshoot + tapeJitter;

    float centerFactor = 1.0 - abs(vUv.x - 0.5) * 2.0;
    float centerPull = magneticPull * (1.0 - localP) * (0.75 + 0.25 * rndC) * clamp(centerFactor, 0.0, 1.0);

    vec2 uv = vUv;
    uv.x += shift;
    uv.x = mix(uv.x, 0.5, centerPull);
    uv = handleUVBounds(uv);

    float motion = clamp((1.0 - localP) + tapeWindow * 0.6, 0.0, 1.0);
    float g = ghostAmount * motion * (0.8 + 0.4 * rndA);

    vec2 uvR = handleUVBounds(uv + vec2(g, 0.0));
    vec2 uvB = handleUVBounds(uv - vec2(g, 0.0));

    vec4 cG = texture2D(tDiffuse, uv);
    vec4 cR = texture2D(tDiffuse, uvR);
    vec4 cB = texture2D(tDiffuse, uvB);

    vec3 rgb = vec3(cR.r, cG.g, cB.b);
    return vec4(rgb, cG.a);
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