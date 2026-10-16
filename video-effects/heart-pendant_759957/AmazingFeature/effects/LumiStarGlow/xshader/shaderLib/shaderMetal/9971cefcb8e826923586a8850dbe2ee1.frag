#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float3 u_color_mid;
    float2 u_singleGradient;
    float3 u_threeGradient;
    float3 u_color_low;
    float3 u_color_high;
    float4 u_fiveGradient;
    float u_fiveGradientVeryHigh;
    float3 u_color_midLow;
    float3 u_color_midHigh;
    float u_stepSize;
    float u_range;
    float u_gammaInv;
    float2 u_currentDir;
    int u_colorMode;
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
float3 _f0(thread const int& _p0, thread const float& _p1, constant float3& u_color_mid, constant float2& u_singleGradient, constant float3& u_threeGradient, constant float3& u_color_low, constant float3& u_color_high, constant float4& u_fiveGradient, constant float& u_fiveGradientVeryHigh, constant float3& u_color_midLow, constant float3& u_color_midHigh)
{
    if (_p0 == 0)
    {
        return mix(float3(0.0), u_color_mid, float3(smoothstep(u_singleGradient.x, u_singleGradient.y, _p1)));
    }
    else
    {
        if (_p0 == 1)
        {
            return mix(mix(u_color_low, u_color_mid, float3(smoothstep(u_threeGradient.x, u_threeGradient.y, _p1))), mix(u_color_mid, u_color_high, float3(smoothstep(u_threeGradient.y, u_threeGradient.z, _p1))), float3(step(u_threeGradient.y, _p1)));
        }
        else
        {
            if (_p0 == 2)
            {
                return mix(mix(mix(u_color_low, u_color_midLow, float3(smoothstep(u_fiveGradient.x, u_fiveGradient.y, _p1))), mix(u_color_midLow, u_color_mid, float3(smoothstep(u_fiveGradient.y, u_fiveGradient.z, _p1))), float3(step(u_fiveGradient.y, _p1))), mix(mix(u_color_mid, u_color_midHigh, float3(smoothstep(u_fiveGradient.z, u_fiveGradient.w, _p1))), mix(u_color_midHigh, u_color_high, float3(smoothstep(u_fiveGradient.w, u_fiveGradientVeryHigh, _p1))), float3(step(u_fiveGradient.w, _p1))), float3(step(u_fiveGradient.z, _p1)));
            }
        }
    }
    return u_color_mid;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _202 = fast::min(1.0, 1.0 / buffer.u_stepSize);
    float _216 = _202 * (1.0 / fast::max(buffer.u_range, 0.001000000047497451305389404296875));
    float3 _220 = float3(buffer.u_gammaInv);
    int _229 = int(fast::min(buffer.u_range / _202, 64.0));
    if (_229 <= 0)
    {
        out.o_fragColor = float4(0.0, 0.0, 0.0, 1.0);
        return out;
    }
    float3 _t23 = float3(0.0);
    float _t24 = 0.0;
    float2 _244 = buffer.u_currentDir * (buffer.u_stepSize * _202);
    float2 _t26 = in.v_uv;
    for (int _t27 = 1; _t27 <= _229; _t27++)
    {
        _t26 += _244;
        float _265 = float(_t27) * _216;
        float _280 = exp((-3.0) * (_265 * _265)) * (1.0 - smoothstep(0.0, 1.0, _265 * 0.800000011920928955078125));
        if (_280 < 0.001000000047497451305389404296875)
        {
            continue;
        }
        float3 _294 = pow(u_inputTexture.sample(u_inputTextureSmplr, _t26).xyz, _220);
        int param = buffer.u_colorMode;
        float param_1 = dot(_294, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
        _t23 += ((_294 * _f0(param, param_1, buffer.u_color_mid, buffer.u_singleGradient, buffer.u_threeGradient, buffer.u_color_low, buffer.u_color_high, buffer.u_fiveGradient, buffer.u_fiveGradientVeryHigh, buffer.u_color_midLow, buffer.u_color_midHigh)) * _280);
        _t24 += _280;
    }
    float3 _325;
    if (_t24 > 0.001000000047497451305389404296875)
    {
        _325 = _t23 / float3(_t24);
    }
    else
    {
        _325 = float3(0.0);
    }
    out.o_fragColor = float4(_325, 1.0);
    return out;
}

