#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float2 imagestep;
};

struct main0_out
{
    float2 textureCoordinate_0 [[user(textureCoordinate_0)]];
    float2 textureCoordinate_1 [[user(textureCoordinate_1)]];
    float2 textureCoordinate_2 [[user(textureCoordinate_2)]];
    float2 textureCoordinate_3 [[user(textureCoordinate_3)]];
    float2 textureCoordinate_4 [[user(textureCoordinate_4)]];
    float2 textureCoordinate_5 [[user(textureCoordinate_5)]];
    float2 textureCoordinate_6 [[user(textureCoordinate_6)]];
    float2 textureCoordinate_7 [[user(textureCoordinate_7)]];
    float2 textureCoordinate_8 [[user(textureCoordinate_8)]];
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
    spvUnsafeArray<float2, 9> textureCoordinate = {};
    out.gl_Position = float4(in.attPosition, 1.0);
    textureCoordinate[4] = in.attUV;
    textureCoordinate[0] = textureCoordinate[4] + (buffer.imagestep * float2(-1.5));
    textureCoordinate[1] = textureCoordinate[4] + (buffer.imagestep * float2(0.0, -1.5));
    textureCoordinate[2] = textureCoordinate[4] + (buffer.imagestep * float2(1.5, -1.5));
    textureCoordinate[3] = textureCoordinate[4] + (buffer.imagestep * float2(-1.5, 0.0));
    textureCoordinate[5] = textureCoordinate[4] + (buffer.imagestep * float2(1.5, 0.0));
    textureCoordinate[6] = textureCoordinate[4] + (buffer.imagestep * float2(-1.5, 1.5));
    textureCoordinate[7] = textureCoordinate[4] + (buffer.imagestep * float2(0.0, 1.5));
    textureCoordinate[8] = textureCoordinate[4] + (buffer.imagestep * float2(1.5));
    out.textureCoordinate_0 = textureCoordinate[0];
    out.textureCoordinate_1 = textureCoordinate[1];
    out.textureCoordinate_2 = textureCoordinate[2];
    out.textureCoordinate_3 = textureCoordinate[3];
    out.textureCoordinate_4 = textureCoordinate[4];
    out.textureCoordinate_5 = textureCoordinate[5];
    out.textureCoordinate_6 = textureCoordinate[6];
    out.textureCoordinate_7 = textureCoordinate[7];
    out.textureCoordinate_8 = textureCoordinate[8];
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

