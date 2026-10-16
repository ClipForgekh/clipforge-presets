exports.source=`
//===begin_frag_code===
precision highp float;

uniform sampler2D tDiffuse;
uniform float progress; // = 0.0 [0.0, 1.0]
uniform float ratio; // = 1.0 [0.1, 2.0]
uniform float maxBlurRadius; // = 20.0 [0.0, 40.0]
uniform float glowIntensity; // = 2.5 [0.0, 5.0]
uniform vec3 glowColor; // = vec3(0.35, 0.75, 1.0)
uniform float scanFeather; // = 0.03 [0.001, 0.2]
uniform float contrastMin; // = 0.6 [0.1, 1.0]
uniform float brightnessMin; // = 0.3 [0.0, 1.0]

varying vec2 vUv;

float tween(float p) {
    return 1.0 - pow(1.0 - p, 2.0);
}

vec2 handleUVBounds(vec2 uv) {
    return clamp(uv, 0.0, 1.0);
}

vec4 verticalBlur(sampler2D tex, vec2 uv, float radius) {
    if (radius <= 0.0001) return texture2D(tex, uv);
    vec2 stepUV = vec2(0.0, (radius / 1024.0) / max(ratio, 0.0001));
    vec4 col = vec4(0.0);
    col += texture2D(tex, handleUVBounds(uv + stepUV * -4.0)) * 0.05;
    col += texture2D(tex, handleUVBounds(uv + stepUV * -3.0)) * 0.09;
    col += texture2D(tex, handleUVBounds(uv + stepUV * -2.0)) * 0.12;
    col += texture2D(tex, handleUVBounds(uv + stepUV * -1.0)) * 0.15;
    col += texture2D(tex, handleUVBounds(uv)) * 0.18;
    col += texture2D(tex, handleUVBounds(uv + stepUV * 1.0)) * 0.15;
    col += texture2D(tex, handleUVBounds(uv + stepUV * 2.0)) * 0.12;
    col += texture2D(tex, handleUVBounds(uv + stepUV * 3.0)) * 0.09;
    col += texture2D(tex, handleUVBounds(uv + stepUV * 4.0)) * 0.05;
    return col;
}

vec3 applyContrastBrightness(vec3 color, float contrast, float brightness) {
    vec3 c = (color - 0.5) * contrast + 0.5;
    c *= brightness;
    return clamp(c, 0.0, 1.0);
}

vec4 effect(vec4 texel, float p) {
    float strength = 1.0 - p;
    float blurRadius = maxBlurRadius * strength;
    vec4 blurredTexel = verticalBlur(tDiffuse, vUv, blurRadius);

    float contrast = mix(contrastMin, 1.0, p);
    float brightness = mix(brightnessMin, 1.0, p);
    vec3 baseColor = applyContrastBrightness(blurredTexel.rgb, contrast, brightness);

    float scanY = mix(1.0, -0.2, p);
    float feather = max(scanFeather, 0.0001);
    float revealMask = smoothstep(scanY - feather, scanY + feather, vUv.y);

    float bandWidth = max(0.02, 0.25 * strength);
    float d = abs(vUv.y - scanY);
    float band = exp(-(d * d) / max(2.0 * bandWidth * bandWidth, 0.0001));
    float glow = glowIntensity * strength * band;

    vec3 rgb = baseColor * revealMask + glowColor * glow;
    rgb = clamp(rgb, 0.0, 1.0);

    float alpha = texel.a * revealMask * p;
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