precision mediump float;

varying vec4 v_color;
varying vec2 v_texCoord;
uniform sampler2D _tex;

vec4 BlendNormal(vec4 vert_color, vec4 tex_color)
{
    return vert_color * tex_color;
}
/*
 [BF_ONE, BF_ONE]
 */
vec4 BlendLinearLight(vec4 vert_color, vec4 tex_color)
{
    return vert_color * tex_color * vert_color.a * 2.0 - vec4(1.0, 1.0, 1.0, 0.0);
}
/*
 [BF_ZERO, BF_SRC_COLOR]
 */
vec4 BlendMultiply(vec4 vert_color, vec4 tex_color)
{
    vec4 prev = vert_color * tex_color;
    return mix(vec4(1.0, 1.0, 1.0, 1.0), prev, prev.a);
}
/*
 [BF_ONE, BF_ONE_MINUS_SRC_ALPHA]
 */
vec4 BlendAddMultiply(vec4 vert_color, vec4 tex_color)
{
    vec4 res;
    res.rgb =  tex_color.rgb * vert_color.rgb ;
    res.a   = (1.0 - tex_color.a) * vert_color.a;
    return res;
}
/*
 [BF_ONE, BF_ONE_MINUS_SRC_ALPHA]
 */
vec4 BlendPremultiply(vec4 vert_color, vec4 tex_color)
{
    vec4 res = vert_color * tex_color * vert_color.a;
    return vec4(res.rgb, 0.0);
}
/*
 [BF_ONE, BF_ONE_MINUS_SRC_COLOR]
 */
vec4 BlendSmooth(vec4 vert_color, vec4 tex_color)
{
    vec4 prev = vert_color * tex_color;
    prev.rgb *= prev.a;
    return prev;
}

void main()
{
    vec4 vert_color = v_color;
    vec2 uvFrac = fract(v_texCoord);
    vec4 tex_color  = texture2D(_tex, uvFrac);

    gl_FragColor = BlendNormal(vert_color, tex_color);
}
