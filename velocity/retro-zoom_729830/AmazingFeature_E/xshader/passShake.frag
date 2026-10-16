precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform vec4 u_ScreenParams;
uniform float shakeTime;
uniform float intensity;

vec2 rotate(vec2 uv, float theta)
{

    uv -= .5;
    uv *= u_ScreenParams.xy / min(u_ScreenParams.x, u_ScreenParams.y);
    float cost = cos(theta);
    float sint = sin(theta);
    uv = uv * mat2(cost, -sint, sint, cost);
    uv *= min(u_ScreenParams.x, u_ScreenParams.y) / u_ScreenParams.xy;
    return uv + .5;

}

void main()
{
    vec2 uv1 = (uv0 - .5) / (1. + .3 * intensity) + .5;

    float ratio = 0.;
    if (shakeTime < .25) {
        ratio = shakeTime / .25;
        ratio = (1. - pow(ratio - 1., 2.));
    }
    else if (shakeTime < .5) {
        ratio = (shakeTime - .25) / .25;
        ratio = (1. - pow(ratio, 2.)); 
    }
    else if (shakeTime < .75) {
        ratio = (shakeTime - .5) / .25;
        ratio = -(1. - pow(ratio - 1., 2.));
    }
    else {
        ratio = (shakeTime - .75) / .25;
        ratio = -(1. - pow(ratio, 2.)); 
    }

    uv1 = rotate(uv1, .24 * ratio * intensity);
    
    vec4 resultColor = texture2D(inputTex, uv1);
    // resultColor = vec4(myNoise1);
    gl_FragColor = resultColor;
}
