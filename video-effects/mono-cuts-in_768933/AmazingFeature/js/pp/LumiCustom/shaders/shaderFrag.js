exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float dropDistance; // = 0.7 [0.2, 1.2]
uniform float bounceAmount; // = 0.06 [0.0, 0.2]
uniform float seamMax; // = 0.03 [0.0, 0.08]
uniform float flashStrength; // = 0.75 [0.0, 1.5]
uniform float glowStrength; // = 0.25 [0.0, 1.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float validUV(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 panelColor(float p, float startT, float span, float x0, float x1, float seam, float colorMix, out float outMask, out float outFlash) {
    float tu = (p - startT) / span;
    float t = clamp(tu, 0.0, 1.0);
    float started = step(startT, p);

    float easeOut = 1.0 - pow(1.0 - t, 3.0);
    float drop = (1.0 - easeOut) * dropDistance;
    float bounce = sin(t * 12.5663706) * pow(1.0 - t, 2.0) * bounceAmount;
    drop -= bounce;

    vec2 uv = vec2(vUv.x, vUv.y + drop);
    float insideY = validUV(uv);
    vec2 bounded = handleUVBounds(uv);

    float xMask = step(x0 + seam * 0.5, vUv.x) * step(vUv.x, x1 - seam * 0.5);
    outMask = xMask * insideY * started;

    vec4 c = texture2D(tDiffuse, bounded);
    float g = dot(c.rgb, vec3(0.299, 0.587, 0.114));
    vec3 mono = vec3(g);
    vec3 base = mix(mono, c.rgb, colorMix);

    float fw = 0.10;
    outFlash = exp(-pow((tu - 1.0) / fw, 2.0)) * started * xMask;
    float flash = outFlash * flashStrength * (1.0 + glowStrength * 1.5);

    return vec4(base + vec3(flash), c.a);
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    float panelSpan = 0.36;
    float seam = (1.0 - smoothstep(0.62, 0.96, p)) * seamMax;
    float colorMix = smoothstep(0.74, 0.98, p);

    float m0; float f0;
    float m1; float f1;
    float m2; float f2;

    vec4 c0 = panelColor(p, 0.00, panelSpan, 0.0 / 3.0, 1.0 / 3.0, seam, colorMix, m0, f0);
    vec4 c1 = panelColor(p, 0.22, panelSpan, 1.0 / 3.0, 2.0 / 3.0, seam, colorMix, m1, f1);
    vec4 c2 = panelColor(p, 0.44, panelSpan, 2.0 / 3.0, 3.0 / 3.0, seam, colorMix, m2, f2);

    float mask = clamp(m0 + m1 + m2, 0.0, 1.0);
    vec3 rgb = c0.rgb * m0 + c1.rgb * m1 + c2.rgb * m2;

    vec4 composed = vec4(rgb, texel.a * mask);
    float finish = smoothstep(0.985, 1.0, p);
    return mix(composed, texel, finish);
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