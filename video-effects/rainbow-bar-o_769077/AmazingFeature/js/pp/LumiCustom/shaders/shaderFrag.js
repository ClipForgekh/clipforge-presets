exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float slideDistance; // = 1.2 [0.8, 2.0] // 行横向移出距离倍数

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float sineInOut(float t) {
    return -0.5 * (cos(PI * t) - 1.0);
}

vec3 getRowTint(float row) {
    if (row < 0.5) return vec3(1.0, 0.2, 0.35);
    else if (row < 1.5) return vec3(1.0, 0.6, 0.1);
    else if (row < 2.5) return vec3(1.0, 0.95, 0.15);
    else if (row < 3.5) return vec3(0.1, 0.95, 0.5);
    else if (row < 4.5) return vec3(0.2, 0.55, 1.0);
    return vec3(0.8, 0.3, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    const float totalRows = 6.0;
    const float activePhaseEnd = 1.5 / 1.85;
    const float rowStagger = 0.08 / 1.5;

    float baseProgress = min(progress / activePhaseEnd, 1.0);

    float rowIndex = floor(vUv.y * totalRows);
    rowIndex = clamp(rowIndex, 0.0, totalRows - 1.0);

    float start = rowIndex * rowStagger;
    float localProgress = clamp((baseProgress - start) / max(1.0 - start, 0.0001), 0.0, 1.0);
    float eased = sineInOut(localProgress);

    float direction = mix(-1.0, 1.0, step(1.0, mod(rowIndex, 2.0)));
    float displacement = eased * slideDistance * direction;

    vec2 shiftedUV = vUv + vec2(displacement, 0.0);
    vec2 sampleUV = handleUVBounds(shiftedUV);
    vec4 rowSample = texture2D(tDiffuse, sampleUV);
    float mask = getHardBoundaryMask(shiftedUV);

    float tintStrength = smoothstep(0.0, 0.25, localProgress);
    vec3 tintColor = getRowTint(rowIndex);
    vec3 tintedRGB = mix(rowSample.rgb, tintColor, tintStrength);

    vec3 finalRGB = tintedRGB * mask;
    float finalAlpha = mix(rowSample.a, 1.0, 1.0 - mask);

    return vec4(finalRGB, finalAlpha);
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