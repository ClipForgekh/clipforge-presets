exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2]
uniform float waveAmp; // = 0.06 [0.0, 0.2]
uniform float waveFreq; // = 18.0 [1.0, 40.0]
uniform float depthSpread; // = 0.08 [0.0, 0.3]
uniform float blurStrength; // = 0.02 [0.0, 0.08]
uniform float goldIntensity; // = 1.2 [0.0, 2.0]
uniform float radialBlur; // = 0.015 [0.0, 0.08]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectVec(vec2 uv, vec2 center) {
    vec2 d = uv - center;
    if (ratio > 1.0) d.y /= ratio;
    else d.x *= ratio;
    return d;
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5);
    vec3 gold = vec3(1.0, 0.78, 0.45);

    vec3 layeredColor = vec3(0.0);
    float layeredWeight = 0.0;

    for (int i = 0; i < 5; i++) {
        float fi = float(i);
        float layerT = fi / 4.0;

        float delay = 0.28;
        float localP = clamp((p - layerT * delay) / (1.0 - layerT * delay), 0.0, 1.0);
        float layerStrength = 1.0 - smoothstep(0.0, 1.0, localP);

        float zDepth = (1.0 - p) * (0.25 + layerT) * depthSpread;
        vec2 d = vUv - center;

        float phase = (1.0 - p) * 6.2831853 + fi * 1.1;
        float wave = sin((vUv.y + fi * 0.07) * waveFreq + phase) * waveAmp * (1.0 + zDepth * 8.0) * layerStrength;

        vec2 uv = center + d * (1.0 + zDepth * 2.2);
        uv.x += wave;

        vec2 dir = getAspectVec(vUv, center);
        float dirLen = max(length(dir), 0.0001);
        vec2 rdir = dir / dirLen;
        if (ratio > 1.0) rdir.y *= ratio;
        else rdir.x /= ratio;

        float vBlur = blurStrength * (1.0 + layerT * 0.6) * layerStrength;
        float rBlur = radialBlur * layerStrength;

        vec2 uv0 = handleUVBounds(uv);
        vec2 uv1 = handleUVBounds(uv + vec2(0.0, vBlur));
        vec2 uv2 = handleUVBounds(uv - vec2(0.0, vBlur));
        vec2 uv3 = handleUVBounds(uv + rdir * rBlur);
        vec2 uv4 = handleUVBounds(uv - rdir * rBlur);

        vec3 c0 = texture2D(tDiffuse, uv0).rgb;
        vec3 c1 = texture2D(tDiffuse, uv1).rgb;
        vec3 c2 = texture2D(tDiffuse, uv2).rgb;
        vec3 c3 = texture2D(tDiffuse, uv3).rgb;
        vec3 c4 = texture2D(tDiffuse, uv4).rgb;

        vec3 blurred = (c0 * 0.30 + c1 * 0.22 + c2 * 0.22 + c3 * 0.13 + c4 * 0.13);

        float radius = length(getAspectVec(vUv, center));
        float th = smoothstep(1.05, 0.0, radius);
        float glow = goldIntensity * layerStrength * (0.35 + 0.65 * th);

        vec3 watercolor = mix(blurred, gold, clamp(0.55 * layerStrength + 0.25 * glow, 0.0, 1.0));
        watercolor += gold * glow * 0.35;

        float layerOpacity = (1.0 - fi * 0.15);
        layeredColor += watercolor * layerOpacity;
        layeredWeight += layerOpacity;
    }

    vec3 stylized = layeredColor / max(layeredWeight, 0.0001);
    float masterStrength = 1.0 - p;
    vec3 finalRgb = mix(texel.rgb, stylized, masterStrength);

    return vec4(finalRgb, texel.a);
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