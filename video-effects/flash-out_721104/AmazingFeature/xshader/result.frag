precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_inputTex;
uniform float u_tileVal;

vec2 flip_uv(vec2 uv)
{
    return abs(mod(uv + 1., 2.) - 1.0);
}
void main()
{
    vec2 uv1 = uv0;
    uv1 = (uv1 - .5) / u_tileVal + .5;
    uv1 = flip_uv(uv1);
    vec4 resultColor = texture2D(u_inputTex, uv1);
    gl_FragColor = vec4(resultColor);
    // gl_FragColor = vec4(maskColor);
}