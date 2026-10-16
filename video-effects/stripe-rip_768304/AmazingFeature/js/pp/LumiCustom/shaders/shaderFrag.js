exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float stripCount; // = 12.0 [6.0, 24.0]
uniform float maxStretch; // = 2.2 [1.0, 4.0]
uniform float maxShift; // = 1.2 [0.0, 2.0]
uniform float delayStep; // = 0.03 [0.0, 0.08]
uniform float burnIntensity; // = 1.2 [0.0, 3.0]
uniform float blurStrength; // = 0.012 [0.0, 0.05]
uniform float alphaStagger; // = 0.015 [0.0, 0.05]

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 directionalBlur(vec2 uv, float radius, float dir) {
    vec2 o = vec2(0.0, radius * dir);
    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv - 2.0 * o)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - 1.0 * o)) * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.30;
    c += texture2D(tDiffuse, handleUVBounds(uv + 1.0 * o)) * 0.23;
    c += texture2D(tDiffuse, handleUVBounds(uv + 2.0 * o)) * 0.12;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float holdEnd = 0.2;
    if (p < holdEnd) return texel;

    float count = max(1.0, floor(stripCount + 0.5));
    float idx = floor(vUv.x * count);
    float localX = fract(vUv.x * count);

    float dir = mix(-1.0, 1.0, step(0.5, mod(idx, 2.0)));
    float localDelay = idx * delayStep;

    float act = clamp((p - holdEnd - localDelay) / max(0.0001, (0.7 - holdEnd)), 0.0, 1.0);
    float actEase = act * act;

    float stretch = 1.0 + maxStretch * actEase;
    float shift = dir * maxShift * actEase;

    vec2 uv = vUv;
    uv.y = 0.5 + (vUv.y - 0.5) / stretch - shift;

    float seam = smoothstep(0.0, 0.06, localX) * (1.0 - smoothstep(0.94, 1.0, localX));
    uv = handleUVBounds(uv);

    float bRadius = blurStrength * actEase * (1.0 + idx / count);
    vec4 baseCol = directionalBlur(uv, bRadius, dir);

    float burnPos = mix(0.5, (dir > 0.0 ? 0.0 : 1.0), act);
    float edgeDist = abs(vUv.y - burnPos);
    float burnBand = smoothstep(0.08, 0.0, edgeDist) * act;
    float grain = hash21(vUv * vec2(800.0, 450.0) + vec2(idx * 17.3, p * 211.7));
    vec3 burnColor = vec3(1.0, 0.72, 0.28) * (0.75 + 0.5 * grain);

    float peak = smoothstep(0.45, 0.7, p) * (1.0 - smoothstep(0.7, 0.9, p));
    float glow = burnBand * burnIntensity * (0.4 + 0.6 * peak);

    float fadeStart = 0.7 + idx * alphaStagger;
    float stripFade = 1.0 - clamp((p - fadeStart) / max(0.0001, 1.0 - fadeStart), 0.0, 1.0);

    vec3 rgb = baseCol.rgb + burnColor * glow;
    rgb *= seam;
    float alpha = baseCol.a * seam * stripFade;

    return vec4(rgb * alpha, alpha);
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