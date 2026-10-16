exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float helixStrength; // = 0.75 [0.0, 1.5] // 锥旋扭曲强度
uniform float spinTurns; // = 2.0 [0.0, 6.0] // 螺旋旋进圈数
uniform float tunnelFocus; // = 0.65 [0.1, 2.0] // 锥腔收束强度
uniform float shuttleAmount; // = 0.35 [0.0, 1.0] // 穿梭推进感
uniform float brightnessBoost; // = 0.12 [0.0, 0.5] // 中段亮度提升

varying vec2 vUv;

const float PI = 3.14159265;

float tween(float p) {
    return 0.5 * (1.0 - cos(p * 2.0 * PI));
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 rotate2D(vec2 p, float a) {
    float s = sin(a);
    float c = cos(a);
    return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

vec4 effect(vec4 texel, float p) {
    float amp = clamp(p, 0.0, 1.0);

    vec2 c = vec2(0.5, 0.5);
    vec2 q = vUv - c;
    if (ratio > 1.0) q.y /= ratio;
    else q.x *= ratio;

    float r = length(q) + 1e-6;
    float a = atan(q.y, q.x);

    float cone = (1.0 - smoothstep(0.0, 0.95, r));
    float swirl = amp * helixStrength * (0.35 + 0.65 * cone);
    float ang = swirl * (spinTurns * 2.0 * PI + (1.0 - r) * 8.0);

    vec2 qr = rotate2D(q, ang);

    float forward = amp * shuttleAmount * (0.25 + 0.75 * cone);
    float squeeze = 1.0 + amp * tunnelFocus * (1.0 - r);
    qr /= squeeze;
    qr += vec2(cos(a * 3.0), sin(a * 3.0)) * forward * 0.06 * cone;

    vec2 uv = qr;
    if (ratio > 1.0) uv.y *= ratio;
    else uv.x /= ratio;
    uv += c;
    uv = handleUVBounds(uv);

    vec4 warped = texture2D(tDiffuse, uv);

    float radialFade = smoothstep(1.2, 0.1, r);
    float glow = amp * brightnessBoost * radialFade;
    vec3 color = mix(texel.rgb, warped.rgb, amp);
    color *= (1.0 + glow);
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