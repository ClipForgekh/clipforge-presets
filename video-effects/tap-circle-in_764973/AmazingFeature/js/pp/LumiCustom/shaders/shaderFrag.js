exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float maxBlur; // = 0.03 [0.0, 0.08] // 初始最大径向模糊强度
uniform float ringWidth; // = 0.02 [0.003, 0.08] // 环形光带宽度
uniform float grainIntensity; // = 0.10 [0.0, 0.3] // 胶片颗粒强度
uniform vec3 warmGoldColor; // = vec3(1.0, 0.78, 0.42) // 暖金色光带颜色

varying vec2 vUv;

float tween(float p) {
    return p * p;
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
    const float safetyFactor = 1.2;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 radialBlur(sampler2D tex, vec2 uv, vec2 center, float blurAmt) {
    vec2 dir = uv - center;
    float lenDir = length(dir);
    if (lenDir < 1e-5 || blurAmt <= 1e-5) return texture2D(tex, uv);
    dir /= lenDir;

    vec4 col = vec4(0.0);
    float w = 0.0;

    for (int i = -3; i <= 3; i++) {
        float fi = float(i);
        float wt = 1.0 - abs(fi) / 4.0;
        vec2 suv = handleUVBounds(uv + dir * blurAmt * fi);
        col += texture2D(tex, suv) * wt;
        w += wt;
    }
    return col / w;
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, 0.5);
    vec2 sp = getSDFCoordinate(vUv, center);
    float dist = length(sp);

    float maxR = getMaxShapeSize() * 0.5;
    float scanR = p * maxR;

    float revealFeather = ringWidth * 2.0;
    float reveal = smoothstep(0.0, revealFeather, scanR - dist);

    float bandDist = abs(dist - scanR);
    float ring = exp(-bandDist / max(ringWidth, 0.0001));
    ring *= (1.0 - p);

    float localBlur = maxBlur * (1.0 - reveal) * (1.0 - p);
    vec4 blurredTexel = radialBlur(tDiffuse, vUv, center, localBlur);
    vec3 sceneRgb = mix(blurredTexel.rgb, texel.rgb, reveal);

    float noise = hash21(vUv * vec2(1280.0, 720.0));
    float grain = (noise - 0.5) * 2.0;
    float grainAmt = grainIntensity * reveal * (1.0 - p);
    sceneRgb += grain * grainAmt;

    float highlight = pow(ring, 1.5) * 0.35;
    vec3 ringColor = warmGoldColor * (ring * 1.1 + highlight);

    float visibility = clamp(reveal + ring * 0.85, 0.0, 1.0);
    vec3 finalRgb = sceneRgb * visibility + ringColor;
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    float alpha = clamp(reveal + ring * 0.6, 0.0, 1.0);
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