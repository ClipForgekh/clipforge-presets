
uniform mat4 u_mat;

attribute vec4 a_position;
varying vec2 v_uv;
attribute vec2 a_texcoord0;

void main()
{
    gl_Position = a_position;
    v_uv = (u_mat * vec4(a_texcoord0, 0.0, 1.0)).xy;
}

