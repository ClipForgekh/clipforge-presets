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
    float maxBlurStep;
    float ratio;
    float maxStretch;
    float4 metalColor;
    float maxGlow;
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
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxBlurStep, constant float& ratio, thread float2& vUv, constant float& maxStretch, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float4& metalColor, constant float& maxGlow)
{
    float effectStrength = 1.0 - progress;
    if (effectStrength < 0.001000000047497451305389404296875)
    {
        return texel;
    }
    float stepY = (maxBlurStep * effectStrength) / ratio;
    float2 baseUV = vUv;
    baseUV.y = 0.5 + ((baseUV.y - 0.5) * (1.0 + (effectStrength * (maxStretch - 1.0))));
    float distort = (sin((baseUV.x * 20.0) + (progress * 3.141590118408203125)) * 0.0199999995529651641845703125) * effectStrength;
    baseUV.y += distort;
    float4 sumColor = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 9> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 2.0;
    kernel0[2] = 4.0;
    kernel0[3] = 8.0;
    kernel0[4] = 16.0;
    kernel0[5] = 8.0;
    kernel0[6] = 4.0;
    kernel0[7] = 2.0;
    kernel0[8] = 1.0;
    for (int i = -4; i <= 4; i++)
    {
        float weight = kernel0[i + 4];
        float2 param = baseUV + float2(0.0, float(i) * stepY);
        float2 sampleUV = handleUVBounds(param);
        sumColor += (tDiffuse.sample(tDiffuseSmplr, sampleUV) * weight);
        totalWeight += weight;
    }
    float4 sampledColor = sumColor / float4(totalWeight);
    float4 glowTint = (metalColor * maxGlow) * effectStrength;
    float3 blendedColor = mix(glowTint.xyz, sampledColor.xyz, float3(1.0 - (effectStrength * 0.800000011920928955078125)));
    float alpha = 1.0 - (effectStrength * 0.89999997615814208984375);
    float2 param_1 = baseUV;
    float mask = getHardBoundaryMask(param_1);
    return float4(blendedColor, (alpha * mask) * sampledColor.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.maxBlurStep, buffer.ratio, in.vUv, buffer.maxStretch, tDiffuse, tDiffuseSmplr, buffer.metalColor, buffer.maxGlow);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

