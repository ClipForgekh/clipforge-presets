#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    spvUnsafeArray<float2, 10> u_posVec;
    int u_lineNum;
    float u_intensity;
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
float _f0(thread const float2& _p0, thread const float2& _p1, thread const float2& _p2)
{
    return step(cross(float3(_p0 - _p1, 0.0), float3(_p2 - _p1, 0.0)).z, 0.0);
}

static inline __attribute__((always_inline))
float _f1(thread const float2& _p0, constant spvUnsafeArray<float2, 10>& u_posVec, constant int& u_lineNum)
{
    float2 param = _p0;
    float2 param_1 = u_posVec[u_lineNum];
    float2 param_2 = u_posVec[0];
    float _t3 = _f0(param, param_1, param_2);
    for (int _t4 = 0; _t4 < u_lineNum; _t4++)
    {
        float2 param_3 = _p0;
        float2 param_4 = u_posVec[_t4];
        float2 param_5 = u_posVec[_t4 + 1];
        _t3 *= _f0(param_3, param_4, param_5);
    }
    return _t3;
}

static inline __attribute__((always_inline))
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2, thread const float2& _p3, constant spvUnsafeArray<float2, 10>& u_posVec, constant int& u_lineNum, constant float& u_intensity, constant float& u_quality, constant float& u_regionIns, constant float& u_lightIns)
{
    if (u_intensity < 0.00999999977648258209228515625)
    {
        return _p0.sample(_p0Smplr, _p1);
    }
    float4 _t7 = float4(0.0);
    float4 _t9 = float4(0.0);
    float4 _t10 = float4(0.4000000059604644775390625);
    float2 _149 = (float2(2.0) * float2(_p2)) / _p3;
    float _158 = mix(2.0, 0.5, u_intensity) * mix(2.0, 1.0, u_quality);
    float _169 = fast::max(5.0, (12.0 / _158) * mix(0.64999997615814208984375, 1.0, u_quality));
    float _174 = mix(0.699999988079071044921875, 1.0, u_regionIns);
    for (float _t15 = 0.0; _t15 < 30.0; _t15 += 1.0)
    {
        if ((_t15 > _169) || (u_intensity < 0.300000011920928955078125))
        {
            break;
        }
        for (float _t16 = 0.0; _t16 < 30.0; _t16 += 1.0)
        {
            if (_t16 > _169)
            {
                break;
            }
            float2 _219 = float2(mix(-11.0, 11.0, _t15 / _169), mix(-11.0, 11.0, _t16 / _169));
            float2 param = _219;
            if (_f1(param, u_posVec, u_lineNum) < 0.5)
            {
                continue;
            }
            float4 _235 = _p0.sample(_p0Smplr, (_p1 - ((_219 * 0.5) * _149)));
            _t7 = fast::max(_t7, _235 * _174);
            float4 _249 = ((pow(_235, float4(9.0)) * 539.45001220703125) + float4(0.4000000059604644775390625)) * u_regionIns;
            _t9 += (_249 * _235);
            _t10 += _249;
        }
    }
    for (int _t19 = 0; _t19 < u_lineNum; _t19++)
    {
        float _290 = fast::max((length(u_posVec[_t19] - u_posVec[_t19 + 1]) / 1.5) * mix(0.5, 1.0, fast::clamp(u_quality * 1.5, 0.0, 1.0)), 3.0);
        for (float _t21 = 0.0; _t21 < 40.0; _t21 += 1.0)
        {
            float _303 = _t21 * _158;
            if (_303 > _290)
            {
                break;
            }
            float4 _331 = _p0.sample(_p0Smplr, (_p1 - ((mix(u_posVec[_t19], u_posVec[_t19 + 1], float2(_303 / _290)) * 0.5) * _149)));
            _t7 = fast::max(_t7, _331);
            float4 _340 = (pow(_331, float4(9.0)) * 539.45001220703125) + float4(0.4000000059604644775390625);
            _t9 += (_340 * _331);
            _t10 += _340;
        }
    }
    float4 _359 = fast::clamp(_t9 / _t10, float4(0.0), float4(1.0));
    return float4(mix(_359, _t7, fast::clamp(_359 * u_lightIns, float4(0.0), float4(1.0))));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.v_uv;
    float param_1 = buffer.u_blurSize;
    float2 param_2 = (float2(buffer.u_baseTexWidth, buffer.u_baseTexHeight) / float2(fast::min(buffer.u_baseTexWidth, buffer.u_baseTexHeight))) * 720.0;
    out.o_fragColor = _f2(u_inputTex, u_inputTexSmplr, param, param_1, param_2, buffer.u_posVec, buffer.u_lineNum, buffer.u_intensity, buffer.u_quality, buffer.u_regionIns, buffer.u_lightIns);
    return out;
}

