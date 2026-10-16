exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float startZoom; // = 1.5 [1.0, 2.0] // 起始缩放倍数
uniform float reliefStrength; // = 1.0 [0.0, 2.0] // 浮雕强度
uniform float edgeSharpness; // = 2.2 [0.5, 4.0] // 边缘光影强度
uniform float sampleStep; // = 0.0025 [0.0005, 0.01] // 浮雕采样步长

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float luminance(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

vec3 makeRelief(vec2 uv, vec3 baseColor) {
    vec2 stepUV = vec2(sampleStep, sampleStep / max(ratio, 0.0001));

    float l  = luminance(baseColor);
    float lL = luminance(texture2D(tDiffuse, handleUVBounds(uv - vec2(stepUV.x, 0.0))).rgb);
    float lR = luminance(texture2D(tDiffuse, handleUVBounds(uv + vec2(stepUV.x, 0.0))).rgb);
    float lD = luminance(texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, stepUV.y))).rgb);
    float lU = luminance(texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, stepUV.y))).rgb);

    float gx = (lR - lL) * reliefStrength;
    float gy = (lU - lD) * reliefStrength;

    vec3 n = normalize(vec3(gx, gy, 1.0));
    vec3 lightDir = normalize(vec3(-0.45, 0.65, 0.75));
    float diff = clamp(dot(n, lightDir) * 0.5 + 0.5, 0.0, 1.0);

    float edge = clamp(length(vec2(gx, gy)) * edgeSharpness, 0.0, 1.0);

    vec3 grayBase = vec3(l);
    vec3 relief = grayBase * (0.9 + 0.25 * diff);
    relief += vec3((diff - 0.5) * 0.35);
    relief += vec3(edge * 0.22);

    return clamp(relief, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float zoom = mix(startZoom, 1.0, p);
    vec2 uv = 0.5 + (vUv - 0.5) / zoom;
    uv = handleUVBounds(uv);

    vec4 zoomed = texture2D(tDiffuse, uv);

    float reliefAmount = 1.0 - p;
    vec3 reliefColor = makeRelief(uv, zoomed.rgb);
    vec3 finalRgb = mix(zoomed.rgb, reliefColor, reliefAmount);

    return vec4(finalRgb, zoomed.a);
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