#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float2 uv1 [[user(uv1)]];
    float2 uv0 [[user(uv0)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 attPosition [[attribute(0)]];
    float2 attUV [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]])
{
    main0_out out = {};
    out.gl_Position = float4(in.attPosition.xy, in.attPosition.z, 1.0);
    out.uv1 = float2(fma(in.attPosition.x, 0.5, 0.5), fma(in.attPosition.y, 0.5, 0.5));
    out.uv0 = in.attUV;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

