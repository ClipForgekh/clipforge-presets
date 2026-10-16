exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0, 1]
uniform float ratio; // = 1.0 [0.1, 2]
uniform float shardDensity; // = 18.0 [10.0, 32.0]
uniform float flyDistance; // = 1.8 [0.5, 3.0]
uniform float maxBlur; // = 0.02 [0.0, 0.06]
uniform float glowIntensity; // = 1.4 [0.0, 3.0]
uniform float rainbowStrength; // = 0.6 [0.0, 1.5]

varying vec2 vUv;

float tween(float p) {
    return p * p * p * p * p;
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

vec2 hash22(vec2 p) {
    float n = hash21(p);
    return vec2(n, hash21(p + n + 17.13));
}

vec4 voronoiInfo(vec2 uv, float cells) {
    vec2 gv = uv * cells;
    vec2 id = floor(gv);
    vec2 f = fract(gv);

    float d1 = 10.0;
    float d2 = 10.0;
    vec2 bestId = id;

    for (int j = -1; j <= 1; j++) {
        for (int i = -1; i <= 1; i++) {
            vec2 o = vec2(float(i), float(j));
            vec2 cid = id + o;
            vec2 p = hash22(cid);
            vec2 r = o + p - f;
            float d = length(r);
            if (d < d1) {
                d2 = d1;
                d1 = d;
                bestId = cid;
            } else if (d < d2) {
                d2 = d;
            }
        }
    }
    return vec4(d1, d2, bestId);
}

vec4 blur9(vec2 uv, float radius) {
    vec2 stepUV = vec2(radius, radius / max(ratio, 0.0001));
    vec2 uv0 = handleUVBounds(uv);

    vec4 c = texture2D(tDiffuse, uv0) * 0.227027;
    c += texture2D(tDiffuse, handleUVBounds(uv0 + vec2( stepUV.x, 0.0))) * 0.1945946;
    c += texture2D(tDiffuse, handleUVBounds(uv0 - vec2( stepUV.x, 0.0))) * 0.1945946;
    c += texture2D(tDiffuse, handleUVBounds(uv0 + vec2(0.0,  stepUV.y))) * 0.1945946;
    c += texture2D(tDiffuse, handleUVBounds(uv0 - vec2(0.0,  stepUV.y))) * 0.1945946;
    c += texture2D(tDiffuse, handleUVBounds(uv0 + stepUV)) * 0.060598;
    c += texture2D(tDiffuse, handleUVBounds(uv0 - stepUV)) * 0.060598;
    c += texture2D(tDiffuse, handleUVBounds(uv0 + vec2(stepUV.x, -stepUV.y))) * 0.060598;
    c += texture2D(tDiffuse, handleUVBounds(uv0 + vec2(-stepUV.x, stepUV.y))) * 0.060598;
    return c / 1.2536064;
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.000001) return texel;

    float cells = shardDensity;
    vec4 vi = voronoiInfo(vUv, cells);
    float edgeDist = vi.y - vi.x;
    vec2 cid = vi.zw;

    float rnd = hash21(cid + 2.71);
    vec2 rnd2 = hash22(cid + 9.37);

    vec2 radial = vUv - 0.5;
    if (ratio > 1.0) radial.y /= ratio; else radial.x *= ratio;
    vec2 dir = normalize(radial + (rnd2 - 0.5) * 0.75);
    if (length(dir) < 0.0001) dir = normalize(rnd2 - 0.5);

    float accel = pow(p, 1.8);
    float speed = accel * (0.6 + 0.8 * rnd);
    vec2 displacement = dir * flyDistance * speed;

    vec2 srcUV = vUv - displacement;
    float srcMask = getHardBoundaryMask(srcUV);

    float blurRadius = maxBlur * speed;
    vec4 blurred = blur9(srcUV, blurRadius);

    float crackWidth = 0.035 / max(cells / 18.0, 0.5);
    float crack = 1.0 - smoothstep(0.0, crackWidth, edgeDist);

    vec2 local = fract(vUv * cells);
    vec2 cp = hash22(cid);
    float localD = length(local - cp);
    float edgeToInner = smoothstep(0.12, 0.58, localD);
    float cover = smoothstep(0.0, 1.0, p * 1.35 + edgeToInner * 0.9 - 0.25);

    vec3 iceBlue = vec3(0.45, 0.78, 1.0);
    float glow = glowIntensity * (0.28 * crack * (1.0 - p) + cover * pow(p, 1.5));

    float ang = 6.2831853 * hash21(cid + 21.0);
    vec2 n = vec2(cos(ang), sin(ang));
    float ch = (0.001 + 0.004 * speed) * rainbowStrength * (0.2 + crack);
    vec2 chOff = vec2(ch, ch / max(ratio, 0.0001)) * n;

    vec2 uvR = handleUVBounds(srcUV + chOff);
    vec2 uvG = handleUVBounds(srcUV);
    vec2 uvB = handleUVBounds(srcUV - chOff);

    vec3 refractRGB = vec3(
        texture2D(tDiffuse, uvR).r,
        texture2D(tDiffuse, uvG).g,
        texture2D(tDiffuse, uvB).b
    );

    vec3 rgb = blurred.rgb;
    rgb += iceBlue * glow;
    rgb += refractRGB * crack * glow * 0.65;
    rgb = min(rgb, vec3(2.5));

    float vanish = 1.0 - pow(p, 1.25);
    float tailFade = 1.0 - smoothstep(0.9, 1.0, p);
    float a = blurred.a * srcMask * vanish * tailFade;
    rgb *= srcMask * vanish * tailFade;

    return vec4(rgb, a);
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