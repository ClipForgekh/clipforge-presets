exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float warpStrength; // = 1.0 [0.2, 2.0] // LumiWaveWarp强度（extreme）
uniform float waveFrequency; // = 18.0 [4.0, 40.0] // 波频率
uniform float edgeRoughness; // = 0.12 [0.0, 0.4] // LumiRoughEdge粗糙度（medium）
uniform float toneContrast; // = 1.35 [0.8, 2.0] // Lumitone强度（high）

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float noise2(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);

    float a = hash12(i);
    float b = hash12(i + vec2(1.0, 0.0));
    float c = hash12(i + vec2(0.0, 1.0));
    float d = hash12(i + vec2(1.0, 1.0));

    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

vec4 effect(vec4 texel, float p) {
    float p1 = clamp(p / 0.3, 0.0, 1.0);          // 0.0s - 0.6s
    float p2 = clamp((p - 0.3) / 0.35, 0.0, 1.0); // 0.6s - 1.3s
    float p3 = clamp((p - 0.65) / 0.35, 0.0, 1.0);// 1.3s - 2.0s

    float easeInQuad = p1 * p1;
    float easeOutQuad = 1.0 - (1.0 - p3) * (1.0 - p3);

    vec2 center = vec2(0.5);
    vec2 d = vUv - center;

    float recover = easeOutQuad;
    float activeWarp = (1.0 - recover) * warpStrength;

    float travel = p2 * 2.0;
    float waveA = sin((vUv.y / max(ratio, 0.0001)) * waveFrequency + travel * 6.2831853);
    float waveB = sin(vUv.x * (waveFrequency * 0.55) - travel * 4.0);
    float waveMix = 0.65 * waveA + 0.35 * waveB;

    float compressCore = (0.25 + 0.75 * easeInQuad) * activeWarp;
    vec2 compressOffset = vec2(-d.x * compressCore * (0.8 + 0.2 * waveA), d.y * 0.12 * compressCore * waveB);

    float horizontalTravelWarp = (0.15 + 0.85 * p2) * activeWarp;
    vec2 travelOffset = vec2(0.0, waveMix * 0.035 * horizontalTravelWarp);

    vec2 warpedUVRaw = vUv + compressOffset + travelOffset;
    vec2 warpedUV = handleUVBounds(warpedUVRaw);
    vec4 warpedTexel = texture2D(tDiffuse, warpedUV);

    float luma = dot(warpedTexel.rgb, vec3(0.299, 0.587, 0.114));
    luma = clamp((luma - 0.5) * toneContrast + 0.5, 0.0, 1.0);

    float roughFade = (1.0 - recover) * (1.0 - 0.25 * p2);
    float n = noise2(vUv * vec2(180.0, 120.0) + vec2(travel * 5.0, -travel * 3.0));
    float edgeNoise = (n - 0.5) * edgeRoughness * roughFade;

    float toneThreshold = 1.05 - 1.25 * p2;
    float edgeSoft = 0.06 + 0.02 * (1.0 - p2);
    float toneMask = smoothstep(toneThreshold + edgeNoise - edgeSoft, toneThreshold + edgeNoise + edgeSoft, luma);

    float reveal = mix(toneMask * (0.2 + 0.8 * p2), 1.0, recover);
    reveal = clamp(reveal, 0.0, 1.0);

    vec3 col = mix(vec3(0.0), warpedTexel.rgb, reveal);
    col = mix(col, texel.rgb, recover);

    return vec4(col, texel.a);
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