
uniform vec4 u_uvScaleC[12];
uniform float u_uvRotate[12];
uniform vec4 u_model[24];
uniform mat4 u_MVP;

attribute vec2 a_texcoord1;
varying vec2 v_uv;
attribute vec2 a_texcoord0;
varying vec2 v_id;
attribute vec4 a_position;

vec2 _f0(inout vec2 _p0, int _p1)
{
    _p0 -= vec2(0.5);
    _p0 -= u_uvScaleC[_p1].zw;
    float _42 = sin(u_uvRotate[_p1]);
    float _47 = cos(u_uvRotate[_p1]);
    _p0 = mat2(vec2(_47, _42), vec2(-_42, _47)) * _p0;
    _p0 *= u_uvScaleC[_p1].xy;
    _p0 += vec2(0.5);
    return _p0;
}

void main()
{
    float _83 = a_texcoord1.x + 0.5;
    float _88 = a_texcoord1.y + 0.5;
    int _91 = int(_83);
    vec2 param = a_texcoord0;
    int param_1 = (_91 + _91) + int(_88);
    vec2 _108 = _f0(param, param_1);
    v_uv = _108;
    v_id = vec2(_83, _88);
    int _122 = _91 * 4;
    gl_Position = (u_MVP * mat4(vec4(u_model[_122 + 0]), vec4(u_model[_122 + 1]), vec4(u_model[_122 + 2]), vec4(u_model[_122 + 3]))) * a_position;
}

