exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float activePortion; // = 0.972973 [0.8, 1.0]
uniform float zoomStart; // = 1.5 [1.0, 2.0]

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float keyLerp5(float t, float v0, float v1, float v2, float v3, float v4) {
    if (t < 0.25) {
        return mix(v0, v1, t / 0.25);
    } else if (t < 0.5) {
        return mix(v1, v2, (t - 0.25) / 0.25);
    } else if (t < 0.75) {
        return mix(v2, v3, (t - 0.5) / 0.25);
    }
    return mix(v3, v4, (t - 0.75) / 0.25);
}

vec4 effect(vec4 texel, float pIn) {
    float p = clamp(pIn / max(activePortion, 0.0001), 0.0, 1.0);

    float baseZoom = keyLerp5(p, zoomStart, 1.38, 1.25, 1.12, 1.0);
    float diffRB = keyLerp5(p, 0.30, 0.22, 0.15, 0.08, 0.0);
    float diffGB = diffRB * 0.5;

    float zoomB = baseZoom;
    float zoomG = baseZoom * (1.0 + diffGB);
    float zoomR = baseZoom * (1.0 + diffRB);

    vec2 uvB = handleUVBounds(0.5 + (vUv - 0.5) / zoomB);
    vec2 uvG = handleUVBounds(0.5 + (vUv - 0.5) / zoomG);
    vec2 uvR = handleUVBounds(0.5 + (vUv - 0.5) / zoomR);

    vec4 texB = texture2D(tDiffuse, uvB);
    vec4 texG = texture2D(tDiffuse, uvG);
    vec4 texR = texture2D(tDiffuse, uvR);

    vec3 rgb = vec3(texR.r, texG.g, texB.b);
    return vec4(rgb, texel.a);
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