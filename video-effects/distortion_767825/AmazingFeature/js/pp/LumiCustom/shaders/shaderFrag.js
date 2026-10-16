exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比
uniform float foldFrequency; // = 18.0 [6.0, 36.0] // 褶皱频率
uniform float foldAmplitude; // = 0.08 [0.02, 0.2] // 最大褶皱幅度
uniform float shadingStrength; // = 0.6 [0.0, 1.0] // 褶皱阴影强度

varying vec2 vUv;

float tween(float p) {
    if (p < 0.5) {
        float x = 2.0 * p;
        return 0.5 * (1.0 - sqrt(1.0 - x * x));
    }
    float x = -2.0 * p + 2.0;
    return 0.5 * (sqrt(1.0 - x * x) + 1.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float foldHeight(vec2 uv, float frequency) {
    float h1 = sin((uv.x + uv.y) * frequency);
    float h2 = sin((uv.x - uv.y) * frequency * 0.7);
    float h3 = sin(uv.x * frequency * 0.43);
    float h4 = sin(uv.y * frequency * 0.51);
    float h5 = sin((uv.x * 1.3 + uv.y * 0.6) * frequency * 0.33);
    return (h1 + h2 + h3 + h4 + h5) / 5.0;
}

vec4 effect(vec4 texel, float effectProgress) {
    float rawProgress = clamp(progress, 0.0, 1.0);
    float appear = smoothstep(0.15, 0.18, rawProgress);
    float settle = smoothstep(0.90, 0.94, rawProgress);
    float effectStrength = 1.0 - effectProgress;

    float scale = mix(0.35, 1.0, effectProgress);
    vec2 centered = vUv - 0.5;
    vec2 baseUV = 0.5 + centered * scale;

    float mask = getHardBoundaryMask(baseUV);
    float presence = appear * mask;

    float frequency = foldFrequency;
    float amplitude = foldAmplitude * effectStrength;

    float h0 = foldHeight(baseUV, frequency);
    vec2 eps = vec2(0.002, 0.002 / max(ratio, 0.0001));
    float hx = foldHeight(baseUV + vec2(eps.x, 0.0), frequency);
    float hy = foldHeight(baseUV + vec2(0.0, eps.y), frequency);
    vec2 slope = vec2((hx - h0) / eps.x, (hy - h0) / eps.y);

    vec2 bendDir = vec2(-slope.y, slope.x);
    vec2 warp = (slope * 0.2 + bendDir * 0.8) * amplitude;

    vec2 sampleUV = handleUVBounds(baseUV + warp);
    vec4 crumpledTexel = texture2D(tDiffuse, sampleUV);

    vec3 normal = normalize(vec3(-slope.x * amplitude * 6.0, -slope.y * amplitude * 6.0, 1.0));
    vec3 lightDir = normalize(vec3(-0.3, 0.6, 0.8));
    float diffuse = clamp(dot(normal, lightDir), 0.0, 1.0);
    float facing = clamp(dot(normal, vec3(0.0, 0.0, 1.0)), 0.0, 1.0);
    float rim = pow(1.0 - facing, 2.5);

    float shadeMix = shadingStrength * effectStrength;
    float targetLighting = clamp(0.55 + diffuse * 0.6 + rim * 0.25, 0.0, 1.0);
    float lighting = mix(1.0, targetLighting, shadeMix);
    vec3 shadedColor = crumpledTexel.rgb * lighting;
    vec3 unfoldedColor = mix(crumpledTexel.rgb, shadedColor, shadeMix);

    vec3 stagedColor = mix(vec3(0.0), unfoldedColor, presence);
    float stagedAlpha = mix(0.0, crumpledTexel.a, presence);

    vec3 finalColor = mix(stagedColor, texel.rgb, settle);
    float finalAlpha = mix(stagedAlpha, texel.a, settle);

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