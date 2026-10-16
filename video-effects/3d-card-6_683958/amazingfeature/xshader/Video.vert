precision highp float;

attribute vec3 attPosition;
attribute vec2 attUV;

uniform vec2 u_pos;
uniform float u_scale;
uniform float u_angle;
uniform vec4 u_size;
uniform float u_flipX;
uniform float u_flipY;

varying vec2 uv;

void main ()
{
    //float cosTheta = cos(-u_angle);
    //float sinTheta = sin(-u_angle);
    //float aspect = u_size.x / u_size.y;
    //float scaleX = u_size.x / u_size.z / u_scale;
    //float scaleY = u_size.y / u_size.w / u_scale;
    gl_Position = vec4(attPosition, 1.0);
    uv = vec2(attUV.x * 2.0 - 1.0, attUV.y * 2.0 - 1.0);
    if (u_size.z < u_size.w)
    {
        uv.y = uv.y * u_size.z / u_size.w;
    }
    else
    {
        uv.x = uv.x * u_size.w / u_size.z;
    }
    if (u_flipX > 0.5)
    {
        uv.x = -uv.x;
    }
    if (u_flipY > 0.5)
    {
        uv.y = -uv.y;
    }
    //uv = vec2(uv.x - u_pos.x, uv.y - u_pos.y);
    //uv = vec2(uv.x * aspect, uv.y);
    //uv = vec2(cosTheta * uv.x + sinTheta * uv.y, cosTheta * uv.y - sinTheta * uv.x);
    //uv = vec2(uv.x / aspect, uv.y);
    //uv = vec2(uv.x * scaleX, uv.y * scaleY);
    uv = vec2(uv.x * 0.5 + 0.5, uv.y * 0.5 + 0.5);
}
