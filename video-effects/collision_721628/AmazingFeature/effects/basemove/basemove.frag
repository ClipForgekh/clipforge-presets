precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform float u_Intensity;
uniform float rot;

uniform float scale;
uniform vec2 pos;

uniform vec2 pivot;

uniform vec4 u_ScreenParams;
uniform vec2 input_ScreenParams;

uniform float adapt_mode;

void ExposureLighten(vec4 i_col, float _alpha, out vec4 o_col){
    float x = pow((u_Intensity) * 0.263, 2.92) + pow((u_Intensity) * 0.34, 0.92);
    o_col = i_col * vec4(x+1.) + 0.;
    o_col = mix(i_col, o_col, _alpha);
}

const float PI = 3.1415926;
vec2 Rotate(vec2 _u, float angle)
{
    float radius = angle*1./180.*PI;
    vec2 ru = _u-0.5;


    ru.x *= input_ScreenParams.x/input_ScreenParams.y;
    // ru.y *= u_ScreenParams.y/u_ScreenParams.x;
    // if(adapt_mode>0.5){
    //     ru *= mat2(cos(radius), -sin(radius), sin(radius), cos(radius));
    // }else{
    //     ru.x *= u_ScreenParams.x/u_ScreenParams.y;
        ru *= mat2(cos(radius), -sin(radius), sin(radius), cos(radius));
    //     ru.x /= u_ScreenParams.x/u_ScreenParams.y;
    // }
    // ru *= mat2(cos(radius), -sin(radius), sin(radius), cos(radius));
    ru.x /= input_ScreenParams.x/input_ScreenParams.y;
    // ru.y /= u_ScreenParams.y/u_ScreenParams.x;
    return ru + 0.5;
}
vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }

void main()
{
    vec2 uv1 = uv0;
    uv1 += pos;
    uv1 -= 0.5;
    uv1 /= scale;
    uv1 += 0.5;
    uv1 -= pivot;
    uv1 = Rotate(uv1, rot);
    vec4 res = texture2D(inputTex, Mirror(uv1));
    ExposureLighten(res, 1., res);

    // res = vec4(uv1,0,1);
    res.rgb *= min(smoothstep(-0.5, 0., uv1.y), 1.);
    // res *= uv1.y;
    // res *= step(0., uv0.y);
    // res = mix(vec4(0,0,0,1), res, cut(uv1));


    gl_FragColor = res;
}
