#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_screen_size;
    float2 u_size;
    float u_scale;
    float u_angle;
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
    float _109 = buffer.u_angle * 0.01745329238474369049072265625;
    float _111 = cos(_109);
    float _113 = sin(_109);
    float2 _128 = fma(in.a_texcoord0, buffer.u_screen_size, buffer.u_screen_size * float2(-0.5));
    out.v_uv = (float2(dot(float2(_111, _113), _128), dot(float2(-_113, _111), _128)) / (buffer.u_size * float2(buffer.u_scale))) + float2(0.5);
    out.gl_Position = in.a_position;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

