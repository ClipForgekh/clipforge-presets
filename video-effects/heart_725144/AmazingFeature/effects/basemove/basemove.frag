precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform sampler2D heartTex;

uniform float scale;
uniform float rot;
uniform float alpha;

uniform vec4 u_ScreenParams;
uniform vec2 input_rt_size;


vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }

void TRS(inout vec2 io_u, vec2 _t, float _r, vec2 _s, vec2 _screensize){
    io_u -= 0.5;
    io_u += vec2(-_t.x, _t.y);
    io_u /= _s;

    // rotate
    const float TRS_PI = 3.1415926;
    float r = -_r/180.*TRS_PI;
    float s = sin(r);
    float c = cos(r);

    io_u.x *= _screensize.x/_screensize.y;
    io_u = mat2(c, -s, s,  c) * io_u;
    io_u.x /= _screensize.x/_screensize.y;

    io_u += 0.5;
}

void AdaptWithMaxLine(inout vec2 _u, vec2 _screensize){
    _u -= 0.5;
    if(_screensize.x>_screensize.y) _u.y *= _screensize.y/_screensize.x;
    else _u.x *= _screensize.x/_screensize.y;
    _u += 0.5;
}

void main()
{
    // vec2 uv1 = uv0;
    // AdaptWithMaxLine(uv1, input_rt_size);
    // TRS(uv1, vec2(0), 0., vec2(scale) * 500./1080., input_rt_size);
    // uv1.y = 1.-uv1.y;
    // vec4 heart_col = texture2D(heartTex, uv1);

    // vec2 uv2 = uv0;
    // TRS(uv2, vec2(0), rot, vec2(scale), input_rt_size);

    // vec4 ori_col = texture2D(inputTex, uv2);
    // ori_col *= heart_col.a;
    // vec4 res = ori_col;
    // res *= alpha;
    // gl_FragColor = res;

    gl_FragColor = texture2D(inputTex, uv0);
}
