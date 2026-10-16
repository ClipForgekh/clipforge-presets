#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_lineOffsetX;
    float u_lineOffsetY;
    float u_reflectionAngle;
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
float2 _f1(thread const float2& _p0, thread const float2& _p1, thread const float& _p2, constant float4& u_ScreenParams)
{
    float2 _t1 = _p0 - _p1;
    float _53 = u_ScreenParams.x / u_ScreenParams.y;
    bool _56 = _53 < 1.0;
    float2 _57;
    if (_56)
    {
        _57 = float2(_53, 1.0);
    }
    else
    {
        _57 = float2(1.0, 1.0 / _53);
    }
    _t1 = float2x2(float2(cos(_p2), sin(_p2)), float2(-sin(_p2), cos(_p2))) * (_t1 * _57);
    float2 _89;
    if (_56)
    {
        _89 = float2(_53, 1.0);
    }
    else
    {
        _89 = float2(1.0, 1.0 / _53);
    }
    float2 _99 = _t1;
    float2 _100 = _99 / _89;
    _t1 = _100;
    return _100 + _p1;
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    float2 _t0 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t0.x * _t0.y;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _124 = 1.0 / fast::max(fast::max(buffer.u_ScreenParams.x / buffer.u_ScreenParams.y, buffer.u_ScreenParams.y / buffer.u_ScreenParams.x) * 2.2000000476837158203125, 0.001000000047497451305389404296875);
    float2 param = (((float2(in.v_uv.x, 1.0 - in.v_uv.y) - float2(0.5)) * _124) + float2(0.5)) - (float2(buffer.u_lineOffsetX, buffer.u_lineOffsetY) * _124);
    float2 param_1 = float2(0.5);
    float param_2 = buffer.u_reflectionAngle;
    float2 _158 = _f1(param, param_1, param_2, buffer.u_ScreenParams);
    float2 param_3 = _158;
    out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, _158) * _f0(param_3);
    return out;
}

