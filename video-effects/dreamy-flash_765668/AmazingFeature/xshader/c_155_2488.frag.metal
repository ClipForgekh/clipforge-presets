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
    float ratio;
    float blurRadius;
    float effectStrength;
    float exposureGain;
    float warmGainR;
    float warmGainG;
    float u_brightness;
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
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, constant float& ratio)
{
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
    float baseStep = 0.001000000047497451305389404296875 * blurStrength;
    float2 stepSize = float2(baseStep, baseStep / ratio);
    for (int i = -2; i <= 2; i++)
    {
        for (int j = -2; j <= 2; j++)
        {
            float weight = kernel0[((i + 2) * 5) + (j + 2)];
            float2 offset = float2(float(i) * stepSize.x, float(j) * stepSize.y);
            float2 sampleUV = fast::clamp(uv + offset, float2(0.0), float2(1.0));
            color += (tex.sample(texSmplr, sampleUV) * weight);
            totalWeight += weight;
        }
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& baseColor, thread const float3& blendColor)
{
    return float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - blendColor));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = in.vUv;
    float4 originalTexel = texture1.sample(texture1Smplr, mappedUv);
    float2 param = mappedUv;
    float param_1 = buffer.blurRadius;
    float4 blurredTexel = gaussianBlur(texture1, texture1Smplr, param, param_1, buffer.ratio);
    float3 blurredMixed = mix(originalTexel.xyz, blurredTexel.xyz, float3(fast::clamp(buffer.effectStrength, 0.0, 1.0)));
    blurredMixed *= buffer.exposureGain;
    float3 warmColor = float3(buffer.warmGainR, buffer.warmGainG, 1.0) - float3(1.0);
    warmColor = fast::max(warmColor, float3(0.0));
    float3 param_2 = blurredMixed;
    float3 param_3 = warmColor * fast::clamp(buffer.effectStrength, 0.0, 1.0);
    float3 screenedColor = screenBlend(param_2, param_3);
    float3 finalRgb = mix(originalTexel.xyz, screenedColor, float3(fast::clamp(buffer.effectStrength, 0.0, 1.0)));
    float4 texColor = float4(finalRgb, originalTexel.w);
    float4 _255 = texColor;
    float3 _257 = _255.xyz * buffer.u_brightness;
    texColor.x = _257.x;
    texColor.y = _257.y;
    texColor.z = _257.z;
    out.gl_FragColor = texColor;
    return out;
}

