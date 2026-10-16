exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float sliceCount; // = 18.0 [6.0, 48.0] // VHS横向切片数量
uniform float displacement; // = 0.045 [0.0, 0.2] // 切片位移强度
uniform float rgbOffset; // = 0.003 [0.0, 0.02] // RGB通道偏移强度
uniform float scanlineStrength; // = 0.06 [0.0, 0.2] // 扫描线强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash11(float n) {
    return fract(sin(n * 127.1) * 43758.5453123);
}

vec4 effect(vec4 texel, float p) {
    float sliceN = max(2.0, floor(sliceCount));
    float s = floor(vUv.y * sliceN);
    float sliceCenterY = (s + 0.5) / sliceN;

    float centerDist = abs((s + 0.5) - 0.5 * sliceN) / (0.5 * sliceN);

    float revealCore = smoothstep(-0.05, 0.25, p * 1.35 - centerDist);
    float startupGate = smoothstep(0.02, 0.10, p);
    float reveal = revealCore * startupGate;

    float alignKill = 1.0 - smoothstep(0.42, 0.75, p);
    float baseStrength = (1.0 - p) * alignKill;

    float r1 = hash11(s + 1.23);
    float r2 = hash11(s + 9.71);
    float r3 = hash11(s + 23.17);

    float pulseCenter = mix(0.14, 0.48, r1);
    float pulseWidth = mix(0.035, 0.09, r2);
    float pulse = exp(-pow((p - pulseCenter) / pulseWidth, 2.0));

    float jitter = sin((p * 70.0 + r2 * 6.2831853) + vUv.y * 90.0) * 0.5
                 + sin((p * 120.0 + r3 * 6.2831853) + vUv.y * 38.0) * 0.5;

    float xShift = displacement * (baseStrength * (r1 - 0.5) * 1.3 + pulse * jitter * 0.7);
    float yShift = displacement * 0.35 * (1.0 - p) * (r2 - 0.5);

    float finalTrackPulse = exp(-pow((p - 0.82) / 0.045, 2.0));
    float globalTrack = (sin(vUv.y * 180.0) + 0.5 * sin(vUv.y * 55.0 + 1.4)) * 0.0028 * finalTrackPulse;

    vec2 uvBase = vec2(vUv.x + xShift + globalTrack, vUv.y + yShift);
    uvBase = handleUVBounds(uvBase);

    float rgbAmp = rgbOffset * (0.25 + 0.75 * (1.0 - p)) * (0.6 + 0.4 * pulse);
    vec2 uvR = handleUVBounds(uvBase + vec2(rgbAmp, 0.0));
    vec2 uvG = uvBase;
    vec2 uvB = handleUVBounds(uvBase - vec2(rgbAmp, 0.0));

    vec3 col;
    col.r = texture2D(tDiffuse, uvR).r;
    col.g = texture2D(tDiffuse, uvG).g;
    col.b = texture2D(tDiffuse, uvB).b;

    float scan = sin((vUv.y + p * 0.15) * 900.0);
    float scanMix = scanlineStrength * (0.35 + 0.65 * (1.0 - p));
    col *= 1.0 - scanMix * (0.5 + 0.5 * scan);

    vec4 outColor = vec4(col, texel.a * reveal);
    return mix(outColor, texel, smoothstep(0.93, 1.0, p));
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