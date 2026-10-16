
uniform vec4 u_ScreenParams;
uniform vec2 u_inputSize;

varying vec2 v_uv;
attribute vec2 a_texcoord0;
attribute vec2 a_position;

vec2 _f0(vec2 _p0, vec2 _p1, vec2 _p2, vec2 _p3, vec2 _p4, float _p5, vec2 _p6)
{
    return ((_p6 * _p0 + (-(_p2 * _p0))) / (_p1 * _p4)) + _p3;
}

void main()
{
    vec2 param = u_ScreenParams.xy;
    vec2 param_1 = u_inputSize;
    vec2 param_2 = vec2(0.5);
    vec2 param_3 = vec2(0.5);
    vec2 param_4 = vec2(1.0);
    float param_5 = 0.0;
    vec2 param_6 = a_texcoord0;
    v_uv = _f0(param, param_1, param_2, param_3, param_4, param_5, param_6);
    gl_Position = vec4(a_position, 0.0, 1.0);
}

