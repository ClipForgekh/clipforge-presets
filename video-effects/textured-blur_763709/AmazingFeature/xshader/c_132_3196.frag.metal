#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float maxBlurPx;
    float maxExposure;
    float maxSaturation;
    float3 warmTemperatureColor;
    float3 warmGlowColor;
    float maxGlowIntensity;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurPx, constant float& ratio)
{
    float baseStep = blurPx * 0.00150000001303851604461669921875;
    float2 _97;
    if (ratio > 1.0)
    {
        _97 = float2(baseStep / ratio, baseStep);
    }
    else
    {
        _97 = float2(baseStep, baseStep * ratio);
    }
    float2 stepSize = _97;
    float4 c = float4(0.0);
    float2 param = uv + (stepSize * float2(-1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 1.0);
    float2 param_1 = uv + (stepSize * float2(0.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 2.0);
    float2 param_2 = uv + (stepSize * float2(1.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 1.0);
    float2 param_3 = uv + (stepSize * float2(-1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 2.0);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 4.0);
    float2 param_5 = uv + (stepSize * float2(1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 2.0);
    float2 param_6 = uv + (stepSize * float2(-1.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 1.0);
    float2 param_7 = uv + (stepSize * float2(0.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 2.0);
    float2 param_8 = uv + (stepSize * float2(1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 1.0);
    return c / float4(16.0);
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& sat)
{
    float luma = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(luma), color, float3(sat));
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& maxBlurPx, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& maxExposure, constant float& maxSaturation, constant float3& warmTemperatureColor, constant float3& warmGlowColor, constant float& maxGlowIntensity)
{
    float strength = 1.0 - p;
    float blurNow = maxBlurPx * strength;
    float2 param = vUv;
    float param_1 = blurNow;
    float4 blurred = gaussianBlur9(tDiffuse, tDiffuseSmplr, param, param_1, ratio);
    float exposureNow = 1.0 + ((maxExposure - 1.0) * strength);
    float saturationNow = 1.0 + ((maxSaturation - 1.0) * strength);
    float3 baseColor = blurred.xyz * exposureNow;
    float3 param_2 = baseColor;
    float param_3 = saturationNow;
    baseColor = adjustSaturation(param_2, param_3);
    float3 tempTint = mix(float3(1.0), warmTemperatureColor, float3(strength));
    baseColor *= tempTint;
    float glowAlpha = strength;
    float3 glowLayer = (blurred.xyz * warmGlowColor) * (maxGlowIntensity * strength);
    float3 param_4 = baseColor;
    float3 param_5 = glowLayer;
    float3 screened = screenBlend(param_4, param_5);
    float3 finalRgb = mix(baseColor, screened, float3(glowAlpha));
    finalRgb = fast::clamp(finalRgb, float3(0.0), float3(1.0));
    return float4(finalRgb, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.maxBlurPx, tDiffuse, tDiffuseSmplr, in.vUv, buffer.maxExposure, buffer.maxSaturation, buffer.warmTemperatureColor, buffer.warmGlowColor, buffer.maxGlowIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

