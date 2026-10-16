exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float diveStrength; // = 1.0 [0.0, 2.0] // 环井穿航强度
uniform float spinTurns; // = 2.0 [0.0, 4.0] // 旋转圈数
uniform float edgeBlur; // = 0.75 [0.0, 1.5] // 外圈模糊强度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 aspectCentered(vec2 uv) {
    vec2 p = uv - 0.5;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec2 inverseAspect(vec2 p) {
    vec2 q = p;
    if (ratio > 1.0) q.y *= ratio;
    else q.x /= ratio;
    return q;
}

vec4 effect(vec4 texel, float pIn) {
    float p = tween(pIn);
    float strength = (1.0 - p) * diveStrength;

    vec2 pc = aspectCentered(vUv);
    float r = length(pc);
    float a = atan(pc.y, pc.x);

    float spin = strength * spinTurns * 6.2831853 * (1.0 - smoothstep(0.0, 0.9, r));
    float funnel = 1.0 - 0.38 * strength * (1.0 - smoothstep(0.0, 1.2, r));
    float ripple = 0.03 * strength * sin(18.0 * r - 4.0 * p);

    float na = a + spin;
    float nr = max(0.0, r * funnel + ripple);

    vec2 warped = vec2(cos(na), sin(na)) * nr;
    vec2 uv = inverseAspect(warped) + 0.5;

    vec2 radialDir = normalize(pc + vec2(1e-5));
    vec2 tangentDir = vec2(-radialDir.y, radialDir.x);

    float outer = smoothstep(0.35, 1.05, r);
    float blurAmt = edgeBlur * strength * outer * 0.012;

    vec2 uv0 = handleUVBounds(uv);
    vec2 uv1 = handleUVBounds(uv + inverseAspect(tangentDir * blurAmt));
    vec2 uv2 = handleUVBounds(uv - inverseAspect(tangentDir * blurAmt));
    vec2 uv3 = handleUVBounds(uv + inverseAspect(radialDir * blurAmt * 0.8));
    vec2 uv4 = handleUVBounds(uv - inverseAspect(radialDir * blurAmt * 0.8));

    vec4 c0 = texture2D(tDiffuse, uv0);
    vec4 c1 = texture2D(tDiffuse, uv1);
    vec4 c2 = texture2D(tDiffuse, uv2);
    vec4 c3 = texture2D(tDiffuse, uv3);
    vec4 c4 = texture2D(tDiffuse, uv4);

    vec4 warpedColor = c0 * 0.40 + (c1 + c2) * 0.22 + (c3 + c4) * 0.08;

    float vignette = 1.0 - 0.28 * strength * smoothstep(0.25, 1.1, r);
    warpedColor.rgb *= vignette;

    float borderMask = getHardBoundaryMask(uv);
    vec4 outColor = vec4(warpedColor.rgb, warpedColor.a * borderMask);

    return mix(outColor, texel, p);
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