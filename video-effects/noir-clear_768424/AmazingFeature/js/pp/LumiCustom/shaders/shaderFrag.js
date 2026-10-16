exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float thresholdBase; // = 0.45 [0.0, 1.0] // LumiThreshold中等预设基准阈值
uniform float thresholdSoftness; // = 0.12 [0.001, 0.5] // 阈值边缘柔和度
uniform float darkness; // = 0.85 [0.0, 1.0] // 初始暗场强度
uniform float shakeAmount; // = 0.012 [0.0, 0.05] // LumiShake振幅
uniform float chromaAmount; // = 0.02 [0.0, 0.08] // LumiChromaticAberration高预设强度

varying vec2 vUv;

float tween(float p) {
    return p;
}

float easeInQuad(float t) {
    return t * t;
}

float easeOutQuad(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float p) {
    const float stage1End = 0.3; // 0.0s - 0.6s
    const float stage2End = 0.6; // 0.6s - 1.2s

    float t1 = clamp(p / stage1End, 0.0, 1.0);
    float t2 = clamp((p - stage1End) / (stage2End - stage1End), 0.0, 1.0);
    float t3 = clamp((p - stage2End) / (1.0 - stage2End), 0.0, 1.0);

    float revealFront = easeInQuad(clamp(p / stage2End, 0.0, 1.0));

    vec2 center = vec2(0.5);
    vec2 ap = getSDFCoordinate(vUv, center);
    float maxR = (ratio > 1.0) ? 0.5 * sqrt(1.0 + 1.0 / (ratio * ratio)) : 0.5 * sqrt(ratio * ratio + 1.0);
    float distN = length(ap) / max(maxR, 0.0001);

    float luma = dot(texel.rgb, vec3(0.299, 0.587, 0.114));
    float thresholdSignal = luma - thresholdBase + (revealFront - distN) * 1.25;
    float thresholdMask = smoothstep(-thresholdSoftness, thresholdSoftness, thresholdSignal);

    float thresholdWeight = 1.0 - easeOutQuad(t3);
    float revealMask = mix(1.0, thresholdMask, thresholdWeight);

    float shakeW;
    if (p < stage1End) {
        shakeW = 0.35 * t1;
    } else if (p < stage2End) {
        shakeW = 0.35 + 0.65 * smoothstep(0.0, 1.0, t2);
    } else {
        shakeW = 1.0 - easeOutQuad(t3);
    }

    vec2 vib = vec2(
        sin(p * 123.0) + 0.5 * sin(p * 217.0 + 1.1),
        cos(p * 141.0 + 0.7) + 0.5 * cos(p * 251.0 + 2.3)
    );
    vec2 shakeOffset = vib * (shakeAmount * 0.5 * shakeW);

    float chromaW;
    if (p < stage1End) {
        chromaW = 0.0;
    } else if (p < stage2End) {
        chromaW = smoothstep(0.0, 1.0, t2);
    } else {
        chromaW = 1.0 - easeOutQuad(t3);
    }

    vec2 radialDir = normalize((vUv - center) + vec2(1e-5));
    vec2 chromaOffset = radialDir * (chromaAmount * chromaW);

    vec2 uvG = handleUVBounds(vUv + shakeOffset);
    vec2 uvR = handleUVBounds(vUv + shakeOffset + chromaOffset);
    vec2 uvB = handleUVBounds(vUv + shakeOffset - chromaOffset);

    vec4 cR = texture2D(tDiffuse, uvR);
    vec4 cG = texture2D(tDiffuse, uvG);
    vec4 cB = texture2D(tDiffuse, uvB);

    vec3 chromaColor = vec3(cR.r, cG.g, cB.b);

    vec3 darkBase = texel.rgb * (1.0 - darkness);
    vec3 finalRGB = mix(darkBase, chromaColor, revealMask);

    return vec4(finalRGB, texel.a);
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