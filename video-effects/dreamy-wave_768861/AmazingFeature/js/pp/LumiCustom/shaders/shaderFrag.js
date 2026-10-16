exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2] // 屏幕宽高比

uniform float blurMax; // = 9.0 [0.0, 20.0] // 最大模糊强度
uniform float displacementStrength; // = 0.025 [0.0, 0.08] // 水平位移强度
uniform float glowStrength; // = 0.35 [0.0, 1.0] // 极光发光强度
uniform float bandDensity; // = 2.8 [1.0, 6.0] // 极光条带密度
uniform float bandSpeed; // = 2.2 [0.5, 5.0] // 极光流动速度

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec2 getAspectCorrectUV(vec2 uv) {
    vec2 aspectUV = uv;
    if (ratio > 1.0) {
        aspectUV.y /= ratio;
        aspectUV.y += (1.0 - 1.0 / ratio) * 0.5;
    } else {
        aspectUV.x *= ratio;
        aspectUV.x += (1.0 - ratio) * 0.5;
    }
    return aspectUV;
}

vec4 gaussianBlur9(sampler2D tex, vec2 uv, float amount) {
    vec2 stepSize = vec2(0.0016 * amount, 0.0016 * amount / max(ratio, 0.0001));
    vec4 c = vec4(0.0);

    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0, -1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0, -1.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0, -1.0))) * 0.075;

    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  0.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  0.0))) * 0.200;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  0.0))) * 0.125;

    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2(-1.0,  1.0))) * 0.075;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 0.0,  1.0))) * 0.125;
    c += texture2D(tex, handleUVBounds(uv + stepSize * vec2( 1.0,  1.0))) * 0.075;

    return c;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;

    vec2 auv = getAspectCorrectUV(vUv);
    vec2 diagDir = normalize(vec2(1.0, 0.6));
    float flow = dot(auv - 0.5, diagDir) * bandDensity * 10.0 - p * bandSpeed * 6.2831853;

    float b1 = 0.5 + 0.5 * sin(flow + 0.0);
    float b2 = 0.5 + 0.5 * sin(flow * 1.15 + 1.3);
    float b3 = 0.5 + 0.5 * sin(flow * 0.92 + 2.4);
    float b4 = 0.5 + 0.5 * sin(flow * 1.32 + 3.2);

    b1 = pow(b1, 2.0);
    b2 = pow(b2, 2.0);
    b3 = pow(b3, 2.0);
    b4 = pow(b4, 2.0);

    vec3 colorPink   = vec3(1.00, 0.78, 0.90);
    vec3 colorViolet = vec3(0.82, 0.72, 1.00);
    vec3 colorMint   = vec3(0.74, 1.00, 0.90);
    vec3 colorBlue   = vec3(0.72, 0.86, 1.00);

    vec3 auroraColor = (
        colorPink * b1 +
        colorViolet * b2 +
        colorMint * b3 +
        colorBlue * b4
    ) / (b1 + b2 + b3 + b4 + 0.0001);

    float auroraMask = (b1 + b2 + b3 + b4) * 0.25;
    auroraMask = smoothstep(0.15, 0.9, auroraMask) * strength;

    float dispWave = (b1 - b3) * 0.7 + (b2 - b4) * 0.3;
    float xDisp = dispWave * displacementStrength * strength;

    vec2 uv = vUv + vec2(xDisp, 0.0);
    uv = handleUVBounds(uv);

    vec4 sharpTexel = texture2D(tDiffuse, uv);
    vec4 blurTexel = gaussianBlur9(tDiffuse, uv, blurMax * strength);
    vec4 baseTexel = mix(sharpTexel, blurTexel, strength);

    vec3 glow = auroraColor * auroraMask * glowStrength * (0.6 + 0.4 * strength);
    vec3 bandTint = auroraColor * auroraMask * 0.22 * strength;

    vec3 finalRgb = clamp(baseTexel.rgb + glow + bandTint, 0.0, 1.0);
    float finalAlpha = texel.a * p;

    return vec4(finalRgb, finalAlpha);
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