#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_Speed;
    float u_XSpeed;
    float u_Twist;
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
};

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0, thread const float& _p1, constant float& u_Speed, constant float& u_XSpeed)
{
    if (abs(_p1) <= 9.9999999747524270787835121154785e-07)
    {
        return _p0;
    }
    float2 _t0 = _p0;
    float2 _t1 = (_p0 * 0.5) + float2(0.5);
    _t0.y -= (((sin(((((_t1.x - (u_Speed / 30.0)) - 0.100000001490116119384765625) * 3.141592502593994140625) * u_XSpeed) * 2.0) * _p1) * 0.5) * sin(_t1.y * 3.141592502593994140625));
    return _t0;
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float4 _82 = float4(in.a_position.xy, 0.0, 1.0);
    float4 _t3 = _82;
    float2 param = _82.xy;
    float param_1 = buffer.u_Twist;
    float2 _89 = _f0(param, param_1, buffer.u_Speed, buffer.u_XSpeed);
    _t3.x = _89.x;
    _t3.y = _89.y;
    out.gl_Position = _t3;
    out.v_uv = in.a_texcoord0;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

