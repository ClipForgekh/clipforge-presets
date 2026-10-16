exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float twistStrength; // = 1.25 [0.0, 3.0] // 漩阶扭转强度
uniform float zoomDepth; // = 0.22 [0.0, 0.6] // 螺井纵深感
uniform float motionBlurStrength; // = 0.24 [0.0, 0.5] // 旋动拖影强度
uniform float chromaAmount; // = 0.10 [0.0, 0.2] // 色差强度

varying vec2 vUv;

float tween(float p) {
    return smoothstep(0.0, 1.0, p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float windowPulse(float p, float inStart, float peak, float outEnd) {
    float up = smoothstep(inStart, peak, p);
    float down = 1.0 - smoothstep(peak, outEnd, p);
    return clamp(up * down * 4.0, 0.0, 1.0);
}

vec2 rotate2D(vec2 p, float a) {
    float s = sin(a);
    float c = cos(a);
    return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

vec4 sampleMotionBlur(vec2 uv, vec2 dir, float amount) {
    vec4 c0 = texture2D(tDiffuse, handleUVBounds(uv - dir * amount * 0.50));
    vec4 c1 = texture2D(tDiffuse, handleUVBounds(uv - dir * amount * 0.25));
    vec4 c2 = texture2D(tDiffuse, handleUVBounds(uv));
    vec4 c3 = texture2D(tDiffuse, handleUVBounds(uv + dir * amount * 0.25));
    vec4 c4 = texture2D(tDiffuse, handleUVBounds(uv + dir * amount * 0.50));
    return (c0 + c1 * 2.0 + c2 * 3.0 + c3 * 2.0 + c4) / 9.0;
}

vec4 effect(vec4 texel, float p) {
    const float t0 = 0.1333333;
    const float t1 = 0.4166667;
    const float t2 = 0.7000000;

    float envelope = 4.0 * p * (1.0 - p);

    float enter = smoothstep(t0, t1, p);
    float relay = smoothstep(t1, t2, p);
    float exitBack = smoothstep(t2, 1.0, p);

    float baseAngle = (-0.5585 * enter) + (3.7699 * relay) + (-3.2114 * exitBack);
    float overshoot = 0.22 * exp(-pow((p - t2) * 18.0, 2.0)) * sin((p - t1) * 28.0);
    float angle = baseAngle + overshoot * envelope;

    vec2 pc = vUv - 0.5;
    vec2 aspectP = pc;
    if (ratio > 1.0) aspectP.x *= ratio;
    else aspectP.y /= max(ratio, 0.0001);

    float r = length(aspectP);
    vec2 dir = r > 0.0001 ? normalize(aspectP) : vec2(1.0, 0.0);
    vec2 tangent = vec2(-dir.y, dir.x);

    float whirl = twistStrength * envelope * (1.0 - clamp(r, 0.0, 1.0));
    float localSpin = whirl * sin(11.0 * r - 7.0 * p);
    vec2 warped = rotate2D(aspectP, angle + localSpin);

    float scale = 1.0 - zoomDepth * envelope * (0.35 + 0.65 * relay);
    warped *= max(scale, 0.25);

    vec2 uv = warped;
    if (ratio > 1.0) uv.x /= ratio;
    else uv.y *= ratio;
    uv += 0.5;
    uv = handleUVBounds(uv);

    float caWin = windowPulse(p, 0.2333333, 0.5000000, 0.7666667);
    float ca = chromaAmount * caWin * envelope;
    vec2 caOffset = vec2(dir.x, dir.y);
    if (ratio > 1.0) caOffset.x /= ratio;
    else caOffset.y *= ratio;
    caOffset *= ca;

    vec4 cR = texture2D(tDiffuse, handleUVBounds(uv + caOffset));
    vec4 cG = texture2D(tDiffuse, uv);
    vec4 cB = texture2D(tDiffuse, handleUVBounds(uv - caOffset));
    vec4 caColor = vec4(cR.r, cG.g, cB.b, cG.a);

    float mbWin = windowPulse(p, 0.1500000, 0.4250000, 0.7000000);
    float blurAmt = motionBlurStrength * mbWin * (0.2 + 0.8 * abs(angle)) * envelope * 0.06;

    vec2 blurDir = tangent;
    if (ratio > 1.0) blurDir.x /= ratio;
    else blurDir.y *= ratio;

    vec4 blurColor = sampleMotionBlur(uv, normalize(blurDir + 1e-5), blurAmt);
    vec4 mixedColor = mix(caColor, blurColor, mbWin * 0.75);

    return mix(texel, mixedColor, envelope);
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