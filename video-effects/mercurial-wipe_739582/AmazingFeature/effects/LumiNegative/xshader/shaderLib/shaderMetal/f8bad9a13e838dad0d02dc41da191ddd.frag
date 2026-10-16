#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float2 u_size;
    float negativeAlpha;
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
float3 _f0(thread const float3& _p0)
{
    return float3(1.0) - _p0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_albedo [[texture(0)]], sampler u_albedoSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t0 = in.v_uv;
    _t0.y = 1.0 - _t0.y;
    _t0 -= float2(0.5);
    _t0.x *= (buffer.u_ScreenParams.x / buffer.u_size.x);
    _t0.y *= (buffer.u_ScreenParams.y / buffer.u_size.y);
    float2 _61 = _t0;
    float2 _63 = _61 + float2(0.5);
    _t0 = _63;
    float4 _72 = u_albedo.sample(u_albedoSmplr, _63);
    float4 _t1 = _72;
    float4 _t2 = _72;
    float3 param = _72.xyz;
    float3 _78 = _f0(param);
    _t2.x = _78.x;
    _t2.y = _78.y;
    _t2.z = _78.z;
    float4 _86 = _t1;
    float3 _93 = mix(_86.xyz, _t2.xyz, float3(buffer.negativeAlpha));
    _t1.x = _93.x;
    _t1.y = _93.y;
    _t1.z = _93.z;
    out.o_fragColor = _t1;
    return out;
}

