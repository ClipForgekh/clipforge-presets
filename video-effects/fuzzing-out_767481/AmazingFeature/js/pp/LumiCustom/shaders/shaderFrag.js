exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float particleDensity; // = 120.0 [40.0, 260.0] // 粒子密度（越大粒子越多）
uniform float particleSize; // = 0.26 [0.08, 0.48] // 单个粒子半径（相对网格）
uniform float spread; // = 1.4 [0.2, 3.0] // 向外扩散距离
uniform float accel; // = 2.2 [0.0, 5.0] // 速度递增强度

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
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec2 aspectDirection(vec2 uv) {
    vec2 p = uv - 0.5;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float p) {
    vec2 grid = ratio > 1.0
        ? vec2(particleDensity * ratio, particleDensity)
        : vec2(particleDensity, particleDensity / max(ratio, 0.0001));

    vec2 gUv = vUv * grid;
    vec2 cellId = floor(gUv);
    vec2 local = fract(gUv) - 0.5;

    float rnd = hash21(cellId);
    float ang = rnd * 6.28318530718;
    vec2 jitterDir = vec2(cos(ang), sin(ang));

    vec2 radial = aspectDirection(vUv);
    vec2 dir = normalize(radial + jitterDir * 0.35 + vec2(1e-6));

    float speed = spread * (p * p) * (1.0 + accel * p);
    vec2 displacement = dir * speed;

    vec2 srcRawUV = vUv - displacement;
    vec2 srcUV = handleUVBounds(srcRawUV);
    vec4 moved = texture2D(tDiffuse, srcUV);
    float srcMask = getHardBoundaryMask(srcRawUV);

    float rVar = mix(0.75, 1.25, hash21(cellId + 17.13));
    float radius = particleSize * rVar;
    float d = length(local);
    float dotMask = 1.0 - smoothstep(radius, radius + 0.08, d);

    float particleMix = smoothstep(0.06, 0.35, p);
    float shapeMask = mix(1.0, dotMask, particleMix);

    float alphaFade = 1.0 - p;
    float finalAlpha = moved.a * srcMask * shapeMask * alphaFade;

    return vec4(moved.rgb, finalAlpha);
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