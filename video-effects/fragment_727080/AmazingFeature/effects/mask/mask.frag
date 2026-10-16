precision highp float;

varying vec2 uv0;

uniform sampler2D inputTex;
uniform sampler2D maskTex;

uniform vec2 pos;
uniform vec4 u_ScreenParams;
uniform float shadow_alpha;

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

void main()
{
    vec2 uv1 = uv0;
    TRS(uv1, pos, 0., vec2(1), u_ScreenParams.xy);
    vec4 inputCol = texture2D(inputTex, uv1);

    vec2 uv2 = uv0;
    uv2 -= 0.5;
    uv2 /= 1280./1080.;
    uv2 += 0.5;
    uv2.y = 1.-uv2.y;
    vec4 maskCol = texture2D(maskTex, uv2);

    vec4 corner = mix(vec4(0), inputCol, maskCol.g);
    vec4 shadow = vec4(vec3(0),maskCol.a);
    vec4 res = mix(vec4(0), corner, maskCol.a);
    res = shadow * shadow_alpha*inputCol.a + corner;
    gl_FragColor = res;
}
