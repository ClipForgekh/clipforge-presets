#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4x4 uMVPMatrix;
    float4x4 uSTMatrix;
    float4x4 uSegMatrix;
    float texelWidthOffset;
    float texelHeightOffset;
};

struct main0_out
{
    float2 texCoord [[user(texCoord)]];
    float2 sucaiTexCoord [[user(sucaiTexCoord)]];
    float2 textureShift_1 [[user(textureShift_1)]];
    float2 textureShift_2 [[user(textureShift_2)]];
    float2 textureShift_3 [[user(textureShift_3)]];
    float2 textureShift_4 [[user(textureShift_4)]];
    float2 segCoord [[user(segCoord)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 attPosition [[attribute(0)]];
    float2 attStandardUV [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    out.gl_Position = buffer.uMVPMatrix * float4(in.attPosition, 1.0);
    out.texCoord = (out.gl_Position.xy * 0.5) + float2(0.5);
    out.sucaiTexCoord = (buffer.uSTMatrix * float4(in.attStandardUV, 0.0, 1.0)).xy;
    out.segCoord = (buffer.uSegMatrix * float4(in.attPosition, 1.0)).xy;
    out.textureShift_1 = float2(out.texCoord + (float2(buffer.texelWidthOffset, buffer.texelHeightOffset) * 0.25));
    out.textureShift_2 = float2(out.texCoord + (float2(-buffer.texelWidthOffset, -buffer.texelHeightOffset) * 0.25));
    out.textureShift_3 = float2(out.texCoord + (float2(-buffer.texelWidthOffset, buffer.texelHeightOffset) * 0.25));
    out.textureShift_4 = float2(out.texCoord + (float2(buffer.texelWidthOffset, -buffer.texelHeightOffset) * 0.25));
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

