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
    return exp((_p0 * _p0) * (-5.5555553436279296875));
}

static inline __attribute__((always_inline))
float _f1(thread const float4& _p0)
{
    return fma(_p0.w, 6.0308629201699659461155533790588e-08, fma(_p0.z, 1.5378700481960549950599670410156e-05, fma(_p0.y, 0.0039215688593685626983642578125, _p0.x)));
}

static inline __attribute__((always_inline))
float3 _f3(thread const int& _p0, thread const float2& _p1, thread float2& v_uv, constant float& u_stride, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr)
{
    float _t2 = 0.0;
    float _t3 = 0.0;
    for (int _t4 = 0; _t4 < 1000; _t4++)
    {
        if (_t4 >= _p0)
        {
            break;
        }
        float _121 = float(_t4);
        float param = _121 / float(_p0);
        float _128 = _f2(param);
        float4 param_1 = u_inputTexture.sample(u_inputTextureSmplr, (v_uv + ((_p1 * _121) * u_stride)));
        float4 param_2 = u_inputTexture.sample(u_inputTextureSmplr, (v_uv + ((_p1 * (-_121)) * u_stride)));
        _t2 = fma((_f1(param_1) + _f1(param_2)) * _128, 0.5, _t2);
        _t3 += _128;
    }
    return float3(_t2) / fast::max(float3(_t3), float3(0.001000000047497451305389404296875));
}

static inline __attribute__((always_inline))
float4 _f0(thread float& _p0)
{
    float4 _t0 = float4(0.0);
    _p0 *= 255.0;
    _t0.x = floor(_p0) * 0.0039215688593685626983642578125;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.y = floor(_p0) * 0.0039215688593685626983642578125;
    _p0 = fract(_p0);
    _p0 *= 255.0;
    _t0.z = floor(_p0) * 0.0039215688593685626983642578125;
    _p0 = fract(_p0);
    _t0.w = _p0;
    return _t0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    int param = buffer.u_steps;
    float2 param_1 = float2(cos(buffer.u_angle), sin(buffer.u_angle)) / ((buffer.u_ScreenParams.xy * 1080.0) / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y)));
    float3 _t13 = _f3(param, param_1, in.v_uv, buffer.u_stride, u_inputTexture, u_inputTextureSmplr);
    float param_2 = _t13.x;
    float4 _228 = _f0(param_2);
    out.o_fragColor = _228;
    return out;
}

