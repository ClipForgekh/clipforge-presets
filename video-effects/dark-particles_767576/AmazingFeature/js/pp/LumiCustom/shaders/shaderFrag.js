exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float particleDensity; // = 90.0 [20.0, 180.0] // 粒子密度
uniform float scatterStrength; // = 1.0 [0.0, 2.0] // 初始散射强度
uniform float particleSize; // = 0.23 [0.05, 0.45] // 粒子尺寸

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
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

vec4 effect(vec4 texel, float p) {
    float inv = 1.0 - p;

    vec2 grid = vec2(particleDensity, particleDensity / max(ratio, 0.0001));
    vec2 cell = floor(vUv * grid);
    vec2 cellUV = (cell + 0.5) / grid;
    vec2 local = fract(vUv * grid) - 0.5;

    float r1 = hash12(cell + 1.37);
    float r2 = hash12(cell + 7.91);
    float ang = r1 * 6.28318530718;

    vec2 dir = vec2(cos(ang), sin(ang));
    float radial = (0.35 + 0.65 * r2) * scatterStrength;

    vec2 centerDir = cellUV - 0.5;
    float d = length(centerDir);
    centerDir = (d > 0.0001) ? centerDir / d : dir;

    vec2 scatterOffset = (dir * 0.25 + centerDir * 0.75) * radial * inv;
    vec2 sampleUV = handleUVBounds(cellUV + scatterOffset);

    vec4 particleColor = texture2D(tDiffuse, sampleUV);

    float radius = particleSize * (0.75 + 0.45 * inv);
    float dotMask = 1.0 - smoothstep(radius, radius + 0.06, length(local));

    vec4 particles = vec4(particleColor.rgb, particleColor.a * dotMask);

    float gather = smoothstep(0.65, 1.0, p);
    vec4 assembled = mix(particles, texel, gather);

    float boundaryMask = getHardBoundaryMask(vUv);
    return vec4(assembled.rgb, assembled.a * boundaryMask);
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