#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float frameNums;
    float wSum1;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture1 [[texture(0)]], texture2d<float> inputImageTexture2 [[texture(1)]], texture2d<float> inputImageTexture3 [[texture(2)]], texture2d<float> inputImageTexture4 [[texture(3)]], texture2d<float> inputImageTexture5 [[texture(4)]], texture2d<float> inputImageTexture6 [[texture(5)]], texture2d<float> inputImageTexture7 [[texture(6)]], texture2d<float> inputImageTexture8 [[texture(7)]], texture2d<float> inputImageTexture9 [[texture(8)]], texture2d<float> inputImageTexture10 [[texture(9)]], texture2d<float> inputImageTexture11 [[texture(10)]], texture2d<float> inputImageTexture12 [[texture(11)]], texture2d<float> inputImageTexture13 [[texture(12)]], texture2d<float> inputImageTexture14 [[texture(13)]], texture2d<float> inputImageTexture15 [[texture(14)]], texture2d<float> inputImageTexture16 [[texture(15)]], sampler inputImageTexture1Smplr [[sampler(0)]], sampler inputImageTexture2Smplr [[sampler(1)]], sampler inputImageTexture3Smplr [[sampler(2)]], sampler inputImageTexture4Smplr [[sampler(3)]], sampler inputImageTexture5Smplr [[sampler(4)]], sampler inputImageTexture6Smplr [[sampler(5)]], sampler inputImageTexture7Smplr [[sampler(6)]], sampler inputImageTexture8Smplr [[sampler(7)]], sampler inputImageTexture9Smplr [[sampler(8)]], sampler inputImageTexture10Smplr [[sampler(9)]], sampler inputImageTexture11Smplr [[sampler(10)]], sampler inputImageTexture12Smplr [[sampler(11)]], sampler inputImageTexture13Smplr [[sampler(12)]], sampler inputImageTexture14Smplr [[sampler(13)]], sampler inputImageTexture15Smplr [[sampler(14)]], sampler inputImageTexture16Smplr [[sampler(15)]])
{
    main0_out out = {};
    float4 _259 = (((((((((((inputImageTexture1.sample(inputImageTexture1Smplr, in.v_uv) * (fast::max(buffer.frameNums - 0.0, 0.0) / buffer.wSum1)) + (inputImageTexture2.sample(inputImageTexture2Smplr, in.v_uv) * (fast::max(buffer.frameNums - 1.0, 0.0) / buffer.wSum1))) + (inputImageTexture3.sample(inputImageTexture3Smplr, in.v_uv) * (fast::max(buffer.frameNums - 2.0, 0.0) / buffer.wSum1))) + (inputImageTexture4.sample(inputImageTexture4Smplr, in.v_uv) * (fast::max(buffer.frameNums - 3.0, 0.0) / buffer.wSum1))) + (inputImageTexture5.sample(inputImageTexture5Smplr, in.v_uv) * (fast::max(buffer.frameNums - 4.0, 0.0) / buffer.wSum1))) + (inputImageTexture6.sample(inputImageTexture6Smplr, in.v_uv) * (fast::max(buffer.frameNums - 5.0, 0.0) / buffer.wSum1))) + (inputImageTexture7.sample(inputImageTexture7Smplr, in.v_uv) * (fast::max(buffer.frameNums - 6.0, 0.0) / buffer.wSum1))) + (inputImageTexture8.sample(inputImageTexture8Smplr, in.v_uv) * (fast::max(buffer.frameNums - 7.0, 0.0) / buffer.wSum1))) + (inputImageTexture9.sample(inputImageTexture9Smplr, in.v_uv) * (fast::max(buffer.frameNums - 8.0, 0.0) / buffer.wSum1))) + (inputImageTexture10.sample(inputImageTexture10Smplr, in.v_uv) * (fast::max(buffer.frameNums - 9.0, 0.0) / buffer.wSum1))) + (inputImageTexture11.sample(inputImageTexture11Smplr, in.v_uv) * (fast::max(buffer.frameNums - 10.0, 0.0) / buffer.wSum1))) + (inputImageTexture12.sample(inputImageTexture12Smplr, in.v_uv) * (fast::max(buffer.frameNums - 11.0, 0.0) / buffer.wSum1));
    out.o_fragColor = (((_259 + (inputImageTexture13.sample(inputImageTexture13Smplr, in.v_uv) * (fast::max(buffer.frameNums - 12.0, 0.0) / buffer.wSum1))) + (inputImageTexture14.sample(inputImageTexture14Smplr, in.v_uv) * (fast::max(buffer.frameNums - 13.0, 0.0) / buffer.wSum1))) + (inputImageTexture15.sample(inputImageTexture15Smplr, in.v_uv) * (fast::max(buffer.frameNums - 14.0, 0.0) / buffer.wSum1))) + (inputImageTexture16.sample(inputImageTexture16Smplr, in.v_uv) * (fast::max(buffer.frameNums - 15.0, 0.0) / buffer.wSum1));
    return out;
}

