exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float turbulenceAmount; // = 0.06 [0.0, 0.2] // 湍流位移最大强度
uniform float blobScale; // = 20.0 [5.0, 40.0] // 细胞分裂团块尺度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

float easeOutCubic(float x) {
    float t = clamp(x, 0.0, 1.0);
    return 1.0 - pow(1.0 - t, 3.0);
}

float elasticOut(float x) {
    float t = clamp(x, 0.0, 1.0);
    if (t <= 0.0) return 0.0;
    if (t >= 1.0) return 1.0;
    float c4 = 2.09439510239;
    return pow(2.0, -10.0 * t) * sin((t * 10.0 - 0.75) * c4) + 1.0;
}

float decay01(float p, float startT, float endT) {
    if (p <= startT) return 1.0;
    if (p >= endT) return 0.0;
    return 1.0 - (p - startT) / (endT - startT);
}

vec2 sphericalizeUV(vec2 uv, float amount) {
    vec2 pc = getSDFCoordinate(uv, vec2(0.5));
    float r = length(pc);
    float lens = 1.0 - amount * 0.55 * exp(-r * 6.0);
    vec2 q = pc * lens;
    if (ratio > 1.0) q.y *= ratio;
    else q.x /= ratio;
    return vec2(0.5) + q;
}

vec2 turbulentDisplace(vec2 uv, float amount, float p) {
    float evo = p * 140.0;
    vec2 q = uv * blobScale;
    float n1 = sin(q.y * 2.1 + evo) + cos(q.x * 1.7 - evo * 0.9);
    float n2 = sin(q.x * 1.9 - evo * 1.1) - cos(q.y * 2.3 + evo * 0.8);
    vec2 disp = vec2(n1, n2) * 0.5;
    return uv + disp * amount;
}

vec4 effect(vec4 texel, float p) {
    const float blackEnd = 0.0666667;
    const float growEnd = 0.6000000;
    const float lockEnd = 0.6333333;

    if (p <= blackEnd) return vec4(0.0);

    if (p >= lockEnd) return texel;

    float growT = clamp((p - blackEnd) / (growEnd - blackEnd), 0.0, 1.0);
    float growEase = easeOutCubic(growT);

    float blobbyDecay = decay01(p, 0.0666667, 0.5666667);
    float turbDecay = decay01(p, 0.1000000, 0.5333333);
    float sphDecay = decay01(p, 0.0666667, 0.4666667);

    vec2 uv = vUv;
    uv = sphericalizeUV(uv, sphDecay);
    uv = turbulentDisplace(uv, turbulenceAmount * turbDecay, p);
    uv = handleUVBounds(uv);

    vec4 col = texture2D(tDiffuse, uv);

    vec2 pc = getSDFCoordinate(vUv, vec2(0.5));
    float dist = length(pc);
    float maxR = getMaxShapeSize();

    float lockT = clamp((p - growEnd) / (lockEnd - growEnd), 0.0, 1.0);
    float lockEase = elasticOut(lockT);

    float baseR = mix(0.0008, maxR * 0.85, growEase);
    baseR = mix(baseR, maxR * 1.05, lockEase);

    float blobWave =
        sin(pc.x * blobScale * 12.0 + p * 95.0) *
        cos(pc.y * blobScale * 11.0 - p * 88.0);
    float blobAmp = 0.18 * blobbyDecay;
    float softness = mix(0.08, 0.001, 1.0 - blobbyDecay);

    float field = (baseR - dist) + blobWave * blobAmp;
    float mask = smoothstep(-softness, softness, field);

    return vec4(col.rgb * mask, col.a * mask);
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