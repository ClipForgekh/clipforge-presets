#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float lowQuality;
    float filterIntensity;
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
float3 _f0(thread const float3& _p0)
{
    float _46 = ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
    return float3(_46, (_p0.z - _46) * 0.564999997615814208984375, (_p0.x - _46) * 0.712999999523162841796875);
}

static inline __attribute__((always_inline))
float3 _f1(thread const float3& _p0)
{
    return float3(_p0.x + (1.40299999713897705078125 * _p0.z), (_p0.x - (0.3440000116825103759765625 * _p0.y)) - (0.7139999866485595703125 * _p0.z), _p0.x + (1.769999980926513671875 * _p0.y));
}

static inline __attribute__((always_inline))
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread const float4& _p1, thread const float& _p2)
{
    float4 _t1 = _p1;
    float _98 = _t1.z * 63.0;
    float _103 = floor(_98);
    float2 _t3;
    _t3.y = floor(_103 / 8.0);
    _t3.x = _103 - (_t3.y * 8.0);
    float _117 = ceil(_98);
    float2 _t4;
    _t4.y = floor(_117 / 8.0);
    _t4.x = _117 - (_t4.y * 8.0);
    float2 _t5;
    _t5.x = (((_t3.x * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.x);
    _t5.y = (((_t3.y * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.y);
    float2 _t6;
    _t6.x = (((_t4.x * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.x);
    _t6.y = (((_t4.y * 1.0) / 8.0) + 0.0009765625) + (0.123046875 * _t1.y);
    return mix(_p1, float4(mix(_p0.sample(_p0Smplr, _t5), _p0.sample(_p0Smplr, _t6), float4(fract(_98))).xyz, _t1.w), float4(_p2));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> lutImageTexture [[texture(1)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler lutImageTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _t11 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float4 _229 = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv);
    float4 _t12 = _229;
    for (float _t14 = 1.0; _t14 <= 8.0; _t14 += 1.0)
    {
        _t12 += inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv - float2(_t14 * _t11.x, 0.0)));
    }
    float4 _256 = _t12;
    float4 _269 = fast::clamp(_229 + ((_229 - (_256 / float4(9.0))) * 0.60000002384185791015625), float4(0.0), float4(1.0));
    _t12 = _269;
    float3 param = _269.xyz;
    float3 _t16 = _f0(param);
    float3 param_1 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv - float2(8.0 * _t11.x, 0.0))).xyz;
    float3 _289 = _t16;
    float2 _294 = mix(_289.yz, _f0(param_1).yz, float2(0.60000002384185791015625));
    _t16.y = _294.x;
    _t16.z = _294.y;
    float3 param_2 = _t16;
    float3 _301 = _f1(param_2);
    _t12.x = _301.x;
    _t12.y = _301.y;
    _t12.z = _301.z;
    float4 _308 = _t12;
    float _311 = _t12.w;
    float3 _314 = fast::clamp(_308.xyz, float3(0.0), float3(_311));
    _t12.x = _314.x;
    _t12.y = _314.y;
    _t12.z = _314.z;
    float4 _322 = _t12;
    float4 _326 = mix(_229, _322, float4(buffer.lowQuality));
    _t12 = _326;
    float4 param_3 = _326;
    float param_4 = buffer.filterIntensity;
    out.o_fragColor = _f2(lutImageTexture, lutImageTextureSmplr, param_3, param_4);
    return out;
}

