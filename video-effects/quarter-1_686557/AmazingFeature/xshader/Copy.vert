precision highp float;

attribute vec3 attPosition;
attribute vec2 attUV;

varying vec2 uv;

void main ()
{   
    gl_Position = vec4(attPosition, 1.0);
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
    uv = attUV * .5 + .5;
}
