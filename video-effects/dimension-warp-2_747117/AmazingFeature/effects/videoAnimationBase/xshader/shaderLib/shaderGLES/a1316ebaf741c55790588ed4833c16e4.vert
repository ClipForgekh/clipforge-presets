
uniform float u_flipX;
uniform float u_flipY;

attribute vec3 a_position;
varying vec2 v_uv;
attribute vec2 a_texcoord0;

void main()
{
    gl_Position = vec4(a_position, 1.0);
    v_uv = (a_texcoord0 * 2.0) - vec2(1.0);
    if (u_flipX > 0.5)
    {
        v_uv.x = -v_uv.x;
    }
    if (u_flipY > 0.5)
    {
        v_uv.y = -v_uv.y;
    }
    v_uv = (v_uv * 0.5) + vec2(0.5);
}

