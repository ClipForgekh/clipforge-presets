exports.source=`
//===begin_frag_code===
precision highp float;

const float PI = 3.14159265;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float ghostOffset; // = 0.02 [0.0, 0.05] // 幽灵影像水平偏移强度
uniform float chromaAmount; // = 0.008 [0.0, 0.03] // 最大色散量
uniform float glitchStrength; // = 0.35 [0.0, 1.0] // 水平扫描故障强度

varying vec2 vUv;

float tween(float p) {
    return 0.5 * (1.0 + sin((p - 0.5) * PI));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float borderMask = getHardBoundaryMask(vUv);
    float maskBlend = smoothstep(0.82, 1.0, progress);
    float combinedMask = mix(borderMask, 1.0, maskBlend);

    vec2 center = vec2(0.5);
    float approach = smoothstep(0.0, 0.5, progress);
    float overshootWindow = smoothstep(0.35, 0.8, progress);
    float settle = smoothstep(0.78, 1.0, progress);
    float baseScale = mix(0.92, 1.0, approach);
    float elasticWave = sin((progress - 0.45) * 2.0 * PI);
    float scale = baseScale + 0.06 * overshootWindow * (1.0 - settle) * elasticWave;
    scale = clamp(scale, 0.85, 1.03);

    vec2 scaledUV = center + (vUv - center) * scale;

    float glitchPulse = exp(-pow((progress - 0.18) / 0.08, 2.0));
    float glitchBandCenter = 0.5 + 0.18 * sin(progress * 9.0);
    float glitchBand = exp(-pow((vUv.y - glitchBandCenter), 2.0) / 0.00045);
    float glitchMagnitude = glitchStrength * glitchPulse * glitchBand;
    vec2 glitchOffset = vec2(glitchMagnitude * 0.05, 0.0);

    vec2 glitchedUV = scaledUV + glitchOffset;

    float chroma = chromaAmount * (1.0 - progress);
    vec2 chromaVec = vec2(chroma, 0.0);

    vec3 baseColor;
    baseColor.r = texture2D(tDiffuse, handleUVBounds(glitchedUV + chromaVec)).r;
    baseColor.g = texture2D(tDiffuse, handleUVBounds(glitchedUV)).g;
    baseColor.b = texture2D(tDiffuse, handleUVBounds(glitchedUV - chromaVec)).b;

    float separation = ghostOffset * (1.0 - smoothstep(0.2, 0.55, progress));
    vec2 ghostShift = vec2(separation, 0.0);
    vec3 ghostLeft = texture2D(tDiffuse, handleUVBounds(glitchedUV - ghostShift)).rgb;
    vec3 ghostRight = texture2D(tDiffuse, handleUVBounds(glitchedUV + ghostShift)).rgb;
    vec3 ghostColor = ghostLeft * vec3(0.35, 0.55, 1.05) + ghostRight * vec3(1.05, 0.45, 0.35);

    float ghostIntro = smoothstep(0.02, 0.18, progress);
    float ghostOutro = 1.0 - smoothstep(0.35, 0.7, progress);
    float ghostOpacity = mix(0.12, 1.0, ghostIntro) * ghostOutro;

    vec3 combined = mix(ghostColor * ghostOpacity * 0.45, baseColor, smoothstep(0.18, 0.45, progress));
    combined = mix(combined, baseColor, smoothstep(0.75, 1.0, progress));

    vec3 finalColor = mix(combined, texel.rgb, smoothstep(0.85, 1.0, progress));
    finalColor *= combinedMask;

    float finalAlpha = mix(texel.a * combinedMask, texel.a, smoothstep(0.88, 1.0, progress));

    return vec4(finalColor, finalAlpha);
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