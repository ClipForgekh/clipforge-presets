exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float twirlStrength; // = 8.0 [0.0, 20.0] // 旋涡强度
uniform float liquidStrength; // = 1.0 [0.0, 2.0] // 液态金属形变强度
uniform float blurStrength; // = 1.2 [0.0, 3.0] // 径向旋转模糊强度
uniform vec3 metalColor; // = vec3(0.82, 0.86, 0.92) // 金属高光色

varying vec2 vUv;

float tween(float p) {
    return p;
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float easeCubicInOut(float x) {
    return x < 0.5 ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) * 0.5;
}

float easeExpoIn(float x) {
    return (x <= 0.0) ? 0.0 : pow(2.0, 10.0 * (x - 1.0));
}

vec2 rotate2D(vec2 p, float a) {
    float s = sin(a);
    float c = cos(a);
    return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

vec4 radialRotateBlur(vec2 uv, float amount, float inward) {
    vec2 center = vec2(0.5);
    vec4 acc = vec4(0.0);
    const int SAMPLES = 9;
    for (int i = 0; i < SAMPLES; i++) {
        float t = float(i) / float(SAMPLES - 1);
        float k = t - 0.5;
        float ang = k * amount;
        float scale = 1.0 - abs(k) * inward;
        vec2 p = uv - center;
        p.x *= ratio;
        p = rotate2D(p * scale, ang);
        p.x /= ratio;
        vec2 suv = handleUVBounds(center + p);
        acc += texture2D(tDiffuse, suv);
    }
    return acc / float(SAMPLES);
}

vec4 effect(vec4 texel, float p) {
    if (p <= 0.15) return texel;
    if (p >= 0.85) return vec4(0.0);

    float sTwirl = smoothstep(0.15, 0.35, p);
    float sFlow = smoothstep(0.35, 0.525, p);
    float sBlur = smoothstep(0.525, 0.65, p);
    float sCompress = smoothstep(0.65, 0.775, p);

    float vortexPhase = clamp((p - 0.15) / 0.625, 0.0, 1.0);
    float vortexEase = easeCubicInOut(vortexPhase);

    float collapsePhase = clamp((p - 0.775) / 0.075, 0.0, 1.0);
    float collapseEase = easeExpoIn(collapsePhase);

    vec2 center = vec2(0.5);
    vec2 q = vUv - center;
    q.x *= ratio;

    float r = length(q) + 1e-6;
    float a = atan(q.y, q.x);

    float liquid = 0.5 * sin(18.0 * a + 30.0 * r - p * 22.0) + 0.5 * sin(27.0 * a - 24.0 * r + p * 17.0);
    float liquidAmp = liquidStrength * 0.02 * sTwirl * (0.4 + 0.6 * vortexEase);

    float tw = twirlStrength * (0.8 * sTwirl + 1.6 * sFlow + 2.1 * sBlur) * (1.0 - clamp(r, 0.0, 1.0));
    a += tw * (0.55 + 0.45 * vortexEase);

    r = mix(r, r * (1.0 - 0.55 * sFlow - 0.2 * sBlur), clamp(sFlow + sBlur, 0.0, 1.0));
    r += liquid * liquidAmp;

    float compress = (1.0 - 0.9 * sCompress) * (1.0 - 0.98 * collapseEase);
    r *= max(compress, 0.001);

    vec2 n = vec2(cos(a), sin(a)) * r;
    n.x /= ratio;
    vec2 uv = handleUVBounds(center + n);

    vec4 col = texture2D(tDiffuse, uv);

    float blurMix = max(sBlur, sCompress);
    float blurAmount = blurStrength * (0.4 + 2.8 * blurMix) * (0.5 + 0.5 * vortexEase);
    vec4 rb = radialRotateBlur(uv, blurAmount, 0.45 + 0.35 * blurMix);
    col = mix(col, rb, blurMix);

    float luma = dot(col.rgb, vec3(0.299, 0.587, 0.114));
    float metalMix = clamp(0.35 * sTwirl + 0.45 * sFlow + 0.65 * sBlur + 0.85 * sCompress, 0.0, 1.0);
    vec3 metalBase = mix(col.rgb, vec3(luma), metalMix);
    float sheen = pow(clamp(luma, 0.0, 1.0), 2.0) * clamp(0.2 * sFlow + 0.7 * sBlur + 1.0 * sCompress, 0.0, 1.0);
    vec3 rgb = clamp(metalBase + metalColor * sheen * 0.45, 0.0, 1.0);

    float visR = mix(1.6, 0.10, sCompress);
    visR = mix(visR, 0.0, collapseEase);
    float mask = 1.0 - smoothstep(visR, visR + 0.02, length((vUv - center) * vec2(ratio, 1.0)));
    float alpha = (1.0 - collapseEase) * mask;

    return vec4(rgb * alpha, alpha);
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