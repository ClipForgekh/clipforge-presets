exports.source=`
varying vec2 v_uv;
uniform sampler2D u_inputImageTexture;
uniform sampler2D u_depthFilter;
uniform float u_intensity;
uniform float u_lutYFlip;

vec3 unpremul3(vec4 color)
{
    float alpha = max(color.a, 1e-6);
    return color.rgb / alpha;
}

vec3 lut8x8(sampler2D lut, vec3 src)
{
    src *= 63.0;
    float b = src.b;

    vec2 i01 = vec2(floor(b), ceil(b));
    vec2 r01 = floor(i01 * 0.125);
    vec2 c01 = i01 - r01 * 8.0;

    vec4 uv0 = vec4(c01, r01).xzyw * 0.125;
    vec2 uv1 = (src.rg + 0.5) * 0.001953125;
    uv0 += vec4(uv1, uv1);

    float y0 = mix(uv0.y, 1.0 - uv0.y, u_lutYFlip);
    float y1 = mix(uv0.w, 1.0 - uv0.w, u_lutYFlip);
    vec3 c0 = texture2D(lut, vec2(uv0.x, y0)).rgb;
    vec3 c1 = texture2D(lut, vec2(uv0.z, y1)).rgb;
    return mix(c0, c1, b - i01.x);
}

vec4 mappingLut(vec4 color, sampler2D lut, float intensity)
{
    vec3 dst = unpremul3(color);
    vec3 src = lut8x8(lut, dst);
    dst = mix(dst, src, intensity);
    return vec4(dst, 1.0) * color.a;
}

void main() {
    vec4 curColor = texture2D(u_inputImageTexture, v_uv);
    gl_FragColor = mappingLut(curColor, u_depthFilter, 2.0);
}
`;