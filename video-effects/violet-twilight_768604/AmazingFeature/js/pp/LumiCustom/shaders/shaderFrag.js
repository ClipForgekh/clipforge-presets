exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float ghostThickness; // = 0.22 [0.05, 0.4] // VHS幕帘厚度
uniform float rgbSplit; // = 0.012 [0.0, 0.05] // RGB分离强度
uniform float wobbleStrength; // = 0.006 [0.0, 0.02] // 末段模拟晃动强度

varying vec2 vUv;

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

// 边界处理函数：处理UV坐标边界，避免边缘突变拉丝效果
vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

// 边界裁切函数：使用step函数实现硬边界裁切，避免缩小时的边缘拉丝效果
float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;

    float halfGap = progress * 0.5;
    float curtainFeather = 0.04;
    float topEdge = 0.5 - halfGap;
    float bottomEdge = 0.5 + halfGap;
    float upperMask = smoothstep(topEdge - curtainFeather, topEdge + curtainFeather, vUv.y);
    float lowerMask = 1.0 - smoothstep(bottomEdge - curtainFeather, bottomEdge + curtainFeather, vUv.y);
    float revealEnvelope = smoothstep(0.02, 0.35, halfGap);
    float revealMask = clamp(upperMask * lowerMask, 0.0, 1.0) * revealEnvelope;

    float wobbleWindow = smoothstep(0.78, 0.95, progress) * (1.0 - progress);
    vec2 wobbleUV = vUv;
    float wobblePhase = sin(progress * 22.0);
    wobbleUV.x += (sin(vUv.y * 110.0 + wobblePhase) + 0.5 * sin(vUv.y * 40.0 - wobblePhase)) * wobbleStrength * wobbleWindow;
    wobbleUV.y += cos(vUv.y * 60.0 + wobblePhase) * wobbleStrength * 0.4 * wobbleWindow;
    wobbleUV = handleUVBounds(wobbleUV);
    vec4 baseSample = texture2D(tDiffuse, wobbleUV);
    vec3 baseColor = baseSample.rgb * revealMask;
    float baseAlpha = baseSample.a * revealMask;

    float approach = smoothstep(0.0, 0.75, progress);
    float overlapPull = smoothstep(0.55, 0.85, progress);
    float topStart = 0.2;
    float bottomStart = 0.8;
    float centerOffset = 0.22 * (1.0 - overlapPull);
    float topCenter = mix(topStart, 0.5 - centerOffset, approach);
    float bottomCenter = mix(bottomStart, 0.5 + centerOffset, approach);

    float ghostDissolve = smoothstep(0.55, 0.95, progress);
    float ghostPresence = 1.0 - ghostDissolve;

    float normThickness = max(ghostThickness, 0.0001);
    float topBand = exp(-pow((vUv.y - topCenter) / normThickness, 2.0));
    float bottomBand = exp(-pow((vUv.y - bottomCenter) / normThickness, 2.0));
    float ghostBandMix = min(topBand + bottomBand, 1.0);
    float ghostEnvelope = ghostPresence * ghostBandMix;

    vec2 ghostUV = vUv;
    float highWave = sin((vUv.y + progress * 0.35) * 160.0);
    float lowWave = sin(vUv.y * 20.0 - progress * 6.2831853);
    ghostUV.x += (highWave * 0.0025 + lowWave * 0.0015) * (0.6 + 0.4 * effectStrength);
    ghostUV.y += cos(vUv.y * 90.0 + progress * 8.0) * 0.0012 * (0.6 + 0.4 * effectStrength);
    ghostUV = handleUVBounds(ghostUV);

    float separationPulse = smoothstep(0.4, 0.65, progress) * (1.0 - smoothstep(0.7, 0.95, progress));
    vec2 split = vec2(rgbSplit * separationPulse, 0.0);
    vec3 ghostSample = vec3(
        texture2D(tDiffuse, handleUVBounds(ghostUV - split)).r,
        texture2D(tDiffuse, ghostUV).g,
        texture2D(tDiffuse, handleUVBounds(ghostUV + split)).b
    );

    float shimmer = 0.5 + 0.5 * sin((vUv.y - progress) * 50.0);
    vec3 tintA = vec3(0.9, 0.92, 1.05);
    vec3 tintB = vec3(1.1, 0.95, 1.0);
    vec3 tint = mix(tintA, tintB, shimmer);
    vec3 ghostColor = ghostSample * tint;

    float highlight = smoothstep(0.5, 0.72, progress) * (1.0 - smoothstep(0.72, 0.95, progress));
    ghostColor *= vec3(1.0 + 0.6 * highlight, 1.0, 1.0 + 0.4 * highlight);

    ghostColor *= ghostEnvelope * (0.5 + 0.5 * effectStrength);

    vec3 finalColor = baseColor + ghostColor;
    float finalAlpha = clamp(baseAlpha + ghostEnvelope * 0.45, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(vUv);
    finalColor = clamp(finalColor, 0.0, 1.0) * borderMask;
    finalAlpha *= borderMask;

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