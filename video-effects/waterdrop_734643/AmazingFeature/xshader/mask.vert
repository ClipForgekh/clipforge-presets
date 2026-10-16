precision highp float;

attribute vec3 attPosition;
attribute vec2 attUV;
uniform mat4 u_MVP;
varying vec2 uv;
uniform float scale;
uniform vec2 offset;

void main() {
    gl_Position = vec4(attPosition*scale,1.0);
    gl_Position.xy = gl_Position.xy - offset;
    uv = attUV;
}
