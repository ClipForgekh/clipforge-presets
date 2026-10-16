#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_scale;
    float u_depth;
    float u_soft;
    float4 u_light;
    float4 u_upperColor;
    float u_upperAlpha;
    float4 u_lowerColor;
    float u_lowerAlpha;
    int u_lowerBlendMode;
    int u_upperBlendMode;
};

constant float3 _1926 = {};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float4 _f1(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1)
{
    return _p0.sample(_p0Smplr, fast::clamp(_p1, float2(0.0), float2(1.0)));
}

static inline __attribute__((always_inline))
float _f2(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1)
{
    float2 param = _p1;
    float4 _t0 = _f1(_p0, _p0Smplr, param);
    return ((_t0.x + (_t0.y / 255.0)) + (_t0.z / 65025.0)) + (_t0.w / 16581375.0);
}

static inline __attribute__((always_inline))
float3 _f3(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float2& _p2, thread const float& _p3, thread const float& _p4)
{
    float2 param = (_p1 + float2(1.0, 0.0)) * _p2;
    float2 param_1 = (_p1 - float2(1.0, 0.0)) * _p2;
    float _t3 = _f2(_p0, _p0Smplr, param) - _f2(_p0, _p0Smplr, param_1);
    float2 param_2 = (_p1 + float2(0.0, 1.0)) * _p2;
    float2 param_3 = (_p1 - float2(0.0, 1.0)) * _p2;
    float _t4 = _f2(_p0, _p0Smplr, param_2) - _f2(_p0, _p0Smplr, param_3);
    float _t5 = 1.0;
    for (int _t6 = 0; _t6 < 1024; _t6++)
    {
        float _282 = float(_t6);
        if (_282 > _p4)
        {
            break;
        }
        float2 _292 = float2(_282, 0.0);
        float2 _293 = _p1 - _292;
        float2 param_4 = (_293 + float2(1.0, 0.0)) * _p2;
        float2 param_5 = (_293 - float2(1.0, 0.0)) * _p2;
        _t3 += (_f2(_p0, _p0Smplr, param_4) - _f2(_p0, _p0Smplr, param_5));
        float2 _313 = _p1 + _292;
        float2 param_6 = (_313 + float2(1.0, 0.0)) * _p2;
        float2 param_7 = (_313 - float2(1.0, 0.0)) * _p2;
        _t3 += (_f2(_p0, _p0Smplr, param_6) - _f2(_p0, _p0Smplr, param_7));
        float2 _332 = float2(0.0, _282);
        float2 _333 = _p1 - _332;
        float2 param_8 = (_333 + float2(0.0, 1.0)) * _p2;
        float2 param_9 = (_333 - float2(0.0, 1.0)) * _p2;
        _t4 += (_f2(_p0, _p0Smplr, param_8) - _f2(_p0, _p0Smplr, param_9));
        float2 _353 = _p1 + _332;
        float2 param_10 = (_353 + float2(0.0, 1.0)) * _p2;
        float2 param_11 = (_353 - float2(0.0, 1.0)) * _p2;
        _t4 += (_f2(_p0, _p0Smplr, param_10) - _f2(_p0, _p0Smplr, param_11));
        _t5 += 2.0;
    }
    float _376 = _t3;
    float _379 = _t4;
    float _383 = (_376 / _t5) * _p3;
    _t3 = _383;
    float _386 = (_379 / _t5) * _p3;
    _t4 = _386;
    return fast::normalize(cross(float3(2.0, 0.0, _383), float3(0.0, 2.0, _386)));
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    return fract(sin(dot(_p0, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float _f19(thread const float& _p0, thread const float& _p1)
{
    if (_p1 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        if (_p0 <= 0.0)
        {
            return 0.0;
        }
        else
        {
            return 1.0 - fast::min(1.0, (1.0 - _p1) / _p0);
        }
    }
}

static inline __attribute__((always_inline))
float3 _f20(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f19(param, param_1), _f19(param_2, param_3), _f19(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f21(thread const float& _p0, thread const float& _p1)
{
    return fast::max(0.0, (_p1 + _p0) - 1.0);
}

static inline __attribute__((always_inline))
float3 _f22(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f21(param, param_1), _f21(param_2, param_3), _f21(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f8(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float3 _f16(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    return select(_p0, _p1, bool3(_f8(param) <= _f8(param_1)));
}

static inline __attribute__((always_inline))
float _f23(thread const float& _p0, thread const float& _p1)
{
    if (_p1 <= 0.0)
    {
        return 0.0;
    }
    if (_p0 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        return fast::min(1.0, _p1 / (1.0 - _p0));
    }
}

static inline __attribute__((always_inline))
float3 _f24(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f23(param, param_1), _f23(param_2, param_3), _f23(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f25(thread const float& _p0, thread const float& _p1)
{
    return fast::min(1.0, _p1 + _p0);
}

static inline __attribute__((always_inline))
float3 _f26(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f25(param, param_1), _f25(param_2, param_3), _f25(param_4, param_5));
}

static inline __attribute__((always_inline))
float3 _f17(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    return select(_p0, _p1, bool3(_f8(param) > _f8(param_1)));
}

static inline __attribute__((always_inline))
float _f4(thread const float& _p0, thread const float& _p1)
{
    float _398;
    if (_p0 < 0.5)
    {
        _398 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _415;
        if (_p1 < 0.25)
        {
            _415 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _415 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _398 = _415;
    }
    return _398;
}

static inline __attribute__((always_inline))
float3 _f5(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f4(param, param_1), _f4(param_2, param_3), _f4(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f6(thread const float& _p0, thread const float& _p1)
{
    float _476;
    if (_p0 < 0.5)
    {
        _476 = (2.0 * _p0) * _p1;
    }
    else
    {
        _476 = 1.0 - ((2.0 * (1.0 - _p0)) * (1.0 - _p1));
    }
    return _476;
}

static inline __attribute__((always_inline))
float3 _f7(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f6(param, param_1), _f6(param_2, param_3), _f6(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f27(thread const float& _p0, thread const float& _p1)
{
    float _970;
    if (_p0 <= 0.5)
    {
        float param = _p1;
        float param_1 = 2.0 * _p0;
        _970 = _f19(param, param_1);
    }
    else
    {
        float param_2 = _p1;
        float param_3 = 2.0 * (_p0 - 0.5);
        _970 = _f23(param_2, param_3);
    }
    return _970;
}

static inline __attribute__((always_inline))
float3 _f28(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f27(param, param_1), _f27(param_2, param_3), _f27(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f29(thread const float& _p0, thread const float& _p1)
{
    float _1016;
    if (_p0 <= 0.5)
    {
        float param = _p1;
        float param_1 = 2.0 * _p0;
        _1016 = _f21(param, param_1);
    }
    else
    {
        float param_2 = _p1;
        float param_3 = 2.0 * (_p0 - 0.5);
        _1016 = _f25(param_2, param_3);
    }
    return _1016;
}

static inline __attribute__((always_inline))
float3 _f30(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f29(param, param_1), _f29(param_2, param_3), _f29(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f31(thread const float& _p0, thread const float& _p1)
{
    float _1062;
    if (_p0 <= 0.5)
    {
        _1062 = fast::min(_p1, 2.0 * _p0);
    }
    else
    {
        _1062 = fast::max(_p1, 2.0 * (_p0 - 0.5));
    }
    return _1062;
}

static inline __attribute__((always_inline))
float3 _f32(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f31(param, param_1), _f31(param_2, param_3), _f31(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f33(thread const float& _p0, thread const float& _p1)
{
    return float((_p1 + _p0) >= 1.0);
}

static inline __attribute__((always_inline))
float3 _f34(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f33(param, param_1), _f33(param_2, param_3), _f33(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f11(thread const float3& _p0)
{
    return fast::max(_p0.x, fast::max(_p0.y, _p0.z)) - fast::min(_p0.x, fast::min(_p0.y, _p0.z));
}

static inline __attribute__((always_inline))
float3 _f10(thread float3& _p0, thread const float& _p1)
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
float3 _f12(thread float3& _p0, thread const float& _p1)
{
    bool _646 = _p0.x <= _p0.y;
    bool _654;
    if (_646)
    {
        _654 = _p0.x <= _p0.z;
    }
    else
    {
        _654 = _646;
    }
    if (_654)
    {
        if (_p0.y <= _p0.z)
        {
            float3 param = _p0;
            float param_1 = _p1;
            float3 _668 = _f10(param, param_1);
            _p0 = _668;
        }
        else
        {
            float3 param_2 = _p0.xzy;
            float param_3 = _p1;
            float3 _675 = _f10(param_2, param_3);
            _p0 = float3(_675.x, _675.z, _675.y);
        }
    }
    else
    {
        bool _683 = _p0.y <= _p0.x;
        bool _691;
        if (_683)
        {
            _691 = _p0.y <= _p0.z;
        }
        else
        {
            _691 = _683;
        }
        if (_691)
        {
            if (_p0.x <= _p0.z)
            {
                float3 param_4 = _p0.yxz;
                float param_5 = _p1;
                float3 _706 = _f10(param_4, param_5);
                _p0 = float3(_706.y, _706.x, _706.z);
            }
            else
            {
                float3 param_6 = _p0.yzx;
                float param_7 = _p1;
                float3 _715 = _f10(param_6, param_7);
                _p0 = float3(_715.z, _715.x, _715.y);
            }
        }
        else
        {
            if (_p0.x <= _p0.y)
            {
                float3 param_8 = _p0.zxy;
                float param_9 = _p1;
                float3 _731 = _f10(param_8, param_9);
                _p0 = float3(_731.y, _731.z, _731.x);
            }
            else
            {
                float3 param_10 = _p0.zyx;
                float param_11 = _p1;
                float3 _740 = _f10(param_10, param_11);
                _p0 = float3(_740.z, _740.y, _740.x);
            }
        }
    }
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f9(thread float3& _p0, thread float& _p1)
{
    float3 param = _p0;
    _p0 += float3(_p1 - _f8(param));
    float3 param_1 = _p0;
    _p1 = _f8(param_1);
    float _547 = fast::min(_p0.x, fast::min(_p0.y, _p0.z));
    float _550 = _p0.x;
    float _552 = _p0.y;
    float _554 = _p0.z;
    float _556 = fast::max(_550, fast::max(_552, _554));
    if (_547 < 0.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3(_p1 / (_p1 - _547)));
    }
    if (_556 > 1.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3((1.0 - _p1) / (_556 - _p1)));
    }
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f13(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f11(param);
    float3 _752 = _f12(param_1, param_2);
    float3 param_3 = _p1;
    float3 param_4 = _752;
    float param_5 = _f8(param_3);
    float3 _758 = _f9(param_4, param_5);
    return _758;
}

static inline __attribute__((always_inline))
float3 _f14(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p0;
    float3 param_1 = _p1;
    float param_2 = _f11(param);
    float3 _767 = _f12(param_1, param_2);
    float3 param_3 = _p1;
    float3 param_4 = _767;
    float param_5 = _f8(param_3);
    float3 _773 = _f9(param_4, param_5);
    return _773;
}

static inline __attribute__((always_inline))
float3 _f15(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f8(param);
    float3 _782 = _f9(param_1, param_2);
    return _782;
}

static inline __attribute__((always_inline))
float3 _f18(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p0;
    float3 param_1 = _p1;
    float param_2 = _f8(param);
    float3 _818 = _f9(param_1, param_2);
    return _818;
}

static inline __attribute__((always_inline))
float _f35(thread const float& _p0, thread const float& _p1)
{
    float _1135;
    if (_p0 > 0.0)
    {
        _1135 = fast::min(1.0, _p1 / _p0);
    }
    else
    {
        _1135 = 1.0;
    }
    return _1135;
}

static inline __attribute__((always_inline))
float3 _f36(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f35(param, param_1), _f35(param_2, param_3), _f35(param_4, param_5));
}

static inline __attribute__((always_inline))
float4 _f37(thread const int& _p0, thread float4& _p1, thread const float4& _p2, thread float2& v_uv)
{
    float _1171 = _p1.w;
    float4 _1174 = _p1;
    float3 _1177 = _1174.xyz / float3(fast::max(_1171, 0.001000000047497451305389404296875));
    _p1.x = _1177.x;
    _p1.y = _1177.y;
    _p1.z = _1177.z;
    float4 _t15 = _p2;
    if (_p0 == 0)
    {
        _t15.x = _p2.xyz.x;
        _t15.y = _p2.xyz.y;
        _t15.z = _p2.xyz.z;
    }
    else
    {
        if (_p0 == 1)
        {
            bool _1205 = _p2.w == 1.0;
            bool _1223;
            if (!_1205)
            {
                bool _1211 = _p2.w > 0.0;
                bool _1222;
                if (_1211)
                {
                    float2 param = v_uv;
                    _1222 = _p2.w > _f0(param);
                }
                else
                {
                    _1222 = _1211;
                }
                _1223 = _1222;
            }
            else
            {
                _1223 = _1205;
            }
            if (_1223)
            {
                _t15.x = _p2.xyz.x;
                _t15.y = _p2.xyz.y;
                _t15.z = _p2.xyz.z;
            }
        }
        else
        {
            if (_p0 == 2)
            {
                float3 _1244 = fast::min(_p2.xyz, _p1.xyz);
                _t15.x = _1244.x;
                _t15.y = _1244.y;
                _t15.z = _1244.z;
            }
            else
            {
                if (_p0 == 3)
                {
                    float3 _1261 = _p2.xyz * _p1.xyz;
                    _t15.x = _1261.x;
                    _t15.y = _1261.y;
                    _t15.z = _1261.z;
                }
                else
                {
                    if (_p0 == 4)
                    {
                        float3 param_1 = _p2.xyz;
                        float3 param_2 = _p1.xyz;
                        float3 _1280 = _f20(param_1, param_2);
                        _t15.x = _1280.x;
                        _t15.y = _1280.y;
                        _t15.z = _1280.z;
                    }
                    else
                    {
                        if (_p0 == 5)
                        {
                            float3 param_3 = _p2.xyz;
                            float3 param_4 = _p1.xyz;
                            float3 _1299 = _f22(param_3, param_4);
                            _t15.x = _1299.x;
                            _t15.y = _1299.y;
                            _t15.z = _1299.z;
                        }
                        else
                        {
                            if (_p0 == 6)
                            {
                                float3 param_5 = _p2.xyz;
                                float3 param_6 = _p1.xyz;
                                float3 _1318 = _f16(param_5, param_6);
                                _t15.x = _1318.x;
                                _t15.y = _1318.y;
                                _t15.z = _1318.z;
                            }
                            else
                            {
                                if (_p0 == 7)
                                {
                                    float3 _1335 = fast::max(_p2.xyz, _p1.xyz);
                                    _t15.x = _1335.x;
                                    _t15.y = _1335.y;
                                    _t15.z = _1335.z;
                                }
                                else
                                {
                                    if (_p0 == 8)
                                    {
                                        float3 _1358 = (_p2.xyz + _p1.xyz) - (_p2.xyz * _p1.xyz);
                                        _t15.x = _1358.x;
                                        _t15.y = _1358.y;
                                        _t15.z = _1358.z;
                                    }
                                    else
                                    {
                                        if (_p0 == 9)
                                        {
                                            float3 param_7 = _p2.xyz;
                                            float3 param_8 = _p1.xyz;
                                            float3 _1377 = _f24(param_7, param_8);
                                            _t15.x = _1377.x;
                                            _t15.y = _1377.y;
                                            _t15.z = _1377.z;
                                        }
                                        else
                                        {
                                            if (_p0 == 10)
                                            {
                                                float3 param_9 = _p2.xyz;
                                                float3 param_10 = _p1.xyz;
                                                float3 _1396 = _f26(param_9, param_10);
                                                _t15.x = _1396.x;
                                                _t15.y = _1396.y;
                                                _t15.z = _1396.z;
                                            }
                                            else
                                            {
                                                if (_p0 == 11)
                                                {
                                                    float3 param_11 = _p2.xyz;
                                                    float3 param_12 = _p1.xyz;
                                                    float3 _1415 = _f17(param_11, param_12);
                                                    _t15.x = _1415.x;
                                                    _t15.y = _1415.y;
                                                    _t15.z = _1415.z;
                                                }
                                                else
                                                {
                                                    if (_p0 == 12)
                                                    {
                                                        float _1431;
                                                        if (_p1.x < 0.5)
                                                        {
                                                            _1431 = (2.0 * _p1.x) * _p2.x;
                                                        }
                                                        else
                                                        {
                                                            _1431 = 1.0 - ((2.0 * (1.0 - _p1.x)) * (1.0 - _p2.x));
                                                        }
                                                        float _1454;
                                                        if (_p1.y < 0.5)
                                                        {
                                                            _1454 = (2.0 * _p1.y) * _p2.y;
                                                        }
                                                        else
                                                        {
                                                            _1454 = 1.0 - ((2.0 * (1.0 - _p1.y)) * (1.0 - _p2.y));
                                                        }
                                                        float _1477;
                                                        if (_p1.z < 0.5)
                                                        {
                                                            _1477 = (2.0 * _p1.z) * _p2.z;
                                                        }
                                                        else
                                                        {
                                                            _1477 = 1.0 - ((2.0 * (1.0 - _p1.z)) * (1.0 - _p2.z));
                                                        }
                                                        float3 _1497 = float3(_1431, _1454, _1477);
                                                        _t15.x = _1497.x;
                                                        _t15.y = _1497.y;
                                                        _t15.z = _1497.z;
                                                    }
                                                    else
                                                    {
                                                        if (_p0 == 13)
                                                        {
                                                            float3 param_13 = _p2.xyz;
                                                            float3 param_14 = _p1.xyz;
                                                            float3 _1516 = _f5(param_13, param_14);
                                                            _t15.x = _1516.x;
                                                            _t15.y = _1516.y;
                                                            _t15.z = _1516.z;
                                                        }
                                                        else
                                                        {
                                                            if (_p0 == 14)
                                                            {
                                                                float3 param_15 = _p2.xyz;
                                                                float3 param_16 = _p1.xyz;
                                                                float3 _1535 = _f7(param_15, param_16);
                                                                _t15.x = _1535.x;
                                                                _t15.y = _1535.y;
                                                                _t15.z = _1535.z;
                                                            }
                                                            else
                                                            {
                                                                if (_p0 == 15)
                                                                {
                                                                    float3 param_17 = _p2.xyz;
                                                                    float3 param_18 = _p1.xyz;
                                                                    float3 _1554 = _f28(param_17, param_18);
                                                                    _t15.x = _1554.x;
                                                                    _t15.y = _1554.y;
                                                                    _t15.z = _1554.z;
                                                                }
                                                                else
                                                                {
                                                                    if (_p0 == 16)
                                                                    {
                                                                        float3 param_19 = _p2.xyz;
                                                                        float3 param_20 = _p1.xyz;
                                                                        float3 _1573 = _f30(param_19, param_20);
                                                                        _t15.x = _1573.x;
                                                                        _t15.y = _1573.y;
                                                                        _t15.z = _1573.z;
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_p0 == 17)
                                                                        {
                                                                            float3 param_21 = _p2.xyz;
                                                                            float3 param_22 = _p1.xyz;
                                                                            float3 _1592 = _f32(param_21, param_22);
                                                                            _t15.x = _1592.x;
                                                                            _t15.y = _1592.y;
                                                                            _t15.z = _1592.z;
                                                                        }
                                                                        else
                                                                        {
                                                                            if (_p0 == 18)
                                                                            {
                                                                                float3 param_23 = _p2.xyz;
                                                                                float3 param_24 = _p1.xyz;
                                                                                float3 _1611 = _f34(param_23, param_24);
                                                                                _t15.x = _1611.x;
                                                                                _t15.y = _1611.y;
                                                                                _t15.z = _1611.z;
                                                                            }
                                                                            else
                                                                            {
                                                                                if (_p0 == 19)
                                                                                {
                                                                                    float3 _1629 = abs(_p2.xyz - _p1.xyz);
                                                                                    _t15.x = _1629.x;
                                                                                    _t15.y = _1629.y;
                                                                                    _t15.z = _1629.z;
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (_p0 == 20)
                                                                                    {
                                                                                        float3 _1653 = (_p1.xyz + _p2.xyz) - ((_p1.xyz * 2.0) * _p2.xyz);
                                                                                        _t15.x = _1653.x;
                                                                                        _t15.y = _1653.y;
                                                                                        _t15.z = _1653.z;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (_p0 == 21)
                                                                                        {
                                                                                            float3 param_25 = _p2.xyz;
                                                                                            float3 param_26 = _p1.xyz;
                                                                                            float3 _1672 = _f13(param_25, param_26);
                                                                                            _t15.x = _1672.x;
                                                                                            _t15.y = _1672.y;
                                                                                            _t15.z = _1672.z;
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (_p0 == 22)
                                                                                            {
                                                                                                float3 param_27 = _p2.xyz;
                                                                                                float3 param_28 = _p1.xyz;
                                                                                                float3 _1691 = _f14(param_27, param_28);
                                                                                                _t15.x = _1691.x;
                                                                                                _t15.y = _1691.y;
                                                                                                _t15.z = _1691.z;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_p0 == 23)
                                                                                                {
                                                                                                    float3 param_29 = _p2.xyz;
                                                                                                    float3 param_30 = _p1.xyz;
                                                                                                    float3 _1710 = _f15(param_29, param_30);
                                                                                                    _t15.x = _1710.x;
                                                                                                    _t15.y = _1710.y;
                                                                                                    _t15.z = _1710.z;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if (_p0 == 24)
                                                                                                    {
                                                                                                        float3 param_31 = _p2.xyz;
                                                                                                        float3 param_32 = _p1.xyz;
                                                                                                        float3 _1729 = _f18(param_31, param_32);
                                                                                                        _t15.x = _1729.x;
                                                                                                        _t15.y = _1729.y;
                                                                                                        _t15.z = _1729.z;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        if (_p0 == 25)
                                                                                                        {
                                                                                                            float3 _1748 = fast::max(float3(0.0), _p1.xyz - _p2.xyz);
                                                                                                            _t15.x = _1748.x;
                                                                                                            _t15.y = _1748.y;
                                                                                                            _t15.z = _1748.z;
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            if (_p0 == 26)
                                                                                                            {
                                                                                                                float3 param_33 = _p2.xyz;
                                                                                                                float3 param_34 = _p1.xyz;
                                                                                                                float3 _1767 = _f36(param_33, param_34);
                                                                                                                _t15.x = _1767.x;
                                                                                                                _t15.y = _1767.y;
                                                                                                                _t15.z = _1767.z;
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
    float4 _1774 = _p1;
    float _1777 = _p1.w;
    float _1789 = _p1.w;
    float _1796 = _p1.w;
    float3 _1801 = (((_1774.xyz * _1777) * (1.0 - _p2.w)) + ((_p2.xyz * _p2.w) * (1.0 - _1789))) + (_t15.xyz * (_p2.w * _1796));
    _p1.x = _1801.x;
    _p1.y = _1801.y;
    _p1.z = _1801.z;
    _p1.w = _p2.w + (_p1.w * (1.0 - _p2.w));
    return _p1;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_depthTexture [[texture(0)]], texture2d<float> u_inputTexture [[texture(1)]], sampler u_depthTextureSmplr [[sampler(0)]], sampler u_inputTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 param = (((in.v_uv - float2(0.5)) * buffer.u_scale) + float2(0.5)) * buffer.u_ScreenParams.xy;
    float2 param_1 = float2(1.0) / buffer.u_ScreenParams.xy;
    float param_2 = buffer.u_depth;
    float param_3 = buffer.u_soft;
    float _1860 = dot(_f3(u_depthTexture, u_depthTextureSmplr, param, param_1, param_2, param_3), buffer.u_light.xyz);
    float4 _1865 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t21 = _1865;
    float _1878 = _t21.w;
    int param_4 = buffer.u_lowerBlendMode;
    float4 param_5 = _1865;
    float4 param_6 = float4(buffer.u_lowerColor.xyz, (((-_1860) * step(_1860, 0.0)) * buffer.u_lowerAlpha) * _t21.w);
    float4 _1911 = _f37(param_4, param_5, param_6, in.v_uv);
    _t21 = _1911;
    int param_7 = buffer.u_upperBlendMode;
    float4 param_8 = _1911;
    float4 param_9 = float4(buffer.u_upperColor.xyz, ((_1860 * step(0.0, _1860)) * buffer.u_upperAlpha) * _1878);
    float4 _1919 = _f37(param_7, param_8, param_9, in.v_uv);
    _t21 = _1919;
    out.o_fragColor = _1919;
    return out;
}

