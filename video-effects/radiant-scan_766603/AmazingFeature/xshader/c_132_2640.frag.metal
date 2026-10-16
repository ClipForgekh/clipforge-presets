#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxBlurStrength;
    float glowWidth;
    float4 glowColor;
    float glowIntensity;
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
    return 1.0 - pow(1.0 - progress, 2.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 directionBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& strength)
{
    float4 color = float4(0.0);
    float stepSize = 0.00200000009499490261077880859375 * strength;
    float totalWeight = 0.0;
    for (int i = -4; i <= 4; i++)
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
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxBlurStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& glowWidth, constant float4& glowColor, constant float& glowIntensity)
{
    if (progress <= 0.0)
    {
        return texel;
    }
    if (progress >= 1.0)
    {
        return float4(0.0);
    }
    float blurStrength = progress * maxBlurStrength;
    float2 param = vUv;
    float param_1 = blurStrength;
    float4 blurredTexel = directionBlur(tDiffuse, tDiffuseSmplr, param, param_1);
    float glowPos = (progress * 1.5) - 0.25;
    float glowMask = smoothstep(glowPos - glowWidth, glowPos, vUv.y) * smoothstep(glowPos + glowWidth, glowPos, vUv.y);
    float3 glowEffect = ((glowColor.xyz * glowMask) * progress) * glowIntensity;
    float3 mixedColor = blurredTexel.xyz + glowEffect;
    mixedColor = fast::clamp(mixedColor, float3(0.0), float3(2.5));
    float alpha = 1.0 - smoothstep(0.800000011920928955078125, 1.0, progress);
    mixedColor *= alpha;
    return float4(mixedColor, alpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.maxBlurStrength, tDiffuse, tDiffuseSmplr, in.vUv, buffer.glowWidth, buffer.glowColor, buffer.glowIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

