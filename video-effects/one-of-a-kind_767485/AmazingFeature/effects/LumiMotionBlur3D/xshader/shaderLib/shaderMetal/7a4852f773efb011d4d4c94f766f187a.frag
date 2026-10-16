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
float2 _f1(thread const float4x4& _p0, thread const float4x4& _p1, thread const float2& _p2)
{
    float3 _62 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float4 _84 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t3 = _84;
    float3 _100 = fast::normalize((_84.xyz / float3(_t3.w)) - float3(0.0));
    float3 _104 = (_p0 * float4(10.0, -10.0, 0.0, 1.0)).xyz - _62;
    float3 _108 = (_p0 * float4(-10.0, 10.0, 0.0, 1.0)).xyz - _62;
    float3 _112 = cross(_104, _108);
    float _116 = dot(_112, _100);
    if (_116 >= (-1.0000000116860974230803549289703e-07))
    {
        return float2(-10000.0);
    }
    float _133 = dot(_62 - float3(0.0), _112) / _116;
    if (_133 <= 0.0)
    {
        return float2(-10000.0);
    }
    float3 _148 = (float3(0.0) + (_100 * _133)) - _62;
    float _152 = dot(_104, _104);
    float _156 = dot(_104, _108);
    float _160 = dot(_108, _108);
    float _164 = dot(_104, _148);
    float _168 = dot(_108, _148);
    float _176 = (_152 * _160) - (_156 * _156);
    if (abs(_176) <= 1.0000000116860974230803549289703e-07)
    {
        return float2(-10000.0);
    }
    float _186 = 1.0 / _176;
    float _196 = ((_160 * _164) - (_156 * _168)) * _186;
    float _t21 = _196;
    float _206 = ((_152 * _168) - (_156 * _164)) * _186;
    float _t22 = _206;
    if ((((_196 < (-9.9999997473787516355514526367188e-06)) || (_196 > 1.000010013580322265625)) || (_206 < (-9.9999997473787516355514526367188e-06))) || (_206 > 1.000010013580322265625))
    {
        return float2(-10000.0);
    }
    float _223 = _t21;
    float _224 = fast::clamp(_223, 0.0, 1.0);
    _t21 = _224;
    float _225 = _t22;
    float _226 = fast::clamp(_225, 0.0, 1.0);
    _t22 = _226;
    float2 _232 = float2(_224);
    return mix(mix(float2(-4.5), float2(5.5, -4.5), _232), mix(float2(-4.5, 5.5), float2(5.5), _232), float2(_226));
}

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f2(thread const float2& _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

static inline __attribute__((always_inline))
float _f4(thread const float& _p0, thread const float& _p1)
{
    float2 _344 = fract(float2(_p0, _p1) * 13.5170001983642578125);
    float2 _t23 = _344 + float2(dot(_344, _344.yx + float2(22.5410003662109375)));
    return fract((_t23.x + _t23.y) * _t23.y);
}

static inline __attribute__((always_inline))
float2 _f3(thread const float& _p0, thread const float2& _p1, thread const float2& _p2, thread const float2& _p3, thread const float2& _p4, thread const float2& _p5, thread const float2& _p6)
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
        float2 _386 = _f1(param, param_1, param_2);
        float _391 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_3 = _386;
        float2 _401 = (_386 * _391) + (_f0(param_3) * (1.0 - _391));
        float2 param_4 = _401;
        out.o_fragColor = (u_inputTex.sample(u_inputTexSmplr, _401) * buffer.u_alpha) * _f2(param_4);
        return out;
    }
    float4x4 param_5 = buffer.u_mvMat0;
    float4x4 param_6 = buffer.u_pMat0;
    float2 param_7 = in.uv0;
    float2 _426 = _f1(param_5, param_6, param_7);
    float4x4 param_8 = buffer.u_mvMat1;
    float4x4 param_9 = buffer.u_pMat1;
    float2 param_10 = in.uv0;
    float2 _436 = _f1(param_8, param_9, param_10);
    float4x4 param_11 = buffer.u_mvMat2;
    float4x4 param_12 = buffer.u_pMat2;
    float2 param_13 = in.uv0;
    float2 _446 = _f1(param_11, param_12, param_13);
    float4x4 param_14 = buffer.u_mvMat3;
    float4x4 param_15 = buffer.u_pMat3;
    float2 param_16 = in.uv0;
    float2 _456 = _f1(param_14, param_15, param_16);
    float4x4 param_17 = buffer.u_mvMat4;
    float4x4 param_18 = buffer.u_pMat4;
    float2 param_19 = in.uv0;
    float2 _466 = _f1(param_17, param_18, param_19);
    float4x4 param_20 = buffer.u_mvMat5;
    float4x4 param_21 = buffer.u_pMat5;
    float2 param_22 = in.uv0;
    float2 _476 = _f1(param_20, param_21, param_22);
    float4 _t31 = float4(0.0);
    for (float _t32 = 0.0; _t32 <= 50.0; _t32 += 1.0)
    {
        if (_t32 >= buffer.u_samples)
        {
            break;
        }
        float _t33 = _t32 / (buffer.u_samples - 1.0);
        float param_23 = _t32 + in.uv0.x;
        float param_24 = _t32 * in.uv0.y;
        float _518 = _t33;
        float _519 = _518 + ((buffer.u_dither * (_f4(param_23, param_24) - 0.5)) / buffer.u_samples);
        _t33 = _519;
        float param_25 = _519;
        float2 param_26 = _426;
        float2 param_27 = _436;
        float2 param_28 = _446;
        float2 param_29 = _456;
        float2 param_30 = _466;
        float2 param_31 = _476;
        float2 _535 = _f3(param_25, param_26, param_27, param_28, param_29, param_30, param_31);
        float _537 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_32 = _535;
        float2 _547 = (_535 * _537) + (_f0(param_32) * (1.0 - _537));
        float2 param_33 = _547;
        _t31 += ((u_inputTex.sample(u_inputTexSmplr, _547) * buffer.u_alpha) * _f2(param_33));
    }
    float4 _562 = _t31;
    float4 _564 = _562 / float4(buffer.u_samples);
    _t31 = _564;
    out.o_fragColor = _564;
    return out;
}

