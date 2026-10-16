#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float negativeAlpha;
};

constant float4 _89 = {};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_albedo [[texture(0)]], sampler u_albedoSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _31 = u_albedo.sample(u_albedoSmplr, in.v_uv);
    float3 _36 = _31.xyz;
    float3 _75 = float3(1.0) - _36;
    float4 _77 = _89;
    _77.x = _75.x;
    float4 _79 = _77;
    _79.y = _75.y;
    float4 _81 = _79;
    _81.z = _75.z;
    float3 _61 = mix(_36, _81.xyz, float3(buffer.negativeAlpha));
    float4 _83 = _31;
    _83.x = _61.x;
    float4 _85 = _83;
    _85.y = _61.y;
    float4 _87 = _85;
    _87.z = _61.z;
    out.o_fragColor = _87;
    return out;
}

