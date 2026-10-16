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
    float maxBlurStrength;
    float ratio;
    float maxExposure;
    float maxSaturation;
    float3 glowColor;
    float maxGlowStrength;
    float maxNoiseStrength;
    float progress;
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
float tween(thread const float& progress)
{
    return 1.0 - pow(1.0 - progress, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& ratio)
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
            float2 param = uv + offset;
            float2 sampleUV = handleUVBounds(param);
            color += (tex.sample(texSmplr, sampleUV) * weight);
            totalWeight += weight;
        }
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float rand(thread const float2& co)
{
    return fract(sin(dot(co, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxBlurStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& ratio, constant float& maxExposure, constant float& maxSaturation, constant float3& glowColor, constant float& maxGlowStrength, constant float& maxNoiseStrength)
{
    float effectStrength = 1.0 - progress;
    float currentBlur = effectStrength * maxBlurStrength;
    float2 param = vUv;
    float param_1 = currentBlur;
    float param_2 = ratio;
    float4 blurredTex = gaussianBlur(tDiffuse, tDiffuseSmplr, param, param_1, param_2);
    float3 exposedColor = blurredTex.xyz * (1.0 + (effectStrength * maxExposure));
    float currentSaturation = 1.0 + (effectStrength * (maxSaturation - 1.0));
    float gray = dot(exposedColor, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 saturatedColor = mix(float3(gray), exposedColor, float3(currentSaturation));
    float3 glow = (glowColor * effectStrength) * maxGlowStrength;
    float3 glowedColor = saturatedColor + glow;
    float2 param_3 = vUv;
    float _noise = (rand(param_3) * effectStrength) * maxNoiseStrength;
    float3 finalColor = glowedColor + float3(_noise);
    finalColor = fast::clamp(finalColor, float3(0.0), float3(1.0));
    return float4(finalColor, texel.w);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 effectColor = effect(param_1, param_2, buffer.maxBlurStrength, tDiffuse, tDiffuseSmplr, in.vUv, buffer.ratio, buffer.maxExposure, buffer.maxSaturation, buffer.glowColor, buffer.maxGlowStrength, buffer.maxNoiseStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

