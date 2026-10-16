exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float layerDelay; // = 0.16 [0.05, 0.35] // delay between layers
uniform float offsetAmount; // = 0.18 [0.0, 0.5] // layer position offset
uniform float scaleAmount; // = 0.22 [0.0, 0.6] // layer scale spread

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float layerInProgress(float p, float delay) {
    float x = clamp((p - delay) / max(1.0 - delay, 0.0001), 0.0, 1.0);
    return smoothstep(0.0, 1.0, x);
}

vec4 over(vec4 below, vec4 above) {
    float outA = above.a + below.a * (1.0 - above.a);
    vec3 outRGB = (above.rgb * above.a + below.rgb * below.a * (1.0 - above.a)) / max(outA, 0.0001);
    return vec4(outRGB, outA);
}

vec4 sampleLayer(float p, float delay, vec2 dir, float scaleMul, float alphaMul) {
    float lp = layerInProgress(p, delay);
    float inv = 1.0 - lp;

    vec2 dirFixed = vec2(dir.x, dir.y / max(ratio, 0.0001));
    float scale = 1.0 + scaleAmount * scaleMul * inv;
    vec2 uv = 0.5 + (vUv - 0.5) * scale + dirFixed * offsetAmount * inv;

    float mask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);

    vec4 c = texture2D(tDiffuse, uv);
    c.a *= lp * alphaMul * mask;
    return c;
}

vec4 effect(vec4 texel, float p) {
    vec4 backLayer  = sampleLayer(p, 0.00, vec2(-0.70,  0.55), 1.00, 0.45);
    vec4 midLayer   = sampleLayer(p, layerDelay, vec2( 0.55, -0.35), 0.65, 0.70);
    vec4 frontLayer = sampleLayer(p, layerDelay * 2.0, vec2(-0.25, -0.20), 0.35, 1.00);

    vec4 stacked = over(over(backLayer, midLayer), frontLayer);

    float settle = smoothstep(0.75, 1.0, p);
    return mix(stacked, texel, settle);
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