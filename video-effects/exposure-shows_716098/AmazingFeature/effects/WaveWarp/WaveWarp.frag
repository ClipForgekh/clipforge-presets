precision highp float;

varying vec2 uv0;

uniform sampler2D mainTex;
uniform vec2 u_ScreenParams;
uniform float wave_height;
uniform float wave_width;
uniform float wave_speed;

uniform float dir_angle;

uniform float u_Intensity;
uniform float u_Alpha;
uniform float u_Offset;

uniform float x_phase;

const float PI=3.1415926;

float cut(vec2 _u){
    return step(0., _u.x) * step(_u.x, 1.) * step(0., _u.y) * step(_u.y, 1.);
}

void ExposureLighten(vec4 i_col, float _alpha, out vec4 o_col){
    float x = pow((u_Intensity) * 0.263, 2.92) + pow((u_Intensity) * 0.34, 0.92);
    o_col = i_col * vec4(x+1.) + u_Offset;
    o_col = mix(i_col, o_col, _alpha);
}

vec2 Mirror(vec2 x){
    return abs(mod(x-1., 2.)-1.);
}

void main()
{
    vec2 uv1 = uv0;

    float rad = dir_angle/180.*PI;
    mat2 rot_m = mat2(cos(rad), -sin(rad), sin(rad), cos(rad));

    uv1 -= 0.5;
    // uv1 = rot_m * uv1;
    uv1 += 0.5;

    // uv1.y += sin((uv1.x+x_phase*wave_speed)*PI*4.*wave_width/u_ScreenParams.x) * wave_height/u_ScreenParams.y;
    // uv1.y -= sin((uv1.x+x_phase*wave_speed)*PI*4.*wave_width/u_ScreenParams.x) * wave_height/u_ScreenParams.y * sin(rad);
    uv1.x += cos((uv1.y+x_phase*wave_speed*0.7-0.25)*PI*4.*wave_width) * wave_height * cos(rad);

    vec4 mainCol = texture2D(mainTex, Mirror(uv1));
    vec4 res = mainCol;
    ExposureLighten(res, u_Alpha, res);
    // res = vec4(1,0,0,1);

    // res = mix(vec4(0), res, cut(uv1));

    // res = texture2D(mainTex, uv0);
    gl_FragColor = res;
}
