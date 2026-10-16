precision highp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform sampler2D u_WarpTex;
uniform vec2 u_Offset;
uniform vec2 u_NoiseOffset;

uniform vec4 u_ScreenParams;
vec2 flip_uv(vec2 uv)
{
    vec2 z = abs(mod(uv + 1., 2.) - 1.0);
    return z;
}
void main()
{
    vec4 warpColor = texture2D(u_WarpTex, flip_uv(vec2(uv0.x, 1. - uv0.y) - vec2(u_NoiseOffset.x, -u_NoiseOffset.y)));
    vec2 offset = (warpColor.r * 2.0 - 1.0) / 1080.0 * u_Offset;
    gl_FragColor = texture2D(u_InputTex, flip_uv(uv0 + offset));
    // gl_FragColor = warpColor;
}
