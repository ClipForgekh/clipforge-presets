exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float uBrightness; // = 1.0 [0.0, 2.0] // 画面亮度
uniform float u_chromatic; // = 0.05 [0.0, 0.2] // 色差畸变强度

varying vec2 vUv;

float tween(float progress) {
    // 循环专用正弦曲线，0和1状态完全一致
    return 0.5 * (1.0 - cos(progress * 2.0 * 3.14159265));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float progress) {
    float cycle = progress * 2.0 * 3.14159265;
    float dynamicFactor = tween(progress);
    
    // 动态UV流动效果，模拟双带穿插流动感
    vec2 flowOffset = vec2(
        sin(cycle + vUv.y * 8.0) * 0.008,
        cos(cycle + vUv.x * 8.0) * 0.008
    ) * dynamicFactor;
    vec2 uv = handleUVBounds(vUv + flowOffset);
    
    // 色差畸变效果，RGB通道分离偏移
    float chromaOffset = u_chromatic * dynamicFactor;
    float r = texture2D(tDiffuse, handleUVBounds(uv + vec2(chromaOffset, 0.0))).r;
    float g = texture2D(tDiffuse, uv).g;
    float b = texture2D(tDiffuse, handleUVBounds(uv - vec2(chromaOffset, 0.0))).b;
    
    // 亮度调整，保持alpha不变（禁用透明度渐变）
    vec3 finalColor = vec3(r, g, b) * uBrightness;
    finalColor = clamp(finalColor, 0.0, 1.0);
    
    return vec4(finalColor, texel.a);
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