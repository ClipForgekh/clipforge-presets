#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxBlurStrength;
    float maxGlowIntensity;
    float ratio;
    float3 glowColor;
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
float4 directionalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    float stepSize = (0.001000000047497451305389404296875 * blurStrength) / ratio;
    for (int i = -3; i <= 3; i++)
    {
        float weight = 1.0 - (abs(float(i)) / 4.0);
        float2 offset = float2(0.0, float(i) * stepSize);
        float2 param = uv + offset;
        float2 sampleUV = handleUVBounds(param);
        color += (tex.sample(texSmplr, sampleUV) * weight);
        totalWeight += weight;
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxBlurStrength, constant float& maxGlowIntensity, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& ratio, constant float3& glowColor)
{
    float param = progress;
    float t = tween(param);
    float currentBlur = (1.0 - t) * maxBlurStrength;
    float currentGlow = (1.0 - t) * maxGlowIntensity;
    float2 param_1 = vUv;
    float param_2 = currentBlur;
    float param_3 = ratio;
    float4 blurredTexel = directionalBlur(tDiffuse, tDiffuseSmplr, param_1, param_2, param_3);
    float3 glow = (blurredTexel.xyz * glowColor) * currentGlow;
    float3 finalRGB = blurredTexel.xyz + glow;
    finalRGB = fast::clamp(finalRGB, float3(0.0), float3(1.0));
    return float4(finalRGB, texel.w);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float4 param = texel;
    float param_1 = effectProgress;
    float4 effectColor = effect(param, param_1, buffer.maxBlurStrength, buffer.maxGlowIntensity, tDiffuse, tDiffuseSmplr, in.vUv, buffer.ratio, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

