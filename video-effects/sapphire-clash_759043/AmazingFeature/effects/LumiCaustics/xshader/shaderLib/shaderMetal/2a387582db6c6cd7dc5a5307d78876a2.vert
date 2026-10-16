#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
};

struct main0_out
{
    float2 v_xy [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float2 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

static inline __attribute__((always_inline))
float2 _f0(constant float4& u_ScreenParams)
{
    return u_ScreenParams.xy;
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, constant float4& u_ScreenParams)
{
    return (_p0 - float2(0.5)) * _f0(u_ScreenParams);
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    out.gl_Position = float4(in.a_position, 0.0, 1.0);
    float2 param = in.a_texcoord0;
    out.v_xy = _f1(param, buffer.u_ScreenParams);
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

