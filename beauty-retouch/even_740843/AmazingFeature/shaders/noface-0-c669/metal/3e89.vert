#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4x4 mvpMat;
};

struct main0_out
{
    float2 uv [[user(uv)]];
    float4 uv1 [[user(uv1)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 position [[attribute(0)]];
    float2 texcoord0 [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float4 pos = float4(in.position.xy, 0.0, 1.0);
    out.gl_Position = buffer.mvpMat * pos;
    out.uv1 = buffer.mvpMat * pos;
    out.uv = in.texcoord0;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

