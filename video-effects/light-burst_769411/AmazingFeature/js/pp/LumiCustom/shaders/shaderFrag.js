exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform vec3 sparkleColor; // = vec3(1.0, 0.86, 0.98) // sparkle tint color (RGB, 0-1)
uniform float sparkleDensity; // = 8.0 [3.0, 16.0] // sparkle count multiplier
uniform float glowStrength; // = 1.2 [0.2, 2.5] // glow intensity scaler

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float p) {
    float ease = 1.0 - pow(1.0 - p, 3.0);
    float bounce = sin(p * 4.0 * PI) * exp(-p * 6.0) * 0.12;
    return clamp(ease + bounce, 0.0, 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float hash11(float p) {
    return fract(sin(p) * 43758.5453123);
}

float starShape(vec2 p, float radius, float spikeSharpness) {
    float r = length(p);
    float base = exp(-r * r / (radius * radius + 1e-5));
    float angle = atan(p.y, p.x);
    float spikes = pow(abs(cos(angle * 4.0)), spikeSharpness) * 0.7 + 0.3;
    return base * spikes;
}

float softGlow(vec2 p, float radius) {
    return exp(-dot(p, p) / (radius * radius + 1e-5));
}

float axialFlare(vec2 p, float radius) {
    float axis = exp(-abs(p.x) / (radius + 1e-5)) + exp(-abs(p.y) / (radius + 1e-5));
    float diag = exp(-abs(dot(p, vec2(0.70710678, 0.70710678))) / (radius * 1.2 + 1e-5));
    diag += exp(-abs(dot(p, vec2(-0.70710678, 0.70710678))) / (radius * 1.2 + 1e-5));
    return pow((axis * 0.6 + diag * 0.4) * 0.5, 2.0);
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;
    vec2 center = vec2(0.5);
    
    float scaleBounce = sin(progress * PI * 2.2) * exp(-progress * 4.0) * 0.08;
    float baseScale = mix(0.6, 1.0, progress);
    baseScale -= scaleBounce * (1.0 - progress);
    
    vec2 uv = 0.5 + (vUv - 0.5) * baseScale;
    uv = handleUVBounds(uv);
    vec4 scaledTexel = texture2D(tDiffuse, uv);
    float borderMask = getHardBoundaryMask(vUv);
    scaledTexel.a *= borderMask;
    
    float revealFactor = smoothstep(0.1, 0.65, progress);
    vec3 baseColor = mix(vec3(0.0), scaledTexel.rgb, revealFactor);
    float baseAlpha = scaledTexel.a * revealFactor;
    
    vec2 sdf = getSDFCoordinate(vUv, center);
    
    float expansion = mix(0.04, 0.65, progress);
    float settle = sin(progress * PI * 1.8) * exp(-progress * 5.5) * 0.12;
    expansion += settle * (1.0 - progress);
    
    float coreGlow = softGlow(sdf, expansion * 0.8);
    float flare = axialFlare(sdf, expansion * 0.45);
    float starCore = starShape(sdf, expansion * 0.32, 6.0);
    
    float sparkleEnvelope = smoothstep(0.05, 0.55, progress) * (1.0 - smoothstep(0.75, 1.0, progress));
    sparkleEnvelope = max(sparkleEnvelope, effectStrength * 0.25);
    sparkleEnvelope *= 1.0 - smoothstep(0.92, 1.0, progress);
    
    float starSpread = mix(0.06, 0.9, progress);
    starSpread += settle * 0.5;
    
    float smallSparkles = 0.0;
    for (int i = 0; i < 8; ++i) {
        float fi = float(i);
        float angle = hash11(fi * 17.13) * 6.2831853;
        float radiusJitter = hash11(fi * 31.7 + 12.0);
        float twinklePhase = hash11(fi * 47.7 + 5.0);
        
        float radius = starSpread * (0.35 + 0.65 * radiusJitter);
        vec2 offset = vec2(cos(angle), sin(angle)) * radius;
        vec2 sp = sdf - offset;
        
        float size = mix(0.008, 0.055, progress) * (0.6 + 0.4 * radiusJitter);
        float sparkle = starShape(sp, size, 5.0);
        float twinkle = 0.5 + 0.5 * sin(progress * 18.0 + twinklePhase * 6.2831853);
        float appear = smoothstep(0.02, 0.28 + 0.1 * radiusJitter, progress);
        smallSparkles += sparkle * twinkle * appear;
    }
    smallSparkles /= 8.0;
    smallSparkles *= sparkleDensity * 0.12;
    
    float halo = softGlow(sdf, expansion * 1.4);
    float sparkleField = coreGlow * 0.6 + flare * 0.8 + starCore * 1.2 + smallSparkles;
    sparkleField += halo * 0.3;
    sparkleField *= sparkleEnvelope;
    
    vec3 glowColor = sparkleColor * (sparkleField * glowStrength);
    
    baseColor += glowColor;
    baseAlpha = clamp(baseAlpha + sparkleField * 0.1, 0.0, 1.0);
    
    vec3 settleBlend = mix(baseColor, scaledTexel.rgb, smoothstep(0.85, 1.0, progress));
    vec3 finalRGB = clamp(settleBlend, 0.0, 1.0);
    float finalAlpha = clamp(baseAlpha, 0.0, 1.0);
    
    return vec4(finalRGB, finalAlpha * borderMask);
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