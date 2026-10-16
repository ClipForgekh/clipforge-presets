exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress;
uniform float ratio;
uniform float edgeSharpness; // = 1.4 [0.5, 3.0] // 边缘强化强度
uniform float fragmentSpread; // = 0.45 [0.1, 1.0] // 碎片飞散幅度

varying vec2 vUv;

float tween(float progress) {
    return progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float expoIn(float t) {
    return t <= 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0));
}

float expoOut(float t) {
    return t >= 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec2 hash2(vec2 p) {
    float h1 = hash(p);
    float h2 = hash(p + vec2(23.17, 51.93));
    return vec2(h1, h2);
}

float luminance(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

vec3 fetchColor(vec2 uv) {
    return texture2D(tDiffuse, handleUVBounds(uv)).rgb;
}

float sobelEdge(vec2 uv) {
    float baseStep = 0.0015;
    float stepX = baseStep;
    float stepY = baseStep / max(ratio, 0.0001);
    vec2 sx = vec2(stepX, 0.0);
    vec2 sy = vec2(0.0, stepY);

    float tl = luminance(fetchColor(uv - sx + sy));
    float ml = luminance(fetchColor(uv - sx));
    float bl = luminance(fetchColor(uv - sx - sy));
    float tc = luminance(fetchColor(uv + sy));
    float bc = luminance(fetchColor(uv - sy));
    float tr = luminance(fetchColor(uv + sx + sy));
    float mr = luminance(fetchColor(uv + sx));
    float br = luminance(fetchColor(uv + sx - sy));

    float gx = -tl - 2.0 * ml - bl + tr + 2.0 * mr + br;
    float gy = -tl - 2.0 * tc - tr + bl + 2.0 * bc + br;

    float g = sqrt(gx * gx + gy * gy);
    float sharpened = clamp(g * (0.7 + edgeSharpness * 0.6), 0.0, 1.0);
    return pow(sharpened, 0.6);
}

vec4 effect(vec4 texel, float progress) {
    const float NATURAL_END = 0.15789473;
    const float EDGE_FULL = 0.42105263;
    const float COMP_START = 0.34210527;
    const float COMP_END = 0.55263158;
    const float EXPLODE_START = 0.55263158;
    const float CONTRAST_START = 0.44736842;
    const float CONTRAST_END = 0.68421053;
    const float LEAVE_START = 0.65789473;
    const float LEAVE_END = 0.84210527;
    const float BLACK_START = 0.84210527;

    vec2 center = vec2(0.5);
    vec2 fromCenter = vUv - center;

    float compressionWindow = clamp((progress - COMP_START) / (COMP_END - COMP_START), 0.0, 1.0);
    float explosionWindow = clamp((progress - EXPLODE_START) / 0.10526316, 0.0, 1.0);
    float explosion = expoOut(explosionWindow);
    float compressionFactor = expoIn(compressionWindow) * (1.0 - explosion);
    float compressionScale = mix(1.0, 0.35, compressionFactor);

    vec2 uv = center + fromCenter * compressionScale;

    float leavePhase = clamp((progress - LEAVE_START) / (LEAVE_END - LEAVE_START), 0.0, 1.0);

    if (explosion > 0.0 || leavePhase > 0.0) {
        vec2 cell = floor(vUv * 100.0);
        vec2 randDir = hash2(cell) * 2.0 - 1.0;
        float irregular = hash(cell + vec2(19.0));
        float radius = max(length(fromCenter), 0.0001);
        vec2 outward = fromCenter / radius;

        float spread = fragmentSpread * (0.6 * explosion + 0.9 * leavePhase);
        vec2 offset = outward * (0.4 + 0.6 * irregular) * explosion + randDir * (0.5 * (explosion + leavePhase));
        uv += offset * spread;
        uv += outward * fragmentSpread * 0.25 * leavePhase * leavePhase;
    }

    float sampleMask = getHardBoundaryMask(uv);
    vec2 sampleUV = handleUVBounds(uv);
    vec4 sampled = texture2D(tDiffuse, sampleUV);

    float edgeSignal = sobelEdge(sampleUV);
    float networkPhase = smoothstep(NATURAL_END, EDGE_FULL, progress);
    float contrastPhase = smoothstep(CONTRAST_START, CONTRAST_END, progress);

    float contrastGain = mix(1.0, 1.0 + 1.8 * edgeSharpness, contrastPhase);
    float contourValue = clamp((edgeSignal - 0.5) * contrastGain + 0.5, 0.0, 1.0);
    contourValue = min(1.0, contourValue * (1.0 + explosion * 0.8));

    vec3 contourColor = vec3(contourValue);
    vec3 baseColor = sampled.rgb;
    vec3 stylized = mix(baseColor, contourColor, networkPhase);
    stylized = mix(stylized, contourColor, explosion * 0.8 + leavePhase * 0.6);

    float debrisFade = 1.0;
    if (leavePhase > 0.0) {
        vec2 cell = floor(vUv * 90.0);
        float randomFactor = hash(cell + vec2(71.0));
        debrisFade = 1.0 - smoothstep(randomFactor, randomFactor + 0.35, leavePhase);
        debrisFade = clamp(debrisFade, 0.0, 1.0);
    }

    float blackPhase = smoothstep(BLACK_START, 1.0, progress);

    vec3 finalColor = stylized * sampleMask * debrisFade;
    finalColor *= (1.0 - blackPhase);
    float finalAlpha = sampled.a * sampleMask * debrisFade * (1.0 - blackPhase);

    return vec4(finalColor, finalAlpha);
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