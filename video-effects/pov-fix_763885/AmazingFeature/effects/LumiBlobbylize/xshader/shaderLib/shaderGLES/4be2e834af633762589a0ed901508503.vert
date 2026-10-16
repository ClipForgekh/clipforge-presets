
uniform vec4 u_ScreenParams;

attribute vec2 a_position;
varying vec2 v_xy;
attribute vec2 a_texcoord0;

vec2 _f0(vec2 _p0)
{
    return (_p0 - vec2(0.5)) * u_ScreenParams.xy;
}

void main()
{
    gl_Position = vec4(a_position, 0.0, 1.0);
    vec2 param = a_texcoord0;
    v_xy = _f0(param);
}

