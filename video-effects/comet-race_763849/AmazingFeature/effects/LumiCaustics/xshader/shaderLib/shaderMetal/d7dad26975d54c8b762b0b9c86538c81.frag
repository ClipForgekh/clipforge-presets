#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float u_height;
    float u_causticsStep;
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
float _f5(thread const float2& _p0, constant float4& u_ScreenParams, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr, constant float& u_height, constant float& u_causticsStep, constant float& u_causticsSize)
{
    float2 param = _p0;
    float _126 = _f4(param, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
    float _t3 = _126;
    float _t4 = _126;
    float _t5 = _126;
    float _t6 = 1.0;
    for (int _t7 = 1; _t7 <= 1024; _t7++)
    {
        float _153 = float(_t7) * u_causticsStep;
        if (_153 > u_causticsSize)
        {
            break;
        }
        float _t9 = _p0.x + _153;
        for (int _t10 = 1; _t10 <= 1024; _t10++)
        {
            float _178 = float(_t10) * u_causticsStep;
            if (_178 > u_causticsSize)
            {
                break;
            }
            if (length(float2(_153, _178)) > u_causticsSize)
            {
                break;
            }
            float2 param_1 = float2(_t9, _p0.y + _178);
            float _202 = _f4(param_1, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
            float2 param_2 = float2(_t9, _p0.y - _178);
            float _211 = _f4(param_2, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
            _t5 += (_202 + _211);
            _t6 += 2.0;
            _t3 = fast::min(fast::min(_t3, _202), _211);
            _t4 = fast::max(fast::max(_t4, _202), _211);
        }
        _t9 = _p0.x - _153;
        for (int _t14 = 1; _t14 <= 1024; _t14++)
        {
            float _250 = float(_t14) * u_causticsStep;
            if (_250 > u_causticsSize)
            {
                break;
            }
            if (length(float2(_153, _250)) > u_causticsSize)
            {
                break;
            }
            float2 param_3 = float2(_t9, _p0.y + _250);
            float _274 = _f4(param_3, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
            float2 param_4 = float2(_t9, _p0.y - _250);
            float _283 = _f4(param_4, u_ScreenParams, u_inputTexture, u_inputTextureSmplr, u_height);
            _t5 += (_274 + _283);
            _t6 += 2.0;
            _t3 = fast::min(fast::min(_t3, _274), _283);
            _t4 = fast::max(fast::max(_t4, _274), _283);
        }
    }
    float _308 = _t5;
    float _309 = _308 / _t6;
    _t5 = _309;
    float _315 = _t4 - _t3;
    return mix(0.5, (_309 - _t3) / _315, step(0.20000000298023223876953125, _315));
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
        float param_1 = _f5(param, buffer.u_ScreenParams, u_inputTexture, u_inputTextureSmplr, buffer.u_height, buffer.u_causticsStep, buffer.u_causticsSize);
        float4 _342 = _f2(param_1);
        out.o_fragColor = _342;
    }
    else
    {
        float param_2 = 0.5;
        float4 _345 = _f2(param_2);
        out.o_fragColor = _345;
    }
    return out;
}

