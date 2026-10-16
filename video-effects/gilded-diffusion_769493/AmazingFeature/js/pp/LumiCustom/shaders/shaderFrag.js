exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float holdPortion; // = 0.2 [0.0, 0.6] // 前段保持清晰的时间占比
uniform float stretchStrength; // = 2.2 [0.5, 4.0] // 条带拉伸强度
uniform float blurStrength; // = 1.2 [0.0, 3.0] // 模糊强度
uniform float particleDensity; // = 0.7 [0.0, 1.5] // 金粉密度
uniform vec3 goldColor; // = vec3(1.0, 0.82, 0.35) // 鎏金颜色

varying vec2 vUv;

float tween(float p) {
    return p * p * p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec4 sampleStripBlur(vec2 uv, float amount) {
    vec2 stepY = vec2(0.0, (0.002 + 0.01 * amount) / max(ratio, 0.0001));
    vec2 dir = uv - vec2(0.5);
    if (ratio > 1.0) dir.y /= ratio; else dir.x *= ratio;
    vec2 rdir = normalize(dir + vec2(1e-5));
    vec2 stepR = rdir * (0.001 + 0.008 * amount);

    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.30;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepY)) * 0.16;
    c += texture2D(tDiffuse, handleUVBounds(uv - stepY)) * 0.16;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepR)) * 0.19;
    c += texture2D(tDiffuse, handleUVBounds(uv - stepR)) * 0.19;
    return c;
}

float particleLayer(vec2 uv, float p, float stripId, float dirSign, float edgeFactor, float edgeGlowMask) {
    float gridX = floor(uv.x * 36.0);
    float seed = hash12(vec2(gridX + stripId * 7.13, stripId * 3.71));
    float t = fract(seed + p * (1.1 + seed * 1.5));
    float px = (gridX + seed) / 36.0;
    float py = fract((stripId + 0.5) / 12.0 + dirSign * t * (0.25 + 0.45 * edgeFactor) + (seed - 0.5) * 0.08);
    vec2 pp = vec2(px, py);

    vec2 d = uv - pp;
    if (ratio > 1.0) d.y /= ratio; else d.x *= ratio;
    float r = 0.002 + 0.004 * seed;
    float point = smoothstep(r, 0.0, length(d));
    float alive = step(0.25, seed + particleDensity * 0.35);
    return point * alive * p * edgeGlowMask;
}

vec4 effect(vec4 texel, float p) {
    float localP = clamp((p - holdPortion) / max(1.0 - holdPortion, 0.0001), 0.0, 1.0);
    if (localP <= 0.0) return texel;

    float bands = 12.0;
    float bandF = floor(vUv.y * bands);
    float bandId = clamp(bandF, 0.0, bands - 1.0);
    float bandCenter = (bandId + 0.5) / bands;
    float bandLocal = fract(vUv.y * bands);
    float edgeDist = min(bandLocal, 1.0 - bandLocal);

    float centerDist = abs((bandId + 0.5) - bands * 0.5) / (bands * 0.5);
    float edgeSpeed = mix(1.0, 2.0, centerDist);
    float stripP = clamp(localP * edgeSpeed, 0.0, 1.0);

    float odd = mod(bandId, 2.0);
    float dirSign = mix(-1.0, 1.0, odd);

    float stretch = 1.0 + stripP * stretchStrength * (1.0 + centerDist);
    float shift = dirSign * stripP * (0.25 + 0.45 * centerDist);

    vec2 suv = vUv;
    suv.y = bandCenter + (vUv.y - bandCenter) / stretch + shift;
    vec4 stripCol = sampleStripBlur(suv, stripP * blurStrength);

    float edgeGlowMask = smoothstep(0.18, 0.0, edgeDist);
    float glow = edgeGlowMask * (0.2 + 0.8 * stripP);
    vec3 goldGlow = goldColor * glow * (0.6 + 0.8 * stripP);

    float particles = 0.0;
    particles += particleLayer(vUv, stripP, bandId, dirSign, centerDist, edgeGlowMask);
    particles += particleLayer(vUv + vec2(0.013, -0.009), stripP, bandId + 1.23, dirSign, centerDist, edgeGlowMask) * 0.7;
    vec3 particleCol = goldColor * particles * 1.5;

    vec3 mixed = stripCol.rgb + goldGlow + particleCol;
    mixed = clamp(mixed, 0.0, 1.0);

    float threadThin = smoothstep(0.35, 0.0, edgeDist + (1.0 - stripP) * 0.25);
    float dissolve = 1.0 - localP;
    float alpha = stripCol.a * mix(1.0, threadThin, stripP * 0.75) * dissolve;

    return vec4(mixed, alpha);
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