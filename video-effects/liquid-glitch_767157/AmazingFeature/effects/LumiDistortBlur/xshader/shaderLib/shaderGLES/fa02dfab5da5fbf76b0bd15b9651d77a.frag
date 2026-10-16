precision highp float;
precision highp int;

uniform vec2 u_screenRatio;
uniform mediump sampler2D u_lens;
uniform vec2 u_rotationSinCos;
uniform vec2 u_amountRel;
uniform mediump int u_wrapModeX;
uniform mediump int u_wrapModeY;
uniform float u_blurInterval;
uniform float u_warpAmount;
uniform float u_blurAmount;
uniform mediump sampler2D u_inputTex;

varying vec2 v_uv;

float _f1(vec4 _p0)
{
    return dot(_p0, vec4(1.0, 0.0039215688593685626983642578125, 1.5378700481960549950599670410156e-05, 6.0308629201699659461155533790588e-08));
}

vec2 _f5(vec2 _p0, float _p1)
{
    vec2 _t6 = vec2(abs(_p1)) / u_screenRatio;
    vec4 param = texture2D(u_lens, _p0 + vec2(_t6.x, 0.0));
    vec4 param_1 = texture2D(u_lens, _p0 - vec2(_t6.x, 0.0));
    vec4 param_2 = texture2D(u_lens, _p0 + vec2(0.0, _t6.y));
    vec4 param_3 = texture2D(u_lens, _p0 - vec2(0.0, _t6.y));
    return vec2(_f1(param) - _f1(param_1), _f1(param_2) - _f1(param_3));
}

vec2 _f2(vec2 _p0, vec2 _p1)
{
    return vec2((_p0.x * _p1.y) - (_p0.y * _p1.x), (_p0.x * _p1.x) + (_p0.y * _p1.y));
}

vec2 _f6(vec2 _p0, inout vec2 _p1, float _p2)
{
    vec2 param = _p1;
    vec2 param_1 = u_rotationSinCos;
    _p1 = _f2(param, param_1);
    return _p0 + ((_p1 * _p2) * u_amountRel);
}

float _f3(float _p0)
{
    float _118 = fract(_p0);
    float _123 = floor(mod(_p0, 1.0));
    return (_118 + _123) - ((_118 * _123) * 1.0);
}

vec2 _f4(inout vec2 _p0, mediump int _p1, mediump int _p2, vec2 _p3)
{
    if (_p1 == 0)
    {
        _p0.x = clamp(_p0.x, 0.0, 1.0);
    }
    else
    {
        if (_p1 == 1)
        {
            _p0.x = mod(_p0.x, _p3.x);
        }
        else
        {
            if (_p1 == 2)
            {
                float param = _p0.x;
                _p0.x = _f3(param);
            }
        }
    }
    if (_p2 == 0)
    {
        _p0.y = clamp(_p0.y, 0.0, 1.0);
    }
    else
    {
        if (_p2 == 1)
        {
            _p0.y = mod(_p0.y, _p3.y);
        }
        else
        {
            if (_p2 == 2)
            {
                float param_1 = _p0.y;
                _p0.y = _f3(param_1);
            }
        }
    }
    return _p0;
}

vec4 _f7(mediump sampler2D _p0, inout vec2 _p1)
{
    vec2 param = _p1;
    mediump int param_1 = u_wrapModeX;
    mediump int param_2 = u_wrapModeY;
    vec2 param_3 = u_screenRatio;
    vec2 _296 = _f4(param, param_1, param_2, param_3);
    _p1 = _296;
    return texture2D(_p0, _p1);
}

float _f0(float _p0)
{
    return 0.0900000035762786865234375 / (0.0900000035762786865234375 + (0.5 * (_p0 * _p0)));
}

vec4 _f8(mediump sampler2D _p0, inout vec2 _p1, vec2 _p2, float _p3)
{
    vec2 param = _p1;
    mediump int param_1 = u_wrapModeX;
    mediump int param_2 = u_wrapModeY;
    vec2 param_3 = u_screenRatio;
    vec2 _312 = _f4(param, param_1, param_2, param_3);
    _p1 = _312;
    vec4 _t15 = texture2D(_p0, _p1);
    float _320 = min(_p3, 5.0);
    float _323 = 1.0 / _320;
    float _t18 = 1.0;
    for (float _t19 = u_blurInterval; _t19 <= _320; _t19 += (1.5 * u_blurInterval))
    {
        if (_t19 > _p3)
        {
            break;
        }
        vec2 param_4 = _p2 * _t19;
        vec2 param_5 = u_rotationSinCos;
        vec2 _352 = _f2(param_4, param_5) * u_amountRel;
        vec2 param_6 = _p1 - _352;
        vec4 _363 = _f7(_p0, param_6);
        _t15 += _363;
        vec2 param_7 = _p1 + _352;
        vec4 _368 = _f7(_p0, param_7);
        _t15 += _368;
        float param_8 = _t19 * _323;
        _t18 += 2.0;
    }
    return _t15 / vec4(_t18);
}

void main()
{
    float _396 = max(u_warpAmount, u_blurAmount);
    vec2 param = v_uv;
    float param_1 = _396;
    vec2 _404 = _f5(param, param_1);
    vec2 param_2 = v_uv;
    vec2 param_3 = _404;
    float param_4 = u_warpAmount;
    vec2 _412 = _f6(param_2, param_3, param_4);
    vec2 param_5 = _412;
    vec2 param_6 = _404;
    float param_7 = _396;
    vec4 _422 = _f8(u_inputTex, param_5, param_6, param_7);
    gl_FragData[0] = _422;
}

