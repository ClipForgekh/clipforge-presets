
uniform float u_OutputWidth;
uniform float u_OutputHeight;
uniform mat4 fitMat;
uniform mat4 userMat;
uniform mat4 animMat;

attribute vec2 a_texcoord0;
varying vec2 v_uv;
attribute vec3 a_position;

void _f0(mat4 _p0, inout vec2 _p1)
{
    float _24 = u_OutputWidth / u_OutputHeight;
    _p1 = vec2(((a_texcoord0.x * 2.0) - 1.0) * _24, (a_texcoord0.y * 2.0) - 1.0);
    _p1 = ((fitMat * userMat) * vec4(_p1, 0.0, 1.0)).xy;
    _p1 = vec2(((_p1.x / _24) + 1.0) / 2.0, (_p1.y + 1.0) / 2.0);
}

void main()
{
    mat4 param = animMat;
    vec2 param_1;
    _f0(param, param_1);
    v_uv = param_1;
    gl_Position = vec4(a_position, 1.0);
}

