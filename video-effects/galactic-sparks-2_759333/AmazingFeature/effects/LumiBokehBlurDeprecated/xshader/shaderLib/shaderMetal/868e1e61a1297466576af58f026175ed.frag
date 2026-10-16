#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_intensity;
    float u_scaleX;
    float u_scaleY;
    float u_quality;
    float u_regionIns;
    float u_lightIns;
    float u_baseTexWidth;
    float u_baseTexHeight;
    float u_blurSize;
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
float _f1(thread const float2& _p0)
{
    return step(dot(_p0, _p0), 121.0);
}

static inline __attribute__((always_inline))
float2x2 _f0(thread const float& _p0)
{
    float _32 = sin(_p0);
    float _35 = cos(_p0);
    return float2x2(float2(_35, -_32), float2(_32, _35));
}

static inline __attribute__((always_inline))
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2, thread const float2& _p3, constant float& u_intensity, constant float& u_scaleX, constant float& u_scaleY, constant float& u_quality, constant float& u_regionIns, constant float& u_lightIns)
{
    if (u_intensity < 0.00999999977648258209228515625)
    {
        return _p0.sample(_p0Smplr, _p1);
    }
    float4 _t4 = float4(0.0);
    float4 _t6 = float4(0.0);
    float4 _t7 = float4(0.4000000059604644775390625);
    float2 _102 = ((float2(2.0) * float2(u_scaleX, u_scaleY)) * float2(_p2)) / _p3;
    float _110 = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float _121 = fast::max(5.0, (12.0 / _110) * mix(0.60000002384185791015625, 1.0, u_quality));
    float _126 = mix(0.699999988079071044921875, 1.0, u_regionIns);
    for (float _t12 = 0.0; _t12 < 30.0; _t12 += 1.0)
    {
        if ((_t12 > _121) || (u_intensity < 0.300000011920928955078125))
        {
            break;
        }
        for (float _t13 = 0.0; _t13 < 30.0; _t13 += 1.0)
        {
            if (_t13 > _121)
            {
                break;
            }
            float2 _171 = float2(mix(-11.0, 11.0, _t12 / _121), mix(-11.0, 11.0, _t13 / _121));
            float2 param = _171;
            if (_f1(param) < 0.5)
            {
                continue;
            }
            float4 _187 = _p0.sample(_p0Smplr, (_p1 - ((_171 * 0.5) * _102)));
            _t4 = fast::max(_t4, _187 * _126);
            float4 _201 = ((pow(_187, float4(9.0)) * 539.45001220703125) + float4(0.4000000059604644775390625)) * u_regionIns;
            _t6 += (_201 * _187);
            _t7 += _201;
        }
    }
    float _226 = fast::max(15.0, (34.0 / _110) * mix(0.5, 1.0, fast::clamp(u_quality * 1.5, 0.0, 1.0)));
    float param_1 = 6.280000209808349609375 / _226;
    float2x2 _233 = _f0(param_1);
    float2 _t18 = float2(11.0, 0.0);
    for (float _t19 = 0.0; _t19 < 70.0; _t19 += 1.0)
    {
        if (_t19 > _226)
        {
            break;
        }
        float2 _252 = _t18;
        float2 _253 = _252 * _233;
        _t18 = _253;
        float4 _262 = _p0.sample(_p0Smplr, (_p1 - ((_253 * 0.5) * _102)));
        _t4 = fast::max(_t4, _262);
        float4 _271 = (pow(_262, float4(9.0)) * 539.45001220703125) + float4(0.4000000059604644775390625);
        _t6 += (_271 * _262);
        _t7 += _271;
    }
    float4 _288 = fast::clamp(_t6 / _t7, float4(0.0), float4(1.0));
    return float4(mix(_288, _t4, fast::clamp(_288 * u_lightIns, float4(0.0), float4(1.0))));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.v_uv;
    float param_1 = buffer.u_blurSize;
    float2 param_2 = (float2(buffer.u_baseTexWidth, buffer.u_baseTexHeight) / float2(fast::min(buffer.u_baseTexWidth, buffer.u_baseTexHeight))) * 720.0;
    out.o_fragColor = _f2(u_inputTex, u_inputTexSmplr, param, param_1, param_2, buffer.u_intensity, buffer.u_scaleX, buffer.u_scaleY, buffer.u_quality, buffer.u_regionIns, buffer.u_lightIns);
    return out;
}

