
uniform float frame;
uniform mat4 u_MVP;

attribute vec3 a_normal;
varying vec2 v_uv;
attribute vec2 a_texcoord1;
attribute vec3 a_position;
attribute vec2 a_texcoord0;

void main()
{
    if (frame >= 1.0)
    {
        gl_Position = u_MVP * vec4(a_normal, 1.0);
        v_uv = a_texcoord1;
    }
    else
    {
        if (frame > 0.0)
        {
            gl_Position = u_MVP * vec4(mix(a_position, a_normal, vec3(frame)), 1.0);
            v_uv = mix(a_texcoord0, a_texcoord1, vec2(frame));
        }
        else
        {
            gl_Position = u_MVP * vec4(a_position, 1.0);
            v_uv = a_texcoord0;
        }
    }
}

