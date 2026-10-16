#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_orientation;
    float2 u_center;
    float u_stretch;
    float2 u_size;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_xy [[user(locn0)]];
};

static inline __attribute__((always_inline))
float _f1(thread const float& _p0, thread const float& _p1)
{
    return fma((_p1 * 2.0) * _p0, _p0, _p0);
}

static inline __attribute__((always_inline))
float _f2(thread const float& _p0, thread const float& _p1)
{
    float param = _p0;
    float param_1 = _p1;
    return (_p0 * _p0) / _f1(param, param_1);
}

static inline __attribute__((always_inline))
float4 _f0(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    float2 _31 = _p1;
    _p1 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
    return (_p0.sample(_p0Smplr, _31) * _p1.x) * _p1.y;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t2 = buffer.u_orientation;
    float2 _88 = float2(_t2.y, -_t2.x);
    float2 _95 = in.v_xy - buffer.u_center;
    float _107 = dot(_95, buffer.u_orientation);
    float param = _107;
    float param_1 = buffer.u_stretch;
    float2 param_2 = mix((buffer.u_center + (_88 * dot(_95, _88))) + (buffer.u_orientation * _f2(param, param_1)), in.v_xy, float2(step(_107 * buffer.u_stretch, 0.0))) / buffer.u_size;
    float4 _135 = _f0(u_inputTex, u_inputTexSmplr, param_2);
    out.o_fragColor = _135;
    return out;
}

