#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_frameNums;
    float u_wSum1;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputImageTexture1 [[texture(0)]], texture2d<float> u_inputImageTexture2 [[texture(1)]], texture2d<float> u_inputImageTexture3 [[texture(2)]], texture2d<float> u_inputImageTexture4 [[texture(3)]], texture2d<float> u_inputImageTexture5 [[texture(4)]], texture2d<float> u_inputImageTexture6 [[texture(5)]], texture2d<float> u_inputImageTexture7 [[texture(6)]], texture2d<float> u_inputImageTexture8 [[texture(7)]], texture2d<float> u_inputImageTexture9 [[texture(8)]], texture2d<float> u_inputImageTexture10 [[texture(9)]], texture2d<float> u_inputImageTexture11 [[texture(10)]], texture2d<float> u_inputImageTexture12 [[texture(11)]], texture2d<float> u_inputImageTexture13 [[texture(12)]], texture2d<float> u_inputImageTexture14 [[texture(13)]], texture2d<float> u_inputImageTexture15 [[texture(14)]], texture2d<float> u_inputImageTexture16 [[texture(15)]], sampler u_inputImageTexture1Smplr [[sampler(0)]], sampler u_inputImageTexture2Smplr [[sampler(1)]], sampler u_inputImageTexture3Smplr [[sampler(2)]], sampler u_inputImageTexture4Smplr [[sampler(3)]], sampler u_inputImageTexture5Smplr [[sampler(4)]], sampler u_inputImageTexture6Smplr [[sampler(5)]], sampler u_inputImageTexture7Smplr [[sampler(6)]], sampler u_inputImageTexture8Smplr [[sampler(7)]], sampler u_inputImageTexture9Smplr [[sampler(8)]], sampler u_inputImageTexture10Smplr [[sampler(9)]], sampler u_inputImageTexture11Smplr [[sampler(10)]], sampler u_inputImageTexture12Smplr [[sampler(11)]], sampler u_inputImageTexture13Smplr [[sampler(12)]], sampler u_inputImageTexture14Smplr [[sampler(13)]], sampler u_inputImageTexture15Smplr [[sampler(14)]], sampler u_inputImageTexture16Smplr [[sampler(15)]])
{
    main0_out out = {};
    float4 _258 = (((((((((((u_inputImageTexture1.sample(u_inputImageTexture1Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 0.0, 0.0) / buffer.u_wSum1)) + (u_inputImageTexture2.sample(u_inputImageTexture2Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 1.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture3.sample(u_inputImageTexture3Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 2.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture4.sample(u_inputImageTexture4Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 3.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture5.sample(u_inputImageTexture5Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 4.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture6.sample(u_inputImageTexture6Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 5.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture7.sample(u_inputImageTexture7Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 6.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture8.sample(u_inputImageTexture8Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 7.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture9.sample(u_inputImageTexture9Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 8.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture10.sample(u_inputImageTexture10Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 9.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture11.sample(u_inputImageTexture11Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 10.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture12.sample(u_inputImageTexture12Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 11.0, 0.0) / buffer.u_wSum1));
    out.o_fragColor = (((_258 + (u_inputImageTexture13.sample(u_inputImageTexture13Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 12.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture14.sample(u_inputImageTexture14Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 13.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture15.sample(u_inputImageTexture15Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 14.0, 0.0) / buffer.u_wSum1))) + (u_inputImageTexture16.sample(u_inputImageTexture16Smplr, in.v_uv) * (fast::max(buffer.u_frameNums - 15.0, 0.0) / buffer.u_wSum1));
    return out;
}

