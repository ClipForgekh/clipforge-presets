#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float signalStrength;
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
float _f0(thread const float3& _p0)
{
    return ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
}

static inline __attribute__((always_inline))
float _f1(thread const float2& _p0)
{
    float2 _49 = fract(_p0 * 1324.5179443359375);
    float2 _t0 = _49 + float2(dot(_49, _49.yx + float2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

static inline __attribute__((always_inline))
float4 _f2(thread const float2& _p0)
{
    return float4(floor(_p0.x * 255.0) / 255.0, fract(_p0.x * 255.0), floor(_p0.y * 255.0) / 255.0, fract(_p0.y * 255.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t6 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float _t7 = 0.0;
    float _t8 = in.v_uv.x;
    for (float _t9 = -10.0; _t9 <= 30.0; _t9 += 2.0)
    {
        float3 param = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv - float2((_t9 + 1.0) * _t6.x, 0.0))).xyz - inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv - float2((_t9 - 1.0) * _t6.x, 0.0))).xyz;
        float _176 = abs(_f0(param)) / 1.0;
        float _179 = step(_t7, _176);
        _t8 = ((1.0 - _179) * _t8) + (_179 * (in.v_uv.x - (_t9 * _t6.x)));
        _t7 = fast::max(_t7, _176);
    }
    float2 param_1 = float2(in.v_uv.y);
    float _215 = _t8;
    float _255 = fast::clamp(_215, 0.0, 1.0);
    _t8 = _255;
    float2 param_2 = float2(fast::clamp(1.0 * pow((fast::min(0.4000000059604644775390625, _t7) * (1.0 - (((step(in.v_uv.x, _215) * (_215 - in.v_uv.x)) / _t6.x) / 10.0))) * (1.0 - (((step(_215, in.v_uv.x) * (in.v_uv.x - _215)) / _t6.x) / 30.0)), 1.2000000476837158203125 + (_f1(param_1) * buffer.signalStrength)), 0.0, 1.0), _255);
    out.o_fragColor = _f2(param_2);
    return out;
}

