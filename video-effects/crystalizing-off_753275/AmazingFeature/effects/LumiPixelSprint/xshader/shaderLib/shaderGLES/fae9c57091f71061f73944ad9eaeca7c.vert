#version 300 es

uniform vec3 u_viewPos;

out vec2 v_uv;
layout(location = 1) in vec2 a_texcoord0;
out vec3 v_tangentViewPos;
out vec3 v_tangentFragPos;
layout(location = 0) in vec4 a_position;

void main()
{
    v_uv = a_texcoord0;
    v_tangentViewPos = u_viewPos;
    v_tangentFragPos = a_position.xyz;
    gl_Position = a_position;
}

