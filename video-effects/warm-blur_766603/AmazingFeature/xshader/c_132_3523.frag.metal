#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float blurRadius;
    float peakGlowBoost;
    float glowStrength;
    float glowAlpha;
    float3 glowColor;
    float brightnessBoost;
    float saturationBoost;
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
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusPx, constant float& ratio)
{
    if (radiusPx <= 9.9999997473787516355514526367188e-05)
    {
        float2 param = uv;
        float4 _98 = tex.sample(texSmplr, handleUVBounds(param));
        return _98;
    }
    float r = radiusPx / 1000.0;
    float2 stepUV = float2(r, r / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param_1 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.227026998996734619140625);
    float2 param_2 = uv + float2(stepUV.x, 0.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.19459460675716400146484375);
    float2 param_3 = uv - float2(stepUV.x, 0.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.19459460675716400146484375);
    float2 param_4 = uv + float2(0.0, stepUV.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.19459460675716400146484375);
    float2 param_5 = uv - float2(0.0, stepUV.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.19459460675716400146484375);
    float2 param_6 = uv + stepUV;
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.0606059990823268890380859375);
    float2 param_7 = uv - stepUV;
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.0606059990823268890380859375);
    float2 param_8 = uv + float2(stepUV.x, -stepUV.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0606059990823268890380859375);
    float2 param_9 = uv + float2(-stepUV.x, stepUV.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_9)) * 0.0606059990823268890380859375);
    return c / float4(1.24726641178131103515625);
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& sat)
{
    float luma = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(luma), color, float3(sat));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& blurRadius, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& peakGlowBoost, constant float& glowStrength, constant float& glowAlpha, constant float3& glowColor, constant float& brightnessBoost, constant float& saturationBoost)
{
    float p = fast::clamp(progress, 0.0, 1.0);
    float strength = 1.0 - p;
    float blurFactor;
    if (p < 0.300000011920928955078125)
    {
        float t = smoothstep(0.0, 0.300000011920928955078125, p);
        blurFactor = mix(1.0, 0.5, t);
    }
    else
    {
        float t_1 = smoothstep(0.300000011920928955078125, 1.0, p);
        blurFactor = mix(0.5, 0.0, t_1);
    }
    float currentBlur = blurRadius * blurFactor;
    float2 param = vUv;
    float param_1 = currentBlur;
    float4 blurredTexel = gaussianBlur9(tDiffuse, tDiffuseSmplr, param, param_1, ratio);
    float earlyBoost = 1.0 + (peakGlowBoost * (1.0 - smoothstep(0.0, 0.20000000298023223876953125, p)));
    float currentGlow = (glowStrength * strength) * earlyBoost;
    float currentGlowAlpha = glowAlpha * strength;
    float3 glowLayer = (blurredTexel.xyz * glowColor) * currentGlow;
    float3 param_2 = blurredTexel.xyz;
    float3 param_3 = glowLayer;
    float3 litColor = screenBlend(param_2, param_3);
    float3 color = mix(blurredTexel.xyz, litColor, float3(fast::clamp(currentGlowAlpha, 0.0, 1.0)));
    float currentBrightness = mix(1.0, brightnessBoost, strength);
    float currentSaturation = mix(1.0, saturationBoost, strength);
    color *= currentBrightness;
    float3 param_4 = color;
    float param_5 = currentSaturation;
    color = adjustSaturation(param_4, param_5);
    color = fast::clamp(color, float3(0.0), float3(1.0));
    return float4(color, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.blurRadius, tDiffuse, tDiffuseSmplr, in.vUv, buffer.peakGlowBoost, buffer.glowStrength, buffer.glowAlpha, buffer.glowColor, buffer.brightnessBoost, buffer.saturationBoost);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

