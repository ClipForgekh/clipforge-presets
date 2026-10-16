precision highp float;
precision highp int;

uniform mediump sampler2D noiseTexture;
uniform float u_Brightness;
uniform float u_Contrast;
uniform vec4 u_ScreenParams;
uniform vec2 u_Scale;
uniform float u_Range;
uniform float u_type;
uniform float u_fix_type;
uniform float motion_tile_type;
uniform mediump sampler2D inputImageTexture;

varying vec2 uv0;

vec2 _f0(vec4 _p0)
{
    return vec2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

float _f3(inout float _p0, float _p1, float _p2)
{
    _p0 += _p1;
    _p0 = (((_p0 - 0.5) * _p2) * 10.0) + 0.5;
    return _p0;
}

float _f2(vec2 _p0)
{
    return ((step(0.0, _p0.x) * step(_p0.x, 1.0)) * step(0.0, _p0.y)) * step(_p0.y, 1.0);
}

vec2 _f1(vec2 _p0)
{
    return abs(mod(_p0 - vec2(1.0), vec2(2.0)) - vec2(1.0));
}

void main()
{
    vec4 param = texture2D(noiseTexture, uv0);
    vec2 _t2 = _f0(param);
    float _t3 = _t2.x;
    float _t4 = _t2.y;
    float param_1 = _t2.x;
    float param_2 = u_Brightness;
    float param_3 = u_Contrast;
    float _126 = _f3(param_1, param_2, param_3);
    _t3 = _126;
    float param_4 = _t4;
    float param_5 = u_Brightness;
    float param_6 = u_Contrast;
    float _133 = _f3(param_4, param_5, param_6);
    float _142 = min(u_ScreenParams.x, u_ScreenParams.y);
    _t3 = (((_t3 - 0.5) * _142) / u_ScreenParams.x) + 0.5;
    _t4 = (((_133 - 0.5) * _142) / u_ScreenParams.y) + 0.5;
    float _169 = clamp(u_Scale.x, 0.00999999977648258209228515625, 1.0) * u_Range;
    vec2 _t6 = uv0;
    if (u_type < 0.5)
    {
        _t6 = vec2(uv0.x + ((_t3 - 0.5) * _169), uv0.y + ((_t4 - 0.5) * _169));
    }
    else
    {
        if (u_type < 1.5)
        {
            _t6 = vec2(uv0.x + ((_t3 - 0.5) * _169), uv0.y);
        }
        else
        {
            if (u_type < 2.5)
            {
                _t6 = vec2(uv0.x, uv0.y + ((_t4 - 0.5) * _169));
            }
            else
            {
                _t6 = vec2(uv0.x + ((_t3 - 0.5) * _169), uv0.y + ((_t4 - 0.5) * _169));
            }
        }
    }
    if (u_fix_type < 0.5)
    {
    }
    else
    {
        if (u_fix_type < 1.5)
        {
            if (uv0.x < 0.100000001490116119384765625)
            {
                _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, uv0.x));
            }
            if (uv0.x > 0.89999997615814208984375)
            {
                _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.x));
            }
            if (uv0.y < 0.100000001490116119384765625)
            {
                _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, uv0.y));
            }
            if (uv0.y > 0.89999997615814208984375)
            {
                _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.y));
            }
        }
        else
        {
            if (u_fix_type < 2.5)
            {
                if (clamp(_t6.x, 0.0, 1.0) == _t6.x)
                {
                    if (uv0.y < 0.100000001490116119384765625)
                    {
                        _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, uv0.y));
                    }
                    if (uv0.y > 0.89999997615814208984375)
                    {
                        _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.y));
                    }
                }
            }
            else
            {
                if (u_fix_type < 3.5)
                {
                    if (clamp(_t6.y, 0.0, 1.0) == _t6.y)
                    {
                        if (uv0.x < 0.100000001490116119384765625)
                        {
                            _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, uv0.x));
                        }
                        if (uv0.x > 0.89999997615814208984375)
                        {
                            _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.x));
                        }
                    }
                }
                else
                {
                    if (u_fix_type < 4.5)
                    {
                        bool _423 = _t6.x <= 1.0;
                        bool _432;
                        if (_423)
                        {
                            _432 = clamp(_t6.y, 0.0, 1.0) == _t6.y;
                        }
                        else
                        {
                            _432 = _423;
                        }
                        if (_432)
                        {
                            if (uv0.x < 0.100000001490116119384765625)
                            {
                                _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, uv0.x));
                            }
                        }
                    }
                    else
                    {
                        if (u_fix_type < 5.5)
                        {
                            bool _459 = _t6.x >= 0.0;
                            bool _468;
                            if (_459)
                            {
                                _468 = clamp(_t6.y, 0.0, 1.0) == _t6.y;
                            }
                            else
                            {
                                _468 = _459;
                            }
                            if (_468)
                            {
                                if (uv0.x > 0.89999997615814208984375)
                                {
                                    _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.x));
                                }
                            }
                        }
                        else
                        {
                            if (u_fix_type < 6.5)
                            {
                                bool _496 = _t6.y >= 0.0;
                                bool _505;
                                if (_496)
                                {
                                    _505 = clamp(_t6.x, 0.0, 1.0) == _t6.x;
                                }
                                else
                                {
                                    _505 = _496;
                                }
                                if (_505)
                                {
                                    if (uv0.y > 0.89999997615814208984375)
                                    {
                                        _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.y));
                                    }
                                }
                            }
                            else
                            {
                                if (u_fix_type < 7.5)
                                {
                                    bool _533 = _t6.y <= 1.0;
                                    bool _542;
                                    if (_533)
                                    {
                                        _542 = clamp(_t6.x, 0.0, 1.0) == _t6.x;
                                    }
                                    else
                                    {
                                        _542 = _533;
                                    }
                                    if (_542)
                                    {
                                        if (uv0.y < 0.100000001490116119384765625)
                                        {
                                            _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, uv0.y));
                                        }
                                    }
                                }
                                else
                                {
                                    if (u_fix_type < 8.5)
                                    {
                                        bool _569 = uv0.x < 0.100000001490116119384765625;
                                        if (_569)
                                        {
                                            _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, uv0.x));
                                        }
                                        bool _585 = uv0.x > 0.89999997615814208984375;
                                        if (_585)
                                        {
                                            _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.x));
                                        }
                                        bool _602 = uv0.y < 0.100000001490116119384765625;
                                        if (_602)
                                        {
                                            _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, uv0.y));
                                        }
                                        bool _618 = uv0.y > 0.89999997615814208984375;
                                        if (_618)
                                        {
                                            _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.y));
                                        }
                                        float _t24 = 1.0;
                                        if (_569)
                                        {
                                            _t24 = min(_t24, uv0.x * 10.0);
                                        }
                                        if (_585)
                                        {
                                            _t24 = min(_t24, (1.0 - uv0.x) * 10.0);
                                        }
                                        if (_602)
                                        {
                                            _t24 = min(_t24, uv0.y * 10.0);
                                        }
                                        if (_618)
                                        {
                                            _t24 = min(_t24, (1.0 - uv0.y) * 10.0);
                                        }
                                        _t6 = mix(uv0, _t6, vec2(_t24));
                                    }
                                    else
                                    {
                                        if (u_fix_type < 9.5)
                                        {
                                            bool _689 = uv0.y < 0.100000001490116119384765625;
                                            if (_689)
                                            {
                                                _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, uv0.y));
                                            }
                                            bool _705 = uv0.y > 0.89999997615814208984375;
                                            if (_705)
                                            {
                                                _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.y));
                                            }
                                            float _t27 = 1.0;
                                            if (_689)
                                            {
                                                _t27 = min(_t27, uv0.y * 10.0);
                                            }
                                            if (_705)
                                            {
                                                _t27 = min(_t27, (1.0 - uv0.y) * 10.0);
                                            }
                                            _t6 = mix(uv0, _t6, vec2(_t27));
                                        }
                                        else
                                        {
                                            if (u_fix_type < 10.5)
                                            {
                                                bool _755 = uv0.x < 0.100000001490116119384765625;
                                                if (_755)
                                                {
                                                    _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, uv0.x));
                                                }
                                                bool _771 = uv0.x > 0.89999997615814208984375;
                                                if (_771)
                                                {
                                                    _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.x));
                                                }
                                                float _t30 = 1.0;
                                                if (_755)
                                                {
                                                    _t30 = min(_t30, uv0.x * 10.0);
                                                }
                                                if (_771)
                                                {
                                                    _t30 = min(_t30, (1.0 - uv0.x) * 10.0);
                                                }
                                                _t6 = mix(uv0, _t6, vec2(_t30));
                                            }
                                            else
                                            {
                                                if (u_fix_type < 11.5)
                                                {
                                                    bool _821 = uv0.x < 0.100000001490116119384765625;
                                                    if (_821)
                                                    {
                                                        _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, uv0.x));
                                                    }
                                                    float _t32 = 1.0;
                                                    if (_821)
                                                    {
                                                        _t32 = min(_t32, uv0.x * 10.0);
                                                    }
                                                    _t6 = mix(uv0, _t6, vec2(_t32));
                                                }
                                                else
                                                {
                                                    if (u_fix_type < 12.5)
                                                    {
                                                        bool _859 = uv0.x > 0.89999997615814208984375;
                                                        if (_859)
                                                        {
                                                            _t6.x = mix(uv0.x, _t6.x, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.x));
                                                        }
                                                        float _t34 = 1.0;
                                                        if (_859)
                                                        {
                                                            _t34 = min(_t34, (1.0 - uv0.x) * 10.0);
                                                        }
                                                        _t6 = mix(uv0, _t6, vec2(_t34));
                                                    }
                                                    else
                                                    {
                                                        if (u_fix_type < 13.5)
                                                        {
                                                            bool _899 = uv0.y > 0.89999997615814208984375;
                                                            if (_899)
                                                            {
                                                                _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, 1.0 - uv0.y));
                                                            }
                                                            float _t36 = 1.0;
                                                            if (_899)
                                                            {
                                                                _t36 = min(_t36, (1.0 - uv0.y) * 10.0);
                                                            }
                                                            _t6 = mix(uv0, _t6, vec2(_t36));
                                                        }
                                                        else
                                                        {
                                                            if (u_fix_type < 14.5)
                                                            {
                                                                bool _939 = uv0.y < 0.100000001490116119384765625;
                                                                if (_939)
                                                                {
                                                                    _t6.y = mix(uv0.y, _t6.y, smoothstep(0.0, 0.100000001490116119384765625, uv0.y));
                                                                }
                                                                float _t38 = 1.0;
                                                                if (_939)
                                                                {
                                                                    _t38 = min(_t38, uv0.y * 10.0);
                                                                }
                                                                _t6 = mix(uv0, _t6, vec2(_t38));
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    float _t39 = 1.0;
    if (motion_tile_type < 0.5)
    {
        vec2 param_7 = _t6;
        _t39 = _f2(param_7);
    }
    else
    {
        if (motion_tile_type < 1.5)
        {
            _t6 = fract(_t6);
        }
        else
        {
            vec2 param_8 = _t6;
            _t6 = _f1(param_8);
        }
    }
    gl_FragData[0] = texture2D(inputImageTexture, _t6) * _t39;
}

