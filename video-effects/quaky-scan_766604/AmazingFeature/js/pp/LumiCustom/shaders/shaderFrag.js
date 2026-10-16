exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0, 1] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float blurMax; // = 0.03 [0.0, 0.08] // 初始垂直模糊强度
uniform float glowStrength; // = 1.2 [0.0, 3.0] // 暖金边缘发光强度
uniform float particleDensity; // = 0.45 [0.0, 1.0] // 粒子密度
uniform float floatAmount; // = 1.0 [0.0, 2.0] // 卷轴Z向浮动强度
uniform float sweepStrength; // = 1.0 [0.0, 2.0] // 中段流光强度
uniform vec3 goldColor; // = vec3(1.0, 0.82, 0.45) // 暖金色
uniform vec3 crystalColor; // = vec3(0.75, 0.9, 1.0) // 水晶冷色调

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec4 verticalBlurSample(vec2 uv, float amount) {
    vec2 stepY = vec2(0.0, amount);
    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv - stepY * 2.0)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - stepY)) * 0.22;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.32;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepY)) * 0.22;
    c += texture2D(tDiffuse, handleUVBounds(uv + stepY * 2.0)) * 0.12;
    return c;
}

vec4 effect(vec4 texel, float p) {
    float edgeY = p;
    float revealMask = step(vUv.y, edgeY);

    float wobble = sin(p * 10.0 * 3.14159265) * (1.0 - p) * floatAmount;
    float scale = 1.0 + wobble * 0.06;
    float ySkew = wobble * 0.05 * (1.0 - vUv.y);

    vec2 centered = vUv - 0.5;
    vec2 uv = 0.5 + vec2(centered.x / scale, (centered.y - ySkew) / scale);
    uv = handleUVBounds(uv);

    float edgeBand = smoothstep(0.035, 0.0, abs(vUv.y - edgeY));
    float blurNearEdge = smoothstep(0.22, 0.0, edgeY - vUv.y);
    float blurAmount = blurMax * (1.0 - p) * (0.35 + 0.65 * blurNearEdge);

    vec4 baseColor = verticalBlurSample(uv, blurAmount);

    float crystalRim = edgeBand * (1.0 - p);
    baseColor.rgb = mix(baseColor.rgb, baseColor.rgb * 0.88 + crystalColor * 0.12, crystalRim * 0.7);

    float glow = edgeBand * (1.0 - p) * glowStrength;

    float pulse = smoothstep(0.45, 0.5, p) * (1.0 - smoothstep(0.5, 0.56, p));
    float sweepFront = clamp((p - 0.45) / 0.11, 0.0, 1.0);
    float sweep = pulse * exp(-pow((vUv.x - sweepFront) * 18.0, 2.0)) * smoothstep(0.03, 0.0, abs(vUv.y - edgeY)) * sweepStrength;

    vec2 grid = floor(vec2(vUv.x * 140.0, vUv.y * 260.0));
    float rnd = hash21(grid + floor(vec2(p * 80.0, p * 53.0)));
    float emit = particleDensity * (1.0 - p);
    float spark = step(1.0 - emit, rnd) * edgeBand;
    float sparkle = spark * (0.5 + 0.5 * hash21(grid + 7.13));

    vec3 lightAdd = goldColor * (glow * 0.55 + sweep + sparkle * 0.9);

    vec3 rgb = baseColor.rgb * revealMask + lightAdd;
    float alpha = baseColor.a * revealMask + (glow * 0.18 + sweep * 0.25 + sparkle * 0.2);

    rgb = clamp(rgb, 0.0, 1.0);
    alpha = clamp(alpha, 0.0, 1.0);

    return vec4(rgb, alpha);
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