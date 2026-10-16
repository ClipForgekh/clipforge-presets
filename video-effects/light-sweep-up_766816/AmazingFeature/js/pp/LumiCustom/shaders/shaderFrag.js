exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float maxBlur; // = 0.035 [0.0, 0.12]
uniform float glowStrength; // = 3.0 [0.0, 5.0]
uniform vec3 glowColor; // = vec3(0.35, 0.75, 1.0)

varying vec2 vUv;

float tween(float p) {
    return smoothstep(0.0, 1.0, p);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlurSample(vec2 uv, float blurAmount) {
    vec2 o = vec2(0.0, blurAmount);

    vec4 c = vec4(0.0);
    c += texture2D(tDiffuse, handleUVBounds(uv - 4.0 * o)) * 0.05;
    c += texture2D(tDiffuse, handleUVBounds(uv - 3.0 * o)) * 0.09;
    c += texture2D(tDiffuse, handleUVBounds(uv - 2.0 * o)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv - 1.0 * o)) * 0.15;
    c += texture2D(tDiffuse, handleUVBounds(uv)) * 0.18;
    c += texture2D(tDiffuse, handleUVBounds(uv + 1.0 * o)) * 0.15;
    c += texture2D(tDiffuse, handleUVBounds(uv + 2.0 * o)) * 0.12;
    c += texture2D(tDiffuse, handleUVBounds(uv + 3.0 * o)) * 0.09;
    c += texture2D(tDiffuse, handleUVBounds(uv + 4.0 * o)) * 0.05;

    return c;
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - smoothstep(0.3, 1.0, p);
    float blurAmount = maxBlur * strength;

    float stretch = 0.12 * strength;
    vec2 uv = vUv;
    uv.y = 0.5 + (vUv.y - 0.5) * (1.0 + stretch);
    uv = handleUVBounds(uv);

    vec4 blurred = verticalBlurSample(uv, blurAmount);

    float reveal = smoothstep(0.0, 0.35, p);
    vec3 baseColor = blurred.rgb * reveal;

    float scanY = mix(-0.25, 1.25, p);
    float rise = smoothstep(0.0, 0.3, p);
    float fall = 1.0 - smoothstep(0.3, 1.0, p);
    float pulse = rise * fall;

    float bandWidth = mix(0.04, 0.35, rise) * max(0.05, fall);
    float d = (vUv.y - scanY) / max(bandWidth, 0.0001);
    float band = exp(-d * d);

    float glow = band * glowStrength * pulse;
    vec3 color = baseColor + glowColor * glow;

    return vec4(clamp(color, 0.0, 1.0), texel.a);
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