exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float waveStrength; // = 0.035 [0.0, 0.12] // LumiWaveWarp强度
uniform float waveFrequency; // = 18.0 [4.0, 40.0] // 波纹频率

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 5.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 effect(vec4 texel, float pEased) {
    float p = 1.0 - pow(1.0 - clamp(pEased, 0.0, 1.0), 0.2);

    float t0 = 0.05;
    float t1 = 0.60;
    float t2 = 0.75;

    float expandT = smoothstep(t0, t1, p);
    float scaleY = mix(0.15, 1.0, expandT);

    vec2 uv = vUv;
    uv.y = 0.5 + (uv.y - 0.5) * scaleY;

    float distortFade = 1.0 - smoothstep(t1, t2, p);

    float front = clamp(expandT, 0.0, 1.0);
    float d = abs(vUv.y - 0.5) * 2.0;
    float spreadMask = 1.0 - smoothstep(front + 0.02, front + 0.20, d);

    float centerBoost = 1.0 - smoothstep(0.0, 0.9, d);
    float mask = max(spreadMask, centerBoost * (1.0 - expandT));

    float phase = (vUv.y - 0.5) * waveFrequency + p * 8.0;
    float amp = waveStrength * distortFade * mask;
    uv.x += sin(phase) * amp;
    uv.y += cos(phase * 0.7) * amp * 0.25 / max(ratio, 0.0001);

    uv = handleUVBounds(uv);
    return texture2D(tDiffuse, uv);
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