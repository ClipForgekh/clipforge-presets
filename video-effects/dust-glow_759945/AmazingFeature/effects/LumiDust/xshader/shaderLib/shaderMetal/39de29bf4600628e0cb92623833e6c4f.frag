#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int AEPlugin;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 testUV [[user(locn0)]];
    float2 dustUV [[user(locn1)]];
    float2 rectUV [[user(locn2)]];
    float particleOpacity [[user(locn5)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputTex [[texture(0)]], texture2d<float> endImg [[texture(1)]], sampler inputTexSmplr [[sampler(0)]], sampler endImgSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _15 = in.testUV - float2(0.5);
    float2 _30 = (_15 * in.rectUV) + in.dustUV;
    float4 _t1 = mix(endImg.sample(endImgSmplr, _30), inputTex.sample(inputTexSmplr, _30), float4(smoothstep(0.949999988079071044921875, 1.0, in.particleOpacity)));
    _t1.w *= (in.particleOpacity * mix(smoothstep(0.5, 0.449999988079071044921875, length(_15)), 1.0, fast::clamp(20.0 * (in.particleOpacity - 0.949999988079071044921875), 0.0, 1.0)));
    if (buffer.AEPlugin == 1)
    {
        float4 _83 = _t1;
        float _86 = _t1.w;
        float3 _90 = fast::clamp(_83.xyz * _86, float3(0.0), float3(1.0));
        _t1.x = _90.x;
        _t1.y = _90.y;
        _t1.z = _90.z;
    }
    out.o_fragColor = _t1;
    return out;
}

