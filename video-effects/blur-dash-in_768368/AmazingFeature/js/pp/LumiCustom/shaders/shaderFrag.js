exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float startScale; // = 0.06 [0.01, 0.3] // 初始中心碎片尺寸
uniform float distortionStrength; // = 0.08 [0.0, 0.3] // 初始扭曲强度
uniform float trailStrength; // = 0.9 [0.0, 1.5] // 多帧融合强度
uniform float radialBlurStrength; // = 0.85 [0.0, 2.0] // 径向模糊强度
uniform float glowStrength; // = 0.35 [0.0, 1.0] // 高亮发光强度

varying vec2 vUv;

float tween(float p) {
    if (p >= 1.0) return 1.0;
    return 1.0 - pow(2.0, -10.0 * p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float luma(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

float invExpOut(float x) {
    if (x <= 0.0) return 0.0;
    if (x >= 1.0) return 1.0;
    return clamp(-log2(max(1e-5, 1.0 - x)) / 10.0, 0.0, 1.0);
}

vec4 radialZoomBlur(vec2 uv, float amt) {
    vec2 c = vec2(0.5);
    vec2 dir = uv - c;
    vec4 col = vec4(0.0);
    float wsum = 0.0;

    for (int i = 0; i < 8; i++) {
        float t = float(i) / 7.0;
        float w = 1.0 - t;
        vec2 suv = uv - dir * t * 0.18 * amt;
        suv = handleUVBounds(suv);
        col += texture2D(tDiffuse, suv) * w;
        wsum += w;
    }
    return col / max(wsum, 1e-5);
}

vec4 multiFrameEchoApprox(vec2 uv, float expandT, float echoT) {
    vec2 c = vec2(0.5);
    vec4 acc = vec4(0.0);
    float wsum = 0.0;

    for (int i = 0; i < 6; i++) {
        float k = float(i) / 5.0;
        float age = 1.0 - k;
        float s = mix(1.0 + 0.28 * echoT, 1.0, k);
        float rot = (age - 0.5) * 0.18 * echoT;
        float cs = cos(rot), sn = sin(rot);
        vec2 p = uv - c;
        vec2 pr = vec2(p.x * cs - p.y * sn, p.x * sn + p.y * cs);
        vec2 suv = c + pr * s;

        vec2 pull = (uv - c) * (0.03 * age * echoT);
        suv -= pull;
        suv = handleUVBounds(suv);

        float w = mix(0.08, 0.32, age) * (0.35 + 0.65 * echoT);
        acc += texture2D(tDiffuse, suv) * w;
        wsum += w;
    }

    vec4 cur = texture2D(tDiffuse, handleUVBounds(uv));
    vec4 fused = mix(cur, acc / max(wsum, 1e-5), echoT * trailStrength);
    return fused;
}

vec3 subtleGlow(vec2 uv, vec3 baseCol, float g) {
    vec2 px = vec2(0.002, 0.002 / max(ratio, 1e-5));
    vec3 s1 = texture2D(tDiffuse, handleUVBounds(uv + vec2(px.x, 0.0))).rgb;
    vec3 s2 = texture2D(tDiffuse, handleUVBounds(uv + vec2(-px.x, 0.0))).rgb;
    vec3 s3 = texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, px.y))).rgb;
    vec3 s4 = texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, -px.y))).rgb;
    vec3 blur = (s1 + s2 + s3 + s4) * 0.25;

    float hi = smoothstep(0.65, 1.0, luma(baseCol));
    return baseCol + blur * hi * g * glowStrength;
}

vec4 effect(vec4 texel, float pEased) {
    float t = invExpOut(pEased);

    float s0End = 0.175;
    float s1End = 0.45;
    float s2End = 0.575;

    float ph0 = clamp(t / s0End, 0.0, 1.0);
    float ph1 = clamp((t - s0End) / (s1End - s0End), 0.0, 1.0);
    float ph2 = clamp((t - s1End) / (s2End - s1End), 0.0, 1.0);
    float ph3 = clamp((t - s2End) / (1.0 - s2End), 0.0, 1.0);

    float expand = tween(clamp((t - 0.10) / 0.50, 0.0, 1.0));
    float scale = mix(startScale, 1.0, expand);

    vec2 c = vec2(0.5);
    vec2 p = vUv - c;
    float r = length(vec2(p.x, p.y * ratio));

    float revealRadius = mix(0.02, 1.4, expand);
    float revealMask = smoothstep(revealRadius + 0.08, revealRadius - 0.02, r);

    float twist = (1.0 - expand) * distortionStrength;
    float ang = atan(p.y, p.x) + sin(r * 36.0 - t * 40.0) * twist;
    float rad = length(p) * (1.0 + sin(ang * 6.0 + t * 24.0) * twist * 0.6);
    vec2 d = vec2(cos(ang), sin(ang)) * rad;

    vec2 uv = c + d * scale;
    uv = handleUVBounds(uv);

    vec4 base = texture2D(tDiffuse, uv);

    float earlyFrag = smoothstep(0.0, 0.25, ph0) * (1.0 - smoothstep(0.75, 1.0, ph0));
    float centerFragMask = smoothstep(0.14, 0.0, r) * (0.65 + 0.35 * earlyFrag);

    float echoRise = smoothstep(0.0, 1.0, ph1);
    float echoPeak = max(echoRise, ph2);
    float echoCollapse = 1.0 - smoothstep(0.0, 1.0, ph3);
    float echoAmt = echoPeak * echoCollapse;

    vec4 fused = multiFrameEchoApprox(uv, expand, echoAmt);

    float rbRise = smoothstep(0.0, 1.0, ph1);
    float rbFall = 1.0 - smoothstep(0.0, 1.0, ph3);
    float rbAmt = rbRise * rbFall * radialBlurStrength;
    vec4 rb = radialZoomBlur(uv, rbAmt);

    vec4 motionCol = mix(fused, rb, clamp(rbAmt * 0.7, 0.0, 1.0));

    float glowPulse = smoothstep(0.0, 1.0, ph2) * (1.0 - smoothstep(0.0, 1.0, ph3));
    vec3 withGlow = subtleGlow(uv, motionCol.rgb, glowPulse);

    vec4 revealed = vec4(withGlow, motionCol.a) * revealMask;

    vec4 black = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 stage0 = mix(black, revealed, smoothstep(0.0, 1.0, ph0) * centerFragMask);
    vec4 stageAll = mix(stage0, revealed, smoothstep(s0End, s0End + 0.03, t));

    vec4 stabilized = mix(stageAll, texel, smoothstep(0.0, 1.0, ph3));

    if (pEased >= 1.0) return texel;
    return stabilized;
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