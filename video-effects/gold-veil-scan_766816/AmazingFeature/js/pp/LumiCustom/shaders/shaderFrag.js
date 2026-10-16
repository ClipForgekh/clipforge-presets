exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比
uniform float blurMax; // = 0.02 [0.0, 0.08] // 最大模糊半径（UV空间）
uniform float particleStrength; // = 1.0 [0.0, 2.0] // 粒子与发光强度
uniform float sweepWidth; // = 0.35 [0.1, 0.8] // 粒子横向扩散宽度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash11(float n) {
    return fract(sin(n * 127.1) * 43758.5453123);
}

float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

vec4 blur9(sampler2D tex, vec2 uv, float radius) {
    if (radius <= 0.00001) return texture2D(tex, uv);

    vec2 stepUV = vec2(radius, radius / max(ratio, 0.0001));

    vec4 c = vec4(0.0);
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2(-1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 0.0, -1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 1.0, -1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2(-1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 0.0,  0.0))) * 4.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 1.0,  0.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2(-1.0,  1.0))) * 1.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 0.0,  1.0))) * 2.0;
    c += texture2D(tex, handleUVBounds(uv + stepUV * vec2( 1.0,  1.0))) * 1.0;

    return c / 16.0;
}

vec4 effect(vec4 texel, float p) {
    float eased = clamp(p, 0.0, 1.0);
    float strength = 1.0 - eased;

    float reveal = eased;
    float blurAmount = blurMax * strength;
    vec4 base = blur9(tDiffuse, vUv, blurAmount) * reveal;

    float head = -0.20 + 1.40 * eased;
    float spread = sweepWidth * (0.65 + 0.35 * (1.0 - abs(eased - 0.35) / 0.35));
    float envelope = pow(strength, 1.15) * particleStrength;

    vec3 gold = vec3(1.00, 0.78, 0.35);
    vec3 warm = vec3(1.00, 0.92, 0.70);

    float particles = 0.0;
    const int COUNT = 24;
    for (int i = 0; i < COUNT; i++) {
        float fi = float(i);
        float r1 = hash11(fi + 1.23);
        float r2 = hash11(fi * 2.71 + 4.56);
        float r3 = hash11(fi * 5.13 + 7.89);
        float r4 = hash11(fi * 9.17 + 2.34);

        float x = head + (r1 - 0.5) * spread + (1.0 - eased) * (0.12 + 0.12 * r2);
        float y = r2;
        y += (r3 - 0.5) * 0.18 * (1.0 - eased);
        y += (1.0 - eased) * 0.08 * (0.5 + r4);

        vec2 pos = vec2(x, y);

        vec2 d = vUv - pos;
        if (ratio > 1.0) d.y /= ratio;
        else d.x *= ratio;

        float rad = mix(0.003, 0.018, r3) * (0.75 + 0.25 * strength);
        float g = exp(-dot(d, d) / max(rad * rad, 1e-6));

        float sparkle = 0.6 + 0.4 * hash21(vec2(fi, floor(eased * 10.0)));
        particles += g * sparkle;
    }

    particles *= envelope / float(COUNT) * 7.5;

    float streak = smoothstep(0.0, 1.0, 1.0 - abs(vUv.x - head) / max(spread, 0.001));
    streak *= 0.35 * envelope;

    vec3 glow = gold * particles * 1.5 + warm * (particles * particles) * 0.6 + gold * streak;

    vec3 outColor = base.rgb + glow;
    outColor = clamp(outColor, 0.0, 1.0);

    return vec4(outColor, 1.0);
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