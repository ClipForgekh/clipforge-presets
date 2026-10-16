precision highp float;

uniform float u_ratio;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;

void main () {
    const vec2 center = vec2(0.5);
    v_uv = center + (a_texcoord0 - center) / u_ratio;
    gl_Position = a_position;
}