precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform float u_Scale;
uniform vec2 u_Offset;
vec2 flip_uv(vec2 uv)
{
    vec2 z = abs(mod(uv + 1., 2.) - 1.0);
    return z;
}
void main()
{
    vec2 uv = (uv0 - u_Offset - 0.5) * u_Scale + 0.5;
    gl_FragColor = texture2D(u_InputTex, flip_uv(uv));
}
