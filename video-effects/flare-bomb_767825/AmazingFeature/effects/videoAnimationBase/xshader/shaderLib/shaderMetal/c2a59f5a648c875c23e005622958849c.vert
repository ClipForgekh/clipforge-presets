#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float2 uv1 [[user(locn0)]];
    float2 uv0 [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]])
{
    main0_out out = {};
    float2 _t0 = in.a_position.xy;
    out.gl_Position = float4(in.a_position.xy, in.a_position.z, 1.0);
    out.uv1 = float2((_t0.x * 0.5) + 0.5, (_t0.y * 0.5) + 0.5);
    out.uv0 = in.a_texcoord0;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

