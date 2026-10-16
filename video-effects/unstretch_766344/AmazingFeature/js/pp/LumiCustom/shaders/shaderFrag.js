exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float stretchStrength; // = 1.6 [0.0, 3.0] // 垂直拉伸强度
uniform float blurStrength; // = 18.0 [0.0, 40.0] // 垂直方向模糊强度
uniform float glowStrength; // = 1.2 [0.0, 3.0] // 发光强度
uniform float exposureStrength; // = 0.9 [0.0, 2.0] // 曝光增强强度
uniform float scaleOffset; // = 0.08 [0.0, 0.3] // 初始缩小量
uniform float liftAmount; // = 0.1 [0.0, 0.3] // 从下往上位移量
uniform vec3 glowColor; // = vec3(0.72, 0.88, 1.0) // 蓝白发光颜色（每维范围[0.0,1.0]）

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec4 directionalVerticalBlur(vec2 uv, float stepY) {
    vec2 o1 = vec2(0.0, stepY);
    vec2 o2 = vec2(0.0, stepY * 2.0);
    vec2 o3 = vec2(0.0, stepY * 3.0);

    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.28;
    c += texture2D(tDiffuse, handleUVBounds(uv + o1)) * 0.20;
    c += texture2D(tDiffuse, handleUVBounds(uv - o1)) * 0.20;
    c += texture2D(tDiffuse, handleUVBounds(uv + o2)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - o2)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv + o3)) * 0.04;
    c += texture2D(tDiffuse, handleUVBounds(uv - o3)) * 0.04;
    return c;
}

vec4 effect(vec4 texel, float progress) {
    float strength = 1.0 - progress;

    float scale = max(1.0 - scaleOffset * strength, 0.001);
    float stretch = 1.0 + stretchStrength * strength;

    vec2 uvRaw = 0.5 + (vUv - 0.5) / scale;
    uvRaw.y = 0.5 + (uvRaw.y - 0.5) / stretch;
    uvRaw.y += liftAmount * strength;

    float borderMask = getHardBoundaryMask(uvRaw);
    vec2 uv = handleUVBounds(uvRaw);

    float stepY = blurStrength * strength * 0.0012;
    vec4 blurredTexel = directionalVerticalBlur(uv, stepY);

    float glowBase = max(max(blurredTexel.r, blurredTexel.g), blurredTexel.b);
    float glow = pow(glowBase, 1.6) * glowStrength * strength;

    vec3 color = blurredTexel.rgb;
    color *= 1.0 + exposureStrength * 0.5 * strength;
    color += glowColor * glow;
    color = clamp(color, 0.0, 1.0);

    float fadeIn = smoothstep(0.0, 0.16, progress);
    float outAlpha = texel.a * borderMask * fadeIn;

    return vec4(color, outAlpha);
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