exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float columnCount; // = 88.0 [24.0, 180.0] // 下落列数
uniform float delaySpread; // = 0.22 [0.0, 0.45] // 列延迟分散
uniform float saturationDelay; // = 0.28 [0.0, 0.6] // 低饱和像素落地延迟
uniform float flashStrength; // = 0.55 [0.0, 1.5] // 落地闪光强度
uniform float trailStrength; // = 0.18 [0.0, 0.8] // 残留像素强度
uniform float glowLow; // = 0.22 [0.0, 0.8] // 低强度辉光

varying vec2 vUv;

float tween(float p) {
    return p;
}

float hash11(float p) {
    p = fract(p * 0.1031);
    p *= p + 33.33;
    p *= p + p;
    return fract(p);
}

float sinOut(float p) {
    return sin(p * 1.57079632679);
}

float quintOut(float p) {
    float q = 1.0 - p;
    return 1.0 - q * q * q * q * q;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    const float T_FALL_END = 1.3 / 1.9;
    const float T_SETTLE_START = 1.15 / 1.9;
    const float T_SETTLE_END = 1.7 / 1.9;
    const float T_CLEAR_START = 1.6 / 1.9;
    const float T_CLEAR_END = 1.85 / 1.9;
    const float T_GLOW_START = 0.2 / 1.9;
    const float T_GLOW_END = 1.0 / 1.9;

    float sat = max(max(texel.r, texel.g), texel.b) - min(min(texel.r, texel.g), texel.b);
    float lum = dot(texel.rgb, vec3(0.299, 0.587, 0.114));

    float colN = floor(vUv.x * columnCount);
    float colRnd = hash11(colN + 7.13);

    float colDelay = colRnd * delaySpread;
    float satDelay = (1.0 - sat) * saturationDelay;

    float fallP = clamp(p / T_FALL_END, 0.0, 1.0);
    float settleP = clamp((p - T_SETTLE_START) / (T_SETTLE_END - T_SETTLE_START), 0.0, 1.0);

    float buildFall = sinOut(fallP) * 0.88;
    float buildSettle = quintOut(settleP);
    float build = max(buildFall, buildSettle);

    float localBuild = clamp((build - colDelay - satDelay) / max(1.0 - delaySpread - saturationDelay, 0.0001), 0.0, 1.0);
    float landedMask = step(vUv.y, localBuild);

    float colCenter = (colN + 0.5) / columnCount;
    float colHalf = 0.5 / columnCount;
    float colMask = 1.0 - smoothstep(colHalf * 0.45, colHalf * 0.95, abs(vUv.x - colCenter));

    float headStart = 0.06;
    float rainP = sinOut(clamp((p + headStart) / (T_FALL_END + headStart), 0.0, 1.0));
    float headY = 1.15 - rainP * (1.35 + colRnd * 0.35) - satDelay * 0.55;
    float dropCore = exp(-abs(vUv.y - headY) * 120.0);

    float trailBand = exp(-max(headY - vUv.y, 0.0) * 22.0) * step(vUv.y, headY);
    float fallingMask = (dropCore + trailBand * 0.38) * colMask * (1.0 - landedMask);

    float landTime = colDelay + satDelay + vUv.y * max(1.0 - delaySpread - saturationDelay, 0.0001);
    float landedNow = step(landTime, build);
    float flashAge = clamp((build - landTime) / 0.06, 0.0, 1.0);
    float flashPulse = landedNow * sin(flashAge * 3.14159265) * exp(-flashAge * 4.8);
    float flash = flashPulse * flashStrength * landedMask;

    vec2 g = floor(vUv * vec2(columnCount * 0.9, 160.0));
    float n = hash11(g.x * 17.0 + g.y * 0.73 + 3.1);
    float straySeed = step(0.985, n);
    float drift = fract(vUv.y + p * (0.55 + hash11(g.x + 2.0) * 0.45));
    float stray = straySeed * smoothstep(0.05, 0.0, abs(drift - 0.5)) * trailStrength;

    float clearP = clamp((p - T_CLEAR_START) / (T_CLEAR_END - T_CLEAR_START), 0.0, 1.0);
    float clearK = quintOut(clearP);
    stray *= (1.0 - clearK);

    vec3 rainColor = mix(vec3(lum), texel.rgb, 0.35 + 0.65 * sat);
    vec3 color = vec3(0.0);
    color += texel.rgb * landedMask;
    color += rainColor * fallingMask;
    color += mix(vec3(1.0), texel.rgb, 0.35) * flash;
    color += rainColor * stray;

    float glowWindow = smoothstep(T_GLOW_START, T_GLOW_START + 0.03, p) * (1.0 - smoothstep(T_GLOW_END - 0.04, T_GLOW_END, p));
    float glow = pow(max(dot(color, vec3(0.2126, 0.7152, 0.0722)) - 0.62, 0.0), 1.4) * glowLow * glowWindow;
    color += glow * vec3(1.0, 0.98, 0.95);

    float alphaMask = max(landedMask, max(fallingMask * 0.95, stray * 0.8));
    return vec4(clamp(color, 0.0, 1.0), texel.a * clamp(alphaMask, 0.0, 1.0));
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