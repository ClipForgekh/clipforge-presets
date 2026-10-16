#version 300 es

layout(location = 0) in vec4 a_position;
out vec2 v_uv;
layout(location = 1) in vec2 a_texcoord0;

void main()
{
    gl_Position = a_position;
    v_uv = a_texcoord0;
}

