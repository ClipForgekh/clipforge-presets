exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float lumiThreshold; // = 0.72 [0.3, 0.95] // 高阈值亮度揭示
uniform float shakeStrength; // = 0.012 [0.0, 0.05] // 水平抖动强度
uniform float chromaAmount; // = 0.006 [0.0, 0.03] // 色差强度（中）
uniform float zoomStrength; // = 0.06 [0.0, 0.2] // 轻微前推缩放
uniform float thresholdSoftness; // = 0.08 [0.01, 0.3] // 阈值过渡柔和度

varying vec2 vUv;

float tween(float p) {
    return p;
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
    p = clamp(p, 0.0, 1.0);

    float t1 = clamp(p / 0.35, 0.0, 1.0);
    float revealEaseIn = t1 * t1;                             // Quadratic.In
    float reveal = mix(revealEaseIn, 1.0, step(0.35, p));

    float t2 = clamp((p - 0.35) / 0.35, 0.0, 1.0);           // 0.35~0.70 build-up

    float t3 = clamp((p - 0.70) / 0.30, 0.0, 1.0);           // 0.70~1.00 settle
    float reduceEaseOut = 1.0 - (1.0 - t3) * (1.0 - t3);     // Quadratic.Out
    float distortionDamp = 1.0 - reduceEaseOut;              // 1 -> 0

    float preSettle = 1.0 - smoothstep(0.70, 0.72, p);
    float shakeEnv = revealEaseIn * preSettle;

    float chromaBuild = smoothstep(0.35, 0.70, p);
    float chromaEnv = chromaBuild * mix(1.0, distortionDamp, smoothstep(0.70, 0.72, p));

    float zoomBuild = smoothstep(0.35, 0.70, p);
    float zoomEnv = zoomBuild * mix(1.0, distortionDamp, smoothstep(0.70, 0.72, p));

    float zoom = 1.0 + zoomStrength * zoomEnv;

    vec2 uv = 0.5 + (vUv - 0.5) / zoom;
    float shakeWave = sin(p * 120.0) * sin(p * 37.0);
    uv.x += shakeStrength * shakeEnv * shakeWave;
    uv = handleUVBounds(uv);

    vec4 base = texture2D(tDiffuse, uv);

    vec2 epx = vec2(0.0015, 0.0);
    vec2 epy = vec2(0.0, 0.0015 / max(ratio, 0.0001));
    vec3 c0 = base.rgb;
    vec3 cx1 = texture2D(tDiffuse, handleUVBounds(uv + epx)).rgb;
    vec3 cx2 = texture2D(tDiffuse, handleUVBounds(uv - epx)).rgb;
    vec3 cy1 = texture2D(tDiffuse, handleUVBounds(uv + epy)).rgb;
    vec3 cy2 = texture2D(tDiffuse, handleUVBounds(uv - epy)).rgb;
    float edge = length((cx1 + cx2 + cy1 + cy2) * 0.25 - c0);

    vec2 dir = getSDFCoordinate(uv, vec2(0.5));
    float dlen = max(length(dir), 0.0001);
    dir /= dlen;

    float ca = chromaAmount * chromaEnv * (0.4 + edge * 3.0);
    vec2 caOffset = vec2(dir.x, dir.y / max(ratio, 0.0001)) * ca;

    float r = texture2D(tDiffuse, handleUVBounds(uv + caOffset)).r;
    float g = base.g;
    float b = texture2D(tDiffuse, handleUVBounds(uv - caOffset)).b;
    vec3 chromaColor = vec3(r, g, b);

    float luma = dot(base.rgb, vec3(0.299, 0.587, 0.114));
    float centerFactor = max(0.0, 1.0 - dlen * 1.9);
    float revealSignal = luma + centerFactor * reveal;

    float vis = smoothstep(lumiThreshold - thresholdSoftness, lumiThreshold + thresholdSoftness, revealSignal);

    float silhouetteBlend = 1.0 - smoothstep(0.28, 0.45, p);
    vec3 silhouette = vec3(smoothstep(lumiThreshold, lumiThreshold + 0.02, revealSignal));
    vec3 stageColor = mix(chromaColor, silhouette, 0.75 * silhouetteBlend);

    float visToFull = smoothstep(0.45, 0.65, p);
    vec3 finalRgb = mix(stageColor * vis, chromaColor, visToFull);
    float finalAlpha = texel.a * mix(vis, 1.0, visToFull);

    if (p >= 0.9999) return texel;
    return vec4(finalRgb, finalAlpha);
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