#version 300 es
precision highp float;

uniform mat4 u_Projection;
uniform mat4 u_View;
uniform mat4 u_AEModel;
uniform mat4 u_Model;

in vec4 a_position;
in vec2 a_texcoord0;

out vec2 v_uv;


void main () {
    v_uv = a_texcoord0;
    mat4 mvp = u_Projection * u_View * u_AEModel;
    gl_Position = mvp * a_position;
}
