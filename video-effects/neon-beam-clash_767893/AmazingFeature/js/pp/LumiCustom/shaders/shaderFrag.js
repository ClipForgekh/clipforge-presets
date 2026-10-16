exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurPeak; // = 0.03 [0.005, 0.08] // 切片方向模糊峰值
uniform float neonStrength; // = 1.8 [0.0, 3.0] // 霓虹光带强度
uniform float gapSize; // = 0.0012 [0.0, 0.01] // 切片间隙宽度（UV单位，约1px）

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

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 34.45);
    return fract(p.x * p.y);
}

vec4 directionalBlur(vec2 uv, vec2 dir, float radius) {
    vec4 acc = vec4(0.0);
    float wsum = 0.0;

    for (int i = -4; i <= 4; i++) {
        float fi = float(i);
        float w = 1.0 - abs(fi) / 4.0;
        vec2 suv = handleUVBounds(uv + dir * radius * fi);
        acc += texture2D(tDiffuse, suv) * w;
        wsum += w;
    }

    return acc / max(wsum, 0.0001);
}

vec4 effect(vec4 texel, float p) {
    const float sliceCount = 12.0;

    float sliceIdx = floor(vUv.y * sliceCount);
    float localY = fract(vUv.y * sliceCount);

    float gapAppear = smoothstep(0.02, 0.12, p);
    float halfGap = gapSize * 0.5 * gapAppear;
    float gapMask = step(halfGap, localY) * step(localY, 1.0 - halfGap);

    float odd = mod(sliceIdx, 2.0);
    vec2 dir = mix(vec2(0.0, ratio), vec2(1.0, 0.0), odd);

    float blurRise = smoothstep(0.03, 0.45, p);
    float blurRadius = blurPeak * blurRise * (0.8 + 0.2 * hash21(vec2(sliceIdx, 7.13)));
    vec4 sliced = directionalBlur(vUv, dir, blurRadius);

    float detailFade = smoothstep(0.45, 1.0, p);
    vec3 sceneColor = mix(sliced.rgb, vec3(dot(sliced.rgb, vec3(0.299, 0.587, 0.114))), detailFade * 0.35);

    float moveP = smoothstep(0.0, 0.65, p);
    float xL = mix(-0.15, 0.5, moveP);
    float xR = mix(1.15, 0.5, moveP);

    float bandWidth = mix(0.06, 0.015, moveP);
    float leftBand = exp(-abs(vUv.x - xL) / max(bandWidth, 0.0001));
    float rightBand = exp(-abs(vUv.x - xR) / max(bandWidth, 0.0001));

    float collision = exp(-pow((p - 0.62) / 0.11, 2.0));
    float centerGlow = exp(-abs(vUv.x - 0.5) / 0.11) * (0.6 + 0.4 * exp(-abs(vUv.y - 0.5) / 0.35));
    float flash = collision * centerGlow * 3.2;

    float collapse = smoothstep(0.62, 0.95, p);
    float topRemnant = exp(-abs(vUv.y - mix(0.5, 0.92, collapse)) / 0.03) * (1.0 - collapse);
    float bottomRemnant = exp(-abs(vUv.y - mix(0.5, 0.08, collapse)) / 0.03) * (1.0 - collapse);
    float remnant = (topRemnant + bottomRemnant) * 0.7;

    vec3 magenta = vec3(1.0, 0.15, 0.85);
    vec3 cyan = vec3(0.1, 0.95, 1.0);
    vec3 neon = (leftBand * magenta + rightBand * cyan) * neonStrength;
    neon += (flash + remnant * collision) * vec3(1.0, 0.95, 1.0) * neonStrength;

    float edgeZone = exp(-abs(abs(vUv.x - 0.5) - 0.09) / 0.03) * collision;
    float grain = hash21(floor(vUv * vec2(220.0, 220.0)));
    float particles = step(0.965, grain) * edgeZone * (1.0 - smoothstep(0.68, 0.95, p));
    neon += particles * vec3(0.9, 1.0, 1.0) * 1.8;

    vec3 composed = sceneColor + neon;

    float blackout = smoothstep(0.55, 1.0, p);
    composed *= (1.0 - blackout);

    float alpha = texel.a * gapMask * (1.0 - smoothstep(0.5, 1.0, p));
    return vec4(composed, alpha);
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