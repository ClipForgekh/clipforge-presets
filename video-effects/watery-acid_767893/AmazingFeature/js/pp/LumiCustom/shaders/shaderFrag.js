exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float warpIntensity; // = 0.18 [0.0, 0.5] // UV扭曲强度
uniform float swirlTurns; // = 2.5 [0.0, 6.0] // 旋转圈数
uniform float desaturateAmount; // = 0.65 [0.0, 1.0] // 初始去饱和度

varying vec2 vUv;

float tween(float progress) {
    return 3.0 * progress * progress - 2.0 * progress * progress * progress;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

vec4 effect(vec4 texel, float progress) {
    float effectStrength = 1.0 - progress;

    vec2 centered = vUv - 0.5;
    float radius = length(centered);
    float swirlAngle = swirlTurns * effectStrength * exp(-radius * 2.8);
    float s = sin(swirlAngle);
    float c = cos(swirlAngle);
    vec2 rotated = vec2(
        centered.x * c - centered.y * s,
        centered.x * s + centered.y * c
    );

    float scale = 1.0 + effectStrength * 0.35;
    vec2 uv = rotated * scale + 0.5;

    vec2 noiseCoord = vec2(vUv.x, vUv.y * max(ratio, 0.0001)) * (4.0 + effectStrength * 12.0);
    float n1 = noise(noiseCoord);
    float n2 = noise(noiseCoord + vec2(13.1, 7.4));
    vec2 flow = (vec2(n1, n2) - 0.5) * warpIntensity * (1.0 + 3.0 * radius) * effectStrength;
    uv += flow;

    uv = handleUVBounds(uv);
    vec4 warpedTexel = texture2D(tDiffuse, uv);

    float gray = dot(warpedTexel.rgb, vec3(0.299, 0.587, 0.114));
    float desatFactor = clamp(1.0 - effectStrength * desaturateAmount, 0.0, 1.0);
    vec3 colorDesat = mix(vec3(gray), warpedTexel.rgb, desatFactor);

    float vignette = clamp(1.0 - effectStrength * 0.6 * pow(radius, 1.5), 0.0, 1.0);
    vec3 finalColor = colorDesat * vignette;

    float borderMask = getHardBoundaryMask(vUv);
    return vec4(finalColor, warpedTexel.a * borderMask);
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