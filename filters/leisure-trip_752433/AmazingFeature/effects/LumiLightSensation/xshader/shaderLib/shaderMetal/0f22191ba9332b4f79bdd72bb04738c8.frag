#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float intensity;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], texture2d<float> inputImageTexture2 [[texture(1)]], texture2d<float> inputImageTexture3 [[texture(2)]], sampler inputImageTextureSmplr [[sampler(0)]], sampler inputImageTexture2Smplr [[sampler(1)]], sampler inputImageTexture3Smplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _25 = inputImageTexture.sample(inputImageTextureSmplr, in.uv0);
    float4 _t1 = _25;
    float4 _t2 = _25;
    float _34 = _t1.z * 16.0;
    float2 _t4 = float2(289.0, 17.0);
    float2 _t6 = float2(0.0);
    float _49 = floor(_34);
    _t6.y = floor(_49 / 17.0);
    _t6.x = _49 - (_t6.y * 1.0);
    float _64 = ceil(_34);
    float2 _t7;
    _t7.y = floor(_64 / 17.0);
    _t7.x = _64 - (_t7.y * 1.0);
    float2 _t8;
    _t8.x = (((_t6.x * 1.0) / 17.0) + (0.5 / _t4.x)) + ((0.0588235296308994293212890625 - (1.0 / _t4.x)) * _t2.x);
    _t8.y = (((_t6.y * 1.0) / 1.0) + (0.5 / _t4.y)) + ((1.0 - (1.0 / _t4.y)) * _t2.y);
    float2 _t9;
    _t9.x = (((_t7.x * 1.0) / 17.0) + (0.5 / _t4.x)) + ((0.0588235296308994293212890625 - (1.0 / _t4.x)) * _t2.x);
    _t9.y = (((_t7.y * 1.0) / 1.0) + (0.5 / _t4.y)) + ((1.0 - (1.0 / _t4.y)) * _t2.y);
    float _149 = fract(_34);
    float4 _t11 = float4(0.0, 0.0, 0.0, 1.0);
    if (buffer.intensity <= 0.0)
    {
        _t11 = mix(inputImageTexture2.sample(inputImageTexture2Smplr, _t8), inputImageTexture2.sample(inputImageTexture2Smplr, _t9), float4(_149));
    }
    else
    {
        _t11 = mix(inputImageTexture3.sample(inputImageTexture3Smplr, _t8), inputImageTexture3.sample(inputImageTexture3Smplr, _t9), float4(_149));
    }
    float4 _187 = _t11;
    float4 _190 = mix(_25, _187, float4(abs(buffer.intensity)));
    _t11 = _190;
    out.o_fragColor = _190;
    out.o_fragColor.w = _t1.w;
    return out;
}

