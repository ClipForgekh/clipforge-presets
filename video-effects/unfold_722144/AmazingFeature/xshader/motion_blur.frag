precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_Albedo;
uniform sampler2D _MainTex;
uniform vec4 u_ScreenParams;
uniform float u_NextScale;
uniform float u_Scale;
uniform float u_Alpha;
vec2 flip_uv(vec2 uv)
{
    vec2 z = abs(mod(uv + 1., 2.) - 1.0);
    return mod(z, 1.0);
}

vec2 scale_uv(vec2 uv, float scale)
{
    uv -= .5;
    uv *= 1.0 / scale;
    uv += .5;
    return uv;
}
void main()
{
    float d_scale = u_NextScale - u_Scale;
    vec4 res = vec4(0.0);
    float sum_weight = 0.0;
    for(int i = 0; i < 16; ++i)
    {
        float scale = d_scale * float(i) / 15.0 + u_Scale;
        vec2 t_uv = scale_uv(uv0, scale);
        vec2 flag = step(t_uv, vec2(1.5)) * step(vec2(-0.5), t_uv);
        t_uv = flip_uv(t_uv);
        res += texture2D(u_Albedo, t_uv) * flag.x * flag.y;
        sum_weight += 1.0;
    }
    res *= 1. / sum_weight;
    gl_FragColor = res * u_Alpha;

}
