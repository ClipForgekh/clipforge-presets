exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float glowWidth; // = 0.02 [0.001, 0.08] // 低强度发光边缘宽度
uniform float beamWidth; // = 0.10 [0.02, 0.30] // 亮束宽度
uniform float mediumBrightness; // = 0.65 [0.3, 0.9] // 中等亮度
uniform float borderSize; // = 0.03 [0.005, 0.08] // 全息激光边框宽度（约3%）

varying vec2 vUv;

float tween(float p) {
    p = clamp(p, 0.0, 1.0);
    return sqrt(1.0 - pow(1.0 - p, 2.0)); // TWEEN.Easing.Circular.Out
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 effect(vec4 texel, float p) {
    vec2 uv = handleUVBounds(vUv);
    vec4 src = texture2D(tDiffuse, uv);

    float t = clamp(p, 0.0, 1.0);
    float edgeSoft = max(glowWidth, 0.0005);

    // 时间分段（按2.2s映射）
    float pMid = 1.4 / 2.2; // 约0.636

    // 中心向两侧扩展的垂直光束揭示
    float revealHalf = mix(0.0, 0.75, t); // 后段会超出画面
    float dx = abs(uv.x - 0.5);
    float revealMask = 1.0 - smoothstep(revealHalf - edgeSoft, revealHalf + edgeSoft, dx);

    // 亮度：0 -> 中等（前段）-> 1.0（后段稳定）
    float brightness;
    if (t < pMid) {
        brightness = mix(0.0, mediumBrightness, t / max(pMid, 0.0001));
    } else {
        brightness = mix(mediumBrightness, 1.0, (t - pMid) / max(1.0 - pMid, 0.0001));
    }

    // traveling beam（中等光感）
    float scanPos = t; // 从左到右
    float travelingBeam = exp(-pow((uv.x - scanPos) / max(beamWidth, 0.0001), 2.0));
    travelingBeam *= revealMask;

    // 低强度发光边缘（LumiGlow low）
    float edgeGlow = exp(-pow((dx - revealHalf) / max(glowWidth * 1.4, 0.0001), 2.0));

    // 基础颜色（入场：progress=0最强遮蔽，progress=1恢复原图）
    vec3 color = src.rgb * brightness * revealMask;
    color += src.rgb * (0.22 * travelingBeam + 0.10 * edgeGlow);

    // 3% subtle holographic laser border（随入场强度轻微衰减）
    float shortScale = (ratio > 1.0) ? 1.0 : ratio;
    float bw = borderSize * shortScale;
    float dEdge = min(min(uv.x, 1.0 - uv.x), min(uv.y, 1.0 - uv.y));
    float borderMask = 1.0 - smoothstep(bw * 0.6, bw, dEdge);

    vec3 holoA = vec3(0.20, 0.90, 1.00);
    vec3 holoB = vec3(0.85, 0.30, 1.00);
    float holoPhase = 0.5 + 0.5 * sin((uv.y * 28.0 + uv.x * 8.0) * 3.14159265);
    vec3 holoColor = mix(holoA, holoB, holoPhase);

    float borderIntensity = 0.03 * (1.0 - smoothstep(0.85, 1.0, t));
    color = mix(color, color + holoColor, borderMask * borderIntensity);

    // 最后一帧严格恢复原图
    color = mix(color, texel.rgb, smoothstep(0.995, 1.0, t));

    float borderSafe = getHardBoundaryMask(vUv);
    return vec4(clamp(color, 0.0, 1.0), src.a * borderSafe);
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