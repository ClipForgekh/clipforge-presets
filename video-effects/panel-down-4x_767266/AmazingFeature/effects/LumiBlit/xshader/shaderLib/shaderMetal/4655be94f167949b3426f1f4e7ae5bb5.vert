#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct buffer_t
{
    float3 u_anchorPoint;
    float4 u_ScreenParams;
    float3 u_fragScale;
    float3 u_fragRotation;
    float3 u_fragTranslation;
    float4x4 u_MVP;
};

struct main0_out
{
    float2 v_uv [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float2 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

static inline __attribute__((always_inline))
float3x3 _f2(thread const float& _p0)
{
    float _63 = cos(_p0);
    float _66 = sin(_p0);
    return float3x3(float3(_63, -_66, 0.0), float3(_66, _63, 0.0), float3(0.0, 0.0, 1.0));
}

static inline __attribute__((always_inline))
float3x3 _f1(thread const float& _p0)
{
    float _46 = cos(_p0);
    float _49 = sin(_p0);
    return float3x3(float3(_46, 0.0, _49), float3(0.0, 1.0, 0.0), float3(-_49, 0.0, _46));
}

static inline __attribute__((always_inline))
float3x3 _f0(thread const float& _p0)
{
    float _27 = cos(_p0);
    float _30 = sin(_p0);
    return float3x3(float3(1.0, 0.0, 0.0), float3(0.0, _27, -_30), float3(0.0, _30, _27));
}

static inline __attribute__((always_inline))
float3x3 _f3(thread const float3& _p0)
{
    float3 _t6 = radians(_p0);
    float param = _t6.z;
    float param_1 = _t6.y;
    float param_2 = _t6.x;
    return (_f2(param) * _f1(param_1)) * _f0(param_2);
}

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float3 _t7 = buffer.u_anchorPoint;
    float3 _t9 = float3(in.a_position, 0.0) - buffer.u_anchorPoint;
    float _130 = 1.0 / (buffer.u_ScreenParams.y / fast::max(buffer.u_ScreenParams.x, 1.0));
    _t9.x *= _130;
    _t7.x *= _130;
    float3 param = buffer.u_fragRotation;
    out.gl_Position = buffer.u_MVP * float4(((_f3(param) * (_t9 * buffer.u_fragScale)) + buffer.u_fragTranslation) + _t7, 1.0);
    out.v_uv = in.a_texcoord0;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

