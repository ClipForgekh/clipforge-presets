#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_ScreenParams;
    float sharpenSize;
    float sharpenIntensity;
    float signalStrength;
    float destruction;
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
float3 _f1(thread const float3& _p0)
{
    float _88 = ((0.2989999949932098388671875 * _p0.x) + (0.58700001239776611328125 * _p0.y)) + (0.114000000059604644775390625 * _p0.z);
    return float3(_88, (_p0.z - _88) * 0.564999997615814208984375, (_p0.x - _88) * 0.712999999523162841796875);
}

static inline __attribute__((always_inline))
float3 _f2(thread const float3& _p0)
{
    return float3(_p0.x + (1.40299999713897705078125 * _p0.z), (_p0.x - (0.3440000116825103759765625 * _p0.y)) - (0.7139999866485595703125 * _p0.z), _p0.x + (1.769999980926513671875 * _p0.y));
}

static inline __attribute__((always_inline))
float2 _f4(thread const float4& _p0)
{
    return float2(_p0.x + (_p0.y / 255.0), _p0.z + (_p0.w / 255.0));
}

static inline __attribute__((always_inline))
float3 _f0(thread const float3& _p0)
{
    float4 _t0 = float4(1.0, 0.666666686534881591796875, 0.3333333432674407958984375, 3.0);
    return mix(float3(1.0), fast::clamp(abs((fract(float3(_p0.x) + float3(1.0, 0.666666686534881591796875, 0.3333333432674407958984375)) * 6.0) - float3(_t0.w)) - float3(_t0.x), float3(0.0), float3(1.0)), float3(_p0.y)) * _p0.z;
}

static inline __attribute__((always_inline))
float3 _f3(thread const float3& _p0)
{
    return mix(fract(_p0), _p0, step(abs(fast::clamp(_p0, float3(0.00999999977648258209228515625), float3(0.9900000095367431640625)) - _p0), float3(9.9999997473787516355514526367188e-06)));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> blurImageTexture [[texture(1)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler blurImageTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _t7 = float2(1.0) / ((buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y))) * 720.0);
    float4 _205 = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv);
    float4 _t9 = _205;
    for (float _t10 = 1.0; _t10 <= 20.0; _t10 += 1.0)
    {
        if (_t10 > buffer.sharpenSize)
        {
            break;
        }
        _t9 += inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv - float2(_t10 * _t7.x, 0.0)));
    }
    float4 _240 = _t9;
    float4 _242 = _240 / float4(buffer.sharpenSize + 1.0);
    _t9 = _242;
    float3 param = _242.xyz;
    float3 _t11 = _f1(param);
    float3 param_1 = _205.xyz;
    float3 _252 = _f1(param_1);
    float3 _t12 = _252;
    float3 _261 = _t11;
    float2 _269 = mix(_252.yz, _261.yz, float2(fast::min(1.0, buffer.sharpenIntensity * 5.0)));
    _t11.y = _269.x;
    _t11.z = _269.y;
    _t11.x = _t12.x + (((_t12.x - _t11.x) * buffer.sharpenIntensity) * 40.0);
    float3 param_2 = _t11;
    float3 _289 = _f2(param_2);
    _t9.x = _289.x;
    _t9.y = _289.y;
    _t9.z = _289.z;
    float4 param_3 = ((((((((((blurImageTexture.sample(blurImageTextureSmplr, in.v_uv) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(0.0, 1.0 * _t7.y)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(0.0, (-1.0) * _t7.y)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(0.0, 2.0 * _t7.y)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(0.0, (-2.0) * _t7.y)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(1.0 * _t7.x, 0.0)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2((-1.0) * _t7.x, 0.0)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(2.0 * _t7.x, 0.0)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2((-2.0) * _t7.x, 0.0)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2(3.0 * _t7.x, 0.0)))) + blurImageTexture.sample(blurImageTextureSmplr, (in.v_uv + float2((-3.0) * _t7.x, 0.0)))) / float4(11.0);
    float2 _t15 = _f4(param_3);
    float3 param_4 = float3(fract(_t15.y * 40.270000457763671875), 1.0, 0.800000011920928955078125);
    float4 _423 = _t9;
    float3 _435 = mix(_423.xyz, _f0(param_4), float3(fast::min(1.0, _t15.x * 2.0) * (1.0 - buffer.signalStrength)));
    _t9.x = _435.x;
    _t9.y = _435.y;
    _t9.z = _435.z;
    if (buffer.destruction > 0.5)
    {
        float3 param_5 = _t9.xyz;
        float3 _451 = _f3(param_5);
        _t9.x = _451.x;
        _t9.y = _451.y;
        _t9.z = _451.z;
    }
    out.o_fragColor = fast::clamp(_t9, float4(0.0), float4(1.0));
    return out;
}

