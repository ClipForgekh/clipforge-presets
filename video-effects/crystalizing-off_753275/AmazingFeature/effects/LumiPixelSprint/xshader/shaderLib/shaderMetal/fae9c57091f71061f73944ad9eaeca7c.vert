#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float3 u_viewPos;
};

struct main0_out
{
    float2 v_uv [[user(locn0)]];
    float3 v_tangentViewPos [[user(locn1)]];
    float3 v_tangentFragPos [[user(locn2)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float4 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    out.v_uv = in.a_texcoord0;
    out.v_tangentViewPos = buffer.u_viewPos;
    out.v_tangentFragPos = in.a_position.xyz;
    out.gl_Position = in.a_position;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

