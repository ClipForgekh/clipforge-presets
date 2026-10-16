precision highp float;

attribute vec4 position;
attribute vec2 texcoord0;
varying vec2 uv0;
uniform mat4 u_MVP;

void main() 
{ 
    vec4 new_pos = position;
    new_pos.y *= 4.;
    new_pos.x *= 4.;
    gl_Position = u_MVP * new_pos;
    uv0 = texcoord0;
}
