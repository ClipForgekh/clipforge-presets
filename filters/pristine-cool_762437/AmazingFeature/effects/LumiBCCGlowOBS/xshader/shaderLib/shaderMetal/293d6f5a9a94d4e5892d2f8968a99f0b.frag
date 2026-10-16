#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_Delta;
    int u_GlowChannels;
    float u_Threshold;
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
float _f2(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float _f1(thread const float3& _p0)
{
    float _99 = mix(_p0.z, _p0.y, step(_p0.z, _p0.y));
    return mix(_99, _p0.x, step(_99, _p0.x));
}

static inline __attribute__((always_inline))
float _f3(thread const float2& _p0, texture2d<float> u_InputTexture, sampler u_InputTextureSmplr, constant int& u_GlowChannels)
{
    float4 _125 = u_InputTexture.sample(u_InputTextureSmplr, _p0);
    float4 _t4 = _125;
    if (u_GlowChannels == 5)
    {
        float3 param = _125.xyz;
        return _f2(param);
    }
    else
    {
        if (u_GlowChannels == 6)
        {
            float3 param_1 = _125.xyz;
            return _f1(param_1);
        }
        else
        {
            if (u_GlowChannels == 1)
            {
                return _t4.x;
            }
            else
            {
                if (u_GlowChannels == 2)
                {
                    return _t4.y;
                }
                else
                {
                    if (u_GlowChannels == 3)
                    {
                        return _t4.z;
                    }
                    else
                    {
                        if (u_GlowChannels == 4)
                        {
                            return _t4.w;
                        }
                    }
                }
            }
        }
    }
    return _t4.w;
}

static inline __attribute__((always_inline))
float4 _f0(thread const float& _p0, thread const float& _p1, constant float& u_Delta)
{
    float4 _t0 = float4(0.0);
    float _41 = fast::clamp(_p1, u_Delta, 1.0 - u_Delta);
    float _55 = smoothstep(_41 - u_Delta, _41, _p0) - smoothstep(_41, _41 + u_Delta, _p0);
    _t0.x = _55;
    float _64 = u_Delta / 2.0;
    if (_p0 < (_41 - _64))
    {
        _t0.x = 1.0;
    }
    _t0.y = _55 * 0.5;
    if (_p0 > (_41 + _64))
    {
        _t0.y = 1.0;
    }
    return _t0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_InputTexture [[texture(0)]], sampler u_InputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _t5 = float4(0.0);
    if (buffer.u_GlowChannels == 0)
    {
        float4 _t6 = u_InputTexture.sample(u_InputTextureSmplr, in.uv0);
        float _207 = buffer.u_Threshold - buffer.u_Delta;
        float _210 = buffer.u_Threshold + buffer.u_Delta;
        float3 _237 = float3(smoothstep(_207, _210, _t6.x), smoothstep(_207, _210, _t6.y), smoothstep(_207, _210, _t6.z));
        _t5.x = _237.x;
        _t5.y = _237.y;
        _t5.z = _237.z;
    }
    else
    {
        float2 param = in.uv0;
        float param_1 = _f3(param, u_InputTexture, u_InputTextureSmplr, buffer.u_GlowChannels);
        float param_2 = buffer.u_Threshold;
        _t5 = _f0(param_1, param_2, buffer.u_Delta);
    }
    out.o_fragColor = _t5;
    return out;
}

