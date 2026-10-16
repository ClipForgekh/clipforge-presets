#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_height;
    float u_causticsSize;
    int u_enable;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_xy [[user(locn0)]];
};

static inline __attribute__((always_inline))
float2 _f0(constant float4& u_ScreenParams)
{
    return u_ScreenParams.xy;
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, constant float4& u_ScreenParams)
{
    return (_p0 / _f0(u_ScreenParams)) + float2(0.5);
}

static inline __attribute__((always_inline))
float _f3(thread const float4& _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

static inline __attribute__((always_inline))
float _f4(thread const float2& _p0, constant float4& u_ScreenParams, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr, constant float& u_height)
{
    float2 param = _p0;
    float4 param_1 = u_inputTexture.sample(u_inputTextureSmplr, _f1(param, u_ScreenParams));
    return _f3(param_1) * u_height;
}

static inline __attribute__((always_inline))
float _f5(thread const float2& _p0, constant float4& u_ScreenParams, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr, constant float& u_height, constant float& u_causticsSize)
{
    float2 param = _p0;
    float _126 = _f4(param, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
    float _131 = fast::max(u_causticsSize, 1.0);
    float2 _134 = float2(_131, 0.0);
    float2 _137 = float2(0.0, _131);
    float2 param_1 = _p0 + _134;
    float _143 = _f4(param_1, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
    float2 param_2 = _p0 - _134;
    float _149 = _f4(param_2, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
    float2 param_3 = _p0 + _137;
    float _155 = _f4(param_3, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
    float2 param_4 = _p0 - _137;
    float _161 = _f4(param_4, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
    float _183 = fast::min(_126, fast::min(_143, fast::min(_149, fast::min(_155, _161))));
    float _197 = fast::max(_126, fast::max(_143, fast::max(_149, fast::max(_155, _161)))) - _183;
    return mix(0.5, ((((((_126 + _143) + _149) + _155) + _161) * 0.20000000298023223876953125) - _183) / fast::max(_197, 9.9999999747524270787835121154785e-07), step(0.20000000298023223876953125, _197));
}

static inline __attribute__((always_inline))
float4 _f2(thread float& _p0)
{
    float4 _t0 = float4(0.0);
    _p0 *= 255.0;
    _t0.x = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.y = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.z = floor(_p0) / 255.0;
    _p0 = fract(_p0);
    _t0.w = _p0;
    return _t0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.u_enable > 0)
    {
        float2 param = in.v_xy;
        float param_1 = _f5(param, buffer.u_ScreenParams, u_inputTexture, u_inputTextureSmplr, buffer.u_height, buffer.u_causticsSize);
        float4 _231 = _f2(param_1);
        out.o_fragColor = _231;
    }
    else
    {
        float param_2 = 0.5;
        float4 _234 = _f2(param_2);
        out.o_fragColor = _234;
    }
    return out;
}

