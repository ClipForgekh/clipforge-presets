exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2]
uniform float swayStrength; // = 0.22 [0.0, 0.8]
uniform float openSnap; // = 0.45 [0.2, 1.2]
uniform float arcStrength; // = 0.28 [0.0, 0.8]
uniform float flareStrength; // = 0.35 [0.0, 1.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    vec2 q = vUv - 0.5;

    float openT = smoothstep(0.30, 0.80, p);
    float flatT = smoothstep(0.78, 1.0, p);
    float folded = 1.0 - openT;

    float angle = sin(p * 12.5663706) * swayStrength * folded;
    float s = sin(angle);
    float c = cos(angle);
    q = vec2(c * q.x - s * q.y, s * q.x + c * q.y);

    float sx = mix(0.045, 1.0, pow(openT, openSnap));
    float arc = arcStrength * openT * (1.0 - flatT);
    q.y += arc * (q.x * q.x * 4.0 - 0.5);

    float fanMask = step(abs(q.x), 0.5 * sx);
    vec2 uv = vec2(0.5 + q.x / max(sx, 0.0001), 0.5 + q.y);
    uv = handleUVBounds(uv);

    vec4 col = texture2D(tDiffuse, uv);
    float boundMask = getHardBoundaryMask(uv);
    float reveal = smoothstep(0.0, 0.18, p);

    float flareWindow = smoothstep(0.32, 0.46, p) * (1.0 - smoothstep(0.72, 0.90, p));
    float flarePos = mix(-0.35, 1.35, smoothstep(0.34, 0.78, p));
    float flareBand = exp(-pow((vUv.x - flarePos) * 18.0, 2.0)) * (0.45 + 0.55 * exp(-pow((vUv.y - 0.5) * 5.0, 2.0)));
    vec3 flare = vec3(1.0, 0.95, 0.82) * flareBand * flareStrength * flareWindow;

    vec3 rgb = min(col.rgb + flare, vec3(1.0));
    float alpha = col.a * fanMask * boundMask * reveal;

    return vec4(rgb, alpha);
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