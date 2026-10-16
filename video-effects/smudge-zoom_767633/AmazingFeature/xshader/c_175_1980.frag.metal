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
    float u_Steps;
    float u_Sample;
    float u_mirrorEdge;
    float u_Angle;
    float4 u_ScreenParams;
    float u_ExpandFlag;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(v_uv)]];
};

static inline __attribute__((always_inline))
float _f1(thread const float& _p0, thread const float& _p1)
{
    return (0.3989399969577789306640625 * exp((((-0.5) * _p0) * _p0) / (_p1 * _p1))) / _p1;
}

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float2& _p2, constant float& u_Steps, constant float& u_Sample, constant float& u_mirrorEdge)
{
    float param = 0.0;
    float param_1 = 4.0;
    float param_2 = param;
    float param_3 = param_1;
    float _60 = _f1(param_2, param_3);
    float4 _t2 = float4(0.0);
    float2 _69 = _p2 * u_Steps;
    float _t8 = _60;
    for (int _t10 = 1; _t10 <= 1024; _t10++)
    {
        if (float(_t10) > u_Sample)
        {
            break;
        }
        float2 _98 = _p1 + (_69 * float(_t10));
        float2 _t11 = _98;
        float2 _t12 = _p1 + (_69 * float(-_t10));
        float _115 = step(u_mirrorEdge, 0.5);
        float _120 = 1.0 - _115;
        float2 param_2_1 = _98;
        float2 param_4 = param_2_1;
        _t11 = (_98 * _115) + (_f0(param_4) * _120);
        float2 _134 = _t12;
        float2 param_3_1 = _134;
        float2 param_5 = param_3_1;
        float2 _138 = (_134 * _115) + (_f0(param_5) * _120);
        _t12 = _138;
        float param_4_1 = (float(_t10) / u_Sample) * 15.0;
        float param_5_1 = 4.0;
        float param_6 = param_4_1;
        float param_7 = param_5_1;
        float _157 = _f1(param_6, param_7);
        _t2 = (_t2 + (pow(_p0.sample(_p0Smplr, _t11), float4(1.0)) * _157)) + (pow(_p0.sample(_p0Smplr, _138), float4(1.0)) * _157);
        _t8 += (_157 * 2.0);
    }
    return fast::clamp(pow((_t2 + (pow(_p0.sample(_p0Smplr, _p1), float4(1.0)) * _60)) / float4(_t8), float4(1.0)), float4(0.0), float4(1.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _200 = (buffer.u_Angle * 3.141592502593994140625) / 180.0;
    float2 param = in.v_uv;
    float2 param_1 = float2(cos(_200), sin(_200)) / ((buffer.u_ScreenParams.xy * ((1.0 + (buffer.u_ExpandFlag * 0.4000000059604644775390625)) * 720.0)) / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y)));
    float2 param_2 = param;
    float2 param_3 = param_1;
    out.gl_FragColor = _f2(tDiffuse, tDiffuseSmplr, param_2, param_3, buffer.u_Steps, buffer.u_Sample, buffer.u_mirrorEdge);
    return out;
}

