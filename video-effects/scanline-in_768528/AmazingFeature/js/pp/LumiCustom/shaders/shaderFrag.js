exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float bandDensity; // = 42.0 [12.0, 96.0] // 扫描带密度
uniform float bandSpeed; // = 18.0 [4.0, 40.0] // 扫描带下移速度
uniform float displacementAmp; // = 0.012 [0.0, 0.05] // 水平位移强度
uniform float waveFreq; // = 22.0 [4.0, 60.0] // 位移波频率

varying vec2 vUv;

float tween(float p) {
    return p;
}

float expInOut(float p) {
    p = clamp(p, 0.0, 1.0);
    if (p <= 0.0) return 0.0;
    if (p >= 1.0) return 1.0;
    if (p < 0.5) return 0.5 * pow(2.0, 20.0 * p - 10.0);
    return 1.0 - 0.5 * pow(2.0, -20.0 * p + 10.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    const float tStart = 0.0666667;
    const float tRevealEnd = 0.6666667;
    const float tCleanEnd = 0.8;

    if (p < tStart) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    if (p >= tRevealEnd) {
        return texel;
    }

    float revealT = clamp((p - tStart) / (tRevealEnd - tStart), 0.0, 1.0);
    float eased = expInOut(revealT);

    float yTop = 1.0 - vUv.y;
    float frontier = eased;

    float connectedFill = 1.0 - smoothstep(frontier - 0.0025, frontier + 0.0025, yTop);

    float cell = fract(yTop * bandDensity - revealT * bandSpeed);
    float thickness = mix(0.06, 0.98, eased);
    float stripeMask = step(cell, thickness);

    float scanMask = connectedFill * stripeMask;
    float mergeToSolid = smoothstep(0.72, 1.0, eased);
    float revealMask = mix(scanMask, connectedFill, mergeToSolid);

    float centerTime = 0.4;
    float bell = exp(-pow((p - centerTime) / 0.12, 2.0));
    float revealWindow = smoothstep(tStart, tStart + 0.03, p) * (1.0 - smoothstep(tRevealEnd - 0.03, tRevealEnd, p));
    float disp = displacementAmp * bell * revealWindow;

    vec2 uv = vUv;
    uv.x += sin((vUv.y * waveFreq + revealT * 2.0) * 6.2831853) * disp;
    uv = handleUVBounds(uv);

    vec4 col = texture2D(tDiffuse, uv);
    return vec4(col.rgb * revealMask, 1.0);
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