#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_screen_size;
    float2 u_position;
    float2 u_anchor;
    float2 u_scale;
};

struct main0_out
{
    float2 v_uv [[user(v_uv)]];
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
    out.v_uv = (fma(in.a_texcoord0, buffer.u_screen_size, -(buffer.u_position * buffer.u_screen_size)) / (buffer.u_screen_size * buffer.u_scale)) + buffer.u_anchor;
    out.gl_Position = in.a_position;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

