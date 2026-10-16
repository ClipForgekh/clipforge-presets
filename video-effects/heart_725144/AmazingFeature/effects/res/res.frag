precision highp float;

varying vec2 uv0;

uniform sampler2D frontTex;
uniform sampler2D heartTex;
uniform sampler2D backTex;
uniform sampler2D _MainTex;
uniform sampler2D oriTex;

uniform float back_alpha;
uniform float alpha2;
uniform float scale;
uniform float back_scale;
uniform vec2 pos;
uniform vec2 pivot;
uniform float exposure;
uniform float inner_glow_alpha;

uniform float front_scale;
uniform float front_rot;
uniform float front_alpha;

uniform float sucai_scale;

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

void ExposureLighten(inout vec3 col, float _intensity, float _offset, float _gray_scale_correct, float _linear){

    if(_linear>0.5) col = pow(col, vec3(2.2));
    col *= pow(0.75, -_intensity);
    col += _offset;
    col = pow(col, vec3(1.0 / _gray_scale_correct));

    if (_linear>0.5) col = pow(col, vec3(1.0/2.2));
}

// screen
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec4 blendScreen(vec4 base, vec4 blend) {
    return vec4(
        blendScreen(base.r,blend.r),
        blendScreen(base.g,blend.g),
        blendScreen(base.b,blend.b),
        blendScreen(base.a,blend.a)
        );
}

void main()
{
    vec2 uv1_front = uv0;
    TRS(uv1_front, vec2(0), front_rot, vec2(front_scale), input_rt_size);
    vec4 front_col = texture2D(frontTex, Mirror(uv1_front));

    vec2 uv2_front = uv0;
    AdaptWithMaxLine(uv2_front, input_rt_size);
    TRS(uv2_front, vec2(0), 0., vec2(scale) * 500./1080., input_rt_size);
    uv2_front.y = 1.-uv2_front.y;
    vec4 heart_col = texture2D(heartTex, uv2_front);
    front_col.rgb = mix(front_col.rgb, front_col.rgb * heart_col.r, inner_glow_alpha);

    vec2 uv2 = uv0;
    TRS(uv2, vec2(0), 0., vec2(back_scale), input_rt_size);
    vec4 back_col = texture2D(backTex, Mirror(uv2));
    ExposureLighten(back_col.rgb, exposure, 0., 1., 0.);
    // back_col = mix(vec4(0,0,0,1), back_col, back_alpha);
    back_col *= back_alpha;

    vec2 uv3 = uv0;
    AdaptWithMaxLine(uv3, input_rt_size);
    TRS(uv3, vec2(0), 0., vec2(scale), input_rt_size);
    uv3.y = 1.-uv3.y;
    vec4 light_col = texture2D(_MainTex, uv3);

    vec4 res = back_col;
    // res = res * (1.-front_col.a) + front_col;
    res = blendScreen(res, light_col);
    res = mix(res, front_col, heart_col.a * front_alpha);

    // res = front_col;

    // res = texture2D(backTex, Mirror(uv2));

    gl_FragColor = res;
}
