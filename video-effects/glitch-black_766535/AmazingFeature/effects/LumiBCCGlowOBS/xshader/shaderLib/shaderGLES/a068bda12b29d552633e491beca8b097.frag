precision highp float;
precision highp int;

uniform mediump sampler2D u_InputTexture;
uniform mediump sampler2D u_BlurTexture;
uniform mediump int u_ShowMode;
uniform float u_Intensity;
uniform mediump int u_Combine;
uniform mediump int u_GlowChannels;
uniform vec3 u_ColorB;
uniform float u_Threshold;
uniform vec3 u_ColorA;

varying vec2 v_uv;

vec3 _1240;

float _f5(vec3 _p0)
{
    return dot(_p0, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

float _f4(vec3 _p0)
{
    float _203 = mix(_p0.z, _p0.y, step(_p0.z, _p0.y));
    return mix(_203, _p0.x, step(_203, _p0.x));
}

float _f0(float _p0, float _p1)
{
    float _67;
    if (_p0 < 0.5)
    {
        _67 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _86;
        if (_p1 < 0.25)
        {
            _86 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _86 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _67 = _86;
    }
    return _67;
}

vec3 _f1(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f0(param, param_1), _f0(param_2, param_3), _f0(param_4, param_5));
}

float _f2(float _p0, float _p1)
{
    float _151;
    if (_p0 < 0.5)
    {
        _151 = (2.0 * _p0) * _p1;
    }
    else
    {
        _151 = 1.0 - ((2.0 * (1.0 - _p0)) * (1.0 - _p1));
    }
    return _151;
}

vec3 _f3(vec3 _p0, vec3 _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return vec3(_f2(param, param_1), _f2(param_2, param_3), _f2(param_4, param_5));
}

float _f8(vec3 _p0)
{
    return max(_p0.x, max(_p0.y, _p0.z)) - min(_p0.x, min(_p0.y, _p0.z));
}

vec3 _f7(inout vec3 _p0, float _p1)
{
    if (_p0.z > _p0.x)
    {
        _p0.y = ((_p0.y - _p0.x) * _p1) / (_p0.z - _p0.x);
        _p0.z = _p1;
    }
    else
    {
        _p0.y = 0.0;
        _p0.z = 0.0;
    }
    _p0.x = 0.0;
    return _p0;
}

vec3 _f9(inout vec3 _p0, float _p1)
{
    bool _343 = _p0.x <= _p0.y;
    bool _351;
    if (_343)
    {
        _351 = _p0.x <= _p0.z;
    }
    else
    {
        _351 = _343;
    }
    if (_351)
    {
        if (_p0.y <= _p0.z)
        {
            vec3 param = _p0;
            float param_1 = _p1;
            vec3 _365 = _f7(param, param_1);
            _p0 = _365;
        }
        else
        {
            vec3 param_2 = _p0.xzy;
            float param_3 = _p1;
            vec3 _372 = _f7(param_2, param_3);
            _p0 = vec3(_372.x, _372.z, _372.y);
        }
    }
    else
    {
        bool _380 = _p0.y <= _p0.x;
        bool _388;
        if (_380)
        {
            _388 = _p0.y <= _p0.z;
        }
        else
        {
            _388 = _380;
        }
        if (_388)
        {
            if (_p0.x <= _p0.z)
            {
                vec3 param_4 = _p0.yxz;
                float param_5 = _p1;
                vec3 _403 = _f7(param_4, param_5);
                _p0 = vec3(_403.y, _403.x, _403.z);
            }
            else
            {
                vec3 param_6 = _p0.yzx;
                float param_7 = _p1;
                vec3 _412 = _f7(param_6, param_7);
                _p0 = vec3(_412.z, _412.x, _412.y);
            }
        }
        else
        {
            if (_p0.x <= _p0.y)
            {
                vec3 param_8 = _p0.zxy;
                float param_9 = _p1;
                vec3 _428 = _f7(param_8, param_9);
                _p0 = vec3(_428.y, _428.z, _428.x);
            }
            else
            {
                vec3 param_10 = _p0.zyx;
                float param_11 = _p1;
                vec3 _437 = _f7(param_10, param_11);
                _p0 = vec3(_437.z, _437.y, _437.x);
            }
        }
    }
    return _p0;
}

vec3 _f6(inout vec3 _p0, inout float _p1)
{
    vec3 param = _p0;
    _p0 += vec3(_p1 - _f5(param));
    vec3 param_1 = _p0;
    _p1 = _f5(param_1);
    float _243 = min(_p0.x, min(_p0.y, _p0.z));
    float _246 = _p0.x;
    float _248 = _p0.y;
    float _250 = _p0.z;
    float _252 = max(_246, max(_248, _250));
    if (_243 < 0.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3(_p1 / (_p1 - _243)));
    }
    if (_252 > 1.0)
    {
        _p0 = mix(vec3(_p1, _p1, _p1), _p0, vec3((1.0 - _p1) / (_252 - _p1)));
    }
    return _p0;
}

vec3 _f10(vec3 _p0, vec3 _p1)
{
    vec3 param = _p1;
    vec3 param_1 = _p0;
    float param_2 = _f8(param);
    vec3 _449 = _f9(param_1, param_2);
    vec3 param_3 = _p1;
    vec3 param_4 = _449;
    float param_5 = _f5(param_3);
    vec3 _455 = _f6(param_4, param_5);
    return _455;
}

vec3 _f11(vec3 _p0, vec3 _p1)
{
    vec3 param = _p0;
    vec3 param_1 = _p1;
    float param_2 = _f8(param);
    vec3 _464 = _f9(param_1, param_2);
    vec3 param_3 = _p1;
    vec3 param_4 = _464;
    float param_5 = _f5(param_3);
    vec3 _470 = _f6(param_4, param_5);
    return _470;
}

vec3 _f12(vec3 _p0, vec3 _p1)
{
    vec3 param = _p1;
    vec3 param_1 = _p0;
    float param_2 = _f5(param);
    vec3 _479 = _f6(param_1, param_2);
    return _479;
}

void main()
{
    mediump vec4 _494 = texture2D(u_InputTexture, v_uv);
    vec4 _t4 = _494;
    mediump vec4 _499 = texture2D(u_BlurTexture, v_uv);
    vec4 _t5 = _499;
    float _504 = (_t5.y * 2.0) - 1.0;
    float _511 = (1.0 - abs(_504)) * _t5.y;
    float _517 = step(_504, 0.0) * (0.5 - _511);
    if (u_ShowMode == 1)
    {
        gl_FragData[0] = _499 * u_Intensity;
        if (u_Combine == 2)
        {
            gl_FragData[0] = _499.xxxx * u_Intensity;
        }
        else
        {
            if (u_GlowChannels != 0)
            {
                gl_FragData[0] = vec4(vec3(_511) * u_Intensity, 1.0);
            }
        }
        return;
    }
    vec4 _t9 = _499;
    bool _562 = u_GlowChannels != 0;
    if (_562)
    {
        if (u_Combine == 2)
        {
            _t9 = _499.xxxx;
        }
        else
        {
            _t9 = vec4(_511);
        }
        vec4 _577 = _t9;
        vec3 _579 = _577.xyz * u_ColorB;
        _t9.x = _579.x;
        _t9.y = _579.y;
        _t9.z = _579.z;
    }
    vec4 _587 = _t9;
    vec3 _589 = _587.xyz * u_Intensity;
    _t9.x = _589.x;
    _t9.y = _589.y;
    _t9.z = _589.z;
    vec4 _596 = _t9;
    vec3 _600 = clamp(_596.xyz, vec3(0.0), vec3(1.0));
    _t9.x = _600.x;
    _t9.y = _600.y;
    _t9.z = _600.z;
    float _t10 = 0.0;
    if (u_GlowChannels == 1)
    {
        _t10 = _t4.x;
    }
    else
    {
        if (u_GlowChannels == 2)
        {
            _t10 = _t4.y;
        }
        else
        {
            if (u_GlowChannels == 3)
            {
                _t10 = _t4.z;
            }
            else
            {
                if (u_GlowChannels == 4)
                {
                    _t10 = _t4.w;
                }
                else
                {
                    if (u_GlowChannels == 5)
                    {
                        vec3 param = _494.xyz;
                        _t10 = _f5(param);
                    }
                    else
                    {
                        if (u_GlowChannels == 6)
                        {
                            vec3 param_1 = _494.xyz;
                            _t10 = _f4(param_1);
                        }
                    }
                }
            }
        }
    }
    vec4 _t11 = _494;
    if (u_Combine == 1)
    {
        vec3 _668 = _t9.xyz + _494.xyz;
        _t11.x = _668.x;
        _t11.y = _668.y;
        _t11.z = _668.z;
    }
    else
    {
        if (u_Combine == 2)
        {
            vec3 _684 = _t9.xyz * _494.xyz;
            _t11.x = _684.x;
            _t11.y = _684.y;
            _t11.z = _684.z;
        }
        else
        {
            if (u_Combine == 3)
            {
                vec3 _701 = abs(_t9.xyz - _494.xyz);
                _t11.x = _701.x;
                _t11.y = _701.y;
                _t11.z = _701.z;
            }
            else
            {
                if (u_Combine == 4)
                {
                    if (_562)
                    {
                        vec4 _718 = _t9;
                        vec3 _721 = _718.xyz + vec3(_517);
                        _t9.x = _721.x;
                        _t9.y = _721.y;
                        _t9.z = _721.z;
                    }
                    float _731;
                    if (_t4.x < 0.5)
                    {
                        _731 = (2.0 * _t4.x) * _t9.x;
                    }
                    else
                    {
                        _731 = 1.0 - ((2.0 * (1.0 - _t4.x)) * (1.0 - _t9.x));
                    }
                    float _754;
                    if (_t4.y < 0.5)
                    {
                        _754 = (2.0 * _t4.y) * _t9.y;
                    }
                    else
                    {
                        _754 = 1.0 - ((2.0 * (1.0 - _t4.y)) * (1.0 - _t9.y));
                    }
                    float _777;
                    if (_t4.z < 0.5)
                    {
                        _777 = (2.0 * _t4.z) * _t9.z;
                    }
                    else
                    {
                        _777 = 1.0 - ((2.0 * (1.0 - _t4.z)) * (1.0 - _t9.z));
                    }
                    vec3 _797 = vec3(_731, _754, _777);
                    _t11.x = _797.x;
                    _t11.y = _797.y;
                    _t11.z = _797.z;
                }
                else
                {
                    if (u_Combine == 5)
                    {
                        if (_562)
                        {
                            vec4 _814 = _t9;
                            vec3 _817 = _814.xyz + vec3(_517);
                            _t9.x = _817.x;
                            _t9.y = _817.y;
                            _t9.z = _817.z;
                        }
                        vec4 _824 = _t9;
                        vec3 _826 = _824.xyz * 2.0;
                        _t9.x = _826.x;
                        _t9.y = _826.y;
                        _t9.z = _826.z;
                        vec3 _837 = min(_t9.xyz, _494.xyz);
                        _t11.x = _837.x;
                        _t11.y = _837.y;
                        _t11.z = _837.z;
                    }
                    else
                    {
                        if (u_Combine == 6)
                        {
                            vec3 _853 = max(_t9.xyz, _494.xyz);
                            _t11.x = _853.x;
                            _t11.y = _853.y;
                            _t11.z = _853.z;
                        }
                        else
                        {
                            if (u_Combine == 7)
                            {
                                if (_562)
                                {
                                    vec4 _871 = _t9;
                                    vec3 _874 = _871.xyz + vec3(_517);
                                    _t9.x = _874.x;
                                    _t9.y = _874.y;
                                    _t9.z = _874.z;
                                }
                                vec3 param_2 = _t9.xyz;
                                vec3 param_3 = _494.xyz;
                                vec3 _887 = _f1(param_2, param_3);
                                _t11.x = _887.x;
                                _t11.y = _887.y;
                                _t11.z = _887.z;
                            }
                            else
                            {
                                if (u_Combine == 8)
                                {
                                    if (_562)
                                    {
                                        vec4 _905 = _t9;
                                        vec3 _908 = _905.xyz + vec3(_517);
                                        _t9.x = _908.x;
                                        _t9.y = _908.y;
                                        _t9.z = _908.z;
                                    }
                                    vec3 param_4 = _t9.xyz;
                                    vec3 param_5 = _494.xyz;
                                    vec3 _921 = _f3(param_4, param_5);
                                    _t11.x = _921.x;
                                    _t11.y = _921.y;
                                    _t11.z = _921.z;
                                }
                                else
                                {
                                    if (u_Combine == 9)
                                    {
                                        if (u_GlowChannels == 0)
                                        {
                                            _t11.x = _t9.xyz.x;
                                            _t11.y = _t9.xyz.y;
                                            _t11.z = _t9.xyz.z;
                                        }
                                        else
                                        {
                                            vec3 _951 = _494.xyz;
                                            vec3 _974 = mix(mix(_t9.xyz, (_t9.xyz + _951) - (_t9.xyz * _951), vec3(clamp(_t9.x, 0.0, 1.0))), _951, vec3(clamp(_517 * 2.0, 0.0, 1.0)));
                                            _t11.x = _974.x;
                                            _t11.y = _974.y;
                                            _t11.z = _974.z;
                                        }
                                    }
                                    else
                                    {
                                        if (u_Combine == 10)
                                        {
                                            if (u_GlowChannels == 0)
                                            {
                                                vec3 param_6 = _t9.xyz;
                                                vec3 param_7 = _494.xyz;
                                                vec3 _997 = _f10(param_6, param_7);
                                                _t11.x = _997.x;
                                                _t11.y = _997.y;
                                                _t11.z = _997.z;
                                            }
                                            else
                                            {
                                                vec4 _1006 = _t9;
                                                vec3 _1009 = _1006.xyz + vec3(_517);
                                                _t9.x = _1009.x;
                                                _t9.y = _1009.y;
                                                _t9.z = _1009.z;
                                                vec3 param_8 = _t9.xyz;
                                                vec3 _1021 = _494.xyz;
                                                vec3 param_9 = _1021;
                                                vec3 _1030 = mix(_f10(param_8, param_9), _1021, vec3(clamp(_t9.x * 2.0, 0.0, 1.0)));
                                                _t11.x = _1030.x;
                                                _t11.y = _1030.y;
                                                _t11.z = _1030.z;
                                            }
                                        }
                                        else
                                        {
                                            if (u_Combine == 11)
                                            {
                                                if (u_GlowChannels == 0)
                                                {
                                                    vec3 param_10 = _t9.xyz;
                                                    vec3 param_11 = _494.xyz;
                                                    vec3 _1053 = _f11(param_10, param_11);
                                                    _t11.x = _1053.x;
                                                    _t11.y = _1053.y;
                                                    _t11.z = _1053.z;
                                                }
                                                else
                                                {
                                                    vec4 _1062 = _t9;
                                                    vec3 _1065 = _1062.xyz + vec3(_517);
                                                    _t9.x = _1065.x;
                                                    _t9.y = _1065.y;
                                                    _t9.z = _1065.z;
                                                    vec3 param_12 = _t9.xyz;
                                                    vec3 _1077 = _494.xyz;
                                                    vec3 param_13 = _1077;
                                                    vec3 _1086 = mix(_f11(param_12, param_13), _1077, vec3(clamp(_t9.x * 2.0, 0.0, 1.0)));
                                                    _t11.x = _1086.x;
                                                    _t11.y = _1086.y;
                                                    _t11.z = _1086.z;
                                                }
                                            }
                                            else
                                            {
                                                if (u_Combine == 12)
                                                {
                                                    if (u_GlowChannels == 0)
                                                    {
                                                        vec3 param_14 = _t9.xyz;
                                                        vec3 param_15 = _494.xyz;
                                                        vec3 _1109 = _f12(param_14, param_15);
                                                        _t11.x = _1109.x;
                                                        _t11.y = _1109.y;
                                                        _t11.z = _1109.z;
                                                    }
                                                    else
                                                    {
                                                        vec4 _1118 = _t9;
                                                        vec3 _1121 = _1118.xyz + vec3(_517);
                                                        _t9.x = _1121.x;
                                                        _t9.y = _1121.y;
                                                        _t9.z = _1121.z;
                                                        vec3 param_16 = _t9.xyz;
                                                        vec3 _1133 = _494.xyz;
                                                        vec3 param_17 = _1133;
                                                        vec3 _1142 = mix(_f12(param_16, param_17), _1133, vec3(clamp(_t9.x * 2.0, 0.0, 1.0)));
                                                        _t11.x = _1142.x;
                                                        _t11.y = _1142.y;
                                                        _t11.z = _1142.z;
                                                    }
                                                }
                                                else
                                                {
                                                    vec3 _1153 = _494.xyz;
                                                    vec3 _1160 = (_t9.xyz + _1153) - (_t9.xyz * _1153);
                                                    _t11.x = _1160.x;
                                                    _t11.y = _1160.y;
                                                    _t11.z = _1160.z;
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
    if (_562)
    {
        if (_t10 > u_Threshold)
        {
            vec4 _1181 = _t11;
            vec3 _1183 = _1181.xyz + (u_ColorA * _t10);
            _t11.x = _1183.x;
            _t11.y = _1183.y;
            _t11.z = _1183.z;
        }
        if (((((((((u_Combine == 2) || (u_Combine == 4)) || (u_Combine == 5)) || (u_Combine == 7)) || (u_Combine == 8)) || (u_Combine == 9)) || (u_Combine == 10)) || (u_Combine == 11)) || (u_Combine == 12))
        {
            _t11 = mix(_494, _t11, vec4(clamp(u_Intensity, 0.0, 1.0)));
        }
    }
    vec4 _1224 = _t11;
    float _1227 = _t11.w;
    vec3 _1230 = clamp(_1224.xyz, vec3(0.0), vec3(_1227));
    _t11.x = _1230.x;
    _t11.y = _1230.y;
    _t11.z = _1230.z;
    gl_FragData[0] = _t11;
}

