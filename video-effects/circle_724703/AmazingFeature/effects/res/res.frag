precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex1;
uniform sampler2D inputTex2;
uniform sampler2D sucaiTex;
uniform sampler2D oriTex;

uniform float alpha;
uniform float scale;
uniform vec2 pos;
uniform vec2 pivot;
uniform float exposure;
uniform float blur_alpha;

uniform float sucai_scale;

uniform vec4 u_ScreenParams;
uniform vec2 output_size;

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

void ExposureLighten(inout vec3 col, float _intensity, float _offset, float _gray_scale_correct, float _linear){

    if(_linear>0.5) col = pow(col, vec3(2.2));
    col *= pow(0.75, -_intensity);
    col += _offset;
    col = pow(col, vec3(1.0 / _gray_scale_correct));

    if (_linear>0.5) col = pow(col, vec3(1.0/2.2));
}


////////////////////////  cclens  ////////////////////////////
uniform float u_Convergence;
uniform float u_Size;
uniform vec2 u_Center;
void CCLens(inout vec2 io_uv, vec2 _center, float _convergence, float _size, vec2 _screensize, out float o_mask)
{
    io_uv = (io_uv - _center);
    io_uv.x *= _screensize.x / _screensize.y;
    float distortion_k1 = -_convergence * 96.25 * 1920.0 / 1080.0 * 1.0 / pow(_size, 2.0);
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


void main()
{
    vec2 uv1 = uv0;
    vec4 col1 = texture2D(inputTex1, Mirror(uv1));

    vec2 uv2 = uv0;
    vec4 col2 = texture2D(inputTex2, Mirror(uv2));
    col2 = vec4(vec3(72./255., 88./255., 246./255.)*col2.a, col2.a) * blur_alpha;

    vec4 res = mix(col2, col1, alpha);
    res = mix(col2, res, res.a);
    res.a = max(col2.a, res.a);

    res = col2;
    res = col2*(1.-col1.a)+col1;
    // res = mix(col2, col1, col1.a);

    vec2 uv3 = uv0;
    AdaptWithMaxLine(uv3, output_size);
    TRS(uv3, vec2(0), 0., vec2(sucai_scale), output_size);
    uv3.y = 1.-uv3.y;
    res.rgb += texture2D(sucaiTex, uv3).rgb;

    // res = col1;
    // res = vec4(1,0,0,1);
    // res = vec4(col2.a,0,0,1);
    // res = col1;
    // res = vec4(1,0,0,1);
    // ExposureLighten(res.rgb, exposure, 0., 1., 0.);

    // vec2 uv4 = uv0;
    // float cclens_mask = 0.;
    // CCLens(uv4, u_Center, u_Convergence, u_Size, u_ScreenParams.xy, cclens_mask);
    // res = texture2D(oriTex, uv4) * cclens_mask;
    // res = vec4(uv4.xy,0,1);

    gl_FragColor = res;
}
