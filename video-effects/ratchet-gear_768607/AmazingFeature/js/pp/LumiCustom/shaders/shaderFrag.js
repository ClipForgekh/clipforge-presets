exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float uBrightness; // = 1.0 [0.5, 1.5] // 全局亮度
uniform float petalStrength; // = 1.0 [0.0, 1.5] // 齿瓣开合强度

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float cubicInOut(float x) {
    return x < 0.5 ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) * 0.5;
}

float cubicOut(float x) {
    float a = 1.0 - x;
    return 1.0 - a * a * a;
}

float backOut(float x) {
    float c1 = 1.70158;
    float c3 = c1 + 1.0;
    float t = x - 1.0;
    return 1.0 + c3 * t * t * t + c1 * t * t;
}

mat2 rot2(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

vec2 aspectVec(vec2 p) {
    vec2 q = p;
    if (ratio > 1.0) q.y /= ratio;
    else q.x *= ratio;
    return q;
}

vec2 unAspectVec(vec2 q) {
    vec2 p = q;
    if (ratio > 1.0) p.y *= ratio;
    else p.x /= ratio;
    return p;
}

vec4 effect(vec4 texel, float p) {
    const float t1 = 0.55 / 3.0;
    const float t2 = 1.55 / 3.0;
    const float t3 = 2.35 / 3.0;
    const float t4 = 1.0;

    float s1 = clamp(p / t1, 0.0, 1.0);
    float s3 = clamp((p - t2) / (t3 - t2), 0.0, 1.0);
    float s4 = clamp((p - t3) / (t4 - t3), 0.0, 1.0);

    float parentTilt = radians(-22.0) * cubicInOut(s1) * (1.0 - cubicOut(s4));
    float parentScale = mix(1.0, 0.90, cubicInOut(s1)) + (1.0 - (mix(1.0, 0.90, cubicInOut(s1)))) * cubicOut(s4);

    float step10 = floor(s3 * 10.0) / 10.0;
    float ratchetZ = radians(30.0) * step10 * (1.0 - cubicOut(s4));

    vec2 uv = vUv;
    vec2 c = uv - 0.5;
    vec2 q = aspectVec(c);

    q *= parentScale;
    q = rot2(parentTilt + ratchetZ) * q;

    float r = length(q);
    float ang = atan(q.y, q.x);
    float twoPi = 6.28318530718;
    if (ang < 0.0) ang += twoPi;

    float kf = floor(mod(floor((ang + 0.2617993878) / 0.5235987756), 12.0));
    float openStart = t1 + (0.04 / 3.0) * kf;
    float openP = clamp((p - openStart) / (1.0 / 3.0), 0.0, 1.0);
    float openEase = backOut(openP);
    float closeEase = 1.0 - cubicOut(s4);
    float petalOpen = openEase * closeEase * petalStrength;

    float sectorCenter = kf * 0.5235987756;
    float da = abs(ang - sectorCenter);
    da = min(da, twoPi - da);

    float innerR = 0.22;
    float outerR = 0.56;
    float petalMask = smoothstep(innerR, innerR + 0.015, r) * (1.0 - smoothstep(outerR - 0.015, outerR, r));
    petalMask *= 1.0 - smoothstep(0.17, 0.23, da);

    vec2 dir = normalize(q + vec2(1e-5, 0.0));
    vec2 tanDir = vec2(-dir.y, dir.x);

    float radialMove = 0.24 * petalOpen;
    float fanTwist = radians(72.0) * 0.22 * petalOpen;
    vec2 qPetal = rot2(-fanTwist) * (q - dir * radialMove);
    qPetal += tanDir * (0.06 * petalOpen * smoothstep(innerR, outerR, r));

    vec2 qMix = mix(q, qPetal, petalMask);
    vec2 src = unAspectVec(qMix) + 0.5;
    src = handleUVBounds(src);

    vec4 col = texture2D(tDiffuse, src);
    col.rgb *= clamp(uBrightness, 0.0, 2.0);
    col.rgb = clamp(col.rgb, 0.0, 1.0);
    return vec4(col.rgb, texel.a);
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