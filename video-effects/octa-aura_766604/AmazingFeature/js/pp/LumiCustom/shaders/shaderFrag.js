exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurMax; // = 0.035 [0.005, 0.08] // 最大散焦强度
uniform float scanWidth; // = 0.12 [0.03, 0.3] // 扫光前沿宽度
uniform float wedgeSoftness; // = 0.22 [0.05, 0.5] // 扇形软边
uniform float glowStrength; // = 1.1 [0.0, 2.0] // 霓虹辉光强度
uniform float centerBloom; // = 1.25 [0.0, 2.5] // 中心过曝高光强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
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

float getMaxRadius() {
    vec2 c = vec2(0.5);
    float r1 = length(getSDFCoordinate(vec2(0.0, 0.0), c));
    float r2 = length(getSDFCoordinate(vec2(1.0, 0.0), c));
    float r3 = length(getSDFCoordinate(vec2(0.0, 1.0), c));
    float r4 = length(getSDFCoordinate(vec2(1.0, 1.0), c));
    return max(max(r1, r2), max(r3, r4));
}

vec2 dirFromIndex(int i) {
    if (i == 0) return vec2(1.0, 0.0);
    if (i == 1) return vec2(-1.0, 0.0);
    if (i == 2) return vec2(0.0, 1.0);
    if (i == 3) return vec2(0.0, -1.0);
    if (i == 4) return normalize(vec2(1.0, 1.0));
    if (i == 5) return normalize(vec2(-1.0, 1.0));
    if (i == 6) return normalize(vec2(1.0, -1.0));
    return normalize(vec2(-1.0, -1.0));
}

vec3 neonColor(int i) {
    if (i == 0 || i == 4) return vec3(1.0, 0.15, 0.75); // 荧光粉
    if (i == 1 || i == 6) return vec3(0.12, 0.65, 1.0); // 电光蓝
    if (i == 2 || i == 7) return vec3(0.45, 0.18, 0.85); // 暗紫
    return vec3(0.68, 1.0, 0.18); // 青柠
}

vec4 multiDirBlur(vec2 uv, vec2 p, float strength) {
    vec4 acc = vec4(0.0);
    float wsum = 0.0;

    acc += texture2D(tDiffuse, uv) * 0.18;
    wsum += 0.18;

    for (int i = 0; i < 8; i++) {
        vec2 d = dirFromIndex(i);
        vec2 o1 = d * strength * 0.8;
        vec2 o2 = d * strength * 1.6;
        vec2 o3 = d * strength * 2.4;

        vec2 uv1 = handleUVBounds(uv + vec2(o1.x, o1.y * (ratio > 1.0 ? ratio : 1.0 / max(ratio, 0.0001))));
        vec2 uv2 = handleUVBounds(uv - vec2(o1.x, o1.y * (ratio > 1.0 ? ratio : 1.0 / max(ratio, 0.0001))));
        vec2 uv3 = handleUVBounds(uv + vec2(o2.x, o2.y * (ratio > 1.0 ? ratio : 1.0 / max(ratio, 0.0001))));
        vec2 uv4 = handleUVBounds(uv - vec2(o2.x, o2.y * (ratio > 1.0 ? ratio : 1.0 / max(ratio, 0.0001))));
        vec2 uv5 = handleUVBounds(uv + vec2(o3.x, o3.y * (ratio > 1.0 ? ratio : 1.0 / max(ratio, 0.0001))));
        vec2 uv6 = handleUVBounds(uv - vec2(o3.x, o3.y * (ratio > 1.0 ? ratio : 1.0 / max(ratio, 0.0001))));

        acc += texture2D(tDiffuse, uv1) * 0.10;
        acc += texture2D(tDiffuse, uv2) * 0.10;
        acc += texture2D(tDiffuse, uv3) * 0.07;
        acc += texture2D(tDiffuse, uv4) * 0.07;
        acc += texture2D(tDiffuse, uv5) * 0.04;
        acc += texture2D(tDiffuse, uv6) * 0.04;
        wsum += 0.42;
    }

    return acc / wsum;
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5);
    vec2 q = getSDFCoordinate(vUv, center);
    float r = length(q);
    vec2 n = q / max(r, 1e-5);

    float sweepPhase = min(p / 0.8, 1.0);
    float sweepFront = sweepPhase * getMaxRadius();

    float clearMask = 0.0;
    float edgeGlow = 0.0;
    vec3 neonAccum = vec3(0.0);

    float cosCore = cos(0.39269908); // 22.5°
    float cosSoft = cos(0.39269908 + wedgeSoftness);

    for (int i = 0; i < 8; i++) {
        vec2 d = dirFromIndex(i);
        float ang = dot(n, d);
        float wedge = smoothstep(cosSoft, cosCore, ang);
        float proj = dot(q, d);

        float swept = smoothstep(-scanWidth, scanWidth, sweepFront - proj);
        clearMask = max(clearMask, wedge * swept);

        float edge = exp(-abs(proj - sweepFront) / max(scanWidth * 0.7, 0.0001)) * wedge;
        edgeGlow += edge;
        neonAccum += neonColor(i) * edge;
    }

    float blurAmount = (1.0 - clearMask) * (1.0 - sweepPhase) * blurMax + (1.0 - clearMask) * blurMax * 0.35;
    vec4 blurred = multiDirBlur(vUv, q, blurAmount);

    float sat = 1.45 - 0.45 * sweepPhase;
    vec3 vivid = blurred.rgb;
    float luma = dot(vivid, vec3(0.299, 0.587, 0.114));
    vivid = mix(vec3(luma), vivid, sat);

    float centerHot = exp(-r * 18.0) * centerBloom * (1.0 - sweepPhase);
    float trailFade = 1.0 - smoothstep(0.8, 1.0, p);

    vec3 glowColor = neonAccum * glowStrength * trailFade * 0.55;
    float glowInt = min(edgeGlow * 0.22 * glowStrength * trailFade, 1.0);

    vec3 staged = vivid + glowColor + vec3(centerHot + glowInt * 0.25);
    staged = clamp(staged, 0.0, 1.0);

    vec3 finalRgb = mix(staged, texel.rgb, clearMask);
    finalRgb = mix(finalRgb, texel.rgb, smoothstep(0.8, 1.0, p));

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