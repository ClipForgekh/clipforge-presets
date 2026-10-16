#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4x4 u_Model;
    float4x4 u_Projection;
    float4x4 u_View;
};

struct main0_out
{
    float2 vUv [[user(vUv)]];
    float3 vWorldPos [[user(vWorldPos)]];
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
    out.vUv = in.attTexcoord0;
    float4 worldPos = buffer.u_Model * float4(in.attPosition, 1.0);
    out.vWorldPos = worldPos.xyz;
    out.gl_Position = (buffer.u_Projection * buffer.u_View) * worldPos;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

