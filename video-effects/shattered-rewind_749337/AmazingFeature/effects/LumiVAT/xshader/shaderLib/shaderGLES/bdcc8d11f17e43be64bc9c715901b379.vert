
uniform mat4 u_MVP;

attribute vec3 a_position;

void main()
{
    gl_Position = u_MVP * vec4(a_position, 1.0);
}

