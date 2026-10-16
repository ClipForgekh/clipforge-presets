precision lowp float;
varying highp vec2 uv0;
uniform sampler2D u_InputTex;
uniform vec2 u_Position;
uniform vec2 u_Scale;
uniform float u_Rotate;
uniform vec4 u_ScreenParams;
vec2 flip_uv(vec2 uv)
{
    vec2 z = abs(mod(uv + 1., 2.) - 1.0);
    return z;
}

vec2 rotate(vec2 uv, float angle)
{
    uv.y *= u_ScreenParams.y / u_ScreenParams.x;
    float theta = angle / 180.0 * 3.1415926;
    float cost = cos(theta);
    float sint = sin(theta);
    mat2 rot = mat2(
        cos(theta), sin(theta),
        -sin(theta), cos(theta)
    );
    uv = rot * uv;
    uv.y *= u_ScreenParams.x / u_ScreenParams.y;
    return uv;
}
void main()
{
    vec2 uv = uv0;
    uv -= u_Position;
    uv -= 0.5;
    uv /= u_Scale;
    uv = rotate(uv, u_Rotate);
    uv += .5;
    gl_FragColor = texture2D(u_InputTex, flip_uv(uv));
}
