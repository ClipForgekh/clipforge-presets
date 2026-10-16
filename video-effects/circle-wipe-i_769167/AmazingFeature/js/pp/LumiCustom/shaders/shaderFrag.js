exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float edgeSoftness; // = 0.01 [0.001, 0.05] // 圆形边缘羽化

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 q = uv - center;
    if (ratio > 1.0) q.y /= ratio;
    else q.x *= ratio;
    return q;
}

float getCoverRadius(vec2 center) {
    vec2 c0 = getSDFCoordinate(vec2(0.0, 0.0), center);
    vec2 c1 = getSDFCoordinate(vec2(1.0, 0.0), center);
    vec2 c2 = getSDFCoordinate(vec2(0.0, 1.0), center);
    vec2 c3 = getSDFCoordinate(vec2(1.0, 1.0), center);
    float r = length(c0);
    r = max(r, length(c1));
    r = max(r, length(c2));
    r = max(r, length(c3));
    return r;
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, 0.5);
    float split = 0.25;
    float e = max(edgeSoftness, 0.0001);

    float maxR = getCoverRadius(center) + e * 2.0;
    float rStart = -e * 2.0;
    float rMid = maxR * 0.28;

    float radius;
    if (p < split) {
        float t = smoothstep(0.0, 1.0, p / split);
        radius = mix(rStart, rMid, t);
    } else {
        float t = smoothstep(0.0, 1.0, (p - split) / (1.0 - split));
        radius = mix(rMid, maxR, t);
    }

    float dist = length(getSDFCoordinate(vUv, center));
    float mask = 1.0 - smoothstep(radius - e, radius + e, dist);

    return vec4(texel.rgb, texel.a * mask);
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