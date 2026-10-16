precision highp float;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_xy;


void main () {
    v_xy = a_position.xy;
    gl_Position = a_position;
}
