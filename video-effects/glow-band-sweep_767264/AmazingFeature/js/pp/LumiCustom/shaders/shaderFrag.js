exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurStrength; // = 0.03 [0.0, 0.08] // 初始斜向模糊强度
uniform float bandWidth; // = 0.035 [0.01, 0.12] // 霓虹光带核心宽度
uniform float glowWidth; // = 0.12 [0.03, 0.3] // 霓虹辉光扩散宽度
uniform float neonIntensity; // = 1.2 [0.0, 3.0] // 霓虹亮度强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 directionalBlur45(vec2 uv, float amount) {
    vec2 dir = normalize(vec2(1.0, 1.0 / max(ratio, 0.0001)));
    vec4 sum = vec4(0.0);
    float wsum = 0.0;

    float w0 = 0.18;
    float w1 = 0.15;
    float w2 = 0.12;
    float w3 = 0.10;
    float w4 = 0.08;

    for (int i = -4; i <= 4; i++) {
        float fi = float(i);
        float w = (abs(fi) < 0.5) ? w0 :
                  (abs(fi) < 1.5) ? w1 :
                  (abs(fi) < 2.5) ? w2 :
                  (abs(fi) < 3.5) ? w3 : w4;
        vec2 suv = handleUVBounds(uv + dir * fi * amount);
        sum += texture2D(tDiffuse, suv) * w;
        wsum += w;
    }

    return sum / max(wsum, 0.0001);
}

float revealByLine(vec2 uv, float xPos, float b, float softness) {
    float lineX = uv.y + xPos - b;
    return smoothstep(-softness, softness, lineX - uv.x);
}

float lineDistance(vec2 uv, float xPos, float b) {
    float f = uv.y - (uv.x - xPos + b);
    return abs(f) * 0.70710678;
}

vec4 effect(vec4 texel, float p) {
    float x1 = -1.2 + 3.1 * pow(p, 0.90);
    float x2 = -1.2 + 3.1 * pow(p, 0.72);
    float x3 = -1.2 + 3.1 * pow(p, 0.88);

    float b1 = 0.18;
    float b2 = 0.50;
    float b3 = 0.82;

    float r1 = revealByLine(vUv, x1, b1, 0.03);
    float r2 = revealByLine(vUv, x2, b2, 0.03);
    float r3 = revealByLine(vUv, x3, b3, 0.03);
    float reveal = clamp(max(r1, max(r2, r3)), 0.0, 1.0);

    float localBlur = blurStrength * pow(1.0 - reveal, 2.6);
    vec4 blurred = directionalBlur45(vUv, localBlur);
    vec4 base = mix(vec4(0.0, 0.0, 0.0, 1.0), blurred, reveal);

    float d1 = lineDistance(vUv, x1, b1);
    float d2 = lineDistance(vUv, x2, b2);
    float d3 = lineDistance(vUv, x3, b3);

    float core1 = exp(-d1 / max(bandWidth, 0.0001));
    float core2 = exp(-d2 / max(bandWidth, 0.0001));
    float core3 = exp(-d3 / max(bandWidth, 0.0001));

    float glow1 = exp(-d1 / max(glowWidth, 0.0001));
    float glow2 = exp(-d2 / max(glowWidth, 0.0001));
    float glow3 = exp(-d3 / max(glowWidth, 0.0001));

    vec3 c1 = vec3(1.0, 0.12, 0.72);
    vec3 c2 = vec3(0.10, 0.92, 1.0);
    vec3 c3 = vec3(1.0, 0.92, 0.20);

    float neonFade = pow(1.0 - p, 1.15);
    vec3 neon =
        c1 * (core1 * 0.95 + glow1 * 0.45) +
        c2 * (core2 * 1.00 + glow2 * 0.45) +
        c3 * (core3 * 0.95 + glow3 * 0.45);

    vec3 color = base.rgb + neon * neonIntensity * neonFade;
    color = clamp(color, 0.0, 1.0);

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