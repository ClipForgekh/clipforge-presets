#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_ShowMode;
    float u_Intensity;
    int u_Combine;
    int u_GlowChannels;
    float3 u_ColorB;
    float u_Threshold;
    float3 u_ColorA;
};

constant float3 _1240 = {};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float _f5(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float _f4(thread const float3& _p0)
{
    float _203 = mix(_p0.z, _p0.y, step(_p0.z, _p0.y));
    return mix(_203, _p0.x, step(_203, _p0.x));
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0, thread const float& _p1)
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

static inline __attribute__((always_inline))
float3 _f1(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f0(param, param_1), _f0(param_2, param_3), _f0(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f2(thread const float& _p0, thread const float& _p1)
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

static inline __attribute__((always_inline))
float3 _f3(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f2(param, param_1), _f2(param_2, param_3), _f2(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f8(thread const float3& _p0)
{
    return fast::max(_p0.x, fast::max(_p0.y, _p0.z)) - fast::min(_p0.x, fast::min(_p0.y, _p0.z));
}

static inline __attribute__((always_inline))
float3 _f7(thread float3& _p0, thread const float& _p1)
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

static inline __attribute__((always_inline))
float3 _f9(thread float3& _p0, thread const float& _p1)
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
            float3 param = _p0;
            float param_1 = _p1;
            float3 _365 = _f7(param, param_1);
            _p0 = _365;
        }
        else
        {
            float3 param_2 = _p0.xzy;
            float param_3 = _p1;
            float3 _372 = _f7(param_2, param_3);
            _p0 = float3(_372.x, _372.z, _372.y);
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
                float3 param_4 = _p0.yxz;
                float param_5 = _p1;
                float3 _403 = _f7(param_4, param_5);
                _p0 = float3(_403.y, _403.x, _403.z);
            }
            else
            {
                float3 param_6 = _p0.yzx;
                float param_7 = _p1;
                float3 _412 = _f7(param_6, param_7);
                _p0 = float3(_412.z, _412.x, _412.y);
            }
        }
        else
        {
            if (_p0.x <= _p0.y)
            {
                float3 param_8 = _p0.zxy;
                float param_9 = _p1;
                float3 _428 = _f7(param_8, param_9);
                _p0 = float3(_428.y, _428.z, _428.x);
            }
            else
            {
                float3 param_10 = _p0.zyx;
                float param_11 = _p1;
                float3 _437 = _f7(param_10, param_11);
                _p0 = float3(_437.z, _437.y, _437.x);
            }
        }
    }
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f6(thread float3& _p0, thread float& _p1)
{
    float3 param = _p0;
    _p0 += float3(_p1 - _f5(param));
    float3 param_1 = _p0;
    _p1 = _f5(param_1);
    float _243 = fast::min(_p0.x, fast::min(_p0.y, _p0.z));
    float _246 = _p0.x;
    float _248 = _p0.y;
    float _250 = _p0.z;
    float _252 = fast::max(_246, fast::max(_248, _250));
    if (_243 < 0.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3(_p1 / (_p1 - _243)));
    }
    if (_252 > 1.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3((1.0 - _p1) / (_252 - _p1)));
    }
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f10(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f8(param);
    float3 _449 = _f9(param_1, param_2);
    float3 param_3 = _p1;
    float3 param_4 = _449;
    float param_5 = _f5(param_3);
    float3 _455 = _f6(param_4, param_5);
    return _455;
}

static inline __attribute__((always_inline))
float3 _f11(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p0;
    float3 param_1 = _p1;
    float param_2 = _f8(param);
    float3 _464 = _f9(param_1, param_2);
    float3 param_3 = _p1;
    float3 param_4 = _464;
    float param_5 = _f5(param_3);
    float3 _470 = _f6(param_4, param_5);
    return _470;
}

static inline __attribute__((always_inline))
float3 _f12(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f5(param);
    float3 _479 = _f6(param_1, param_2);
    return _479;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_InputTexture [[texture(0)]], texture2d<float> u_BlurTexture [[texture(1)]], sampler u_InputTextureSmplr [[sampler(0)]], sampler u_BlurTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _494 = u_InputTexture.sample(u_InputTextureSmplr, in.v_uv);
    float4 _t4 = _494;
    float4 _499 = u_BlurTexture.sample(u_BlurTextureSmplr, in.v_uv);
    float4 _t5 = _499;
    float _504 = (_t5.y * 2.0) - 1.0;
    float _511 = (1.0 - abs(_504)) * _t5.y;
    float _517 = step(_504, 0.0) * (0.5 - _511);
    if (buffer.u_ShowMode == 1)
    {
        out.o_fragColor = _499 * buffer.u_Intensity;
        if (buffer.u_Combine == 2)
        {
            out.o_fragColor = _499.xxxx * buffer.u_Intensity;
        }
        else
        {
            if (buffer.u_GlowChannels != 0)
            {
                out.o_fragColor = float4(float3(_511) * buffer.u_Intensity, 1.0);
            }
        }
        return out;
    }
    float4 _t9 = _499;
    bool _562 = buffer.u_GlowChannels != 0;
    if (_562)
    {
        if (buffer.u_Combine == 2)
        {
            _t9 = _499.xxxx;
        }
        else
        {
            _t9 = float4(_511);
        }
        float4 _577 = _t9;
        float3 _579 = _577.xyz * buffer.u_ColorB;
        _t9.x = _579.x;
        _t9.y = _579.y;
        _t9.z = _579.z;
    }
    float4 _587 = _t9;
    float3 _589 = _587.xyz * buffer.u_Intensity;
    _t9.x = _589.x;
    _t9.y = _589.y;
    _t9.z = _589.z;
    float4 _596 = _t9;
    float3 _600 = fast::clamp(_596.xyz, float3(0.0), float3(1.0));
    _t9.x = _600.x;
    _t9.y = _600.y;
    _t9.z = _600.z;
    float _t10 = 0.0;
    if (buffer.u_GlowChannels == 1)
    {
        _t10 = _t4.x;
    }
    else
    {
        if (buffer.u_GlowChannels == 2)
        {
            _t10 = _t4.y;
        }
        else
        {
            if (buffer.u_GlowChannels == 3)
            {
                _t10 = _t4.z;
            }
            else
            {
                if (buffer.u_GlowChannels == 4)
                {
                    _t10 = _t4.w;
                }
                else
                {
                    if (buffer.u_GlowChannels == 5)
                    {
                        float3 param = _494.xyz;
                        _t10 = _f5(param);
                    }
                    else
                    {
                        if (buffer.u_GlowChannels == 6)
                        {
                            float3 param_1 = _494.xyz;
                            _t10 = _f4(param_1);
                        }
                    }
                }
            }
        }
    }
    float4 _t11 = _494;
    if (buffer.u_Combine == 1)
    {
        float3 _668 = _t9.xyz + _494.xyz;
        _t11.x = _668.x;
        _t11.y = _668.y;
        _t11.z = _668.z;
    }
    else
    {
        if (buffer.u_Combine == 2)
        {
            float3 _684 = _t9.xyz * _494.xyz;
            _t11.x = _684.x;
            _t11.y = _684.y;
            _t11.z = _684.z;
        }
        else
        {
            if (buffer.u_Combine == 3)
            {
                float3 _701 = abs(_t9.xyz - _494.xyz);
                _t11.x = _701.x;
                _t11.y = _701.y;
                _t11.z = _701.z;
            }
            else
            {
                if (buffer.u_Combine == 4)
                {
                    if (_562)
                    {
                        float4 _718 = _t9;
                        float3 _721 = _718.xyz + float3(_517);
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
                    float3 _797 = float3(_731, _754, _777);
                    _t11.x = _797.x;
                    _t11.y = _797.y;
                    _t11.z = _797.z;
                }
                else
                {
                    if (buffer.u_Combine == 5)
                    {
                        if (_562)
                        {
                            float4 _814 = _t9;
                            float3 _817 = _814.xyz + float3(_517);
                            _t9.x = _817.x;
                            _t9.y = _817.y;
                            _t9.z = _817.z;
                        }
                        float4 _824 = _t9;
                        float3 _826 = _824.xyz * 2.0;
                        _t9.x = _826.x;
                        _t9.y = _826.y;
                        _t9.z = _826.z;
                        float3 _837 = fast::min(_t9.xyz, _494.xyz);
                        _t11.x = _837.x;
                        _t11.y = _837.y;
                        _t11.z = _837.z;
                    }
                    else
                    {
                        if (buffer.u_Combine == 6)
                        {
                            float3 _853 = fast::max(_t9.xyz, _494.xyz);
                            _t11.x = _853.x;
                            _t11.y = _853.y;
                            _t11.z = _853.z;
                        }
                        else
                        {
                            if (buffer.u_Combine == 7)
                            {
                                if (_562)
                                {
                                    float4 _871 = _t9;
                                    float3 _874 = _871.xyz + float3(_517);
                                    _t9.x = _874.x;
                                    _t9.y = _874.y;
                                    _t9.z = _874.z;
                                }
                                float3 param_2 = _t9.xyz;
                                float3 param_3 = _494.xyz;
                                float3 _887 = _f1(param_2, param_3);
                                _t11.x = _887.x;
                                _t11.y = _887.y;
                                _t11.z = _887.z;
                            }
                            else
                            {
                                if (buffer.u_Combine == 8)
                                {
                                    if (_562)
                                    {
                                        float4 _905 = _t9;
                                        float3 _908 = _905.xyz + float3(_517);
                                        _t9.x = _908.x;
                                        _t9.y = _908.y;
                                        _t9.z = _908.z;
                                    }
                                    float3 param_4 = _t9.xyz;
                                    float3 param_5 = _494.xyz;
                                    float3 _921 = _f3(param_4, param_5);
                                    _t11.x = _921.x;
                                    _t11.y = _921.y;
                                    _t11.z = _921.z;
                                }
                                else
                                {
                                    if (buffer.u_Combine == 9)
                                    {
                                        if (buffer.u_GlowChannels == 0)
                                        {
                                            _t11.x = _t9.xyz.x;
                                            _t11.y = _t9.xyz.y;
                                            _t11.z = _t9.xyz.z;
                                        }
                                        else
                                        {
                                            float3 _951 = _494.xyz;
                                            float3 _974 = mix(mix(_t9.xyz, (_t9.xyz + _951) - (_t9.xyz * _951), float3(fast::clamp(_t9.x, 0.0, 1.0))), _951, float3(fast::clamp(_517 * 2.0, 0.0, 1.0)));
                                            _t11.x = _974.x;
                                            _t11.y = _974.y;
                                            _t11.z = _974.z;
                                        }
                                    }
                                    else
                                    {
                                        if (buffer.u_Combine == 10)
                                        {
                                            if (buffer.u_GlowChannels == 0)
                                            {
                                                float3 param_6 = _t9.xyz;
                                                float3 param_7 = _494.xyz;
                                                float3 _997 = _f10(param_6, param_7);
                                                _t11.x = _997.x;
                                                _t11.y = _997.y;
                                                _t11.z = _997.z;
                                            }
                                            else
                                            {
                                                float4 _1006 = _t9;
                                                float3 _1009 = _1006.xyz + float3(_517);
                                                _t9.x = _1009.x;
                                                _t9.y = _1009.y;
                                                _t9.z = _1009.z;
                                                float3 param_8 = _t9.xyz;
                                                float3 _1021 = _494.xyz;
                                                float3 param_9 = _1021;
                                                float3 _1030 = mix(_f10(param_8, param_9), _1021, float3(fast::clamp(_t9.x * 2.0, 0.0, 1.0)));
                                                _t11.x = _1030.x;
                                                _t11.y = _1030.y;
                                                _t11.z = _1030.z;
                                            }
                                        }
                                        else
                                        {
                                            if (buffer.u_Combine == 11)
                                            {
                                                if (buffer.u_GlowChannels == 0)
                                                {
                                                    float3 param_10 = _t9.xyz;
                                                    float3 param_11 = _494.xyz;
                                                    float3 _1053 = _f11(param_10, param_11);
                                                    _t11.x = _1053.x;
                                                    _t11.y = _1053.y;
                                                    _t11.z = _1053.z;
                                                }
                                                else
                                                {
                                                    float4 _1062 = _t9;
                                                    float3 _1065 = _1062.xyz + float3(_517);
                                                    _t9.x = _1065.x;
                                                    _t9.y = _1065.y;
                                                    _t9.z = _1065.z;
                                                    float3 param_12 = _t9.xyz;
                                                    float3 _1077 = _494.xyz;
                                                    float3 param_13 = _1077;
                                                    float3 _1086 = mix(_f11(param_12, param_13), _1077, float3(fast::clamp(_t9.x * 2.0, 0.0, 1.0)));
                                                    _t11.x = _1086.x;
                                                    _t11.y = _1086.y;
                                                    _t11.z = _1086.z;
                                                }
                                            }
                                            else
                                            {
                                                if (buffer.u_Combine == 12)
                                                {
                                                    if (buffer.u_GlowChannels == 0)
                                                    {
                                                        float3 param_14 = _t9.xyz;
                                                        float3 param_15 = _494.xyz;
                                                        float3 _1109 = _f12(param_14, param_15);
                                                        _t11.x = _1109.x;
                                                        _t11.y = _1109.y;
                                                        _t11.z = _1109.z;
                                                    }
                                                    else
                                                    {
                                                        float4 _1118 = _t9;
                                                        float3 _1121 = _1118.xyz + float3(_517);
                                                        _t9.x = _1121.x;
                                                        _t9.y = _1121.y;
                                                        _t9.z = _1121.z;
                                                        float3 param_16 = _t9.xyz;
                                                        float3 _1133 = _494.xyz;
                                                        float3 param_17 = _1133;
                                                        float3 _1142 = mix(_f12(param_16, param_17), _1133, float3(fast::clamp(_t9.x * 2.0, 0.0, 1.0)));
                                                        _t11.x = _1142.x;
                                                        _t11.y = _1142.y;
                                                        _t11.z = _1142.z;
                                                    }
                                                }
                                                else
                                                {
                                                    float3 _1153 = _494.xyz;
                                                    float3 _1160 = (_t9.xyz + _1153) - (_t9.xyz * _1153);
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
        if (_t10 > buffer.u_Threshold)
        {
            float4 _1181 = _t11;
            float3 _1183 = _1181.xyz + (buffer.u_ColorA * _t10);
            _t11.x = _1183.x;
            _t11.y = _1183.y;
            _t11.z = _1183.z;
        }
        if (((((((((buffer.u_Combine == 2) || (buffer.u_Combine == 4)) || (buffer.u_Combine == 5)) || (buffer.u_Combine == 7)) || (buffer.u_Combine == 8)) || (buffer.u_Combine == 9)) || (buffer.u_Combine == 10)) || (buffer.u_Combine == 11)) || (buffer.u_Combine == 12))
        {
            _t11 = mix(_494, _t11, float4(fast::clamp(buffer.u_Intensity, 0.0, 1.0)));
        }
    }
    float4 _1224 = _t11;
    float _1227 = _t11.w;
    float3 _1230 = fast::clamp(_1224.xyz, float3(0.0), float3(_1227));
    _t11.x = _1230.x;
    _t11.y = _1230.y;
    _t11.z = _1230.z;
    out.o_fragColor = _t11;
    return out;
}

