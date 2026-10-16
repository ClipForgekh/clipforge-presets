precision highp float;
precision highp int;

uniform mediump vec2 FBS;
uniform mediump sampler2D inputImageTexture;

varying vec2 v_uv;
mediump float QUALITY[10];

void _f2()
{
    QUALITY[0] = 1.5;
    QUALITY[1] = 2.0;
    QUALITY[2] = 2.0;
    QUALITY[3] = 2.0;
    QUALITY[4] = 2.0;
    QUALITY[5] = 4.0;
    QUALITY[6] = 8.0;
}

mediump float _f0(mediump vec3 _p0)
{
    return sqrt(dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)));
}

mediump float _f1(mediump sampler2D _p0, mediump vec2 _p1)
{
    mediump vec3 param = texture2D(_p0, _p1).xyz;
    return _f0(param);
}

void main()
{
    _f2();
    mediump vec2 _78 = vec2(vec2(1.0) / FBS);
    mediump vec2 _t0 = _78;
    mediump vec2 _t1 = v_uv;
    mediump vec4 _88 = texture2D(inputImageTexture, v_uv);
    mediump vec3 param = _88.xyz;
    mediump float _96 = _f0(param);
    mediump vec2 param_1 = v_uv + (vec2(0.0, -1.0) * _78);
    mediump float _106 = _f1(inputImageTexture, param_1);
    mediump vec2 param_2 = v_uv + (vec2(0.0, 1.0) * _78);
    mediump float _114 = _f1(inputImageTexture, param_2);
    mediump vec2 param_3 = v_uv + (vec2(-1.0, 0.0) * _78);
    mediump float _122 = _f1(inputImageTexture, param_3);
    mediump vec2 param_4 = v_uv + (vec2(1.0, 0.0) * _78);
    mediump float _130 = _f1(inputImageTexture, param_4);
    mediump float _150 = max(_96, max(max(_106, _114), max(_122, _130)));
    mediump float _154 = _150 - min(_96, min(min(_106, _114), min(_122, _130)));
    if (_154 < max(0.031199999153614044189453125, _150 * 0.125))
    {
        gl_FragData[0] = _88;
        return;
    }
    mediump vec2 param_5 = v_uv + (vec2(-1.0) * _78);
    mediump float _176 = _f1(inputImageTexture, param_5);
    mediump vec2 param_6 = v_uv + (vec2(1.0) * _78);
    mediump float _184 = _f1(inputImageTexture, param_6);
    mediump vec2 param_7 = v_uv + (vec2(-1.0, 1.0) * _78);
    mediump float _192 = _f1(inputImageTexture, param_7);
    mediump vec2 param_8 = v_uv + (vec2(1.0, -1.0) * _78);
    mediump float _200 = _f1(inputImageTexture, param_8);
    mediump float _204 = _106 + _114;
    mediump float _208 = _122 + _130;
    mediump float _212 = _176 + _192;
    mediump float _220 = _200 + _184;
    mediump float _233 = (-2.0) * _96;
    bool _268 = ((abs(((-2.0) * _122) + _212) + (abs(_233 + _204) * 2.0)) + abs(((-2.0) * _130) + _220)) >= ((abs(((-2.0) * _114) + (_184 + _192)) + (abs(_233 + _208) * 2.0)) + abs(((-2.0) * _106) + (_176 + _200)));
    float _273 = _268 ? _106 : _122;
    float _278 = _268 ? _114 : _130;
    mediump float _289 = abs(_273 - _96);
    mediump float _291 = abs(_278 - _96);
    mediump float _300 = 0.25 * max(_289, _291);
    mediump float _303;
    if (_268)
    {
        _303 = _t0.y;
    }
    else
    {
        _303 = _t0.x;
    }
    mediump float _t31 = _303;
    mediump float _t32 = 0.0;
    if (_289 >= _291)
    {
        _t31 = -_t31;
        _t32 = 0.5 * (_273 + _96);
    }
    else
    {
        _t32 = 0.5 * (_278 + _96);
    }
    mediump vec2 _t33 = v_uv;
    if (_268)
    {
        _t33.y += (_t31 * 0.5);
    }
    else
    {
        _t33.x += (_t31 * 0.5);
    }
    mediump vec2 _350;
    if (_268)
    {
        _350 = vec2(_t0.x, 0.0);
    }
    else
    {
        _350 = vec2(0.0, _t0.y);
    }
    mediump vec2 _364 = _t33 - _350;
    mediump vec2 _t35 = _364;
    mediump vec2 _t36 = _t33 + _350;
    mediump vec3 param_9 = texture2D(inputImageTexture, _364).xyz;
    mediump float _t37 = _f0(param_9);
    mediump vec3 param_10 = texture2D(inputImageTexture, _t36).xyz;
    mediump float _384 = _t37;
    mediump float _385 = _384 - _t32;
    _t37 = _385;
    mediump float _388 = _f0(param_10) - _t32;
    mediump float _t38 = _388;
    bool _393 = abs(_385) >= _300;
    bool _t39 = _393;
    bool _398 = abs(_388) >= _300;
    bool _t40 = _398;
    bool _t41 = _393 && _398;
    if (!_393)
    {
        _t35 -= _350;
    }
    if (!_t40)
    {
        _t36 += _350;
    }
    if (!_t41)
    {
        for (mediump int _t42 = 2; _t42 < 12; _t42++)
        {
            if (!_t39)
            {
                mediump vec3 param_11 = texture2D(inputImageTexture, _t35).xyz;
                _t37 = _f0(param_11) - _t32;
            }
            if (!_t40)
            {
                mediump vec3 param_12 = texture2D(inputImageTexture, _t36).xyz;
                _t38 = _f0(param_12) - _t32;
            }
            bool _460 = abs(_t37) >= _300;
            _t39 = _460;
            bool _464 = abs(_t38) >= _300;
            _t40 = _464;
            _t41 = _460 && _464;
            if (!_460)
            {
                if (_t42 == 2)
                {
                    _t35 -= (_350 * QUALITY[2]);
                }
                else
                {
                    if (_t42 == 3)
                    {
                        _t35 -= (_350 * QUALITY[3]);
                    }
                    else
                    {
                        if (_t42 == 4)
                        {
                            _t35 -= (_350 * QUALITY[4]);
                        }
                        else
                        {
                            if (_t42 == 5)
                            {
                                _t35 -= (_350 * QUALITY[5]);
                            }
                            else
                            {
                                if (_t42 == 6)
                                {
                                    _t35 -= (_350 * QUALITY[6]);
                                }
                                else
                                {
                                    if (_t42 == 7)
                                    {
                                        _t35 -= (_350 * QUALITY[7]);
                                    }
                                    else
                                    {
                                        if (_t42 == 8)
                                        {
                                            _t35 -= (_350 * QUALITY[8]);
                                        }
                                        else
                                        {
                                            if (_t42 == 9)
                                            {
                                                _t35 -= (_350 * QUALITY[9]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (!_t40)
            {
                if (_t42 == 2)
                {
                    _t36 += (_350 * QUALITY[2]);
                }
                else
                {
                    if (_t42 == 3)
                    {
                        _t36 += (_350 * QUALITY[3]);
                    }
                    else
                    {
                        if (_t42 == 4)
                        {
                            _t36 += (_350 * QUALITY[4]);
                        }
                        else
                        {
                            if (_t42 == 5)
                            {
                                _t36 += (_350 * QUALITY[5]);
                            }
                            else
                            {
                                if (_t42 == 6)
                                {
                                    _t36 += (_350 * QUALITY[6]);
                                }
                                else
                                {
                                    if (_t42 == 7)
                                    {
                                        _t36 += (_350 * QUALITY[7]);
                                    }
                                    else
                                    {
                                        if (_t42 == 8)
                                        {
                                            _t36 += (_350 * QUALITY[8]);
                                        }
                                        else
                                        {
                                            if (_t42 == 9)
                                            {
                                                _t36 += (_350 * QUALITY[9]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (_t41)
            {
                break;
            }
        }
    }
    mediump float _661;
    if (_268)
    {
        _661 = _t1.x - _t35.x;
    }
    else
    {
        _661 = _t1.y - _t35.y;
    }
    mediump float _678;
    if (_268)
    {
        _678 = _t36.x - _t1.x;
    }
    else
    {
        _678 = _t36.y - _t1.y;
    }
    mediump float _745 = clamp(abs((0.083333335816860198974609375 * (((2.0 * (_204 + _208)) + _212) + _220)) - _96) / _154, 0.0, 1.0);
    mediump float _754 = ((((-2.0) * _745) + 3.0) * _745) * _745;
    mediump float _763 = max(((((_661 < _678) ? _t37 : _t38) < 0.0) != (_96 < _t32)) ? (((-min(_661, _678)) / (_661 + _678)) + 0.5) : 0.0, (_754 * _754) * 0.75);
    mediump vec2 _t56 = v_uv;
    if (_268)
    {
        _t56.y += (_763 * _t31);
    }
    else
    {
        _t56.x += (_763 * _t31);
    }
    gl_FragData[0] = texture2D(inputImageTexture, _t56);
}

