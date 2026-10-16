#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_lineOffsetY;
    float u_fixDistance;
    float u_reflectionAngle;
    float u_lineOffsetX;
    float u_reflectionDistance;
    float u_reflectionFalloff;
    float u_opacity;
    float3 u_tintColor;
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
float2 _f0(thread float2& _p0, thread const float2& _p1, thread const float& _p2, constant float4& u_ScreenParams)
{
    float _28 = sin(_p2);
    float _31 = cos(_p2);
    _p0 -= _p1;
    float _47 = u_ScreenParams.x / u_ScreenParams.y;
    bool _51 = _47 < 1.0;
    if (_51)
    {
        _p0.x *= _47;
    }
    else
    {
        _p0.y /= _47;
    }
    _p0 = float2x2(float2(_31, _28), float2(-_28, _31)) * _p0;
    if (_51)
    {
        _p0.x /= _47;
    }
    else
    {
        _p0.y *= _47;
    }
    return _p0 + _p1;
}

static inline __attribute__((always_inline))
float _f2(thread const float2& _p0, thread const float& _p1, thread const float& _p2)
{
    float _t3 = 0.0;
    if (_p2 < 0.5)
    {
        _t3 = smoothstep(0.0, (2.0 * _p1) * _p2, _p0.y);
    }
    else
    {
        _t3 = smoothstep((2.0 * _p1) * (_p2 - 0.5), _p1, _p0.y);
    }
    float _138 = _t3;
    float _139 = 1.0 - _138;
    _t3 = _139;
    return _139;
}

static inline __attribute__((always_inline))
float _f1(thread const float2& _p0)
{
    return ((step(0.0, _p0.x) * step(0.0, _p0.y)) * step(_p0.x, 1.0)) * step(_p0.y, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t5 = float2(0.0, 1.0 - buffer.u_lineOffsetY);
    float2 _180 = ((float2(in.v_uv.x, 1.0 - in.v_uv.y) - float2(0.5)) * (fast::max(buffer.u_ScreenParams.x / buffer.u_ScreenParams.y, buffer.u_ScreenParams.y / buffer.u_ScreenParams.x) * 2.2000000476837158203125)) + float2(0.5);
    float2 _t6 = _180;
    float2 param = float2(_t6.x, _t6.y);
    float2 param_1 = float2(0.5);
    float param_2 = buffer.u_reflectionAngle;
    float2 _205 = _f0(param, param_1, param_2, buffer.u_ScreenParams);
    _t6 = _205 + float2(buffer.u_lineOffsetX, _t5.y - 1.0);
    float2 param_3 = _180 + float2(0.0, (_t5.y - 1.0) - mix(0.0, 0.3499999940395355224609375, fast::clamp(buffer.u_fixDistance, 0.0, 1.0)));
    float param_4 = buffer.u_reflectionDistance;
    float param_5 = buffer.u_reflectionFalloff;
    float2 param_6 = _t6;
    float4 _241 = ((u_inputTexture.sample(u_inputTextureSmplr, _t6) * _f1(param_6)) * buffer.u_opacity) * _f2(param_3, param_4, param_5);
    float4 _t9 = _241;
    float3 _248 = _241.xyz * buffer.u_tintColor;
    _t9.x = _248.x;
    _t9.y = _248.y;
    _t9.z = _248.z;
    out.o_fragColor = _t9;
    return out;
}

