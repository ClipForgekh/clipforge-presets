precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform float scale;
uniform float angle;

#define PI 3.1415926

vec2 rot(float angle, vec2 uv)
{
    
    float theta = angle * PI / 180.;
    mat2 r = mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
    return uv * r;
}

void main()
{
    vec2 uv1 = uv0;
    float xOffset = sin(uv0.y * 20.) * .02;
    uv1.x += xOffset;
    uv1 = rot(angle, uv1 - .5) / scale + .5;
    gl_FragColor = texture2D(u_albedo, uv0);
}
