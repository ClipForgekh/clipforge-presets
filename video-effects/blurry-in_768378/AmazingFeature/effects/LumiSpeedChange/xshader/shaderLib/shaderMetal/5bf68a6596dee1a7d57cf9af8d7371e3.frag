#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_wSum1;
    float u_wSum;
    float u_frameNums;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_mergedTexture [[texture(0)]], texture2d<float> u_inputImageTexture1 [[texture(1)]], texture2d<float> u_inputImageTexture2 [[texture(2)]], texture2d<float> u_inputImageTexture3 [[texture(3)]], texture2d<float> u_inputImageTexture4 [[texture(4)]], texture2d<float> u_inputImageTexture5 [[texture(5)]], texture2d<float> u_inputImageTexture6 [[texture(6)]], texture2d<float> u_inputImageTexture7 [[texture(7)]], texture2d<float> u_inputImageTexture8 [[texture(8)]], texture2d<float> u_inputImageTexture9 [[texture(9)]], texture2d<float> u_inputImageTexture10 [[texture(10)]], texture2d<float> u_inputImageTexture11 [[texture(11)]], texture2d<float> u_inputImageTexture12 [[texture(12)]], texture2d<float> u_inputImageTexture13 [[texture(13)]], texture2d<float> u_inputImageTexture14 [[texture(14)]], texture2d<float> u_inputImageTexture15 [[texture(15)]], sampler u_mergedTextureSmplr [[sampler(0)]], sampler u_inputImageTexture1Smplr [[sampler(1)]], sampler u_inputImageTexture2Smplr [[sampler(2)]], sampler u_inputImageTexture3Smplr [[sampler(3)]], sampler u_inputImageTexture4Smplr [[sampler(4)]], sampler u_inputImageTexture5Smplr [[sampler(5)]], sampler u_inputImageTexture6Smplr [[sampler(6)]], sampler u_inputImageTexture7Smplr [[sampler(7)]], sampler u_inputImageTexture8Smplr [[sampler(8)]], sampler u_inputImageTexture9Smplr [[sampler(9)]], sampler u_inputImageTexture10Smplr [[sampler(10)]], sampler u_inputImageTexture11Smplr [[sampler(11)]], sampler u_inputImageTexture12Smplr [[sampler(12)]], sampler u_inputImageTexture13Smplr [[sampler(13)]], sampler u_inputImageTexture14Smplr [[sampler(14)]], sampler u_inputImageTexture15Smplr [[sampler(15)]])
{
    main0_out out = {};
    float4 _257 = (((((((((((u_mergedTexture.sample(u_mergedTextureSmplr, in.v_uv) * (buffer.u_wSum1 / buffer.u_wSum)) + (u_inputImageTexture1.sample(u_inputImageTexture1Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 16.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture2.sample(u_inputImageTexture2Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 17.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture3.sample(u_inputImageTexture3Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 18.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture4.sample(u_inputImageTexture4Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 19.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture5.sample(u_inputImageTexture5Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 20.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture6.sample(u_inputImageTexture6Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 21.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture7.sample(u_inputImageTexture7Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 22.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture8.sample(u_inputImageTexture8Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 23.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture9.sample(u_inputImageTexture9Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 24.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture10.sample(u_inputImageTexture10Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 25.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture11.sample(u_inputImageTexture11Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 26.0, 0.0) / buffer.u_wSum));
    out.o_fragColor = (((_257 + (u_inputImageTexture12.sample(u_inputImageTexture12Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 27.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture13.sample(u_inputImageTexture13Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 28.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture14.sample(u_inputImageTexture14Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 29.0, 0.0) / buffer.u_wSum))) + (u_inputImageTexture15.sample(u_inputImageTexture15Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 30.0, 0.0) / buffer.u_wSum));
    return out;
}

