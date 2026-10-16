#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_stride;
    float u_steps;
    float2 u_dir;
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
float _f1(thread const float4& _p0)
{
    return dot(_p0, float4(1.0, 0.0039215688593685626983642578125, 1.5378700481960549950599670410156e-05, 6.0308629201699659461155533790588e-08));
}

static inline __attribute__((always_inline))
float _f2(thread const float& _p0)
{
    return 1.0 / (1.0 + ((_p0 * _p0) * 11.10999965667724609375));
}

static inline __attribute__((always_inline))
float3 _f3(thread const float& _p0, thread const float2& _p1, texture2d<float> u_inputTex, sampler u_inputTexSmplr, thread float2& v_uv, constant float& u_stride)
{
    float _t2 = 0.0;
    float _t3 = 0.0;
    float _88 = 1.0 / _p0;
    int _95 = int(fast::min(_p0, 100.0));
    float4 param = u_inputTex.sample(u_inputTexSmplr, v_uv);
    float param_1 = 0.0;
    float _110 = _f2(param_1);
    _t2 += (_f1(param) * _110);
    _t3 += _110;
    for (int _t8 = 2; _t8 <= _95; _t8 += 2)
    {
        float _132 = float(_t8);
        float param_2 = _132 * _88;
        float _138 = _f2(param_2);
        float2 _146 = (_p1 * _132) * u_stride;
        float4 param_3 = u_inputTex.sample(u_inputTexSmplr, (v_uv + _146));
        float4 param_4 = u_inputTex.sample(u_inputTexSmplr, (v_uv - _146));
        _t2 += ((_f1(param_3) + _f1(param_4)) * _138);
        _t3 += (_138 * 2.0);
    }
    return float3(_t2 / _t3);
}

static inline __attribute__((always_inline))
float4 _f0(thread float& _p0)
{
    _p0 *= 255.0;
    float4 _t0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0) * 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0) * 255.0;
    _t0.z = floor(_p0) / 255.0;
    _t0.w = fract(_p0);
    return _t0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float param = buffer.u_steps;
    float2 param_1 = buffer.u_dir;
    float3 _t16 = _f3(param, param_1, u_inputTex, u_inputTexSmplr, in.v_uv, buffer.u_stride);
    float param_2 = _t16.x;
    float4 _202 = _f0(param_2);
    out.o_fragColor = _202;
    return out;
}

