precision highp float;
varying vec2 uv0;
uniform sampler2D inputImageTexture;
uniform sampler2D _MainTex0;
uniform sampler2D _MainTex1;
uniform int baseTexWidth;
uniform int baseTexHeight;
uniform float uniAlpha0;
uniform float uniAlpha1;
uniform float progress;

vec3 unpremultiply (vec3 color, float alpha) {
    return color / (alpha + 0.0001);
}

vec3 lut8x8 (sampler2D lut, vec3 src) {
    src *= 63.0;
    float b = src.b;

    vec2 i01 = vec2(floor(b), ceil(b));
    vec2 r01 = floor(i01 * 0.125);
    vec2 c01 = i01 - r01 * 8.0;

    vec4 uv0 = vec4(c01, r01).xzyw * 0.125;
    vec2 uv1 = (src.rg + 0.5) * 0.001953125;
    uv0 += vec4(uv1, uv1);

    vec3 c0 = texture2D(lut, uv0.xy).rgb;
    vec3 c1 = texture2D(lut, uv0.zw).rgb;
    return mix(c0, c1, b - i01.x);
}

vec4 mapping (vec4 color, sampler2D lut, float intensity) {
    vec3 dst = unpremultiply(color.rgb, color.a);
    vec3 src = lut8x8(lut, dst);
    dst = mix(dst, src, intensity);
    return vec4(dst, 1.0) * color.a;
}


void main(void)
{
    vec4 base = texture2D(inputImageTexture, uv0);
    vec4 col0 = mapping(base, _MainTex0, uniAlpha0);
    vec4 col1 = mapping(base, _MainTex1, uniAlpha1);
    base = mix(col0, col1, progress);

    gl_FragColor=base;
}