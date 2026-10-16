#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_angle;
    float u_aspectRatio;
    float2 u_rotationPoint;
    float2 u_screenSize;
    float u_radius;
    float u_fade0;
    float u_fade1;
    float u_opacity;
    float2 u_maskPosition;
    float2 u_maskSize;
    int u_maskType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float4 _f0(constant float& u_angle, constant float& u_aspectRatio, thread float2& v_uv, constant float2& u_rotationPoint, constant float2& u_screenSize, constant float& u_radius, constant float& u_fade0, constant float& u_fade1, constant float& u_opacity)
{
    float _27 = (u_angle * 3.141590118408203125) / 180.0;
    float _32 = cos(_27);
    float _34 = sin(_27);
    float2 _72 = u_screenSize * 0.5;
    float2 _83 = abs((((float2x2(float2(_32, (-_34) * u_aspectRatio), float2(_34 / u_aspectRatio, _32)) * (v_uv - u_rotationPoint)) + u_rotationPoint) * u_screenSize) - _72) - (_72 - float2(u_radius));
    float2 _t6 = _83;
    return ((float4(1.0) * smoothstep(u_fade0, u_fade1, -((length(fast::max(_83, float2(0.0))) + fast::min(fast::max(_t6.x, _t6.y), 0.0)) - u_radius))) * u_opacity) * (step(0.001000000047497451305389404296875, u_screenSize.x) * step(0.001000000047497451305389404296875, u_screenSize.y));
}

static inline __attribute__((always_inline))
float _f1(thread const float2& _p0, thread float2& v_uv, constant float2& u_screenSize, constant float2& u_maskPosition)
{
    float2 _140 = float2(u_maskPosition.x - (_p0.x * 0.5), u_maskPosition.y - (_p0.y * 0.5));
    float2 _t9 = _140;
    float2 _154 = float2(u_maskPosition.x + (_p0.x * 0.5), u_maskPosition.y + (_p0.y * 0.5));
    float2 _t10 = _154;
    float2 _t11 = (_140 + _154) / float2(2.0);
    float _168 = (_t10.x - _t9.x) / 2.0;
    float _175 = (_t10.y - _t9.y) / 2.0;
    return smoothstep(1.0, 1.0 - ((3.0 / u_screenSize.x) / fast::max(_168, _175)), (((v_uv.x - _t11.x) * (v_uv.x - _t11.x)) / (_168 * _168)) + (((v_uv.y - _t11.y) * (v_uv.y - _t11.y)) / (_175 * _175)));
}

static inline __attribute__((always_inline))
float4 _f2(thread float2& v_uv, constant float2& u_screenSize, constant float& u_opacity, constant float2& u_maskPosition, constant float2& u_maskSize)
{
    float2 param = u_maskSize;
    return (float4(1.0) * u_opacity) * _f1(param, v_uv, u_screenSize, u_maskPosition);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float4 _t20 = float4(0.0);
    if (buffer.u_maskType == 0)
    {
        _t20 = _f0(buffer.u_angle, buffer.u_aspectRatio, in.v_uv, buffer.u_rotationPoint, buffer.u_screenSize, buffer.u_radius, buffer.u_fade0, buffer.u_fade1, buffer.u_opacity);
    }
    else
    {
        if (buffer.u_maskType == 1)
        {
            _t20 = _f2(in.v_uv, buffer.u_screenSize, buffer.u_opacity, buffer.u_maskPosition, buffer.u_maskSize);
        }
    }
    out.o_fragColor = _t20;
    return out;
}

