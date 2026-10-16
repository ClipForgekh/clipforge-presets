exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float waveWidth; // = 0.035 [0.01, 0.12] // 扫光波带宽度
uniform float waveSoftness; // = 0.03 [0.005, 0.12] // 显示边缘柔和度
uniform float glowStrength; // = 1.05 [0.2, 2.0] // 发光强度
uniform float sparkleDensity; // = 85.0 [20.0, 180.0] // 粒子密度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec2 toAspect(vec2 p) {
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = vUv;
    vec2 center = vec2(0.5);
    vec2 ap = toAspect(uv - center);

    vec2 sweepDir = normalize(vec2(1.0, 1.0));
    float diag = dot(ap, sweepDir);

    float wavePos = mix(-0.95, 0.95, p);

    float revealMask = smoothstep(-waveSoftness, waveSoftness, wavePos - diag);

    float bw = max(waveWidth, 0.0001);
    float d = abs(diag - wavePos);

    float waveCore = exp(-d / bw);
    float waveHalo = exp(-d / (bw * 3.5));
    float trail = exp(-max(0.0, wavePos - diag) / (bw * 8.0)) * exp(-d / (bw * 2.0));

    float density = max(sparkleDensity, 1.0);
    vec2 guv = uv * density;
    vec2 cid = floor(guv);
    vec2 gv = fract(guv) - 0.5;

    float rnd = hash21(cid);
    vec2 jitter = vec2(hash21(cid + 17.7), hash21(cid + 41.3)) - 0.5;
    vec2 starP = jitter * 0.6;

    float starShape = smoothstep(0.16, 0.0, length(gv - starP));
    vec2 starUv = (cid + starP + 0.5) / density;
    float starDiag = dot(toAspect(starUv - center), sweepDir);
    float onWave = exp(-abs(starDiag - wavePos) / (bw * 2.4));
    float spawn = smoothstep(0.52, 1.0, rnd);
    float twinkle = 0.65 + 0.35 * sin(p * 42.0 + rnd * 31.4159);
    float sparkle = starShape * onWave * spawn * twinkle;

    vec2 cp = toAspect(uv - center);
    float r = length(cp);
    float centerHit = exp(-abs(wavePos) / 0.08);
    float a = atan(cp.y, cp.x);
    float rays = pow(max(0.0, cos(a * 6.0 + p * 10.0)), 8.0);
    float centerBurst = (exp(-r / 0.13) + 0.7 * rays * exp(-r / 0.24)) * centerHit;

    float endFade = 1.0 - p;
    float particleFade = 1.0 - smoothstep(0.78, 1.0, p);

    float light = (waveCore * 1.2 + waveHalo * 0.4 + trail * 0.45) * endFade;
    light += sparkle * 1.1 * particleFade;
    light += centerBurst * 0.9 * particleFade;

    float hueMix = 0.5 + 0.5 * sin((diag - wavePos) * 20.0);
    vec3 aurora = mix(vec3(0.55, 0.85, 1.0), vec3(0.95, 0.72, 1.0), hueMix);
    vec3 glow = aurora * light * glowStrength;

    vec3 baseRgb = texel.rgb * revealMask;
    float baseA = texel.a * revealMask;

    vec3 finalRgb = clamp(baseRgb + glow, 0.0, 1.0);
    float glowA = clamp(light * 0.55, 0.0, 1.0) * (1.0 - baseA);
    float finalA = clamp(baseA + glowA, 0.0, 1.0);

    return vec4(finalRgb, finalA);
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