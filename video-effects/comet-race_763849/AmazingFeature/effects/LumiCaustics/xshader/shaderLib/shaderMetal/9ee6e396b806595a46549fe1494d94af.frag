#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_stride;
    float4 u_ScreenParams;
    float u_angle;
    int u_steps;
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
float _f2(thread const float& _p0)
{
    return exp(((-0.5) * (_p0 * _p0)) / 0.0900000035762786865234375);
}

static inline __attribute__((always_inline))
float _f1(thread const float4& _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

static inline __attribute__((always_inline))
float _f3(thread const int& _p0, thread const float2& _p1, thread float2& v_uv, constant float& u_stride, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr)
{
    float _t2 = 0.0;
    float _t3 = 0.0;
    for (int _t4 = 0; _t4 < 128; _t4++)
    {
        if (_t4 >= _p0)
        {
            break;
        }
        float _120 = float(_t4);
        float param = _120 / float(_p0);
        float _127 = _f2(param);
        float4 param_1 = u_inputTexture.sample(u_inputTextureSmplr, (v_uv + ((_p1 * _120) * u_stride)));
        float4 param_2 = u_inputTexture.sample(u_inputTextureSmplr, (v_uv + ((_p1 * (-_120)) * u_stride)));
        _t2 += (((_f1(param_1) + _f1(param_2)) * _127) / 2.0);
        _t3 += _127;
    }
    return _t2 / fast::max(_t3, 0.001000000047497451305389404296875);
}

static inline __attribute__((always_inline))
float4 _f0(thread float& _p0)
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
    int param = buffer.u_steps;
    float2 param_1 = float2(cos(buffer.u_angle), sin(buffer.u_angle)) / ((buffer.u_ScreenParams.xy * 720.0) / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y)));
    float param_2 = _f3(param, param_1, in.v_uv, buffer.u_stride, u_inputTexture, u_inputTextureSmplr);
    float4 _222 = _f0(param_2);
    out.o_fragColor = _222;
    return out;
}

