precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform float baseTexHeight;
uniform float baseTexWidth;
uniform float angle;

#define SQRT2 1.414214
#define PI 3.1415926

vec2 rotate(vec2 point, float angle, vec2 center)
{
    float anglePI = angle * PI / 180.0;
    mat2 rot = mat2( cos(anglePI), sin(anglePI), 
                    -sin(anglePI), cos(anglePI) );
    point -= center;
    point.y *= float(baseTexHeight) / float(baseTexWidth);
    point = rot * point;
    point.y /= float(baseTexHeight) / float(baseTexWidth);
    point += center;
    return point ;
}

void main()
{
    vec2 uv1 = uv0;
    uv1 = rotate(uv1, -angle, vec2(.5));

    gl_FragColor = texture2D(inputTex, uv1);
    // gl_FragColor = vec4(1.);
}
