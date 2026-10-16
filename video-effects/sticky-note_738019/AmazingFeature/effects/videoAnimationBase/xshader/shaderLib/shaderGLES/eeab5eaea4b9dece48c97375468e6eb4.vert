
uniform float u_OutputWidth;
uniform float u_OutputHeight;
uniform mat4 fitMat;
uniform mat4 userMat;
uniform mat4 animMat;

attribute vec2 a_texcoord0;
varying vec2 v_uv;
attribute vec3 a_position;

void transformUV(mat4 mat, inout vec2 uv)
{
    float _24 = u_OutputWidth / u_OutputHeight;
    uv = vec2((a_texcoord0.x * 2.0 + (-1.0)) * _24, a_texcoord0.y * 2.0 + (-1.0));
    uv = ((fitMat * userMat) * vec4(uv, 0.0, 1.0)).xy;
    uv = vec2(((uv.x / _24) + 1.0) * 0.5, (uv.y + 1.0) * 0.5);
}

void main()
{
    mat4 param = animMat;
    vec2 param_1;
    transformUV(param, param_1);
    v_uv = param_1;
    gl_Position = vec4(a_position, 1.0);
}

