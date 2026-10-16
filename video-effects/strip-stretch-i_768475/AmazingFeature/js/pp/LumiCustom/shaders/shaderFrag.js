exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float panelCount; // = 12.0 [2.0, 40.0]
uniform float panelStagger; // = 0.45 [0.0, 0.9]
uniform float riseHeight; // = 0.6 [0.0, 1.5]
uniform float cameraDropAmount; // = 0.18 [0.0, 0.6]
uniform float tiltStrength; // = 1.0 [0.0, 2.0]

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    if (p < 0.5) {
        return 0.5 * (1.0 - sqrt(max(0.0, 1.0 - 4.0 * p * p)));
    }
    float t = -2.0 * p + 2.0;
    return 0.5 * (sqrt(max(0.0, 1.0 - t * t)) + 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = vUv;
    vec2 centered = vUv - 0.5;

    float camDrop = (1.0 - p) * cameraDropAmount;
    float tilt = (1.0 - p) * tiltStrength;

    uv.y += camDrop;
    uv.y += centered.y * tilt * 0.15;
    uv.x += centered.y * tilt * 0.08 / max(ratio, 0.0001);

    float cols = max(1.0, panelCount);
    float panelId = floor(vUv.x * cols);
    float rnd = fract(sin((panelId + 1.0) * 91.7) * 43758.5453123);
    float start = rnd * panelStagger;
    float panelP = clamp((p - start) / max(0.0001, 1.0 - start), 0.0, 1.0);

    float lift = (1.0 - panelP) * riseHeight;
    uv.y += lift;

    uv = handleUVBounds(uv);
    vec4 moved = texture2D(tDiffuse, uv);

    float reveal = smoothstep(0.0, 0.22, panelP) * smoothstep(0.0, 0.12, p);
    return vec4(moved.rgb * reveal, moved.a * reveal);
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