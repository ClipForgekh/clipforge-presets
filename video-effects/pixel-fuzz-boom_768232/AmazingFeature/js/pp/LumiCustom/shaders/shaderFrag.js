exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float shardCount; // = 72.0 [12.0, 180.0] // 棱镜碎片密度
uniform float shatterStrength; // = 0.22 [0.0, 0.6] // 碎裂位移强度
uniform float chromaStrength; // = 1.0 [0.0, 2.0] // 色散强度
uniform float glowStrength; // = 0.85 [0.0, 2.0] // 裂纹辉光强度
uniform vec3 crackGlowColor; // = vec3(0.72, 0.9, 1.0) // 裂纹光颜色

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
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

vec2 hash22(vec2 p) {
    float n = hash12(p);
    return vec2(n, hash12(p + n + 7.13));
}

vec2 rot2(vec2 p, float a) {
    float s = sin(a);
    float c = cos(a);
    return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = vUv;
    vec2 centered = uv - 0.5;
    vec2 aspectCentered = centered;
    if (ratio > 1.0) aspectCentered.y /= ratio;
    else aspectCentered.x *= ratio;

    float phaseCrack = (1.0 - smoothstep(0.24, 0.48, p));
    float phaseShatter = smoothstep(0.18, 0.42, p) * (1.0 - smoothstep(0.72, 0.96, p));
    float phaseStorm = smoothstep(0.44, 0.62, p) * (1.0 - smoothstep(0.76, 0.95, p));
    float phasePolish = smoothstep(0.82, 0.98, p) * (1.0 - p);

    vec2 grid = vec2(shardCount, shardCount * (ratio > 1.0 ? 1.0 / ratio : ratio));
    vec2 cell = floor(uv * grid);
    vec2 f = fract(uv * grid) - 0.5;
    vec2 rnd = hash22(cell + 11.7);

    float baseAng = rnd.x * 6.2831853;
    vec2 randDir = normalize(vec2(cos(baseAng), sin(baseAng)) + 1e-4);
    vec2 radial = normalize(aspectCentered + (rnd - 0.5) * 0.18 + 1e-4);

    float shatterAmt = shatterStrength * (phaseShatter * 0.8 + phaseStorm * 1.2);
    float spin = (rnd.y - 0.5) * 4.0 * (phaseShatter + phaseStorm * 1.4);
    vec2 rf = rot2(f, spin);
    vec2 uvSharded = (cell + (rf + 0.5)) / grid;

    vec2 drift = (radial * 0.35 + randDir * 0.25) * shatterAmt;
    vec2 stormJitter = (hash22(cell + p * 41.3) - 0.5) * 0.06 * phaseStorm * chromaStrength;
    vec2 displacedUVRaw = uvSharded - drift - stormJitter;
    float borderMask = getHardBoundaryMask(displacedUVRaw);
    vec2 displacedUV = handleUVBounds(displacedUVRaw);

    vec2 chromaDir = normalize(aspectCentered + (rnd - 0.5) * 0.2 + 1e-4);
    vec2 chromaOff = chromaDir * 0.018 * chromaStrength * phaseStorm;

    vec4 baseCol = texture2D(tDiffuse, displacedUV);
    vec4 colR = texture2D(tDiffuse, handleUVBounds(displacedUV + chromaOff));
    vec4 colG = texture2D(tDiffuse, displacedUV);
    vec4 colB = texture2D(tDiffuse, handleUVBounds(displacedUV - chromaOff));
    vec3 chromaCol = vec3(colR.r, colG.g, colB.b);

    vec3 mixedCol = mix(baseCol.rgb, chromaCol, clamp(phaseStorm, 0.0, 1.0));

    float crackA = abs(sin((uv.x * 142.0 + uv.y * 91.0) + rnd.x * 6.2831));
    float crackB = abs(sin((uv.y * 167.0 - uv.x * 103.0) + rnd.y * 6.2831));
    float crackMask = smoothstep(0.92, 0.995, crackA * crackB);
    float crackGlow = crackMask * glowStrength * phaseCrack;

    float polishWave = exp(-pow(length(aspectCentered) * 3.0, 2.0));
    vec3 polish = vec3(1.0) * polishWave * phasePolish * 0.9;

    vec3 finalRgb = mixedCol + crackGlowColor * crackGlow + polish;
    finalRgb = clamp(finalRgb, 0.0, 1.0);

    float finalAlpha = baseCol.a * borderMask;
    return vec4(finalRgb, finalAlpha);
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