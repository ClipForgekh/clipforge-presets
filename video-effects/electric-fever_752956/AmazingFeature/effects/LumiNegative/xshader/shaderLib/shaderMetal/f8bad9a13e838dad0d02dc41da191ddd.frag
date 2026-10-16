#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_negativeAlpha;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _19 = u_inputTex.sample(u_inputTexSmplr, in.v_uv);
    float4 _t0 = _19;
    float4 _t1 = _19;
    float3 _25 = _19.xyz;
    float3 _27 = float3(1.0) - _25;
    _t1.x = _27.x;
    _t1.y = _27.y;
    _t1.z = _27.z;
    float3 _47 = mix(_25, _t1.xyz, float3(buffer.u_negativeAlpha));
    _t0.x = _47.x;
    _t0.y = _47.y;
    _t0.z = _47.z;
    out.o_fragColor = _t0;
    return out;
}

