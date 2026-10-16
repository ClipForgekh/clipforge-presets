precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
uniform vec4 u_ScreenParams;
uniform float u_strength;

void main()
{
    vec2 uv1 = uv0;
    vec2 uv2 = uv1 - .5;
    float l = length(uv2);
    float angle = atan(uv2.y, uv2.x);
    float y = min(.5, abs(.5 * uv2.y / (uv2.x + .0001)));
    float x = y / (uv2.y / (uv2.x + .0001) + .0001);
    float l1 = length(vec2(x, y));

    float distort = u_strength * 65. / 88.;
    if (distort < 0.){
        uv1 = (uv1 - .5) / (pow(l / l1, 1.) * (-distort) + (1. + distort)) + .5;
    }
    else {
        uv1 = (uv1 - .5) / (1. + pow((.707 - l) / .65, .75) * distort * (4.7 / 4.) * 1.9) + .5;
    }
    vec4 resultColor = texture2D(u_inputTex, uv1);
    gl_FragColor = resultColor;
}