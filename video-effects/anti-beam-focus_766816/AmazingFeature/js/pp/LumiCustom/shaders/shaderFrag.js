exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float layerCount; // = 12.0 [4.0, 24.0] // 径向分层数量
uniform float blurStrength; // = 14.0 [0.0, 24.0] // 最大模糊强度
uniform float glowStrength; // = 1.4 [0.0, 3.0] // 霓虹发光强度
uniform float pulseSoftness; // = 0.22 [0.05, 0.6] // 每层脉冲过渡宽度
uniform float bounceStrength; // = 0.05 [0.0, 0.2] // 径向弹动强度
uniform float glitchStrength; // = 0.45 [0.0, 1.0] // 边缘故障线强度
uniform vec3 neonColorA; // = vec3(0.75, 0.15, 1.0) // 霓虹紫
uniform vec3 neonColorB; // = vec3(1.0, 0.45, 0.1) // 霓虹橙

varying vec2 vUv; // 纹理坐标

float tween(float progress) {
    return 1.0 - pow(1.0 - progress, 3.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float getHardBoundaryMask(vec2 uv) {
    return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 radialBlur9(vec2 uv, float amount) {
    if (amount <= 0.0001) return texture2D(tDiffuse, handleUVBounds(uv));

    vec4 col = vec4(0.0);
    float w = 0.0;
    vec2 stepBase = vec2(0.0012 * amount, 0.0012 * amount);
    if (ratio > 1.0) stepBase.y /= ratio;
    else stepBase.x *= ratio;

    vec2 o0 = vec2(0.0);
    vec2 o1 = stepBase;
    vec2 o2 = -stepBase;
    vec2 o3 = vec2(stepBase.x, -stepBase.y);
    vec2 o4 = vec2(-stepBase.x, stepBase.y);
    vec2 o5 = stepBase * 2.0;
    vec2 o6 = -stepBase * 2.0;
    vec2 o7 = vec2(stepBase.x * 2.0, -stepBase.y * 2.0);
    vec2 o8 = vec2(-stepBase.x * 2.0, stepBase.y * 2.0);

    float k0 = 0.20;
    float k1 = 0.14;
    float k2 = 0.14;
    float k3 = 0.12;
    float k4 = 0.12;
    float k5 = 0.09;
    float k6 = 0.09;
    float k7 = 0.05;
    float k8 = 0.05;

    col += texture2D(tDiffuse, handleUVBounds(uv + o0)) * k0; w += k0;
    col += texture2D(tDiffuse, handleUVBounds(uv + o1)) * k1; w += k1;
    col += texture2D(tDiffuse, handleUVBounds(uv + o2)) * k2; w += k2;
    col += texture2D(tDiffuse, handleUVBounds(uv + o3)) * k3; w += k3;
    col += texture2D(tDiffuse, handleUVBounds(uv + o4)) * k4; w += k4;
    col += texture2D(tDiffuse, handleUVBounds(uv + o5)) * k5; w += k5;
    col += texture2D(tDiffuse, handleUVBounds(uv + o6)) * k6; w += k6;
    col += texture2D(tDiffuse, handleUVBounds(uv + o7)) * k7; w += k7;
    col += texture2D(tDiffuse, handleUVBounds(uv + o8)) * k8; w += k8;

    return col / max(w, 0.0001);
}

vec4 effect(vec4 texel, float progress) {
    vec2 center = vec2(0.5, 0.5);
    vec2 p = getSDFCoordinate(vUv, center);
    float dist = length(p);
    float maxDist = 0.5 * sqrt(2.0);
    float nDist = clamp(dist / maxDist, 0.0, 1.0);

    float layers = max(layerCount, 1.0);
    float ringPos = nDist * layers;
    float ringId = floor(min(ringPos, layers - 0.0001));
    float ringFrac = fract(ringPos);

    float scanHead = progress * layers;
    float layerReveal = smoothstep(0.0, max(pulseSoftness, 0.0001), scanHead - ringId);
    layerReveal = clamp(layerReveal, 0.0, 1.0);

    float fx = 1.0 - layerReveal;

    vec2 dir = dist > 0.0001 ? p / dist : vec2(0.0, 0.0);
    if (ratio > 1.0) dir.y *= ratio; else dir.x /= max(ratio, 0.0001);
    dir = normalize(dir + 1e-6);

    float bounceWindow = (1.0 - layerReveal) * smoothstep(0.0, 0.15, layerReveal);
    vec2 animatedUV = vUv + dir * bounceStrength * bounceWindow;
    animatedUV = handleUVBounds(animatedUV);

    vec4 blurred = radialBlur9(animatedUV, blurStrength * fx);
    vec4 sharp = texture2D(tDiffuse, animatedUV);
    vec4 baseMix = mix(sharp, blurred, fx);

    float angle = atan(p.y, p.x);
    float a01 = angle / 6.2831853 + 0.5;
    vec3 neonGrad = mix(neonColorA, neonColorB, smoothstep(0.0, 1.0, a01 + nDist * 0.25));

    float overExpo = fx * fx;
    vec3 neonOverlay = neonGrad * (0.8 + glowStrength * 1.6) * overExpo;

    float edgeMask = 1.0 - smoothstep(0.40, 0.50, abs(ringFrac - 0.5) * 2.0);
    float flicker = step(0.65, sin((nDist * 170.0 + progress * 220.0) * 6.2831853) * 0.5 + 0.5);
    float glitchPulse = smoothstep(0.0, 0.12, layerReveal) * (1.0 - smoothstep(0.12, 0.45, layerReveal));
    float glitch = edgeMask * flicker * glitchPulse * glitchStrength;

    vec3 glitchColor = mix(neonColorB, neonColorA, ringFrac) * glitch * 1.8;

    vec3 color = baseMix.rgb + neonOverlay + glitchColor;
    color = mix(color, sharp.rgb, layerReveal * layerReveal);
    color = clamp(color, 0.0, 1.0);

    float borderMask = getHardBoundaryMask(vUv);
    return vec4(color, sharp.a * borderMask);
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