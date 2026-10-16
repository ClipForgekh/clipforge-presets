#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uniAlpha;
};

constant float4 _84 = {};

struct main0_out
{
    float4 fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(uv0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture3d<float> u_albedo [[texture(0)]], texture2d<float> VIDEO [[texture(1)]], sampler u_albedoSmplr [[sampler(0)]], sampler VIDEOSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _34 = VIDEO.sample(VIDEOSmplr, in.uv0);
    float3 _74 = _34.xyz;
    float4 _75 = u_albedo.sample(u_albedoSmplr, _74);
    float4 _77 = _84;
    _77.x = _75.x;
    float4 _79 = _77;
    _79.y = _75.y;
    float4 _81 = _79;
    _81.z = _75.z;
    out.fragColor = float4(mix(_74, _81.xyz, float3(buffer.uniAlpha)), _34.w);
    return out;
}

