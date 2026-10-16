precision highp float;

attribute vec3 attPosition;
attribute vec2 attUV;

uniform mat4 u_MVP;
uniform vec4 u_size;
varying vec2 uv;
uniform vec4 crop;

void main ()
{
    gl_Position = u_MVP * vec4(attPosition, 1.0);
    uv = vec2(attUV.x * 2.0 - 1.0, attUV.y * 2.0 - 1.0);
    if (crop.z < crop.w)
    {
        uv.y = uv.y * crop.z / crop.w;
    }
    else
    {
        uv.x = uv.x * crop.w / crop.z;
    }
    //
    // if (1.0 < crop)
    // {
    //     uv.y = uv.y * 1. / crop;
    // }
    // else
    // {
    //     uv.x = uv.x * crop / 1.;
    // }
    uv = vec2(uv.x * 0.5 + 0.5, uv.y * 0.5 + 0.5);
}
