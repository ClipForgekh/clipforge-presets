precision highp float;

attribute vec2 position;
attribute vec2 texcoord0;
varying vec2 uv0;
uniform float scale;
uniform float angle;
uniform vec4 u_ScreenParams;

//uniform mat4 u_MVP;

#define PI 3.1415926

vec2 rot(float angle, vec2 uv)
{
    vec2 scale = u_ScreenParams.xy / max(u_ScreenParams.x, u_ScreenParams.y);
    uv *= scale;
    // uv += .1;
    float theta = angle * PI / 180.;
    mat2 r = mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
    vec2 uv1 = uv * r;
    uv1 /= scale;
    return uv1;
}

void main() 
{ 
    //gl_Position = u_MVP * position;
    gl_Position = sign(vec4(position.xy, 0.0, 1.0));
    vec2 uv1 = texcoord0;
    // float xOffset = sin(uv1.y * 100.) * .1;
    // uv1.x += xOffset;
    uv0 = rot(angle, uv1 - .5) / scale + .5;
}
