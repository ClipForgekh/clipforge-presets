precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform sampler2D circleTex;

uniform float ori_scale;
uniform vec2 ori_pos;
uniform float ori_rot;
uniform float circle_scale;

uniform vec4 u_ScreenParams;
uniform vec2 output_size;


vec2 Mirror(vec2 x) { return abs(mod(x-1., 2.)-1.); }

float cut(vec2 u) {return step(0., u.x)*step(u.x, 1.)*step(0., u.y)*step(u.y, 1.); }

float dynamic_collage(vec2 u, vec2 _output_size) {
    return step(0.5-_output_size.x*0.5, u.x)*step(u.x, _output_size.x*0.5+0.5)
        *step(0.5-_output_size.y*0.5, u.y)*step(u.y, _output_size.y*0.5+0.5);
}

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

void AdaptWithMinLine(inout vec2 _u, vec2 _screensize){
    _u -= 0.5;
    if(_screensize.x>_screensize.y) _u.x *= _screensize.x/_screensize.y;
    else _u.y *= _screensize.y/_screensize.x;
    _u += 0.5;
}

////////////////////////  cclens  ////////////////////////////
uniform float u_Convergence;
uniform float u_Size;
uniform vec2 u_Center;
void CCLens(inout vec2 io_uv, vec2 _center, float _convergence, float _size, vec2 _screensize, out float o_mask)
{
    io_uv = (io_uv - _center);
    io_uv.x *= _screensize.x / _screensize.y;
    float distortion_k1 = -_convergence / 1.5625 * 96.25 * 1920.0 / 1080.0 * 1.0 / pow(_size, 2.0);
    float distortion_k2 = 0.0;
    float rr = length(io_uv);
    float r2 = rr * (1.0 + distortion_k1 * pow(rr, 2.0) + distortion_k2 * (rr * rr * rr));
    float theta = atan(io_uv.x, io_uv.y);
    float distortion_x = sin(theta) * r2 * 1.0;
    float distortion_y = cos(theta) * r2 * 1.0;
    io_uv = vec2(distortion_x, distortion_y);
    io_uv.x *= _screensize.y / _screensize.x;
    io_uv += _center;

    o_mask = step(rr, (_size) * 0.01 + 0.01 * (_size * 0.02));
}
////////////////////////////////////////////////////////////

vec2 uvProtect(vec2 uv)
{
    return step(vec2(0.0), uv) * step(uv, vec2(1.0));
}

void main()
{
    vec2 uv1 = uv0;
    TRS(uv1, ori_pos, ori_rot, vec2(ori_scale), output_size);
    float cclens_mask=0.;
    CCLens(uv1, u_Center, u_Convergence, u_Size, u_ScreenParams.xy, cclens_mask);

    vec2 uv2 = uv0;
    AdaptWithMaxLine(uv2, output_size);
    TRS(uv2, vec2(0), 0., vec2(circle_scale), output_size);

    vec4 ori_col = texture2D(inputTex, Mirror(uv1))*cclens_mask;
    vec4 circle_col = texture2D(circleTex, uv2);
    vec4 res = ori_col * dynamic_collage(uv1, vec2(5.25));
    res = mix(vec4(0), res, circle_col.a);

    gl_FragColor = res;
}
