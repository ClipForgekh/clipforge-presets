precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_albedo;
uniform vec4 u_ScreenParams;
uniform float centerX;
uniform float centerY;
uniform float width;
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
    vec4 curColor = texture2D(u_albedo, uv0);
    vec4 resultColor = curColor;
    float maskVal = 1.;
    vec2 LB = rot(angle, vec2(-.505 * width, -.9));
    vec2 LU = rot(angle, vec2(-.505 * width, .9));
    vec2 RB = rot(angle, vec2(.505 * width, -.9));
    vec2 RU = rot(angle, vec2(.505 * width, .9));
    vec2 RB1 = rot(angle, vec2(.505 * width + .02, -.9));
    vec2 RU1 = rot(angle, vec2(.505 * width + .02, .9));
    vec2 LB2 = rot(angle, vec2(-.505 * width + .005, -.9));
    vec2 LU2 = rot(angle, vec2(-.505 * width + .005, .9));
    vec2 RB2 = rot(angle, vec2(.505 * width - .005, -.9));
    vec2 RU2 = rot(angle, vec2(.505 * width - .005, .9));
    float maskValLeft = uv0.y * (LU - LB).x + LB.x;
    float maskValRight = uv0.y * (RU - RB).x + RB.x;
    float maskValRight1 = uv0.y * (RU1 - RB1).x + RB1.x;
    float maskValLeft2 = uv0.y * (LU2 - LB2).x + LB2.x;
    float maskValRight2 = uv0.y * (RU2 - RB2).x + RB2.x;
    if ( uv0.x - .5 < maskValLeft || uv0.x - .5 > maskValRight) maskVal = 0.;
    else if (uv0.x - .5 > maskValRight2) maskVal = smoothstep(0., 1., 1. - ((uv0.x - .5 - maskValRight2) * 100.) / ((maskValRight - maskValRight2) * 100. + .0001));
    else if (uv0.x - .5 < maskValLeft2) maskVal = smoothstep(0., 1., ((uv0.x - .5 - maskValLeft) * 100.) / ((maskValLeft2 - maskValLeft) * 100. + .0001));
    resultColor = mix(vec4(0.), curColor, maskVal);
    float shadowIntensity = min(.3, width);
    gl_FragColor = resultColor;
}
