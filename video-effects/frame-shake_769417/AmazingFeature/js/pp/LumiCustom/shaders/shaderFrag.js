exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float shakeAmount; // = 0.03 [0.0, 0.12] // 抖动幅度
uniform float flashIntensity; // = 0.8 [0.0, 1.5] // 冲击闪光强度
uniform float glowIntensity; // = 0.35 [0.0, 1.0] // 微弱辉光强度
uniform float rotateAmount; // = 0.06 [0.0, 0.2] // 微旋转强度(弧度)

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

float hash1(float n) {
    return fract(sin(n) * 43758.5453123);
}

vec4 effect(vec4 texel, float p) {
    vec2 center = vec2(0.5, 0.5);

    float fastEase = 1.0 - pow(1.0 - p, 3.0);

    float impactPulse = exp(-pow((p - 0.30) / 0.05, 2.0));
    float afterT = max(p - 0.30, 0.0);
    float afterShock = step(0.30, p) * exp(-afterT * 7.5);
    float settleFade = 1.0 - smoothstep(0.60, 1.0, p);

    float growth = 1.0 - exp(-p * 20.0);
    float overshoot = 0.15 * impactPulse;
    float springScale = 0.035 * sin(afterT * 70.0) * afterShock * settleFade;
    float scale = growth + overshoot + springScale;
    scale = mix(scale, 1.0, smoothstep(0.85, 1.0, p));
    scale = max(scale, 0.0005);

    float shakeAmp = shakeAmount * (1.8 * impactPulse + 0.9 * afterShock) * settleFade;
    vec2 shake = vec2(
        sin(p * 130.0 + 0.7) + 0.5 * sin(p * 210.0 + 1.3),
        cos(p * 118.0 + 0.2) + 0.5 * cos(p * 176.0 + 2.1)
    ) * shakeAmp * 0.5;

    float microRot = rotateAmount * (impactPulse + 0.7 * afterShock) * settleFade * sin(p * 95.0 + 0.8);
    float s = sin(microRot);
    float c = cos(microRot);

    vec2 local = vUv - center - shake;
    vec2 rotLocal = vec2(
        c * local.x - s * local.y,
        s * local.x + c * local.y
    );

    vec2 uv = center + rotLocal / scale;
    uv = handleUVBounds(uv);

    vec4 col = texture2D(tDiffuse, uv);

    float flash = flashIntensity * 0.45 * impactPulse;
    float radial = exp(-length(vUv - center) * 9.0);
    float glow = glowIntensity * radial * (0.7 * impactPulse + 0.35 * afterShock) * settleFade;

    float particles = 0.0;
    for (int i = 0; i < 8; i++) {
        float fi = float(i);
        float a = hash1(fi + 2.3) * 6.2831853;
        float spd = 0.08 + 0.10 * hash1(fi + 9.1);
        float life = exp(-afterT * (10.0 + 8.0 * hash1(fi + 3.7))) * step(0.30, p);
        vec2 dir = vec2(cos(a), sin(a));
        vec2 pp = center + dir * (0.015 + spd * afterT);
        float d = length(vUv - pp);
        float sz = 0.006 + 0.004 * hash1(fi + 5.5);
        particles += smoothstep(sz, 0.0, d) * life;
    }

    vec3 particleColor = vec3(1.0, 0.92, 0.75) * particles * 0.25;
    col.rgb = col.rgb * (1.0 + flash) + vec3(glow) + particleColor;
    col.rgb = clamp(col.rgb, 0.0, 1.0);

    float visibility = smoothstep(0.0, 0.08, p);
    float alpha = col.a * visibility * getHardBoundaryMask(vUv);
    vec4 outCol = vec4(col.rgb, alpha);

    return mix(outCol, texel, smoothstep(0.985, 1.0, p));
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