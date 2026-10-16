exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform vec3 goldColor; // = vec3(0.96, 0.80, 0.45) // 金箔暖金色
uniform float blurStrength; // = 15.0 [0.0, 30.0] // 最大模糊强度
uniform float ringWidth; // = 0.020 [0.005, 0.060] // 光环宽度
uniform float rayIntensity; // = 0.55 [0.0, 1.5] // 丁达尔光束强度
uniform float ringGlow; // = 1.10 [0.0, 2.5] // 光环发光强度
uniform float ringStartRadius; // = 0.085 [0.02, 0.20] // 初始中心光环半径

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

vec4 fastBlur(vec2 uv, float amount) {
    if (amount <= 0.0001) return texture2D(tDiffuse, uv);
    vec2 stepUV = vec2(amount * 0.0012, amount * 0.0012 / max(ratio, 0.0001));

    vec4 c = texture2D(tDiffuse, uv) * 0.24;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(stepUV.x, 0.0))) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - vec2(stepUV.x, 0.0))) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, stepUV.y))) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, stepUV.y))) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepUV)) * 0.07;
    c += texture2D(tDiffuse, handleUVBounds(uv - stepUV)) * 0.07;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(stepUV.x, -stepUV.y))) * 0.07;
    c += texture2D(tDiffuse, handleUVBounds(uv + vec2(-stepUV.x, stepUV.y))) * 0.07;

    return c;
}

vec4 effect(vec4 texel, float p) {
    const float phase1End = 0.1764706;
    const float phase2End = 0.7058824;
    const float ringInterval = 0.1176471;

    vec2 center = vec2(0.5, 0.5);
    vec2 pc = getSDFCoordinate(vUv, center);
    float d = length(pc);
    float maxR = getMaxShapeSize() * 0.55;

    float imageAlpha = 0.0;
    if (p < phase1End) {
        imageAlpha = 0.0;
    } else if (p < phase2End) {
        imageAlpha = ((p - phase1End) / (phase2End - phase1End)) * 0.7;
    } else {
        imageAlpha = 0.7 + ((p - phase2End) / (1.0 - phase2End)) * 0.3;
    }

    float frontRadius = mix(ringStartRadius, maxR, smoothstep(phase1End, phase2End, p));
    float blurRegion = 1.0 - smoothstep(frontRadius, frontRadius + 0.10, d);
    float blurFade = 1.0 - smoothstep(phase2End, 1.0, p);
    float blurAmount = blurStrength * blurRegion * blurFade;

    vec4 blurredTexel = fastBlur(vUv, blurAmount);
    float clarity = smoothstep(phase2End, 1.0, p);
    vec3 baseRgb = mix(blurredTexel.rgb, texel.rgb, clarity) * imageAlpha;

    float startupHalo = exp(-pow((d - ringStartRadius) / max(ringWidth * 1.8, 0.0001), 2.0));
    startupHalo *= (1.0 - smoothstep(phase1End, phase1End + 0.06, p));

    float rings = 0.0;
    for (int i = 0; i < 5; i++) {
        float fi = float(i);
        float startT = phase1End + fi * ringInterval;
        float rp = clamp((p - startT) / max(phase2End - startT, 0.0001), 0.0, 1.0);
        float ringLife = step(startT, p) * (1.0 - smoothstep(phase2End, 1.0, p));
        float radius = mix(ringStartRadius, maxR, rp);
        float edgeFade = smoothstep(maxR * 0.90, maxR, radius);
        float band = exp(-pow((d - radius) / max(ringWidth, 0.0001), 2.0));
        rings += band * ringLife * (1.0 - edgeFade);
    }

    float angle = atan(pc.y, pc.x);
    float rayPattern = pow(max(0.0, cos(angle * 12.0 + d * 20.0 - p * 12.0)), 6.0);
    float rayPulse = 0.75 + 0.25 * sin(d * 36.0 - p * 20.0);
    float rayMask = smoothstep(ringStartRadius * 0.8, frontRadius + 0.04, d) *
                    (1.0 - smoothstep(frontRadius + 0.35, maxR, d));
    float rays = rayPattern * rayPulse * rayMask;

    float fxFade = 1.0 - smoothstep(phase2End, 1.0, p);
    vec3 glow = goldColor * ((rings + startupHalo) * ringGlow + rays * rayIntensity) * fxFade;

    vec3 finalRgb = clamp(baseRgb + glow, 0.0, 1.0);
    float fxAlpha = clamp(((rings + startupHalo) * 0.55 + rays * 0.25) * fxFade, 0.0, 1.0);
    float finalAlpha = clamp(max(texel.a * imageAlpha, fxAlpha), 0.0, 1.0);

    vec4 outCol = vec4(finalRgb, finalAlpha);
    outCol = mix(outCol, texel, smoothstep(0.999, 1.0, p));
    return outCol;
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