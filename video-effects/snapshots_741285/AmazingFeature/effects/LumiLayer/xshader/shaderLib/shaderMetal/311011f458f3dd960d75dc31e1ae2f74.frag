#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    int u_enableMatte;
    int u_matteMode;
    int u_blendMode;
    int u_layerType;
    int u_hasMatte;
    float u_layerOpacity;
    int u_hasBlend;
    int u_hasBaseTexture;
    int u_hasSourceTexture;
    int u_hasTrs;
    float4x4 u_mvMat;
    float4x4 u_pMat;
    int u_pokertype;
    float u_ratio;
    float u_bool_poker;
    float u_mirrorEdge;
    float u_alpha;
};

constant float3 _2293 = {};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float4 _f7(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float3& _p3, thread const float3& _p4)
{
    float3 _400 = _p3 - _p2;
    float3 _404 = _p4 - _p2;
    float3 _408 = cross(_p1, _404);
    float _412 = dot(_400, _408);
    if (_412 <= 1.0000000116860974230803549289703e-07)
    {
        return float4(-1.0);
    }
    float3 _424 = _p0 - _p2;
    float _430 = dot(_424, _408) / _412;
    if ((_430 < 0.0) || (_430 > 1.0))
    {
        return float4(-1.0);
    }
    float3 _442 = cross(_424, _400);
    float _448 = dot(_p1, _442) / _412;
    bool _450 = _448 < 0.0;
    bool _458;
    if (!_450)
    {
        _458 = (_430 + _448) > 1.0;
    }
    else
    {
        _458 = _450;
    }
    if (_458)
    {
        return float4(-1.0);
    }
    return float4(_430, _448, dot(_404, _442) / _412, 1.0);
}

static inline __attribute__((always_inline))
float2 _f8(thread const float4x4& _p0, thread const float4x4& _p1, thread const float2& _p2)
{
    float4 _501 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t16 = _501;
    float3 _517 = fast::normalize((_501.xyz / float3(_t16.w)) - float3(0.0));
    float3 _520 = (_p0 * float4(10.0, -10.0, 0.0, 1.0)).xyz;
    float3 _523 = _520 + float3(9.9999997473787516355514526367188e-06, 0.0, 0.0);
    float3 _525 = (_p0 * float4(-10.0, 10.0, 0.0, 1.0)).xyz;
    float3 _527 = _525 + float3(0.0, 9.9999997473787516355514526367188e-06, 0.0);
    float3 param = float3(0.0);
    float3 param_1 = _517;
    float3 _534 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float3 param_2 = _534;
    float3 param_3 = _523;
    float3 param_4 = _527;
    float4 _t20 = _f7(param, param_1, param_2, param_3, param_4);
    float3 _541 = _525 - float3(9.9999997473787516355514526367188e-06, 0.0, 0.0);
    float3 _544 = _520 - float3(0.0, 9.9999997473787516355514526367188e-06, 0.0);
    float3 param_5 = float3(0.0);
    float3 param_6 = _517;
    float3 param_7 = _541;
    float3 param_8 = _544;
    float3 _553 = (_p0 * float4(10.0, 10.0, 0.0, 1.0)).xyz;
    float3 param_9 = _553;
    float4 _t21 = _f7(param_5, param_6, param_7, param_8, param_9);
    float3 param_10 = float3(0.0);
    float3 param_11 = _517;
    float3 param_12 = _534;
    float3 param_13 = _527;
    float3 param_14 = _523;
    float4 _t22 = _f7(param_10, param_11, param_12, param_13, param_14);
    float3 param_15 = float3(0.0);
    float3 param_16 = _517;
    float3 param_17 = _541;
    float3 param_18 = _553;
    float3 param_19 = _544;
    float4 _t23 = _f7(param_15, param_16, param_17, param_18, param_19);
    float2 _725 = (((((((float2(-4.5) * ((1.0 - _t20.x) - _t20.y)) + (float2(5.5, -4.5) * _t20.x)) + (float2(-4.5, 5.5) * _t20.y)) * step(0.0, _t20.w)) + ((((float2(-4.5, 5.5) * ((1.0 - _t21.x) - _t21.y)) + (float2(5.5, -4.5) * _t21.x)) + (float2(5.5) * _t21.y)) * (step(_t20.w, 0.0) * step(0.0, _t21.w)))) + ((((float2(-4.5) * ((1.0 - _t22.x) - _t22.y)) + (float2(-4.5, 5.5) * _t22.x)) + (float2(5.5, -4.5) * _t22.y)) * ((step(_t20.w, 0.0) * step(_t21.w, 0.0)) * step(0.0, _t22.w)))) + ((((float2(-4.5, 5.5) * ((1.0 - _t23.x) - _t23.y)) + (float2(5.5) * _t23.x)) + (float2(5.5, -4.5) * _t23.y)) * (((step(_t20.w, 0.0) * step(_t21.w, 0.0)) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + (float2(-10000.0) * (((step(_t20.w, 0.0) * step(_t21.w, 0.0)) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)));
    return _725;
}

static inline __attribute__((always_inline))
float _f9(thread const float2& _p0)
{
    float2 _t29 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t29.x * _t29.y;
}

static inline __attribute__((always_inline))
float _f5(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float4 _f10(thread const float4& _p0, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode)
{
    float4 _t30 = float4(0.0);
    if (u_enableMatte == 1)
    {
        _t30 = u_maskTexture.sample(u_maskTextureSmplr, uv0);
    }
    float _t31 = _t30.w;
    if (u_matteMode == 1)
    {
        float3 param = _t30.xyz;
        _t31 = _f5(param);
    }
    else
    {
        if (u_matteMode == 2)
        {
            _t31 = 1.0 - _t30.w;
        }
        else
        {
            if (u_matteMode == 3)
            {
                float3 param_1 = _t30.xyz;
                _t31 = 1.0 - _f5(param_1);
            }
        }
    }
    return _p0 * _t31;
}

static inline __attribute__((always_inline))
float _f1(thread const float& _p0, thread const float& _p1)
{
    float _195;
    if (_p0 < 0.5)
    {
        _195 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _214;
        if (_p1 < 0.25)
        {
            _214 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _214 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _195 = _214;
    }
    return _195;
}

static inline __attribute__((always_inline))
float3 _f2(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f1(param, param_1), _f1(param_2, param_3), _f1(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f3(thread const float& _p0, thread const float& _p1)
{
    float _279;
    if (_p0 < 0.5)
    {
        _279 = (2.0 * _p0) * _p1;
    }
    else
    {
        _279 = 1.0 - ((2.0 * (1.0 - _p0)) * (1.0 - _p1));
    }
    return _279;
}

static inline __attribute__((always_inline))
float3 _f4(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f3(param, param_1), _f3(param_2, param_3), _f3(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f12(thread const float3& _p0)
{
    return fast::max(_p0.x, fast::max(_p0.y, _p0.z)) - fast::min(_p0.x, fast::min(_p0.y, _p0.z));
}

static inline __attribute__((always_inline))
float3 _f11(thread float3& _p0, thread const float& _p1)
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
float3 _f13(thread float3& _p0, thread const float& _p1)
{
    bool _853 = _p0.x <= _p0.y;
    bool _861;
    if (_853)
    {
        _861 = _p0.x <= _p0.z;
    }
    else
    {
        _861 = _853;
    }
    if (_861)
    {
        if (_p0.y <= _p0.z)
        {
            float3 param = _p0;
            float param_1 = _p1;
            float3 _875 = _f11(param, param_1);
            _p0 = _875;
        }
        else
        {
            float3 param_2 = _p0.xzy;
            float param_3 = _p1;
            float3 _882 = _f11(param_2, param_3);
            _p0 = float3(_882.x, _882.z, _882.y);
        }
    }
    else
    {
        bool _890 = _p0.y <= _p0.x;
        bool _898;
        if (_890)
        {
            _898 = _p0.y <= _p0.z;
        }
        else
        {
            _898 = _890;
        }
        if (_898)
        {
            if (_p0.x <= _p0.z)
            {
                float3 param_4 = _p0.yxz;
                float param_5 = _p1;
                float3 _913 = _f11(param_4, param_5);
                _p0 = float3(_913.y, _913.x, _913.z);
            }
            else
            {
                float3 param_6 = _p0.yzx;
                float param_7 = _p1;
                float3 _922 = _f11(param_6, param_7);
                _p0 = float3(_922.z, _922.x, _922.y);
            }
        }
        else
        {
            if (_p0.x <= _p0.y)
            {
                float3 param_8 = _p0.zxy;
                float param_9 = _p1;
                float3 _938 = _f11(param_8, param_9);
                _p0 = float3(_938.y, _938.z, _938.x);
            }
            else
            {
                float3 param_10 = _p0.zyx;
                float param_11 = _p1;
                float3 _947 = _f11(param_10, param_11);
                _p0 = float3(_947.z, _947.y, _947.x);
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
    float _350 = fast::min(_p0.x, fast::min(_p0.y, _p0.z));
    float _353 = _p0.x;
    float _355 = _p0.y;
    float _357 = _p0.z;
    float _359 = fast::max(_353, fast::max(_355, _357));
    if (_350 < 0.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3(_p1 / (_p1 - _350)));
    }
    if (_359 > 1.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3((1.0 - _p1) / (_359 - _p1)));
    }
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f14(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f12(param);
    float3 _959 = _f13(param_1, param_2);
    float3 param_3 = _p1;
    float3 param_4 = _959;
    float param_5 = _f5(param_3);
    float3 _965 = _f6(param_4, param_5);
    return _965;
}

static inline __attribute__((always_inline))
float3 _f15(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p0;
    float3 param_1 = _p1;
    float param_2 = _f12(param);
    float3 _974 = _f13(param_1, param_2);
    float3 param_3 = _p1;
    float3 param_4 = _974;
    float param_5 = _f5(param_3);
    float3 _980 = _f6(param_4, param_5);
    return _980;
}

static inline __attribute__((always_inline))
float3 _f16(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f5(param);
    float3 _989 = _f6(param_1, param_2);
    return _989;
}

static inline __attribute__((always_inline))
float _f20(thread const float& _p0, thread const float& _p1)
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
float3 _f21(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f20(param, param_1), _f20(param_2, param_3), _f20(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f22(thread const float& _p0, thread const float& _p1)
{
    return fast::max(0.0, (_p1 + _p0) - 1.0);
}

static inline __attribute__((always_inline))
float3 _f23(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f22(param, param_1), _f22(param_2, param_3), _f22(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f24(thread const float& _p0, thread const float& _p1)
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
float3 _f25(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f24(param, param_1), _f24(param_2, param_3), _f24(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f26(thread const float& _p0, thread const float& _p1)
{
    return fast::min(1.0, _p1 + _p0);
}

static inline __attribute__((always_inline))
float3 _f27(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f26(param, param_1), _f26(param_2, param_3), _f26(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f28(thread const float& _p0, thread const float& _p1)
{
    float _1177;
    if (_p0 <= 0.5)
    {
        float param = _p1;
        float param_1 = 2.0 * _p0;
        _1177 = _f20(param, param_1);
    }
    else
    {
        float param_2 = _p1;
        float param_3 = 2.0 * (_p0 - 0.5);
        _1177 = _f24(param_2, param_3);
    }
    return _1177;
}

static inline __attribute__((always_inline))
float3 _f29(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f28(param, param_1), _f28(param_2, param_3), _f28(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f30(thread const float& _p0, thread const float& _p1)
{
    float _1223;
    if (_p0 <= 0.5)
    {
        float param = _p1;
        float param_1 = 2.0 * _p0;
        _1223 = _f22(param, param_1);
    }
    else
    {
        float param_2 = _p1;
        float param_3 = 2.0 * (_p0 - 0.5);
        _1223 = _f26(param_2, param_3);
    }
    return _1223;
}

static inline __attribute__((always_inline))
float3 _f31(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f30(param, param_1), _f30(param_2, param_3), _f30(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f32(thread const float& _p0, thread const float& _p1)
{
    float _1269;
    if (_p0 <= 0.5)
    {
        _1269 = fast::min(_p1, 2.0 * _p0);
    }
    else
    {
        _1269 = fast::max(_p1, 2.0 * (_p0 - 0.5));
    }
    return _1269;
}

static inline __attribute__((always_inline))
float3 _f33(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f32(param, param_1), _f32(param_2, param_3), _f32(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f34(thread const float& _p0, thread const float& _p1)
{
    return float((_p1 + _p0) >= 1.0);
}

static inline __attribute__((always_inline))
float3 _f35(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f34(param, param_1), _f34(param_2, param_3), _f34(param_4, param_5));
}

static inline __attribute__((always_inline))
float _f36(thread const float& _p0, thread const float& _p1)
{
    float _1342;
    if (_p0 > 0.0)
    {
        _1342 = fast::min(1.0, _p1 / _p0);
    }
    else
    {
        _1342 = 1.0;
    }
    return _1342;
}

static inline __attribute__((always_inline))
float3 _f37(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f36(param, param_1), _f36(param_2, param_3), _f36(param_4, param_5));
}

static inline __attribute__((always_inline))
float3 _f19(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p0;
    float3 param_1 = _p1;
    float param_2 = _f5(param);
    float3 _1025 = _f6(param_1, param_2);
    return _1025;
}

static inline __attribute__((always_inline))
float3 _f18(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    return select(_p0, _p1, bool3(_f5(param) > _f5(param_1)));
}

static inline __attribute__((always_inline))
float3 _f17(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    return select(_p0, _p1, bool3(_f5(param) <= _f5(param_1)));
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    return fract(sin(dot(_p0, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float4 _f38(thread float4& _p0, thread float4& _p1, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode, constant int& u_blendMode, constant int& u_layerType, constant int& u_hasMatte, constant float& u_layerOpacity)
{
    float _1378 = _p0.w;
    float4 _1380 = _p0;
    float3 _1383 = _1380.xyz / float3(fast::max(_1378, 9.9999997473787516355514526367188e-06));
    _p0.x = _1383.x;
    _p0.y = _1383.y;
    _p0.z = _1383.z;
    float _1391 = _p1.w;
    float4 _1393 = _p1;
    float3 _1396 = _1393.xyz / float3(fast::max(_1391, 9.9999997473787516355514526367188e-06));
    _p1.x = _1396.x;
    _p1.y = _1396.y;
    _p1.z = _1396.z;
    float4 _t32 = _p1;
    if (u_blendMode == 1)
    {
        float3 _1414 = _p0.xyz + _p1.xyz;
        _t32.x = _1414.x;
        _t32.y = _1414.y;
        _t32.z = _1414.z;
    }
    else
    {
        if (u_blendMode == 2)
        {
            float3 _1430 = _p0.xyz * _p1.xyz;
            _t32.x = _1430.x;
            _t32.y = _1430.y;
            _t32.z = _1430.z;
        }
        else
        {
            if (u_blendMode == 3)
            {
                float3 _1447 = abs(_p0.xyz - _p1.xyz);
                _t32.x = _1447.x;
                _t32.y = _1447.y;
                _t32.z = _1447.z;
            }
            else
            {
                if (u_blendMode == 4)
                {
                    float _1463;
                    if (_p1.x < 0.5)
                    {
                        _1463 = (2.0 * _p1.x) * _p0.x;
                    }
                    else
                    {
                        _1463 = 1.0 - ((2.0 * (1.0 - _p1.x)) * (1.0 - _p0.x));
                    }
                    float _1486;
                    if (_p1.y < 0.5)
                    {
                        _1486 = (2.0 * _p1.y) * _p0.y;
                    }
                    else
                    {
                        _1486 = 1.0 - ((2.0 * (1.0 - _p1.y)) * (1.0 - _p0.y));
                    }
                    float _1509;
                    if (_p1.z < 0.5)
                    {
                        _1509 = (2.0 * _p1.z) * _p0.z;
                    }
                    else
                    {
                        _1509 = 1.0 - ((2.0 * (1.0 - _p1.z)) * (1.0 - _p0.z));
                    }
                    float3 _1529 = float3(_1463, _1486, _1509);
                    _t32.x = _1529.x;
                    _t32.y = _1529.y;
                    _t32.z = _1529.z;
                }
                else
                {
                    if (u_blendMode == 5)
                    {
                        float3 _1546 = fast::min(_p0.xyz, _p1.xyz);
                        _t32.x = _1546.x;
                        _t32.y = _1546.y;
                        _t32.z = _1546.z;
                    }
                    else
                    {
                        if (u_blendMode == 6)
                        {
                            float3 _1563 = fast::max(_p0.xyz, _p1.xyz);
                            _t32.x = _1563.x;
                            _t32.y = _1563.y;
                            _t32.z = _1563.z;
                        }
                        else
                        {
                            if (u_blendMode == 7)
                            {
                                float3 param = _p0.xyz;
                                float3 param_1 = _p1.xyz;
                                float3 _1582 = _f2(param, param_1);
                                _t32.x = _1582.x;
                                _t32.y = _1582.y;
                                _t32.z = _1582.z;
                            }
                            else
                            {
                                if (u_blendMode == 8)
                                {
                                    float3 param_2 = _p0.xyz;
                                    float3 param_3 = _p1.xyz;
                                    float3 _1601 = _f4(param_2, param_3);
                                    _t32.x = _1601.x;
                                    _t32.y = _1601.y;
                                    _t32.z = _1601.z;
                                }
                                else
                                {
                                    if (u_blendMode == 9)
                                    {
                                        float3 param_4 = _p0.xyz;
                                        float3 param_5 = _p1.xyz;
                                        float3 _1620 = _f14(param_4, param_5);
                                        _t32.x = _1620.x;
                                        _t32.y = _1620.y;
                                        _t32.z = _1620.z;
                                    }
                                    else
                                    {
                                        if (u_blendMode == 10)
                                        {
                                            float3 param_6 = _p0.xyz;
                                            float3 param_7 = _p1.xyz;
                                            float3 _1639 = _f15(param_6, param_7);
                                            _t32.x = _1639.x;
                                            _t32.y = _1639.y;
                                            _t32.z = _1639.z;
                                        }
                                        else
                                        {
                                            if (u_blendMode == 11)
                                            {
                                                float3 param_8 = _p0.xyz;
                                                float3 param_9 = _p1.xyz;
                                                float3 _1658 = _f16(param_8, param_9);
                                                _t32.x = _1658.x;
                                                _t32.y = _1658.y;
                                                _t32.z = _1658.z;
                                            }
                                            else
                                            {
                                                if (u_blendMode == 12)
                                                {
                                                    float3 _1681 = (_p0.xyz + _p1.xyz) - (_p0.xyz * _p1.xyz);
                                                    _t32.x = _1681.x;
                                                    _t32.y = _1681.y;
                                                    _t32.z = _1681.z;
                                                }
                                                else
                                                {
                                                    if (u_blendMode == 13)
                                                    {
                                                        float3 param_10 = _p0.xyz;
                                                        float3 param_11 = _p1.xyz;
                                                        float3 _1700 = _f21(param_10, param_11);
                                                        _t32.x = _1700.x;
                                                        _t32.y = _1700.y;
                                                        _t32.z = _1700.z;
                                                    }
                                                    else
                                                    {
                                                        if (u_blendMode == 14)
                                                        {
                                                            float3 param_12 = _p0.xyz;
                                                            float3 param_13 = _p1.xyz;
                                                            float3 _1719 = _f23(param_12, param_13);
                                                            _t32.x = _1719.x;
                                                            _t32.y = _1719.y;
                                                            _t32.z = _1719.z;
                                                        }
                                                        else
                                                        {
                                                            if (u_blendMode == 15)
                                                            {
                                                                float3 param_14 = _p0.xyz;
                                                                float3 param_15 = _p1.xyz;
                                                                float3 _1738 = _f25(param_14, param_15);
                                                                _t32.x = _1738.x;
                                                                _t32.y = _1738.y;
                                                                _t32.z = _1738.z;
                                                            }
                                                            else
                                                            {
                                                                if (u_blendMode == 16)
                                                                {
                                                                    float3 param_16 = _p0.xyz;
                                                                    float3 param_17 = _p1.xyz;
                                                                    float3 _1757 = _f27(param_16, param_17);
                                                                    _t32.x = _1757.x;
                                                                    _t32.y = _1757.y;
                                                                    _t32.z = _1757.z;
                                                                }
                                                                else
                                                                {
                                                                    if (u_blendMode == 17)
                                                                    {
                                                                        float3 param_18 = _p0.xyz;
                                                                        float3 param_19 = _p1.xyz;
                                                                        float3 _1776 = _f29(param_18, param_19);
                                                                        _t32.x = _1776.x;
                                                                        _t32.y = _1776.y;
                                                                        _t32.z = _1776.z;
                                                                    }
                                                                    else
                                                                    {
                                                                        if (u_blendMode == 18)
                                                                        {
                                                                            float3 param_20 = _p0.xyz;
                                                                            float3 param_21 = _p1.xyz;
                                                                            float3 _1795 = _f31(param_20, param_21);
                                                                            _t32.x = _1795.x;
                                                                            _t32.y = _1795.y;
                                                                            _t32.z = _1795.z;
                                                                        }
                                                                        else
                                                                        {
                                                                            if (u_blendMode == 19)
                                                                            {
                                                                                float3 param_22 = _p0.xyz;
                                                                                float3 param_23 = _p1.xyz;
                                                                                float3 _1814 = _f33(param_22, param_23);
                                                                                _t32.x = _1814.x;
                                                                                _t32.y = _1814.y;
                                                                                _t32.z = _1814.z;
                                                                            }
                                                                            else
                                                                            {
                                                                                if (u_blendMode == 20)
                                                                                {
                                                                                    float3 param_24 = _p0.xyz;
                                                                                    float3 param_25 = _p1.xyz;
                                                                                    float3 _1833 = _f35(param_24, param_25);
                                                                                    _t32.x = _1833.x;
                                                                                    _t32.y = _1833.y;
                                                                                    _t32.z = _1833.z;
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (u_blendMode == 21)
                                                                                    {
                                                                                        float3 _1857 = (_p1.xyz + _p0.xyz) - ((_p1.xyz * 2.0) * _p0.xyz);
                                                                                        _t32.x = _1857.x;
                                                                                        _t32.y = _1857.y;
                                                                                        _t32.z = _1857.z;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (u_blendMode == 22)
                                                                                        {
                                                                                            float3 _1875 = fast::max(float3(0.0), _p1.xyz - _p0.xyz);
                                                                                            _t32.x = _1875.x;
                                                                                            _t32.y = _1875.y;
                                                                                            _t32.z = _1875.z;
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (u_blendMode == 23)
                                                                                            {
                                                                                                float3 param_26 = _p0.xyz;
                                                                                                float3 param_27 = _p1.xyz;
                                                                                                float3 _1894 = _f37(param_26, param_27);
                                                                                                _t32.x = _1894.x;
                                                                                                _t32.y = _1894.y;
                                                                                                _t32.z = _1894.z;
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (u_blendMode == 24)
                                                                                                {
                                                                                                    float3 param_28 = _p0.xyz;
                                                                                                    float3 param_29 = _p1.xyz;
                                                                                                    float3 _1913 = _f19(param_28, param_29);
                                                                                                    _t32.x = _1913.x;
                                                                                                    _t32.y = _1913.y;
                                                                                                    _t32.z = _1913.z;
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if (u_blendMode == 25)
                                                                                                    {
                                                                                                        float3 param_30 = _p0.xyz;
                                                                                                        float3 param_31 = _p1.xyz;
                                                                                                        float3 _1932 = _f18(param_30, param_31);
                                                                                                        _t32.x = _1932.x;
                                                                                                        _t32.y = _1932.y;
                                                                                                        _t32.z = _1932.z;
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        if (u_blendMode == 26)
                                                                                                        {
                                                                                                            float3 param_32 = _p0.xyz;
                                                                                                            float3 param_33 = _p1.xyz;
                                                                                                            float3 _1951 = _f17(param_32, param_33);
                                                                                                            _t32.x = _1951.x;
                                                                                                            _t32.y = _1951.y;
                                                                                                            _t32.z = _1951.z;
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            if (u_blendMode == 27)
                                                                                                            {
                                                                                                                bool _1966 = _p0.w == 1.0;
                                                                                                                bool _1982;
                                                                                                                if (!_1966)
                                                                                                                {
                                                                                                                    bool _1972 = _p0.w > 0.0;
                                                                                                                    bool _1981;
                                                                                                                    if (_1972)
                                                                                                                    {
                                                                                                                        float2 param_34 = uv0;
                                                                                                                        _1981 = _p0.w > _f0(param_34);
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        _1981 = _1972;
                                                                                                                    }
                                                                                                                    _1982 = _1981;
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    _1982 = _1966;
                                                                                                                }
                                                                                                                if (_1982)
                                                                                                                {
                                                                                                                    _t32.x = _p0.xyz.x;
                                                                                                                    _t32.y = _p0.xyz.y;
                                                                                                                    _t32.z = _p0.xyz.z;
                                                                                                                }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                                _t32.x = _p0.xyz.x;
                                                                                                                _t32.y = _p0.xyz.y;
                                                                                                                _t32.z = _p0.xyz.z;
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
    float4 _t33 = float4(0.0);
    if (u_layerType == 1)
    {
        float _t34 = 1.0;
        if (u_hasMatte == 1)
        {
            float4 param_35 = float4(1.0);
            _t34 = _f10(param_35, u_enableMatte, u_maskTexture, u_maskTextureSmplr, uv0, u_matteMode).w;
        }
        float4 _2033 = mix(_p1, float4(_t32.xyz, _p0.w), float4(u_layerOpacity * _t34));
        _t33 = _2033;
        float _2035 = _t33.w;
        float3 _2038 = _2033.xyz * _2035;
        _t33.x = _2038.x;
        _t33.y = _2038.y;
        _t33.z = _2038.z;
    }
    else
    {
        float3 _2073 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t32.xyz * (_p0.w * _p1.w));
        _t33.x = _2073.x;
        _t33.y = _2073.y;
        _t33.z = _2073.z;
        _t33.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t33;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTexture [[texture(0)]], texture2d<float> u_baseTexure [[texture(1)]], texture2d<float> u_sourceTexture [[texture(2)]], sampler u_maskTextureSmplr [[sampler(0)]], sampler u_baseTexureSmplr [[sampler(1)]], sampler u_sourceTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _t35 = float4(0.0);
    bool _2096 = buffer.u_hasBlend == 1;
    if (_2096)
    {
        if (buffer.u_hasBaseTexture == 1)
        {
            _t35 = u_baseTexure.sample(u_baseTexureSmplr, in.uv0);
        }
        if (buffer.u_hasSourceTexture == 0)
        {
            out.o_fragColor = _t35;
            return out;
        }
    }
    float4 _t36 = float4(0.0);
    if (buffer.u_hasTrs == 1)
    {
        float4x4 param = buffer.u_mvMat;
        float4x4 param_1 = buffer.u_pMat;
        float2 param_2 = in.uv0;
        float2 _t37 = _f8(param, param_1, param_2);
        float _t38 = 1.0;
        if (buffer.u_pokertype == 0)
        {
            if (_t37.x > 3.400000095367431640625)
            {
                _t38 = 0.0;
            }
            if (buffer.u_ratio > 1.0)
            {
                if (_t37.x > (3.400000095367431640625 - (buffer.u_ratio * 0.100000001490116119384765625)))
                {
                    _t38 = 0.0;
                }
            }
            bool _2163 = _t37.x >= 0.0;
            bool _2169;
            if (_2163)
            {
                _2169 = _t37.x <= 1.0;
            }
            else
            {
                _2169 = _2163;
            }
            if (_2169)
            {
                _t38 = buffer.u_bool_poker;
            }
        }
        else
        {
            if (buffer.u_pokertype == 1)
            {
                if (_t37.x > 1.0)
                {
                    _t38 = 0.0;
                }
                bool _2187 = _t37.x >= (-1.13999998569488525390625);
                bool _2193;
                if (_2187)
                {
                    _2193 = _t37.x < 0.0;
                }
                else
                {
                    _2193 = _2187;
                }
                if (_2193)
                {
                    _t38 = 0.0;
                }
            }
            else
            {
                if (_t37.x > 1.0)
                {
                    _t38 = 0.0;
                }
            }
        }
        if (buffer.u_ratio > 1.0)
        {
            float _2208 = step(buffer.u_mirrorEdge, 0.5);
            float _2220 = 0.14000000059604644775390625 / buffer.u_ratio;
            _t37.x = (_2208 * _t37.x) + ((1.0 - _2208) * abs(mod((_t37.x - 1.0) - _2220, 1.0 + _2220)));
        }
        else
        {
            float _2232 = step(buffer.u_mirrorEdge, 0.5);
            _t37.x = (_2232 * _t37.x) + ((1.0 - _2232) * abs(mod(_t37.x - 1.13999998569488525390625, 1.13999998569488525390625)));
        }
        float2 param_3 = float2(_t37.x, _t37.y);
        _t36 = ((u_sourceTexture.sample(u_sourceTextureSmplr, _t37) * buffer.u_alpha) * _f9(param_3)) * _t38;
    }
    else
    {
        if (buffer.u_hasSourceTexture == 1)
        {
            _t36 = u_sourceTexture.sample(u_sourceTextureSmplr, in.uv0);
        }
    }
    if ((buffer.u_layerType != 1) && (buffer.u_hasMatte == 1))
    {
        float4 param_4 = _t36;
        _t36 = _f10(param_4, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode);
    }
    if (_2096)
    {
        float4 param_5 = _t36;
        float4 param_6 = _t35;
        float4 _2291 = _f38(param_5, param_6, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode, buffer.u_blendMode, buffer.u_layerType, buffer.u_hasMatte, buffer.u_layerOpacity);
        _t36 = _2291;
    }
    out.o_fragColor = _t36;
    return out;
}

