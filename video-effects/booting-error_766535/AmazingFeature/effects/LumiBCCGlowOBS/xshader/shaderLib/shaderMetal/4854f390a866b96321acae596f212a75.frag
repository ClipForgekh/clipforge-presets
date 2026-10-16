#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_edgeMode;
    float4 u_ScreenParams;
    float u_Radius;
    float u_MaxRadius;
    float u_Sigma;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float _f2(thread const float& _p0, thread const float& _p1)
{
    return exp((-(_p0 * _p0)) / _p1);
}

static inline __attribute__((always_inline))
float2 _f0(thread const float& _p0, thread const float& _p1, constant int& u_edgeMode)
{
    float2 _t0 = float2(1.0);
    if (u_edgeMode == 0)
    {
        _t0.x = step(0.0, _p0) * step(_p0, 1.0);
        _t0.y = step(0.0, _p1) * step(_p1, 1.0);
    }
    return _t0;
}

static inline __attribute__((always_inline))
float4 _f1(thread const float& _p0, constant int& u_edgeMode, constant float4& u_ScreenParams, thread float2& uv0, texture2d<float> u_InputTexture, sampler u_InputTextureSmplr)
{
    float2 _67 = float2(1.0) / u_ScreenParams.xy;
    float2 _76 = uv0 + (_67 * float2(0.0, _p0));
    float2 _t2 = _76;
    float2 _83 = uv0 - (_67 * float2(0.0, _p0));
    float2 _t3 = _83;
    float param = _t2.y;
    float param_1 = _t3.y;
    float2 _t4 = _f0(param, param_1, u_edgeMode);
    return (u_InputTexture.sample(u_InputTextureSmplr, _76) * _t4.x) + (u_InputTexture.sample(u_InputTextureSmplr, _83) * _t4.y);
}

static inline __attribute__((always_inline))
float4 _f3(thread float4& _p0, constant int& u_edgeMode, constant float4& u_ScreenParams, thread float2& uv0, texture2d<float> u_InputTexture, sampler u_InputTextureSmplr, constant float& u_Radius, constant float& u_MaxRadius, constant float& u_Sigma)
{
    float4 _t5 = float4(1.0);
    float4 _t6 = float4(0.0);
    float _134 = fast::max(1.0, u_Radius / u_MaxRadius);
    float _t9 = 1.0;
    for (float _t10 = 1.0; _t10 <= 128.0; _t10 += 1.0)
    {
        if (_t9 > 128.0)
        {
            break;
        }
        if ((_t9 > (u_MaxRadius * _134)) || (!(_t9 <= u_Radius)))
        {
            break;
        }
        float param = _t9;
        float param_1 = u_Sigma;
        _t6.x = step(_t9, u_Radius) * _f2(param, param_1);
        float param_2 = _t9;
        float param_3 = u_Sigma;
        _t6.y = step(_t9, u_Radius) * _f2(param_2, param_3);
        float param_4 = _t9;
        float param_5 = u_Sigma;
        _t6.z = step(_t9, u_Radius) * _f2(param_4, param_5);
        float param_6 = _t9;
        float param_7 = u_Sigma;
        _t6.w = step(_t9, u_Radius) * _f2(param_6, param_7);
        float param_8 = _t9;
        _p0 += (_f1(param_8, u_edgeMode, u_ScreenParams, uv0, u_InputTexture, u_InputTextureSmplr) * _t6);
        _t5 += (_t6 * 2.0);
        _t9 += _134;
    }
    _p0 /= _t5;
    return _p0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_InputTexture [[texture(0)]], sampler u_InputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 param = u_InputTexture.sample(u_InputTextureSmplr, in.uv0);
    float4 _238 = _f3(param, buffer.u_edgeMode, buffer.u_ScreenParams, in.uv0, u_InputTexture, u_InputTextureSmplr, buffer.u_Radius, buffer.u_MaxRadius, buffer.u_Sigma);
    out.o_fragColor = _238;
    return out;
}

