exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float maxZoom; // = 1.5 [1.0, 2.0] // 起始缩放倍率（1.5=150%）
uniform float echoSpread; // = 0.09 [0.0, 0.25] // 回声副本最大扩散距离
uniform float echoOpacity; // = 0.5 [0.0, 1.0] // 回声副本透明度
uniform float endProgress; // = 0.973 [0.5, 1.0] // 动画在总progress中的结束点（1.8/1.85≈0.973）

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float localP = clamp(p / max(endProgress, 0.0001), 0.0, 1.0);
    float strength = 1.0 - localP;

    float zoom = mix(maxZoom, 1.0, localP);
    vec2 centered = vUv - 0.5;
    vec2 baseUV = 0.5 + centered / max(zoom, 0.0001);
    baseUV = handleUVBounds(baseUV);
    vec4 baseCol = texture2D(tDiffuse, baseUV);

    vec2 spread = vec2(echoSpread, echoSpread / max(ratio, 0.0001)) * strength;

    vec2 uvR = handleUVBounds(baseUV + vec2(-spread.x, 0.0));
    vec2 uvG = handleUVBounds(baseUV + vec2(0.5 * spread.x, 0.8660254 * spread.y));
    vec2 uvB = handleUVBounds(baseUV + vec2(0.5 * spread.x, -0.8660254 * spread.y));

    vec3 rCol = texture2D(tDiffuse, uvR).rgb * vec3(1.0, 0.0, 0.0);
    vec3 gCol = texture2D(tDiffuse, uvG).rgb * vec3(0.0, 1.0, 0.0);
    vec3 bCol = texture2D(tDiffuse, uvB).rgb * vec3(0.0, 0.0, 1.0);

    float echoMix = echoOpacity * strength;
    vec3 color = clamp(baseCol.rgb + echoMix * (rCol + gCol + bCol), 0.0, 1.0);

    return vec4(color, texel.a);
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