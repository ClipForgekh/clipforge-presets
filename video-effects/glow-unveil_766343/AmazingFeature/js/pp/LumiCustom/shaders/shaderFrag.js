exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse; // 源纹理
uniform float progress; // = 0.0 [0.0, 1.0] // 动画进度
uniform float ratio; // = 1.0 [0.1, 2.0] // 屏幕宽高比

uniform float glowStrength; // = 1.2 [0.0, 3.0]
uniform float trailWidth; // = 1.0 [0.5, 2.0]
uniform float sparkDensity; // = 1.0 [0.2, 2.0]
uniform vec3 glowColor; // = vec3(1.0, 0.82, 0.35)

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 345.45));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

vec2 getSDFCoordinate(vec2 uv, vec2 center) {
    vec2 p = uv - center;
    if (ratio > 1.0) p.y /= ratio;
    else p.x *= ratio;
    return p;
}

vec4 effect(vec4 texel, float p) {
    if (p >= 0.9999) return texel;

    float strength = 1.0 - p;
    vec2 uv = vUv;
    vec2 ap = getSDFCoordinate(uv, vec2(0.5)) + vec2(0.5);

    float x = ap.x;
    float curve1 = 0.16 + 0.62 * x + 0.10 * sin(8.0 * x - 1.1);
    float curve2 = 0.06 + 0.70 * x + 0.07 * sin(11.0 * x + 0.6);

    float front = -0.28 + p * 1.78;

    float widthFactor = 220.0 / (trailWidth * trailWidth);
    float d1 = abs(ap.y - curve1);
    float d2 = abs(ap.y - curve2);
    float trail1 = exp(-d1 * d1 * widthFactor);
    float trail2 = exp(-d2 * d2 * (widthFactor * 1.1));

    float head = exp(-pow((ap.x - front) * 10.0, 2.0));
    float tail = clamp((front - ap.x + 0.03) / 0.55, 0.0, 1.0);
    float trailMask = head * 0.9 + tail * 0.7;

    vec2 sparkCell = floor(ap * vec2(260.0, 160.0) + p * 140.0);
    float sparkRnd = hash21(sparkCell);
    float sparkCut = 1.0 - 0.08 * sparkDensity;
    float spark = step(sparkCut, sparkRnd) * (trail1 + trail2) * head * 2.5;

    float reveal1 = smoothstep(front - 0.22, front + 0.10, ap.x + (ap.y - curve1) * 0.35);
    float reveal2 = smoothstep(front - 0.16, front + 0.14, ap.x + (ap.y - curve2) * 0.25);
    float reveal = clamp(max(reveal1, reveal2), 0.0, 1.0);

    vec3 baseImage = texel.rgb * reveal;
    float glowShape = (trail1 * 0.9 + trail2 * 0.75) * trailMask;
    vec3 glow = glowColor * glowShape * glowStrength * strength;
    vec3 sparkGlow = glowColor * spark * glowStrength * strength;
    vec3 color = baseImage + glow + sparkGlow;

    float alphaImage = texel.a * reveal;
    float alphaGlow = clamp((glowShape + spark) * 0.5 * strength, 0.0, 1.0);
    float outAlpha = max(alphaImage, alphaGlow);

    return vec4(clamp(color, 0.0, 1.0), outAlpha);
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