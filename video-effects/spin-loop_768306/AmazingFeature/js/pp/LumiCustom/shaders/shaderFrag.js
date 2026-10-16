exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float hullPulseAmount; // = 0.66 [0.0, 1.2] // 肋舷法线脉冲幅度
uniform float swayAmount; // = 0.28 [0.0, 0.8] // 左右肋舷反向摆动幅度
uniform float keelBreath; // = 0.07 [0.0, 0.2] // 脊板呼吸幅度
uniform float edgeBoost; // = 0.12 [0.0, 0.3] // 肋舷轮廓增强
uniform float gradientAmount; // = 0.10 [0.0, 0.4] // 暖色四分色渐变强度

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

mat2 rot2(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

vec3 warmGradient(vec2 uv) {
    vec3 c1 = vec3(0.96, 0.55, 0.30);
    vec3 c2 = vec3(0.98, 0.74, 0.36);
    vec3 c3 = vec3(0.85, 0.33, 0.24);
    vec3 c4 = vec3(0.99, 0.86, 0.62);
    float gx = smoothstep(0.0, 1.0, uv.x);
    float gy = smoothstep(0.0, 1.0, uv.y);
    vec3 top = mix(c1, c2, gx);
    vec3 bottom = mix(c3, c4, gx);
    return mix(bottom, top, gy);
}

vec4 effect(vec4 texel, float p) {
    const float PI = 3.14159265;
    const float TAU = 6.28318530;

    float phase = p * TAU;
    float loopWave = 0.5 * (1.0 - cos(phase));         // 0->1->0
    float swingWave = sin(phase);                      // -1->1->-1

    vec2 center = vec2(0.5);
    vec2 base = vUv - center;
    if (ratio > 1.0) base.y /= ratio;
    else base.x *= ratio;

    vec2 uv = (rot2(phase) * base);
    if (ratio > 1.0) uv.y *= ratio;
    else uv.x /= ratio;
    uv += center;

    float leftMask = smoothstep(-0.48, -0.08, vUv.x) * (1.0 - smoothstep(-0.08, 0.02, vUv.x));
    float rightMask = smoothstep(0.08, 0.48, vUv.x) * (1.0 - smoothstep(0.02, 0.08, vUv.x));
    leftMask = smoothstep(0.0, 1.0, leftMask * 2.2);
    rightMask = smoothstep(0.0, 1.0, rightMask * 2.2);
    float sideMask = clamp(leftMask + rightMask, 0.0, 1.0);

    float yBandA = exp(-pow((vUv.y - 0.70) * 7.0, 2.0));
    float yBandB = exp(-pow((vUv.y - 0.50) * 7.0, 2.0));
    float yBandC = exp(-pow((vUv.y - 0.30) * 7.0, 2.0));
    float ribBands = clamp(yBandA + yBandB + yBandC, 0.0, 1.0);
    float ribMask = sideMask * ribBands;

    float sideSign = rightMask - leftMask;
    uv.x += sideSign * (0.06 * hullPulseAmount * loopWave) * ribMask;
    uv.y += sideSign * (0.04 * swayAmount * swingWave) * ribMask;

    float keelMask = exp(-pow((vUv.x - 0.5) * 10.0, 2.0)) * exp(-pow((vUv.y - 0.5) * 1.8, 2.0));
    float keelScale = 1.0 - keelBreath * loopWave * keelMask;
    uv = center + (uv - center) * keelScale;

    float finTop = exp(-pow((vUv.y - 0.82) * 10.0, 2.0)) * exp(-pow((vUv.x - 0.5) * 6.0, 2.0));
    float finMid = exp(-pow((vUv.y - 0.50) * 12.0, 2.0)) * exp(-pow((vUv.x - 0.5) * 7.0, 2.0));
    float finBot = exp(-pow((vUv.y - 0.18) * 10.0, 2.0)) * exp(-pow((vUv.x - 0.5) * 6.0, 2.0));

    float staccato = 0.5 * (1.0 - cos(phase * 2.0));
    float finTB = (1.0 - loopWave);
    uv.y += (finTop - finBot) * 0.035 * finTB;
    uv.x += finMid * 0.05 * staccato * sign(vUv.x - 0.5);

    float boundMask = getHardBoundaryMask(uv);
    uv = handleUVBounds(uv);
    vec4 col = texture2D(tDiffuse, uv);
    col.a *= boundMask;

    float keelBright = 1.0 + 0.06 * loopWave * keelMask;
    col.rgb *= keelBright;

    vec2 px = vec2(1.0 / 1024.0, 1.0 / 1024.0);
    vec3 cL = texture2D(tDiffuse, handleUVBounds(uv - vec2(px.x, 0.0))).rgb;
    vec3 cR = texture2D(tDiffuse, handleUVBounds(uv + vec2(px.x, 0.0))).rgb;
    vec3 cU = texture2D(tDiffuse, handleUVBounds(uv + vec2(0.0, px.y))).rgb;
    vec3 cD = texture2D(tDiffuse, handleUVBounds(uv - vec2(0.0, px.y))).rgb;
    float lumL = dot(cL, vec3(0.299, 0.587, 0.114));
    float lumR = dot(cR, vec3(0.299, 0.587, 0.114));
    float lumU = dot(cU, vec3(0.299, 0.587, 0.114));
    float lumD = dot(cD, vec3(0.299, 0.587, 0.114));
    float edge = clamp(abs(lumR - lumL) + abs(lumU - lumD), 0.0, 1.0);

    float edgeIntensity = mix(0.06, edgeBoost, loopWave);
    col.rgb += edge * edgeIntensity * ribMask;

    vec3 grad = warmGradient(vUv);
    col.rgb = mix(col.rgb, col.rgb * 0.85 + grad * 0.35, gradientAmount);

    col.rgb = clamp(col.rgb, 0.0, 1.0);
    return col;
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