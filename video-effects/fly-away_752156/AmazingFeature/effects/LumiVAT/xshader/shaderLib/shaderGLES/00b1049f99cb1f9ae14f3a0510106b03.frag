precision highp float;
precision highp int;

uniform vec4 u_ScreenParams;
uniform float u_rotate;
uniform vec2 u_offset;
uniform vec2 u_scale;
uniform mediump sampler2D u_inputTex;
uniform vec2 u_padding;
uniform mediump int u_edgeType;

varying vec2 v_uv0;

vec2 _f3(inout vec2 _p0, float _p1, vec2 _p2, vec2 _p3)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _103 = sin(_p1);
    float _106 = cos(_p1);
    _p0 = mat2(vec2(_106, _103), vec2(-_103, _106)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

vec2 _f1(vec2 _p0)
{
    vec2 _56 = mod(_p0, vec2(1.0));
    return _56 + (vec2(1.0) - step(vec2(0.0), _56));
}

vec2 _f0(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

float _f2(vec2 _p0)
{
    vec2 _t1 = step(vec2(0.0), _p0) * step(_p0, vec2(1.0));
    return _t1.x * _t1.y;
}

vec4 _f4(mediump sampler2D _p0, vec2 _p1, vec2 _p2, mediump int _p3)
{
    vec2 _t5 = _p1;
    bool _144 = _p2.x < 0.0;
    bool _151;
    if (!_144)
    {
        _151 = _p2.y < 0.0;
    }
    else
    {
        _151 = _144;
    }
    if (_151)
    {
        if (_p3 == 0)
        {
            vec2 param = _p1;
            _t5 = _f1(param);
        }
        else
        {
            if (_p3 == 1)
            {
                vec2 param_1 = _p1;
                _t5 = _f0(param_1);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t5 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_2 = _p1;
                    if (_f2(param_2) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t5 = _p1;
                }
            }
        }
        return texture2D(_p0, _t5);
    }
    bool _202 = _p1.x < _p2.x;
    bool _212;
    if (!_202)
    {
        _212 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _212 = _202;
    }
    bool _222;
    if (!_212)
    {
        _222 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _222 = _212;
    }
    if (_222)
    {
        if (_p3 == 0)
        {
            vec2 param_3 = _p1;
            _t5 = _f1(param_3);
        }
        else
        {
            if (_p3 == 1)
            {
                vec2 param_4 = _p1;
                _t5 = _f0(param_4);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t5 = clamp(_p1, vec2(0.0), vec2(1.0));
                }
                else
                {
                    vec2 param_5 = _p1;
                    if (_f2(param_5) < 1.0)
                    {
                        return vec4(0.0);
                    }
                    _t5 = _p1;
                }
            }
        }
    }
    return texture2D(_p0, _t5);
}

void main()
{
    vec2 param = v_uv0;
    float param_1 = u_rotate;
    vec2 param_2 = u_offset;
    vec2 param_3 = u_scale;
    vec2 _306 = _f3(param, param_1, param_2, param_3);
    vec2 param_4 = _306;
    vec2 param_5 = u_padding;
    mediump int param_6 = u_edgeType;
    gl_FragData[0] = _f4(u_inputTex, param_4, param_5, param_6);
}

