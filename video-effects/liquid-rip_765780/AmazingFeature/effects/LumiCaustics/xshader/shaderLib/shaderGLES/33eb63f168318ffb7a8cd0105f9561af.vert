
uniform vec4 u_ScreenParams;
uniform vec2 u_inputSize;

varying vec2 v_uv;
attribute vec2 a_texcoord0;
attribute vec2 a_position;

vec2 _f0(vec2 _p0, vec2 _p1)
{
    return (((_p1 * u_ScreenParams.xy) - (u_ScreenParams.xy * 0.5)) / _p0) + vec2(0.5);
}

void main()
{
    vec2 param = u_inputSize;
    vec2 param_1 = a_texcoord0;
    v_uv = _f0(param, param_1);
    gl_Position = vec4(a_position, 0.0, 1.0);
}

