#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float texBlurWidthOffset;
    float texBlurHeightOffset;
};

struct main0_out
{
    float2 textureCoordinate [[user(textureCoordinate)]];
    float4 textureShift_1 [[user(textureShift_1)]];
    float4 textureShift_2 [[user(textureShift_2)]];
    float4 textureShift_3 [[user(textureShift_3)]];
    float4 textureShift_4 [[user(textureShift_4)]];
    float4 gl_Position [[position]];
};

struct main0_in
{
    float3 position [[attribute(0)]];
    float2 texcoord0 [[attribute(1)]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    out.gl_Position = float4(in.position, 1.0);
    out.textureCoordinate = in.texcoord0;
    float2 singleStepOffset = float2(buffer.texBlurWidthOffset * 2.5, buffer.texBlurHeightOffset * 2.5);
    out.textureShift_1 = float4(out.textureCoordinate - singleStepOffset, out.textureCoordinate + singleStepOffset);
    out.textureShift_2 = float4(out.textureCoordinate - (singleStepOffset * 2.0), out.textureCoordinate + (singleStepOffset * 2.0));
    out.textureShift_3 = float4(out.textureCoordinate - (singleStepOffset * 3.0), out.textureCoordinate + (singleStepOffset * 3.0));
    out.textureShift_4 = float4(out.textureCoordinate - (singleStepOffset * 4.0), out.textureCoordinate + (singleStepOffset * 4.0));
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

