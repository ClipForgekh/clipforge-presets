exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2]
uniform float maxDisplace; // = 40.0 [0.0, 100.0]
uniform float turbulenceSize; // = 120.0 [20.0, 300.0]
uniform float noiseMax; // = 0.35 [0.0, 1.0]
uniform vec3 highlightsColor; // = vec3(1.0, 0.15, 0.12)
uniform vec3 midtonesColor; // = vec3(0.45, 0.02, 0.06)
uniform vec3 shadowsColor; // = vec3(0.0, 0.0, 0.0)

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float easeSineInOut(float x) {
    return 0.5 - 0.5 * cos(3.14159265 * clamp(x, 0.0, 1.0));
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec2 fluidField(vec2 uv, float t, float sizeCtrl) {
    float s = max(sizeCtrl, 1.0);
    vec2 p = uv * (8.0 / s) * 120.0;
    float a = sin(p.y * 1.7 + t * 2.1) + cos(p.x * 1.3 - t * 1.7);
    float b = sin((p.x + p.y) * 1.1 - t * 1.3) + cos((p.x - p.y) * 1.5 + t * 1.9);
    vec2 dir = vec2(a, b);
    return dir * 0.5;
}

vec3 applyTritone(vec3 col, vec3 sh, vec3 mid, vec3 hi) {
    float l = dot(col, vec3(0.299, 0.587, 0.114));
    vec3 lowToMid = mix(sh, mid, smoothstep(0.0, 0.55, l));
    vec3 midToHigh = mix(mid, hi, smoothstep(0.45, 1.0, l));
    float w = smoothstep(0.35, 0.75, l);
    return mix(lowToMid, midToHigh, w);
}

vec4 effect(vec4 texel, float p) {
    float t = p * 3.0;

    float emerge = clamp((t - 0.2) / (1.5 - 0.2), 0.0, 1.0);
    emerge = smoothstep(0.0, 1.0, emerge);

    float dispPhase = clamp((t - 0.2) / (2.0 - 0.2), 0.0, 1.0);
    float dispAmt = maxDisplace * (1.0 - easeSineInOut(dispPhase));

    float noisePhase = clamp((t - 0.2) / (2.2 - 0.2), 0.0, 1.0);
    float grainAmt = noiseMax * (1.0 - easeSineInOut(noisePhase));

    float triFade = clamp((t - 1.8) / (2.5 - 1.8), 0.0, 1.0);
    float triOpacity = 1.0 - triFade;
    triOpacity *= step(0.2, t);

    vec2 flow = fluidField(vUv, t, turbulenceSize);
    vec2 disp = flow * (dispAmt * 0.001);
    disp.x /= max(ratio, 0.0001);
    vec2 uv = handleUVBounds(vUv + disp);

    vec4 src = texture2D(tDiffuse, uv);

    vec3 tri = applyTritone(src.rgb, shadowsColor, midtonesColor, highlightsColor);
    vec3 colorAfterTone = mix(src.rgb, tri, triOpacity);

    float n = hash12(vUv * vec2(1920.0, 1080.0) + vec2(t * 17.23, t * 11.71)) - 0.5;
    vec3 grainColor = colorAfterTone + n * grainAmt;
    grainColor = clamp(grainColor, 0.0, 1.0);

    vec3 developed = grainColor;
    vec3 finalRgb = mix(vec3(0.0), developed, emerge);

    return vec4(finalRgb, 1.0);
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