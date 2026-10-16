exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float gridSize; // = 50.0 [10.0, 120.0] // 技术网格密度
uniform float gridOpacity; // = 1.0 [0.0, 1.0] // 网格总体强度
uniform float roughenStrength; // = 0.85 [0.0, 1.5] // 线稿粗糙石墨质感
uniform float edgeWidth; // = 0.0012 [0.0003, 0.0050] // 边缘检测采样步长

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float cubicInOut(float x) {
    x = clamp(x, 0.0, 1.0);
    return (x < 0.5) ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) * 0.5;
}

float remap01(float t, float a, float b) {
    return clamp((t - a) / max(b - a, 1e-5), 0.0, 1.0);
}

float luma(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

float edgeSobel(vec2 uv) {
    vec2 stepUV = vec2(edgeWidth, edgeWidth / max(ratio, 0.0001));

    float tl = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2(-stepUV.x,  stepUV.y))).rgb);
    float tc = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2( 0.0,       stepUV.y))).rgb);
    float tr = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2( stepUV.x,  stepUV.y))).rgb);

    float ml = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2(-stepUV.x,  0.0))).rgb);
    float mr = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2( stepUV.x,  0.0))).rgb);

    float bl = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2(-stepUV.x, -stepUV.y))).rgb);
    float bc = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2( 0.0,      -stepUV.y))).rgb);
    float br = luma(texture2D(tDiffuse, handleUVBounds(uv + vec2( stepUV.x, -stepUV.y))).rgb);

    float gx = -tl - 2.0 * ml - bl + tr + 2.0 * mr + br;
    float gy =  tl + 2.0 * tc + tr - bl - 2.0 * bc - br;

    return clamp(length(vec2(gx, gy)), 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

float technicalGrid(vec2 uv, float size, float thickness) {
    vec2 p = uv - 0.5;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    p += 0.5;

    vec2 g = p * size;
    vec2 f = abs(fract(g) - 0.5);
    float d = min(f.x, f.y);
    return 1.0 - smoothstep(0.0, thickness, d);
}

vec4 effect(vec4 texel, float p) {
    const float tBlackEnd = 0.2 / 3.0;
    const float tSketchBuildEnd = 1.3 / 3.0;
    const float tRoughEnd = 1.4 / 3.0;
    const float tEdgeEnd = 1.5 / 3.0;
    const float tGridEnd = 1.8 / 3.0;
    const float tColorStart = 1.4 / 3.0;
    const float tColorEnd = 2.3 / 3.0;

    if (p <= tBlackEnd) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }
    if (p >= 1.0) {
        return texel;
    }

    float build = remap01(p, tBlackEnd, tSketchBuildEnd);
    float colorPhase = remap01(p, tColorStart, tColorEnd);
    float colorMix = cubicInOut(colorPhase);

    float gridFade = 1.0 - remap01(p, tBlackEnd, tGridEnd);
    float roughFade = 1.0 - remap01(p, tBlackEnd, tRoughEnd);
    float edgeFade = 1.0 - remap01(p, tBlackEnd, tEdgeEnd);

    float e = edgeSobel(vUv);
    float revealThreshold = mix(0.90, 0.18, build);
    float fineSketch = smoothstep(revealThreshold - 0.035, revealThreshold + 0.035, e);

    float n = hash21(vUv * 900.0);
    float graphite = mix(1.0, 0.70 + 0.30 * n, clamp(roughFade * roughenStrength, 0.0, 1.0));
    float sketchLines = fineSketch * graphite;

    float sketchBlend = edgeFade * (1.0 - colorMix);
    vec3 sketchColor = vec3(sketchLines * sketchBlend);

    float g = technicalGrid(vUv, gridSize, 0.018);
    float gridA = g * gridOpacity * gridFade * (1.0 - colorMix * 0.85);
    vec3 gridColor = vec3(gridA);

    vec3 photo = texel.rgb;
    vec3 filledColor = photo * colorMix;

    vec3 rgb = filledColor + sketchColor + gridColor;
    rgb = clamp(rgb, 0.0, 1.0);

    return vec4(rgb, texel.a);
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