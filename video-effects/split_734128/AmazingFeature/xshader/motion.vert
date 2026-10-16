precision highp float;

uniform float u_scale;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv0;
varying vec2 v_uv1;


void main () {
    v_uv0 = a_texcoord0;
    v_uv1 = (a_texcoord0 - 0.5) / u_scale + 0.5;
    gl_Position = a_position;
}
