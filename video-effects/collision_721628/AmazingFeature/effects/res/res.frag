precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform float u_Intensity;
uniform float rot;

uniform vec4 u_ScreenParams;
const float u_Offset = 0.;

void ExposureLighten(vec4 i_col, float _alpha, out vec4 o_col){
    float x = pow((u_Intensity) * 0.263, 2.92) + pow((u_Intensity) * 0.34, 0.92);
    o_col = i_col * vec4(x+1.) + u_Offset;
    o_col = mix(i_col, o_col, _alpha);
}

const float PI = 3.1415926;
vec2 Rotate(vec2 _u, float angle)
{
    float radius = angle/180.*PI;
    vec2 ru = _u-0.5;
    ru.x *= u_ScreenParams.x/u_ScreenParams.y;
    ru *= mat2(cos(radius), -sin(radius), sin(radius), cos(radius));
    ru.x /= u_ScreenParams.x/u_ScreenParams.y;
    return ru + 0.5;
}
vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

void main()
{
    vec2 uv1 = uv0;
    uv1 = Rotate(uv1, rot);
    uv1.y = 1.-uv1.y;
    vec4 res = texture2D(inputTex, Mirror(uv1));
    ExposureLighten(res, 1., res);


    gl_FragColor = res;
}
