exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float flickerSteps; // = 28.0 [4.0, 64.0] // 电流闪烁分段数
uniform float glowBoost; // = 1.2 [0.0, 3.0] // 高光光晕增益
uniform float glowRadius; // = 0.03 [0.0, 0.08] // 最大光晕半径
uniform float highlightThreshold; // = 0.75 [0.3, 1.0] // 高光阈值

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 sampleGlow(vec2 uv, float r) {
    vec2 ar = vec2(1.0, 1.0 / max(ratio, 0.0001));
    vec3 c = vec3(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2( 1.0, 0.0) * r * ar)).rgb;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(-1.0, 0.0) * r * ar)).rgb;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0,  1.0) * r * ar)).rgb;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, -1.0) * r * ar)).rgb;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2( 0.7,  0.7) * r * ar)).rgb;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(-0.7,  0.7) * r * ar)).rgb;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2( 0.7, -0.7) * r * ar)).rgb;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(-0.7, -0.7) * r * ar)).rgb;
    return c * 0.125;
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.1) {
        return vec4(0.0, 0.0, 0.0, texel.a);
    }
    if (p >= 0.65) {
        return texel;
    }

    float flickerPhase = clamp((p - 0.1) / 0.55, 0.0, 1.0);
    float stepped = floor(flickerPhase * max(flickerSteps, 1.0)) / max(flickerSteps, 1.0);

    float exposurePhase = clamp((p - 0.1) / 0.5, 0.0, 1.0);
    float exposureStepped = floor(exposurePhase * max(flickerSteps, 1.0)) / max(flickerSteps, 1.0);

    float frameSeed = floor(p * 240.0);
    float rndA = hash12(vec2(frameSeed, floor(vUv.y * 91.0)));
    float rndB = hash12(vec2(frameSeed * 1.7 + 13.0, floor(vUv.x * 117.0)));
    float rndC = hash12(vec2(frameSeed * 2.3 + 29.0, 7.0));

    float strobeGate = step(0.28, rndA);
    float superFlash = 1.0 + step(0.82, rndB) * 0.9;
    float baseExposure = 5.0 * (1.0 - exposureStepped);
    float exposure = baseExposure * strobeGate * superFlash;

    vec3 lit = texel.rgb * exp2(exposure);

    float tintPhase = clamp((p - 0.1) / 0.4, 0.0, 1.0);
    float tintAmount = (1.0 - tintPhase) * strobeGate;
    vec3 magentaTone = vec3(lit.r + 0.55 * lit.b, lit.g * 0.35, lit.b + 0.35 * lit.r);
    vec3 cyanTone = vec3(lit.r * 0.35, lit.g + 0.45 * lit.b, lit.b + 0.45 * lit.g);
    vec3 tintMix = mix(magentaTone, cyanTone, step(0.5, rndC));
    vec3 tinted = mix(lit, tintMix, tintAmount);

    float lum = dot(tinted, vec3(0.299, 0.587, 0.114));
    float highlightMask = smoothstep(highlightThreshold, 1.0, lum);

    float glowPhase = 1.0 - stepped;
    float radius = glowRadius * glowPhase;
    vec3 blurred = sampleGlow(vUv, radius);
    float blurLum = dot(blurred, vec3(0.299, 0.587, 0.114));
    float blurMask = smoothstep(highlightThreshold, 1.0, blurLum);
    vec3 glow = blurred * blurMask * highlightMask * glowBoost * glowPhase * 1.5;

    float tubeOn = max(strobeGate, step(0.92, rndB));
    vec3 composed = (tinted + glow) * tubeOn;

    return vec4(clamp(composed, 0.0, 1.0), texel.a);
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