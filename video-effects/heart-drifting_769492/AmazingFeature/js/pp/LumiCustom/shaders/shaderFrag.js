exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float pieceCount; // = 42.0 [16.0, 96.0] // 碎块密度
uniform float windStrength; // = 0.22 [0.0, 0.6] // 向右风偏强度
uniform float riseStrength; // = 1.15 [0.2, 2.0] // 上升强度
uniform float trailLength; // = 0.03 [0.005, 0.08] // 拖尾长度（UV）
uniform vec3 trailColor; // = vec3(1.0, 0.78, 0.90) // 淡粉星光拖尾颜色

varying vec2 vUv;

float tween(float p) {
    return p * p;
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

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

float sdHeart(vec2 p) {
    p.x = abs(p.x);
    if (p.y + p.x > 1.0) {
        vec2 q = p - vec2(0.25, 0.75);
        return length(q) - 0.35355339;
    }
    float a = dot(p - vec2(0.00, 1.00), p - vec2(0.00, 1.00));
    float b = dot(p - vec2(0.50, 0.50), p - vec2(0.50, 0.50));
    return sqrt(min(a, b)) * sign(p.x - p.y);
}

float heartSDF(vec2 uv, vec2 center, float size) {
    vec2 p = getSDFCoordinate(uv, center);
    p /= max(size, 0.0001);
    p.y += 0.45;
    return sdHeart(p) * size;
}

vec2 toAspect(vec2 p) {
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

float sdSegmentAspect(vec2 p, vec2 a, vec2 b) {
    vec2 pa = toAspect(p - a);
    vec2 ba = toAspect(b - a);
    float h = clamp(dot(pa, ba) / max(dot(ba, ba), 0.00001), 0.0, 1.0);
    return length(pa - ba * h);
}

vec4 effect(vec4 texel, float p) {
    float t = clamp(p, 0.0, 1.0);

    vec2 gridUV = vUv * pieceCount;
    vec2 cell = floor(gridUV);
    float rnd = hash21(cell);
    float rnd2 = hash21(cell + 17.13);

    float pieceSize = mix(0.38, 0.90, rnd);
    float sizeSpeed = mix(1.45, 0.72, pieceSize);

    float flutterPhase = t * 10.0 + rnd * 6.2831853;
    float flutter = sin(flutterPhase) * (0.012 + 0.010 * rnd2) * (1.0 - t);

    float xMove = windStrength * t * sizeSpeed + flutter * 0.6;
    float yMove = -riseStrength * (0.65 * t + 0.35 * t * t) * sizeSpeed + flutter;

    vec2 move = vec2(xMove, yMove);

    vec2 uvMoved = vUv - move;
    vec2 uvClamped = handleUVBounds(uvMoved);
    vec4 movedTexel = texture2D(tDiffuse, uvClamped);

    vec2 srcGrid = uvMoved * pieceCount;
    vec2 srcCell = floor(srcGrid);
    vec2 srcCenter = (srcCell + 0.5) / pieceCount;

    float srcRnd = hash21(srcCell);
    float srcRnd2 = hash21(srcCell + 9.7);
    float srcPieceSize = mix(0.38, 0.90, srcRnd);

    float scaleNow = mix(1.0, 0.3, t);
    float heartSizeUV = (0.5 / pieceCount) * srcPieceSize * scaleNow;

    vec2 pix = floor((uvMoved * pieceCount - srcCell - 0.5) * 12.0) / 12.0;
    vec2 pixUV = srcCenter + pix / pieceCount;
    float h = heartSDF(pixUV, srcCenter, heartSizeUV);
    float heartMask = 1.0 - smoothstep(-0.0015, 0.0025, h);

    float plushNoise = hash21(srcCell * 1.7 + floor(pix * 18.0 + 20.0));
    float plush = 0.93 + (plushNoise - 0.5) * 0.12;

    vec2 dir = normalize(vec2(0.35 + srcRnd2 * 0.25, -1.0));
    vec2 centerNow = srcCenter + vec2(
        windStrength * t * mix(1.45, 0.72, srcPieceSize),
        -riseStrength * (0.65 * t + 0.35 * t * t) * mix(1.45, 0.72, srcPieceSize)
    );
    vec2 tailEnd = centerNow - dir * trailLength;
    float tailDist = sdSegmentAspect(vUv, centerNow, tailEnd);
    float tailWidth = 0.006;
    float tailMask = smoothstep(tailWidth, 0.0, tailDist) * (1.0 - smoothstep(0.85, 1.0, t));

    float alphaLinear = mix(1.0, 0.5, t);
    float vanish = 1.0 - smoothstep(0.72, 1.0, t);
    float pieceAlpha = heartMask * alphaLinear * vanish;

    float brightness = 1.0 - t;

    vec3 pieceRgb = movedTexel.rgb * plush * brightness;
    vec3 trailRgb = trailColor * brightness;

    vec3 rgb = pieceRgb * pieceAlpha + trailRgb * (tailMask * 0.65 * alphaLinear);
    float outA = max(pieceAlpha, tailMask * 0.65 * alphaLinear) * movedTexel.a * getHardBoundaryMask(uvMoved);

    vec4 fragmented = vec4(rgb, outA);

    float crackIn = smoothstep(0.0, 0.08, t);
    return mix(texel, fragmented, crackIn);
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