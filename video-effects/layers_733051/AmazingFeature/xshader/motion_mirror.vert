precision highp float;

uniform mat4 u_matrix;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;
varying vec2 v_uv0;

void main () {
    v_uv = a_texcoord0;
    v_uv0 = (u_matrix * vec4(a_texcoord0, 0.0, 1.0)).st;
    gl_Position = a_position;
}
