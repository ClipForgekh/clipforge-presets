#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_angle;
    float4 u_ScreenParams;
    int u_steps;
    float u_stride;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float _f0(thread const float& _p0)
{
    return exp(((-0.5) * (_p0 * _p0)) / 0.0900000035762786865234375);
}

static inline __attribute__((always_inline))
float3 _f1(thread const int& _p0, thread const float& _p1, thread const float2& _p2, thread float2& v_uv, texture2d<float> u_inputTex, sampler u_inputTexSmplr)
{
    float3 _t0 = float3(0.0);
    float _t1 = 0.0;
    for (int _t2 = 0; _t2 < 1000; _t2++)
    {
        if (_t2 >= _p0)
        {
            break;
        }
        float _57 = float(_t2);
        float param = _57 / float(_p0);
        float _64 = _f0(param);
        _t0 += (((u_inputTex.sample(u_inputTexSmplr, (v_uv + ((_p2 * _57) * _p1))).xyz + u_inputTex.sample(u_inputTexSmplr, (v_uv + ((_p2 * (-_57)) * _p1))).xyz) * _64) / float3(2.0));
        _t1 += _64;
    }
    return _t0 / fast::max(float3(_t1), float3(0.001000000047497451305389404296875));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _131 = (buffer.u_angle / 180.0) * 3.141592502593994140625;
    int param = buffer.u_steps;
    float param_1 = buffer.u_stride;
    float2 param_2 = float2(cos(_131), sin(_131)) / ((buffer.u_ScreenParams.xy * 720.0) / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y)));
    out.o_fragColor = float4(_f1(param, param_1, param_2, in.v_uv, u_inputTex, u_inputTexSmplr), 1.0);
    return out;
}

