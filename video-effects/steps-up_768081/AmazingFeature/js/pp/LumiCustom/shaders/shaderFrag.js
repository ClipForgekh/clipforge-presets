exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float maxBlur; // = 0.035 [0.0, 0.12] // 初始模糊半径（UV尺度，约对应35px）
uniform float neonStrength; // = 1.2 [0.0, 3.0] // 霓虹强度
uniform float overBright; // = 1.0 [0.0, 2.0] // 过曝增量（1.0表示最高到2.0亮度）
uniform float entranceOffset; // = 1.0 [0.5, 1.8] // 基础下方入场位移

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 directionalBlur(sampler2D tex, vec2 uv, vec2 dir, float radius) {
    vec4 col = vec4(0.0);
    float wsum = 0.0;
    for (int i = -3; i <= 3; i++) {
        float fi = float(i);
        float w = 1.0 - abs(fi) / 3.5;
        vec2 suv = handleUVBounds(uv + dir * radius * fi);
        col += texture2D(tex, suv) * w;
        wsum += w;
    }
    return col / max(wsum, 0.0001);
}

vec4 effect(vec4 texel, float p) {
    const float stripCount = 8.0;
    const float delayStep = 0.05;
    const float totalDelay = 0.35;
    const float activeSpan = 1.0 - totalDelay;

    float idx = clamp(floor(vUv.x * stripCount), 0.0, stripCount - 1.0);
    float local = clamp((p - idx * delayStep) / activeSpan, 0.0, 1.0);
    float localEase = 1.0 - pow(1.0 - local, 2.0);
    float strength = 1.0 - localEase;

    float dy = (entranceOffset + idx * 0.10) * strength;
    vec2 rawUV = vec2(vUv.x, vUv.y + dy);
    vec2 uv = handleUVBounds(rawUV);

    float inMask = step(0.0, rawUV.y) * step(rawUV.y, 1.0);

    float isOdd = step(0.5, mod(idx, 2.0));
    vec2 dirVertical = vec2(0.0, 1.0 / max(ratio, 0.0001));
    vec2 dirDiag = normalize(vec2(1.0, 1.0 / max(ratio, 0.0001)));
    vec2 blurDir = normalize(mix(dirDiag, dirVertical, isOdd));

    float blurRadius = maxBlur * strength;
    vec4 blurred = directionalBlur(tDiffuse, uv, blurDir, blurRadius);

    float brighten = 1.0 + overBright * strength;
    vec3 baseRgb = blurred.rgb * brighten;

    float stripU = fract(vUv.x * stripCount);
    float edgeDist = min(stripU, 1.0 - stripU);
    float edgeGlow = smoothstep(0.10, 0.0, edgeDist) * strength;
    vec3 neonColor = mix(vec3(0.62, 0.22, 1.0), vec3(1.0, 0.25, 0.76), vUv.y);
    baseRgb += neonColor * edgeGlow * neonStrength;

    float topGap = smoothstep(1.0 - dy, 1.0, vUv.y) * step(0.001, dy);
    float haloGrad = smoothstep(0.0, 1.0, (vUv.y - (1.0 - dy)) / max(dy, 0.0001));
    vec3 haloColor = mix(vec3(0.30, 0.08, 0.45), vec3(0.95, 0.25, 0.85), 0.5 + 0.5 * sin(vUv.x * 10.0));
    vec3 haloRgb = haloColor * haloGrad * strength * 0.55;

    vec2 cell = floor(vUv * vec2(140.0, 220.0) + idx * 7.13);
    float spark = step(0.982, hash21(cell));
    float sparkShape = smoothstep(0.95, 1.0, haloGrad);
    vec3 particles = neonColor * spark * sparkShape * topGap * strength * 1.8;

    vec3 mergedRgb = mix(haloRgb, baseRgb, inMask) + particles;
    float mergedA = mix(0.35 * topGap * strength, blurred.a, inMask);

    return vec4(clamp(mergedRgb, 0.0, 1.0), clamp(mergedA, 0.0, 1.0));
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