precision highp float;
varying highp vec2 uv0;
uniform sampler2D inputTex;
uniform float alpha;

uniform vec4 u_ScreenParams;

void main()
{
    vec2 uv1 = uv0;
    uv1 -= 0.5;
    uv1.x *= u_ScreenParams.x/u_ScreenParams.y;
    uv1 += 0.5;
    vec4 res = texture2D(inputTex, uv1) * alpha;
    res = vec4(1,0,0,1);
    gl_FragColor = res;
}
