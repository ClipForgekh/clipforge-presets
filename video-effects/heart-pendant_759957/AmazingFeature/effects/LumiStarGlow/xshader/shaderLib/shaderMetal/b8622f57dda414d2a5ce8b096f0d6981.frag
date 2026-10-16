#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    int u_inputType;
    float u_threshold;
    float u_thresholdSmooth;
    float u_maskRadius;
    float2 u_maskCenter;
    float u_maskFade;
    float u_mask;
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
float3 _f1(thread const float4& _p0)
{
    if (_p0.w == 0.0)
    {
        return float3(0.0);
    }
    return _p0.xyz / float3(_p0.w);
}

static inline __attribute__((always_inline))
float _f2(thread const float3& _p0)
{
    return (fast::max(fast::max(_p0.x, _p0.y), _p0.z) + fast::min(fast::min(_p0.x, _p0.y), _p0.z)) * 0.5;
}

static inline __attribute__((always_inline))
float _f3(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float _f4(thread const float4& _p0, constant int& u_inputType)
{
    float4 param = _p0;
    float3 _114 = _f1(param);
    float3 _t3 = _114;
    if (u_inputType == 0)
    {
        float3 param_1 = _114;
        return _f2(param_1);
    }
    else
    {
        if (u_inputType == 1)
        {
            float3 param_2 = _114;
            return _f3(param_2);
        }
        else
        {
            if (u_inputType == 2)
            {
                return _p0.w;
            }
            else
            {
                if (u_inputType == 3)
                {
                    return _t3.x;
                }
                else
                {
                    if (u_inputType == 4)
                    {
                        return _t3.y;
                    }
                    else
                    {
                        return _t3.z;
                    }
                }
            }
        }
    }
}

static inline __attribute__((always_inline))
float2 _f0(constant float4& u_ScreenParams)
{
    return u_ScreenParams.xy * (1080.0 / fast::min(u_ScreenParams.x, u_ScreenParams.y));
}

static inline __attribute__((always_inline))
float _f5(thread const float& _p0, thread const float2& _p1, thread const float& _p2, thread const float& _p3, constant float4& u_ScreenParams, thread float2& v_uv)
{
    float2 _t4 = _f0(u_ScreenParams);
    return mix(1.0, smoothstep((_p0 + _p2) + 0.001000000047497451305389404296875, _p0, length((v_uv - _p1) * float2(_t4.x / _t4.y, 1.0))), _p3);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _t9 = u_inputTex.sample(u_inputTexSmplr, in.v_uv);
    if (_t9.x < buffer.u_threshold)
    {
        _t9.x = ((_t9.x / buffer.u_threshold) * _t9.x) * buffer.u_thresholdSmooth;
    }
    if (_t9.y < buffer.u_threshold)
    {
        _t9.y = ((_t9.y / buffer.u_threshold) * _t9.y) * buffer.u_thresholdSmooth;
    }
    if (_t9.z < buffer.u_threshold)
    {
        _t9.z = ((_t9.z / buffer.u_threshold) * _t9.z) * buffer.u_thresholdSmooth;
    }
    float4 param = _t9;
    float _t11 = _f4(param, buffer.u_inputType);
    float param_1 = 1.0 - buffer.u_maskRadius;
    float2 param_2 = buffer.u_maskCenter;
    float param_3 = buffer.u_maskFade;
    float param_4 = buffer.u_mask;
    float _285 = _t11;
    float _286 = _285 * _f5(param_1, param_2, param_3, param_4, buffer.u_ScreenParams, in.v_uv);
    _t11 = _286;
    out.o_fragColor = float4(float3(_286), 1.0);
    return out;
}

