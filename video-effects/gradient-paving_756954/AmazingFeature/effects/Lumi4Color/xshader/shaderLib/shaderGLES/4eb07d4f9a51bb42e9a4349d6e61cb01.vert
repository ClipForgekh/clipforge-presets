
uniform vec2 u_screenSize;

attribute vec4 a_position;
varying vec2 v_uv;
attribute vec2 a_texcoord0;
varying vec2 v_p;

void main()
{
    gl_Position = a_position;
    v_uv = a_texcoord0;
    v_p = vec2(a_texcoord0.x, 1.0 - a_texcoord0.y) * u_screenSize;
}

