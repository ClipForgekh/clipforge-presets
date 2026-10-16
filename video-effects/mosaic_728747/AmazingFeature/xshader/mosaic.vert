precision highp float;

uniform vec2 u_screen_size;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_xy;
 
void main () {
    v_xy = a_texcoord0 * u_screen_size;
    gl_Position = a_position;
}