exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float innerRatio; // = 0.45 [0.2, 0.7] // 星形内外半径比例
uniform float glowStrength; // = 0.18 [0.0, 0.5] // 光晕强度
uniform float glowWidth; // = 0.04 [0.005, 0.12] // 光晕宽度（相对短边）
uniform vec3 glowColor; // = vec3(1.0, 0.9, 0.5) // 光晕颜色

varying vec2 vUv;

const float PI = 3.14159265359;

float tween(float p) {
    return 3.0 * p * p - 2.0 * p * p * p;
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) {
        p.y /= ratio;
    } else {
        p.x *= ratio;
    }
    return p;
}

float getMaxShapeSize() {
    const float safetyFactor = 2.0;
    if (ratio > 1.0) {
        return sqrt(1.0 + 1.0 / (ratio * ratio)) * safetyFactor;
    } else {
        return sqrt(ratio * ratio + 1.0) * safetyFactor;
    }
}

float getShortSideRelativeSize(float fraction) {
    if (ratio > 1.0) {
        return fraction;
    } else {
        return fraction * ratio;
    }
}

float starSDF(vec2 p, float outerRadius, float innerRadius, float sharpness) {
    float angle = atan(p.y, p.x);
    float radius = length(p);
    float c = abs(cos(5.0 * angle));
    float shaped = pow(c, max(sharpness, 0.0001));
    float boundary = mix(innerRadius, outerRadius, shaped);
    return radius - boundary;
}

vec4 effect(vec4 texel, float p) {
    float remaining = 1.0 - p;
    float maxSize = getMaxShapeSize();
    float outerRadius = maxSize * p;
    float innerRadius = outerRadius * innerRatio;

    vec2 sdfCoord = getSDFCoordinate(vUv, vec2(0.5));
    float rotation = p * (PI * 0.5);
    float s = sin(rotation);
    float c = cos(rotation);
    sdfCoord = mat2(c, -s, s, c) * sdfCoord;

    float dist = starSDF(sdfCoord, outerRadius, innerRadius, 1.5);
    float edgeSoftness = getShortSideRelativeSize(0.01);
    float mask = smoothstep(edgeSoftness, -edgeSoftness, dist);

    vec4 baseColor = mix(vec4(0.0), texel, mask);

    float glowEdge = getShortSideRelativeSize(glowWidth);
    float glow = smoothstep(glowEdge, 0.0, abs(dist)) * glowStrength * remaining;
    baseColor.rgb += glowColor * glow;
    baseColor.rgb = clamp(baseColor.rgb, 0.0, 1.0);
    baseColor.a = texel.a * mask + glow * (1.0 - texel.a);

    return baseColor;
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