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
    float clearIntensity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
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
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> _MainTex [[texture(0)]], texture2d<float> newGradimage [[texture(1)]], texture2d<float> faceMask [[texture(2)]], sampler _MainTexSmplr [[sampler(0)]], sampler newGradimageSmplr [[sampler(1)]], sampler faceMaskSmplr [[sampler(2)]])
{
    main0_out out = {};
    spvUnsafeArray<float2, 9> textureCoordinate = {};
    textureCoordinate[0] = in.textureCoordinate_0;
    textureCoordinate[1] = in.textureCoordinate_1;
    textureCoordinate[2] = in.textureCoordinate_2;
    textureCoordinate[3] = in.textureCoordinate_3;
    textureCoordinate[4] = in.textureCoordinate_4;
    textureCoordinate[5] = in.textureCoordinate_5;
    textureCoordinate[6] = in.textureCoordinate_6;
    textureCoordinate[7] = in.textureCoordinate_7;
    textureCoordinate[8] = in.textureCoordinate_8;
    float4 inputColor = _MainTex.sample(_MainTexSmplr, textureCoordinate[4]);
    float4 dstColor = inputColor;
    if (buffer.clearIntensity > 0.0)
    {
        float3 centervalue = newGradimage.sample(newGradimageSmplr, textureCoordinate[4]).xyz;
        float avgDiff = 0.039999999105930328369140625 * centervalue.z;
        avgDiff += (0.1599999964237213134765625 * newGradimage.sample(newGradimageSmplr, textureCoordinate[0]).z);
        avgDiff += (0.07999999821186065673828125 * newGradimage.sample(newGradimageSmplr, textureCoordinate[1]).z);
        avgDiff += (0.1599999964237213134765625 * newGradimage.sample(newGradimageSmplr, textureCoordinate[2]).z);
        avgDiff += (0.07999999821186065673828125 * newGradimage.sample(newGradimageSmplr, textureCoordinate[3]).z);
        avgDiff += (0.07999999821186065673828125 * newGradimage.sample(newGradimageSmplr, textureCoordinate[5]).z);
        avgDiff += (0.1599999964237213134765625 * newGradimage.sample(newGradimageSmplr, textureCoordinate[6]).z);
        avgDiff += (0.07999999821186065673828125 * newGradimage.sample(newGradimageSmplr, textureCoordinate[7]).z);
        avgDiff += (0.1599999964237213134765625 * newGradimage.sample(newGradimageSmplr, textureCoordinate[8]).z);
        float maskratio = 1.0 - (0.4000000059604644775390625 * faceMask.sample(faceMaskSmplr, textureCoordinate[4]).y);
        float lastgrad = centervalue.x;
        lastgrad = (lastgrad - 0.5) / 4.0;
        float3 sharpColor = fast::clamp(dstColor.xyz + float3((avgDiff * 1.35000002384185791015625) * lastgrad), float3(0.0), float3(1.0));
        float4 _161 = dstColor;
        float3 _168 = mix(_161.xyz, sharpColor, float3(buffer.clearIntensity * maskratio));
        dstColor.x = _168.x;
        dstColor.y = _168.y;
        dstColor.z = _168.z;
    }
    out.gl_FragColor = dstColor;
    return out;
}

