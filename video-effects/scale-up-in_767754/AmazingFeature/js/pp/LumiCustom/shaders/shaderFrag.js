exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float startScale; // = 0.2 [0.05, 0.8] // 初始缩放（越小越有冲击）
uniform float bounceStrength; // = 0.18 [0.0, 0.5] // 回弹强度
uniform vec3 energyColor; // = vec3(0.35, 0.85, 1.0) // 能量光颜色

varying vec2 vUv; // 纹理坐标

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
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

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    else return sqrt(ratio * ratio + 1.0) * safetyFactor;
}

vec4 effect(vec4 texel, float p) {
    float bounce = sin(p * 3.14159265 * 3.2) * exp(-p * 6.0);
    float displayScale = mix(startScale, 1.0, p) + bounceStrength * bounce;
    displayScale = max(displayScale, 0.05);

    vec2 rawUV = 0.5 + (vUv - 0.5) / displayScale;
    vec2 uv = handleUVBounds(rawUV);
    vec4 subjectTexel = texture2D(tDiffuse, uv);
    float subjectMask = getHardBoundaryMask(rawUV);
    subjectTexel.a *= subjectMask;

    vec2 c = vec2(0.5, 0.5);
    vec2 sp = getSDFCoordinate(vUv, c);
    float dist = length(sp);

    float maxR = getMaxShapeSize() * 0.6;
    float ringRadius = mix(0.01, maxR, p);
    float ringWidth = mix(0.09, 0.018, p);

    float ring = exp(-pow((dist - ringRadius) / max(ringWidth, 0.0001), 2.0));
    float core = exp(-dist * 55.0);

    float energyFade = (1.0 - p);
    float glow = (ring * 1.2 + core * 1.4) * energyFade;

    vec3 rgb = subjectTexel.rgb + energyColor * glow * (1.0 - subjectTexel.a * 0.9);
    rgb = clamp(rgb, 0.0, 1.0);

    return vec4(rgb, subjectTexel.a);
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