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
    float4 u_ScreenParams;
    float blurSize;
    float blurIns;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv [[user(uv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _30 = (float2(buffer.u_ScreenParams.xy) * 720.0) / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y));
    spvUnsafeArray<float, 9> half_gaussian_weight;
    half_gaussian_weight[0] = 0.20000000298023223876953125;
    half_gaussian_weight[1] = 0.189999997615814208984375;
    half_gaussian_weight[2] = 0.17000000178813934326171875;
    half_gaussian_weight[3] = 0.1500000059604644775390625;
    half_gaussian_weight[4] = 0.12999999523162841796875;
    half_gaussian_weight[5] = 0.10999999940395355224609375;
    half_gaussian_weight[6] = 0.07999999821186065673828125;
    half_gaussian_weight[7] = 0.0500000007450580596923828125;
    half_gaussian_weight[8] = 0.0199999995529651641845703125;
    float2 _84 = (float2(buffer.blurSize / _30.x, buffer.blurSize / _30.y) * 1.25) * buffer.blurIns;
    float4 _94 = inputImageTexture.sample(inputImageTextureSmplr, in.uv);
    float4 _171;
    float _172;
    _172 = half_gaussian_weight[0];
    _171 = float4(0.0);
    for (int _170 = 1; _170 <= 8; )
    {
        _172 = fma(half_gaussian_weight[_170], 2.0, _172);
        _171 = (_171 + (inputImageTexture.sample(inputImageTextureSmplr, fma(float2(0.0, float(_170)), _84, in.uv)) * half_gaussian_weight[_170])) + (inputImageTexture.sample(inputImageTextureSmplr, fma(float2(0.0, float(-_170)), _84, in.uv)) * half_gaussian_weight[_170]);
        _170++;
        continue;
    }
    out.gl_FragColor = (_171 + (_94 * half_gaussian_weight[0])) / float4(_172);
    return out;
}

