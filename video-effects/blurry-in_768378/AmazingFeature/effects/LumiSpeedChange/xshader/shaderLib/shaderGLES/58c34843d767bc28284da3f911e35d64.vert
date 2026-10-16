
attribute vec3 u_attPosition;
varying vec2 v_uv;
attribute vec2 u_att;

void main()
{
    gl_Position = vec4(u_attPosition, 1.0);
    v_uv = u_att;
}

