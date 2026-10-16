precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform vec4 u_ScreenParams;
uniform float bounceTime;

void main()
{
    vec2 uv1 = uv0;
    vec4 resultColor = texture2D(inputTex, uv1);
    // resultColor = vec4(myNoise1);
    gl_FragColor = resultColor;
}
