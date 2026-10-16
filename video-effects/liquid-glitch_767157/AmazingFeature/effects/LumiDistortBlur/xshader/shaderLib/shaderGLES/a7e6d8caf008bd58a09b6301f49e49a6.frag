precision highp float;
precision highp int;

uniform mediump sampler2D u_inputTex;
uniform float u_stride;
uniform float u_steps;
uniform vec2 u_dir;

varying vec2 v_uv;

float _f1(vec4 _p0)
{
    return dot(_p0, vec4(1.0, 0.0039215688593685626983642578125, 1.5378700481960549950599670410156e-05, 6.0308629201699659461155533790588e-08));
}

float _f2(float _p0)
{
    return 1.0 / (1.0 + ((_p0 * _p0) * 11.10999965667724609375));
}

vec3 _f3(float _p0, vec2 _p1)
{
    float _t2 = 0.0;
    float _t3 = 0.0;
    float _88 = 1.0 / _p0;
    int _95 = int(min(_p0, 100.0));
    vec4 param = texture2D(u_inputTex, v_uv);
    float param_1 = 0.0;
    float _110 = _f2(param_1);
    _t2 += (_f1(param) * _110);
    _t3 += _110;
    for (mediump int _t8 = 2; _t8 <= _95; _t8 += 2)
    {
        mediump float _132 = float(_t8);
        float param_2 = _132 * _88;
        float _138 = _f2(param_2);
        vec2 _146 = (_p1 * _132) * u_stride;
        vec4 param_3 = texture2D(u_inputTex, v_uv + _146);
        vec4 param_4 = texture2D(u_inputTex, v_uv - _146);
        _t2 += ((_f1(param_3) + _f1(param_4)) * _138);
        _t3 += (_138 * 2.0);
    }
    return vec3(_t2 / _t3);
}

vec4 _f0(inout float _p0)
{
    _p0 *= 255.0;
    vec4 _t0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0) * 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0) * 255.0;
    _t0.z = floor(_p0) / 255.0;
    _t0.w = fract(_p0);
    return _t0;
}

void main()
{
    float param = u_steps;
    vec2 param_1 = u_dir;
    vec3 _t16 = _f3(param, param_1);
    float param_2 = _t16.x;
    vec4 _202 = _f0(param_2);
    gl_FragData[0] = _202;
}

