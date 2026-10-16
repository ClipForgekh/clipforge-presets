precision highp float;

uniform mat4 u_Projection;
uniform mat4 u_View;
uniform mat4 u_AEModel;
uniform mat4 u_Model;

attribute vec4 a_position;
attribute vec2 a_texcoord0;

varying vec2 v_uv;


void main () {
    v_uv = vec2(a_texcoord0.x, 1.0 - a_texcoord0.y);
    mat4 mvp = u_Projection * u_View * u_AEModel;
    gl_Position = mvp * a_position;
    //v_uv = a_texcoord0;
    //gl_Position = a_position;
}
