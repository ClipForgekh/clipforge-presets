#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float wSum1;
    float wSum;
    float frameNums;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> mergedTexture [[texture(0)]], texture2d<float> inputImageTexture1 [[texture(1)]], texture2d<float> inputImageTexture2 [[texture(2)]], texture2d<float> inputImageTexture3 [[texture(3)]], texture2d<float> inputImageTexture4 [[texture(4)]], texture2d<float> inputImageTexture5 [[texture(5)]], texture2d<float> inputImageTexture6 [[texture(6)]], texture2d<float> inputImageTexture7 [[texture(7)]], texture2d<float> inputImageTexture8 [[texture(8)]], texture2d<float> inputImageTexture9 [[texture(9)]], texture2d<float> inputImageTexture10 [[texture(10)]], texture2d<float> inputImageTexture11 [[texture(11)]], texture2d<float> inputImageTexture12 [[texture(12)]], texture2d<float> inputImageTexture13 [[texture(13)]], texture2d<float> inputImageTexture14 [[texture(14)]], texture2d<float> inputImageTexture15 [[texture(15)]], sampler mergedTextureSmplr [[sampler(0)]], sampler inputImageTexture1Smplr [[sampler(1)]], sampler inputImageTexture2Smplr [[sampler(2)]], sampler inputImageTexture3Smplr [[sampler(3)]], sampler inputImageTexture4Smplr [[sampler(4)]], sampler inputImageTexture5Smplr [[sampler(5)]], sampler inputImageTexture6Smplr [[sampler(6)]], sampler inputImageTexture7Smplr [[sampler(7)]], sampler inputImageTexture8Smplr [[sampler(8)]], sampler inputImageTexture9Smplr [[sampler(9)]], sampler inputImageTexture10Smplr [[sampler(10)]], sampler inputImageTexture11Smplr [[sampler(11)]], sampler inputImageTexture12Smplr [[sampler(12)]], sampler inputImageTexture13Smplr [[sampler(13)]], sampler inputImageTexture14Smplr [[sampler(14)]], sampler inputImageTexture15Smplr [[sampler(15)]])
{
    main0_out out = {};
    float4 _258 = (((((((((((mergedTexture.sample(mergedTextureSmplr, in.v_uv) * (buffer.wSum1 / buffer.wSum)) + (inputImageTexture1.sample(inputImageTexture1Smplr, in.v_uv) * (fast::max(buffer.frameNums - 16.0, 0.0) / buffer.wSum))) + (inputImageTexture2.sample(inputImageTexture2Smplr, in.v_uv) * (fast::max(buffer.frameNums - 17.0, 0.0) / buffer.wSum))) + (inputImageTexture3.sample(inputImageTexture3Smplr, in.v_uv) * (fast::max(buffer.frameNums - 18.0, 0.0) / buffer.wSum))) + (inputImageTexture4.sample(inputImageTexture4Smplr, in.v_uv) * (fast::max(buffer.frameNums - 19.0, 0.0) / buffer.wSum))) + (inputImageTexture5.sample(inputImageTexture5Smplr, in.v_uv) * (fast::max(buffer.frameNums - 20.0, 0.0) / buffer.wSum))) + (inputImageTexture6.sample(inputImageTexture6Smplr, in.v_uv) * (fast::max(buffer.frameNums - 21.0, 0.0) / buffer.wSum))) + (inputImageTexture7.sample(inputImageTexture7Smplr, in.v_uv) * (fast::max(buffer.frameNums - 22.0, 0.0) / buffer.wSum))) + (inputImageTexture8.sample(inputImageTexture8Smplr, in.v_uv) * (fast::max(buffer.frameNums - 23.0, 0.0) / buffer.wSum))) + (inputImageTexture9.sample(inputImageTexture9Smplr, in.v_uv) * (fast::max(buffer.frameNums - 24.0, 0.0) / buffer.wSum))) + (inputImageTexture10.sample(inputImageTexture10Smplr, in.v_uv) * (fast::max(buffer.frameNums - 25.0, 0.0) / buffer.wSum))) + (inputImageTexture11.sample(inputImageTexture11Smplr, in.v_uv) * (fast::max(buffer.frameNums - 26.0, 0.0) / buffer.wSum));
    out.o_fragColor = (((_258 + (inputImageTexture12.sample(inputImageTexture12Smplr, in.v_uv) * (fast::max(buffer.frameNums - 27.0, 0.0) / buffer.wSum))) + (inputImageTexture13.sample(inputImageTexture13Smplr, in.v_uv) * (fast::max(buffer.frameNums - 28.0, 0.0) / buffer.wSum))) + (inputImageTexture14.sample(inputImageTexture14Smplr, in.v_uv) * (fast::max(buffer.frameNums - 29.0, 0.0) / buffer.wSum))) + (inputImageTexture15.sample(inputImageTexture15Smplr, in.v_uv) * (fast::max(buffer.frameNums - 30.0, 0.0) / buffer.wSum));
    return out;
}

