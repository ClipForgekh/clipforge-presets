exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float pausePortion; // = 0.18 [0.0, 0.6] // 起爆前停顿占比
uniform float fragmentCount; // = 28.0 [8.0, 80.0] // 碎片网格密度
uniform float explodeStrength; // = 0.42 [0.05, 1.2] // 爆裂扩散强度
uniform float shrinkStrength; // = 0.92 [0.0, 1.0] // 碎片缩小强度
uniform float crackIntensity; // = 1.0 [0.0, 2.0] // 能量裂纹强度
uniform vec4 energyColor; // = vec4(0.20, 0.85, 1.00, 1.00) // 能量裂纹颜色RGBA

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    return (p < 0.5) ? (2.0 * p * p) : (1.0 - pow(-2.0 * p + 2.0, 2.0) * 0.5);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

mat2 rot2(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

vec4 effect(vec4 texel, float p) {
    float start = clamp(pausePortion, 0.0, 0.95);
    float e = clamp((p - start) / max(1.0 - start, 0.0001), 0.0, 1.0);

    float grid = max(fragmentCount, 2.0);
    vec2 gid = floor(vUv * grid);
    vec2 fuv = fract(vUv * grid);

    float rnd = hash21(gid + 7.13);
    float rnd2 = hash21(gid + 19.71);

    vec2 cellCenter = (gid + 0.5) / grid;
    vec2 fromCenter = cellCenter - vec2(0.5);
    if (ratio > 1.0) fromCenter.y /= ratio; else fromCenter.x *= ratio;
    vec2 dir = normalize(fromCenter + vec2(cos(rnd * 6.2831), sin(rnd2 * 6.2831)) * 0.25 + vec2(1e-4));

    float dist = explodeStrength * e * (0.35 + 0.9 * rnd);
    float ang = (rnd - 0.5) * 2.2 * e;

    float shrink = 1.0 - shrinkStrength * e * (0.75 + 0.25 * rnd2);
    shrink = max(shrink, 0.05);

    vec2 local = (fuv - 0.5) / shrink;
    local = rot2(-ang) * local;

    vec2 srcUV = (gid + local + 0.5) / grid - dir * dist;
    vec2 suv = handleUVBounds(srcUV);

    vec2 vel = dir * explodeStrength * (0.012 + 0.02 * e);
    vec4 c0 = texture2D(tDiffuse, handleUVBounds(suv));
    vec4 c1 = texture2D(tDiffuse, handleUVBounds(suv - vel));
    vec4 c2 = texture2D(tDiffuse, handleUVBounds(suv - vel * 2.0));
    vec4 fragColor = (c0 * 0.5 + c1 * 0.3 + c2 * 0.2);

    float edge = min(min(fuv.x, 1.0 - fuv.x), min(fuv.y, 1.0 - fuv.y));
    float crack = (1.0 - smoothstep(0.03, 0.08, edge)) * smoothstep(0.0, 0.2, e) * (1.0 - smoothstep(0.45, 0.9, e));
    float pulse = 0.6 + 0.4 * sin((length(fromCenter) * 25.0 - e * 18.0) * 3.14159265);
    vec3 emissive = energyColor.rgb * crackIntensity * crack * pulse;

    float disappear = 1.0 - smoothstep(0.62, 1.0, e);
    float fragmentAlpha = disappear * (1.0 - 0.35 * e);
    float borderMask = getHardBoundaryMask(srcUV);

    vec3 finalRgb = fragColor.rgb + emissive;
    float finalA = fragColor.a * fragmentAlpha * borderMask;

    return vec4(finalRgb, finalA);
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