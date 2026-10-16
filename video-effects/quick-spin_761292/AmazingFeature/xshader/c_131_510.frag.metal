#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float intensity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 color = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float exposure = pow(2.0, buffer.intensity);
    float3 result = color.xyz * exposure;
    out.gl_FragColor = float4(fast::clamp(result, float3(0.0), float3(1.0)), color.w);
    return out;
}

