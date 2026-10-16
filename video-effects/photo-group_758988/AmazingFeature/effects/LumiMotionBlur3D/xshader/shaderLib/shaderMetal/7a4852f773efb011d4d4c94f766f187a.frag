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
    int u_skipSample;
    float4x4 u_mvMat0;
    float4x4 u_pMat0;
    float u_mirrorEdge;
    float u_alpha;
    float4x4 u_mvMat1;
    float4x4 u_pMat1;
    float4x4 u_mvMat2;
    float4x4 u_pMat2;
    float4x4 u_mvMat3;
    float4x4 u_pMat3;
    float4x4 u_mvMat4;
    float4x4 u_pMat4;
    float4x4 u_mvMat5;
    float4x4 u_pMat5;
    float u_samples;
    float u_dither;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float4 _f1(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float3& _p3, thread const float3& _p4)
{
    float3 _67 = _p3 - _p2;
    float3 _71 = _p4 - _p2;
    float3 _75 = cross(_p1, _71);
    float _79 = dot(_67, _75);
    if (_79 <= 1.0000000116860974230803549289703e-07)
    {
        return float4(-1.0);
    }
    float3 _92 = _p0 - _p2;
    float _98 = dot(_92, _75) / _79;
    if ((_98 < 0.0) || (_98 > 1.0))
    {
        return float4(-1.0);
    }
    float3 _111 = cross(_92, _67);
    float _117 = dot(_p1, _111) / _79;
    bool _119 = _117 < 0.0;
    bool _127;
    if (!_119)
    {
        _127 = (_98 + _117) > 1.0;
    }
    else
    {
        _127 = _119;
    }
    if (_127)
    {
        return float4(-1.0);
    }
    return float4(_98, _117, dot(_71, _111) / _79, 1.0);
}

static inline __attribute__((always_inline))
float2 _f2(thread const float4x4& _p0, thread const float4x4& _p1, thread const float2& _p2)
{
    float3 _167 = (_p0 * float4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    float3 _173 = (_p0 * float4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _178 = (_p0 * float4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _183 = (_p0 * float4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    float4 _193 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t17 = _193;
    float3 _210 = fast::normalize((_193.xyz / float3(_t17.w)) - float3(0.0));
    float3 param = float3(0.0);
    float3 param_1 = _210;
    float3 _218 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float3 param_2 = _218;
    float3 param_3 = _167;
    float3 param_4 = _178;
    float4 _t21 = _f1(param, param_1, param_2, param_3, param_4);
    float3 param_5 = float3(0.0);
    float3 param_6 = _210;
    float3 param_7 = _183;
    float3 param_8 = _173;
    float3 _235 = (_p0 * float4(10.0, 10.0, 0.0, 1.0)).xyz;
    float3 param_9 = _235;
    float4 _t22 = _f1(param_5, param_6, param_7, param_8, param_9);
    float3 param_10 = float3(0.0);
    float3 param_11 = _210;
    float3 param_12 = _218;
    float3 param_13 = _178;
    float3 param_14 = _167;
    float4 _t23 = _f1(param_10, param_11, param_12, param_13, param_14);
    float3 param_15 = float3(0.0);
    float3 param_16 = _210;
    float3 param_17 = _183;
    float3 param_18 = _235;
    float3 param_19 = _173;
    float4 _t24 = _f1(param_15, param_16, param_17, param_18, param_19);
    float2 _401 = (((((((float2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (float2(5.5, -4.5) * _t21.x)) + (float2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((float2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (float2(5.5, -4.5) * _t22.x)) + (float2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((float2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (float2(-4.5, 5.5) * _t23.x)) + (float2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((float2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (float2(5.5) * _t24.x)) + (float2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (float2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _401;
}

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f3(thread const float2& _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

static inline __attribute__((always_inline))
float _f5(thread const float& _p0, thread const float& _p1)
{
    float2 _503 = fract(float2(_p0, _p1) * 13.5170001983642578125);
    float2 _t30 = _503 + float2(dot(_503, _503.yx + float2(22.5410003662109375)));
    return fract((_t30.x + _t30.y) * _t30.y);
}

static inline __attribute__((always_inline))
float2 _f4(thread const float& _p0, thread const float2& _p1, thread const float2& _p2, thread const float2& _p3, thread const float2& _p4, thread const float2& _p5, thread const float2& _p6)
{
    return ((((mix(_p1, _p2, float2(_p0 * 5.0)) * step(_p0, 0.20000000298023223876953125)) + ((mix(_p2, _p3, float2((_p0 * 5.0) - 1.0)) * (1.0 - step(_p0, 0.20000000298023223876953125))) * step(_p0, 0.4000000059604644775390625))) + ((mix(_p3, _p4, float2((_p0 * 5.0) - 2.0)) * (1.0 - step(_p0, 0.4000000059604644775390625))) * step(_p0, 0.60000002384185791015625))) + ((mix(_p4, _p5, float2((_p0 * 5.0) - 3.0)) * (1.0 - step(_p0, 0.60000002384185791015625))) * step(_p0, 0.800000011920928955078125))) + (mix(_p5, _p6, float2((_p0 * 5.0) - 4.0)) * (1.0 - step(_p0, 0.800000011920928955078125)));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.u_skipSample == 1)
    {
        float4x4 param = buffer.u_mvMat0;
        float4x4 param_1 = buffer.u_pMat0;
        float2 param_2 = in.uv0;
        float2 _545 = _f2(param, param_1, param_2);
        float _550 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_3 = _545;
        float2 _560 = (_545 * _550) + (_f0(param_3) * (1.0 - _550));
        float2 param_4 = _560;
        out.o_fragColor = (u_inputTex.sample(u_inputTexSmplr, _560) * buffer.u_alpha) * _f3(param_4);
        return out;
    }
    float4x4 param_5 = buffer.u_mvMat0;
    float4x4 param_6 = buffer.u_pMat0;
    float2 param_7 = in.uv0;
    float2 _585 = _f2(param_5, param_6, param_7);
    float4x4 param_8 = buffer.u_mvMat1;
    float4x4 param_9 = buffer.u_pMat1;
    float2 param_10 = in.uv0;
    float2 _595 = _f2(param_8, param_9, param_10);
    float4x4 param_11 = buffer.u_mvMat2;
    float4x4 param_12 = buffer.u_pMat2;
    float2 param_13 = in.uv0;
    float2 _605 = _f2(param_11, param_12, param_13);
    float4x4 param_14 = buffer.u_mvMat3;
    float4x4 param_15 = buffer.u_pMat3;
    float2 param_16 = in.uv0;
    float2 _615 = _f2(param_14, param_15, param_16);
    float4x4 param_17 = buffer.u_mvMat4;
    float4x4 param_18 = buffer.u_pMat4;
    float2 param_19 = in.uv0;
    float2 _625 = _f2(param_17, param_18, param_19);
    float4x4 param_20 = buffer.u_mvMat5;
    float4x4 param_21 = buffer.u_pMat5;
    float2 param_22 = in.uv0;
    float2 _635 = _f2(param_20, param_21, param_22);
    float4 _t38 = float4(0.0);
    for (float _t39 = 0.0; _t39 <= 256.0; _t39 += 1.0)
    {
        if (_t39 >= buffer.u_samples)
        {
            break;
        }
        float _t40 = _t39 / (buffer.u_samples - 1.0);
        float param_23 = _t39 + in.uv0.x;
        float param_24 = _t39 * in.uv0.y;
        float _677 = _t40;
        float _678 = _677 + ((buffer.u_dither * (_f5(param_23, param_24) - 0.5)) / buffer.u_samples);
        _t40 = _678;
        float param_25 = _678;
        float2 param_26 = _585;
        float2 param_27 = _595;
        float2 param_28 = _605;
        float2 param_29 = _615;
        float2 param_30 = _625;
        float2 param_31 = _635;
        float2 _694 = _f4(param_25, param_26, param_27, param_28, param_29, param_30, param_31);
        float _696 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_32 = _694;
        float2 _706 = (_694 * _696) + (_f0(param_32) * (1.0 - _696));
        float2 param_33 = _706;
        _t38 += ((u_inputTex.sample(u_inputTexSmplr, _706) * buffer.u_alpha) * _f3(param_33));
    }
    float4 _721 = _t38;
    float4 _723 = _721 / float4(buffer.u_samples);
    _t38 = _723;
    out.o_fragColor = _723;
    return out;
}

