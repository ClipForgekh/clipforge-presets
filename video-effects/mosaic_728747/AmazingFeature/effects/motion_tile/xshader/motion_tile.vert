precision highp float;

attribute vec3 position;
attribute vec2 texcoord0;
varying vec2 uv0;
uniform mat4 u_MVP;

uniform mat4 u_Model;
uniform mat4 u_View;
uniform mat4 u_Projection;

varying vec3 local_pos;

uniform vec2 outputTexSize;
uniform vec2 inputTexSize;

void main() 
{ 
    gl_Position = vec4(position, 1.0);
    uv0 = texcoord0;
    local_pos = position;
    // uv0.y = 1.0 - uv0.y;
}
