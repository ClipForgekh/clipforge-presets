precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform vec4 u_ScreenParams;
uniform float bounceTime;
uniform float intensity;

void main()
{
    vec2 uv1 = (uv0 - .5) / (1. + .1 * intensity) + .5;

    float ratio = 0.;
    if (bounceTime < .25) {
        ratio = bounceTime / .25;
        uv1.y -= (1. - pow(ratio - 1., 2.)) * .04 * intensity;
    }
    else if (bounceTime < .5) {
        ratio = (bounceTime - .25) / .25;
        uv1.y -= (1. - pow(ratio, 2.)) * .04 * intensity; 
    }
    else if (bounceTime < .75) {
        ratio = (bounceTime - .5) / .25;
        uv1.y += (1. - pow(ratio - 1., 2.)) * .04 * intensity;
    }
    else {
        ratio = (bounceTime - .75) / .25;
        uv1.y += (1. - pow(ratio, 2.)) * .04 * intensity; 
    }
    vec4 resultColor = texture2D(inputTex, uv1);
    // resultColor = vec4(myNoise1);
    gl_FragColor = resultColor;
}
