#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uvScale;
    float2 uvOffset;
    float4x4 u_MVP;
};

struct main0_out
{
    float2 vUvMapped [[user(vUvMapped)]];
    float2 vLocalUv [[user(vLocalUv)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 attPosition [[attribute(0)]];
    float2 attTexcoord0 [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    out.vLocalUv = in.attTexcoord0;
    out.vUvMapped = (in.attTexcoord0 * buffer.uvScale) + buffer.uvOffset;
    out.gl_Position = buffer.u_MVP * float4(in.attPosition, 1.0);
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

