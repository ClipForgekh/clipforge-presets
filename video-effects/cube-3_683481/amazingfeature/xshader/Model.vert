precision highp float;

attribute vec3 attPosition;
attribute vec2 attUV;

uniform mat4 u_MVP;
uniform vec4 u_size;

varying vec2 uv;

void main ()
{
    gl_Position = u_MVP * vec4(attPosition, 1.0);
    /*uv = vec2(attUV.x * 2.0 - 1.0, attUV.y * 2.0 - 1.0);
    if (u_size.x < u_size.y)
    {
        uv.y = uv.y * u_size.x / u_size.y;
    }
    else
    {
        uv.x = uv.x * u_size.y / u_size.x;
    }
    uv = vec2(uv.x * 0.5 + 0.5, uv.y * 0.5 + 0.5);*/
    uv = attUV;
}
