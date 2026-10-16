#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float frame;
    float4x4 u_MVP;
};

struct main0_out
{
    float2 v_uv [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
    float2 a_texcoord1 [[attribute(2)]];
    float3 a_normal [[attribute(3)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    if (buffer.frame >= 1.0)
    {
        out.gl_Position = buffer.u_MVP * float4(in.a_normal, 1.0);
        out.v_uv = in.a_texcoord1;
    }
    else
    {
        if (buffer.frame > 0.0)
        {
            out.gl_Position = buffer.u_MVP * float4(mix(in.a_position, in.a_normal, float3(buffer.frame)), 1.0);
            out.v_uv = mix(in.a_texcoord0, in.a_texcoord1, float2(buffer.frame));
        }
        else
        {
            out.gl_Position = buffer.u_MVP * float4(in.a_position, 1.0);
            out.v_uv = in.a_texcoord0;
        }
    }
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

