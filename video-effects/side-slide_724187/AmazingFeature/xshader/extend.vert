precision highp float;

uniform float u_ratio;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;


void main() {
    v_uv = (a_texcoord0 - 0.5) * u_ratio + 0.5;
    gl_Position = a_position;
}
