exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2.0]

uniform float darknessStart; // = 0.85 [0.0, 1.0]
uniform float thresholdMedium; // = 0.45 [0.0, 1.0]
uniform float thresholdSoftness; // = 0.10 [0.01, 0.4]
uniform float shakeAmount; // = 0.008 [0.0, 0.03]
uniform float aberrationAmount; // = 0.02 [0.0, 0.08]

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float quadIn(float t) {
    return t * t;
}

float quadOut(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

vec2 aspectDelta(vec2 uv, vec2 center) {
    vec2 d = uv - center;
    if (ratio > 1.0) d.y /= ratio;
    else d.x *= ratio;
    return d;
}

float shakeEnvelope(float p) {
    float a = 0.0;
    if (p < 0.3) {
        float t1 = clamp(p / 0.3, 0.0, 1.0);
        a = mix(0.25, 0.60, quadIn(t1));
    } else if (p < 0.6) {
        float t2 = clamp((p - 0.3) / 0.3, 0.0, 1.0);
        a = mix(0.60, 1.00, smoothstep(0.0, 1.0, t2));
    } else {
        float t3 = clamp((p - 0.6) / 0.4, 0.0, 1.0);
        a = 1.0 - quadOut(t3);
    }
    return a;
}

float aberrationEnvelope(float p) {
    if (p < 0.3) {
        return 0.0;
    } else if (p < 0.6) {
        float t2 = clamp((p - 0.3) / 0.3, 0.0, 1.0);
        return quadIn(t2);
    } else {
        float t3 = clamp((p - 0.6) / 0.4, 0.0, 1.0);
        return 1.0 - quadOut(t3);
    }
}

float thresholdEnvelope(float p) {
    if (p < 0.6) return 1.0;
    float t3 = clamp((p - 0.6) / 0.4, 0.0, 1.0);
    return 1.0 - quadOut(t3);
}

vec4 effect(vec4 texel, float p) {
    if (p >= 1.0) return texel;

    float envShake = shakeEnvelope(p);
    float envAber = aberrationEnvelope(p);
    float envThresh = thresholdEnvelope(p);

    vec2 wave = vec2(
        sin(p * 71.0 + vUv.y * 43.0) + 0.5 * sin(p * 131.0),
        cos(p * 83.0 + vUv.x * 39.0) + 0.5 * cos(p * 113.0)
    );
    vec2 shake = wave * (shakeAmount * envShake);

    vec2 d = aspectDelta(vUv, vec2(0.5));
    float r = length(d) * 2.0;

    float t1 = clamp(p / 0.3, 0.0, 1.0);
    float front = mix(0.0, 1.7, quadIn(t1));
    float radialReveal = 1.0 - smoothstep(front, front + 0.08, r);

    vec2 dir = normalize(d + vec2(1e-5, 1e-5));
    float ab = aberrationAmount * envAber;

    vec2 uvR = handleUVBounds(vUv + shake + dir * ab);
    vec2 uvG = handleUVBounds(vUv + shake);
    vec2 uvB = handleUVBounds(vUv + shake - dir * ab);

    vec4 sR = texture2D(tDiffuse, uvR);
    vec4 sG = texture2D(tDiffuse, uvG);
    vec4 sB = texture2D(tDiffuse, uvB);

    vec3 chroma = vec3(sR.r, sG.g, sB.b);
    float alpha = sG.a;

    float luma = dot(chroma, vec3(0.299, 0.587, 0.114));
    float dynamicThreshold = thresholdMedium + (1.0 - radialReveal) * 0.25;
    float lumiMask = smoothstep(dynamicThreshold - thresholdSoftness, dynamicThreshold + thresholdSoftness, luma);
    float thresholdMask = mix(1.0, lumiMask, envThresh);

    float revealMask = clamp(radialReveal * thresholdMask, 0.0, 1.0);

    float darkMix = darknessStart * (1.0 - quadOut(clamp(p, 0.0, 1.0)));
    vec3 revealed = chroma * revealMask;
    vec3 finalRgb = mix(revealed * (1.0 - darkMix), chroma, quadOut(clamp(p, 0.0, 1.0)) * (1.0 - envThresh));
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    return vec4(finalRgb, alpha);
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