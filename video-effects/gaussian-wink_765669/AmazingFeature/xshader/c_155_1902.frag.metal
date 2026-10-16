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

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float u_segmentIndex;
    float2 u_texSize;
    float ratio;
    float u_blurRadiusPx;
    float u_opacity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

static inline __attribute__((always_inline))
float4 sampleSource(thread const float2& uv, constant float& u_segmentIndex, texture2d<float> texture1, sampler texture1Smplr, texture2d<float> texture2, sampler texture2Smplr)
{
    float useTex2 = mod(u_segmentIndex, 2.0);
    float4 c1 = texture1.sample(texture1Smplr, uv);
    float4 c2 = texture2.sample(texture2Smplr, uv);
    return mix(c1, c2, float4(step(0.5, useTex2)));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(thread const float2& uv, thread const float& blurStrength, constant float& u_segmentIndex, texture2d<float> texture1, sampler texture1Smplr, texture2d<float> texture2, sampler texture2Smplr, constant float2& u_texSize, constant float& ratio)
{
    float2 texel = float2(1.0 / fast::max(u_texSize.x, 1.0), 1.0 / fast::max(u_texSize.y, 1.0));
    float2 stepSize = float2(texel.x * blurStrength, (texel.y * blurStrength) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 25> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 4.0;
    kernel0[2] = 6.0;
    kernel0[3] = 4.0;
    kernel0[4] = 1.0;
    kernel0[5] = 4.0;
    kernel0[6] = 16.0;
    kernel0[7] = 24.0;
    kernel0[8] = 16.0;
    kernel0[9] = 4.0;
    kernel0[10] = 6.0;
    kernel0[11] = 24.0;
    kernel0[12] = 36.0;
    kernel0[13] = 24.0;
    kernel0[14] = 6.0;
    kernel0[15] = 4.0;
    kernel0[16] = 16.0;
    kernel0[17] = 24.0;
    kernel0[18] = 16.0;
    kernel0[19] = 4.0;
    kernel0[20] = 1.0;
    kernel0[21] = 4.0;
    kernel0[22] = 6.0;
    kernel0[23] = 4.0;
    kernel0[24] = 1.0;
    int idx = 0;
    for (int y = -2; y <= 2; y++)
    {
        for (int x = -2; x <= 2; x++)
        {
            float2 suv = fast::clamp(uv + float2(float(x) * stepSize.x, float(y) * stepSize.y), float2(0.0), float2(1.0));
            float w = kernel0[idx];
            float2 param = suv;
            color += (sampleSource(param, u_segmentIndex, texture1, texture1Smplr, texture2, texture2Smplr) * w);
            totalWeight += w;
            idx++;
        }
    }
    return color / float4(fast::max(totalWeight, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], texture2d<float> texture2 [[texture(1)]], sampler texture1Smplr [[sampler(0)]], sampler texture2Smplr [[sampler(1)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadiusPx;
    float4 texColor = gaussianBlur(param, param_1, buffer.u_segmentIndex, texture1, texture1Smplr, texture2, texture2Smplr, buffer.u_texSize, buffer.ratio);
    out.gl_FragColor = float4(texColor.xyz, texColor.w * buffer.u_opacity);
    return out;
}

