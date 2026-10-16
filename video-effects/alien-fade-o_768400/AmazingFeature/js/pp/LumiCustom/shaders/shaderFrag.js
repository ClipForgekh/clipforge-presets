exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float displacementStrength; // = 1.0 [0.2, 2.0] // 回声位移强度
uniform float hueShiftMax; // = 0.22 [0.0, 0.5] // 最大色相偏移
uniform float collapsePower; // = 2.4 [1.0, 4.0] // 末段坍缩速度

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    return (p < 0.5) ? (2.0 * p * p) : (1.0 - pow(-2.0 * p + 2.0, 2.0) * 0.5);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec3 p = abs(fract(c.xxx + vec3(0.0, 2.0 / 3.0, 1.0 / 3.0)) * 6.0 - 3.0);
    vec3 rgb = clamp(p - 1.0, 0.0, 1.0);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

vec3 hueShift(vec3 color, float shift) {
    vec3 hsv = rgb2hsv(color);
    hsv.x = fract(hsv.x + shift);
    return hsv2rgb(hsv);
}

float edgeMask(vec2 uv, vec4 baseCol) {
    vec2 px = vec2(1.0 / 1024.0, 1.0 / 1024.0);
    vec3 c1 = texture2D(tDiffuse, handleUVBounds(uv + vec2(px.x, 0.0))).rgb;
    vec3 c2 = texture2D(tDiffuse, handleUVBounds(uv - vec2(px.x, 0.0))).rgb;
    vec3 c3 = texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, px.y))).rgb;
    vec3 c4 = texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, px.y))).rgb;
    vec3 avgN = (c1 + c2 + c3 + c4) * 0.25;
    float e = length(baseCol.rgb - avgN);
    return clamp(e * 3.0, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float tStableEnd = 0.3 / 1.9;
    float tDispEnd = 1.1 / 1.9;
    float tHueStart = 0.55 / 1.9;
    float tHueEnd = 1.35 / 1.9;
    float tTakeoverEnd = 1.55 / 1.9;

    float dispBuild = smoothstep(tStableEnd, tDispEnd, p);
    float hueBuild = smoothstep(tHueStart, tHueEnd, p);
    float takeover = smoothstep(tDispEnd, tTakeoverEnd, p);
    float collapse = smoothstep(tTakeoverEnd, 1.0, p);

    vec2 aspectP = vUv - 0.5;
    if (ratio > 1.0) aspectP.y /= ratio; else aspectP.x *= ratio;
    float dist = length(aspectP);
    vec2 dir = normalize(aspectP + vec2(1e-5));

    float centerDampen = smoothstep(0.06, 0.34, dist);
    float detail = edgeMask(vUv, texel);

    float spread = displacementStrength * dispBuild * (0.008 + 0.05 * takeover);
    float dispAmt = spread * centerDampen * (0.35 + 0.65 * detail);

    float outwardGain = 1.0 + 1.5 * takeover;
    vec2 uv1 = handleUVBounds(vUv - dir * dispAmt * 1.0 * outwardGain);
    vec2 uv2 = handleUVBounds(vUv - dir * dispAmt * 2.0 * outwardGain);
    vec2 uv3 = handleUVBounds(vUv - dir * dispAmt * 3.2 * outwardGain);

    vec3 e1 = texture2D(tDiffuse, uv1).rgb;
    vec3 e2 = texture2D(tDiffuse, uv2).rgb;
    vec3 e3 = texture2D(tDiffuse, uv3).rgb;

    float hs = hueShiftMax * hueBuild;
    e1 = hueShift(e1, hs * 0.45);
    e2 = hueShift(e2, hs * 0.85);
    e3 = hueShift(e3, hs * 1.2);

    vec3 echoes = (e1 * 0.50 + e2 * 0.32 + e3 * 0.25) / 1.07;

    float origWeight = clamp(1.0 - 0.82 * takeover - 1.2 * collapse, 0.0, 1.0);
    float echoWeight = clamp((0.12 + 0.88 * dispBuild) * (1.0 - 0.25 * collapse), 0.0, 1.0);

    vec3 col = texel.rgb * origWeight + echoes * echoWeight;

    float implode = pow(collapse, collapsePower);
    float centerKeep = 1.0 - smoothstep(0.0, mix(0.95, 0.03, implode), dist);
    col *= centerKeep;
    col *= (1.0 - implode);
    col = clamp(col, 0.0, 1.0);

    return vec4(col, texel.a);
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