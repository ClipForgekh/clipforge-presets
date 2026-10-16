#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float texelWidthOffset;
    float texelHeightOffset;
    float scaleOffset;
    float2 inputSize;
    float4x4 uSegMatrix;
};

struct main0_out
{
    float2 textureCoordinate [[user(textureCoordinate)]];
    float4 textureShift_1 [[user(textureShift_1)]];
    float4 textureShift_2 [[user(textureShift_2)]];
    float4 textureShift_3 [[user(textureShift_3)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 attPosition [[attribute(0)]];
    float2 attUV [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    out.gl_Position = float4(in.attPosition.xy, 0.0, 1.0);
    out.textureCoordinate = in.attUV;
    float2 singleStepOffset = float2(buffer.texelWidthOffset, buffer.texelHeightOffset) * 4.19999980926513671875;
    float2 doubleStepOffset = singleStepOffset * 2.0;
    out.textureShift_1 = float4(in.attUV - singleStepOffset, in.attUV + singleStepOffset);
    out.textureShift_2 = float4(in.attUV - doubleStepOffset, in.attUV + doubleStepOffset);
    float2 newXY2 = float2((in.attUV.x - (buffer.scaleOffset * singleStepOffset.x)) * buffer.inputSize.x, (1.0 - (in.attUV.y - (buffer.scaleOffset * singleStepOffset.y))) * buffer.inputSize.y);
    float2 newXY3 = float2((in.attUV.x + (buffer.scaleOffset * singleStepOffset.x)) * buffer.inputSize.x, (1.0 - (in.attUV.y + (buffer.scaleOffset * singleStepOffset.y))) * buffer.inputSize.y);
    newXY2 = (buffer.uSegMatrix * float4(newXY2, 0.0, 1.0)).xy;
    newXY3 = (buffer.uSegMatrix * float4(newXY3, 0.0, 1.0)).xy;
    out.textureShift_3 = float4(newXY2, newXY3.x, newXY3.y);
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

