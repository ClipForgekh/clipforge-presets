precision highp float;

attribute vec3 attPosition;
attribute vec2 attUV;

uniform mat4 u_MVP;
uniform mat4 u_Model;
uniform mat4 u_View;
uniform mat4 u_Projection;
uniform mat4 u_LastModel;
uniform vec4 u_size;
uniform vec4 u_scaleOffset;

varying vec2 uv;
varying vec4 lastScreenPos;
varying vec4 screenPos;

vec4 ComputeScreenPos(vec4 pos) 
{
    vec4 o = pos * 0.5;
    o.xy = vec2(o.x, o.y) + o.w;
    o.zw = pos.zw;
    return o;
}

void main ()
{   
    vec4 pos = u_Projection * u_View * u_Model * vec4(attPosition, 1.0);
    screenPos = ComputeScreenPos(pos);
    vec4 pos2 = u_Projection * u_View * u_LastModel * vec4(attPosition, 1.0);
    lastScreenPos = ComputeScreenPos(pos2);
    gl_Position = pos;

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
    uv = attUV * u_scaleOffset.xy + u_scaleOffset.zw;
}
