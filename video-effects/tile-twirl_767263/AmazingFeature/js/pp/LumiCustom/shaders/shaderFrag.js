exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float uBrightness; // = 1.0 [0.5, 1.5] // 全局亮度
uniform float gateRadius; // = 0.22 [0.05, 0.5] // 旋涡外卷半径强度
uniform vec3 glowColor; // = vec3(0.35, 0.85, 1.0) // 门脊辉光颜色

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 34.45);
    return fract(p.x * p.y);
}

vec2 aspectVec(vec2 p) {
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float gateLine(vec2 p, vec2 dir, float width) {
    float d = abs(dot(p, dir));
    return 1.0 - smoothstep(width, width + 0.01, d);
}

vec4 effect(vec4 texel, float p) {
    const float T0 = 0.38 / 3.60;
    const float T1 = 0.56 / 3.60;
    const float T2 = 1.46 / 3.60;
    const float T3 = 2.32 / 3.60;
    const float T4 = 3.18 / 3.60;
    const float T5 = 1.00;

    float holdA = 1.0 - smoothstep(T0, T1, p);
    float openRise = smoothstep(T1, T2, p);
    float swapBlend = smoothstep(T2, T3, p);
    float closeFall = 1.0 - smoothstep(T3, T4, p);

    float vortexAmp = openRise * closeFall;
    float dirSign = mix(1.0, -1.0, swapBlend);

    vec2 grid = floor(vUv * 3.0);
    vec2 center = (grid + 0.5) / 3.0;
    vec2 local = vUv - center;
    vec2 localA = aspectVec(local);

    float r = length(localA);
    float a = atan(localA.y, localA.x);

    float jitter = hash21(grid + 0.17) * 0.25 + 0.875;
    float theta = dirSign * vortexAmp * 3.14159265 * jitter;
    float rAdd = gateRadius * vortexAmp * (0.75 + 0.25 * hash21(grid + 1.73));

    float c = cos(a + theta);
    float s = sin(a + theta);

    float flipOpen = openRise * (1.0 - swapBlend);
    float flipScaleX = mix(1.0, 0.309, flipOpen);

    vec2 warpedA = vec2(c, s) * (r + rAdd);
    warpedA.x *= flipScaleX;

    if (ratio > 1.0) warpedA.y *= ratio;
    else warpedA.x /= ratio;

    vec2 uvWarp = center + warpedA;
    uvWarp = handleUVBounds(uvWarp);

    vec2 vel = (uvWarp - vUv);
    float mbEnvA = smoothstep(T1, (0.56 + 0.52) / 3.60, p);
    float mbEnvB = 1.0 - smoothstep((2.60 - 0.24) / 3.60, 2.60 / 3.60, p);
    float motionBlur = 0.36 * mbEnvA * mbEnvB;
    vec2 uvTrail = handleUVBounds(uvWarp - vel * (0.5 + motionBlur));

    vec4 c0 = texture2D(tDiffuse, uvWarp);
    vec4 c1 = texture2D(tDiffuse, uvTrail);
    vec4 warped = mix(c0, c1, motionBlur);

    vec2 cp = aspectVec(vUv - 0.5);
    float gateOn = smoothstep(0.72 / 3.60, 0.94 / 3.60, p) * (1.0 - smoothstep(T3, T4, p));
    float g0 = gateLine(cp, normalize(vec2(1.0, 1.0)), 0.015);
    float g1 = gateLine(cp, normalize(vec2(1.0, -1.0)), 0.015);
    float g2 = gateLine(cp, normalize(vec2(0.92, 0.38)), 0.012);
    float g3 = gateLine(cp, normalize(vec2(0.38, 0.92)), 0.012);
    float gateMask = clamp((g0 + g1 + g2 + g3) * 0.35, 0.0, 1.0) * gateOn;

    float glowEnv = smoothstep(0.72 / 3.60, 1.52 / 3.60, p) * (1.0 - smoothstep(2.32 / 3.60, 2.90 / 3.60, p));
    float glow = pow(max(gateMask, 0.0), 1.4) * 0.18 * glowEnv;

    vec3 col = mix(texel.rgb, warped.rgb, 1.0 - holdA);
    col *= mix(1.0, 0.93, smoothstep(T4, T5, p));
    col = col * uBrightness + glowColor * glow;
    col = clamp(col, 0.0, 1.0);

    return vec4(col, texel.a);
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