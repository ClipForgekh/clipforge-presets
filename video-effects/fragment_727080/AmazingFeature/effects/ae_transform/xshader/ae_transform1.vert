precision highp float;

attribute vec3 position;
attribute vec2 texcoord0;
varying vec2 uv0;

uniform float y_offset;

void main() 
{ 
    gl_Position = vec4(position, 1.0);
    uv0 = texcoord0;
    // uv0.y += y_offset;
    // uv0 -= 0.5;
    // uv0.y *= 0.5;
    // uv0 += 0.5;
}
