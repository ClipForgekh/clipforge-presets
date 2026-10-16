#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uVortexStrength;
    float uBrightness;
    float uGlowStrength;
    float ratio;
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
    return 1.0 - (exp((-progress) * 4.0) * cos((progress * 8.0) * 3.1415927410125732421875));
}

static inline __attribute__((always_inline))
float2 vortexWarp(thread const float2& uv, thread const float2& center, thread const float& strength)
{
    float2 p = uv - center;
    float radius = length(p);
    float angle = precise::atan2(p.y, p.x) + (strength * exp((-radius) * 3.0));
    return (float2(cos(angle), sin(angle)) * radius) + center;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 softGlow(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& strength, thread const float& ratio)
{
    float4 base = tex.sample(texSmplr, uv);
    float brightness = dot(base.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    if (brightness < 0.699999988079071044921875)
    {
        return base;
    }
    float2 stepSize = float2(0.00200000009499490261077880859375, 0.00200000009499490261077880859375 / ratio) * strength;
    float4 sum = float4(0.0);
    sum += tex.sample(texSmplr, (uv + stepSize));
    sum += tex.sample(texSmplr, (uv - stepSize));
    sum += tex.sample(texSmplr, (uv + float2(stepSize.x, -stepSize.y)));
    sum += tex.sample(texSmplr, (uv + float2(-stepSize.x, stepSize.y)));
    sum *= 0.20000000298023223876953125;
    return base + ((sum * strength) * 0.5);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& uVortexStrength, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& uBrightness, constant float& uGlowStrength, constant float& ratio)
{
    float warpAmount = uVortexStrength * (1.0 - pow(abs((progress * 2.0) - 1.0), 3.0));
    float2 param = vUv;
    float2 param_1 = float2(0.5);
    float param_2 = warpAmount;
    float2 warpedUV = vortexWarp(param, param_1, param_2);
    float2 param_3 = warpedUV;
    warpedUV = handleUVBounds(param_3);
    float4 warpedTexel = tDiffuse.sample(tDiffuseSmplr, warpedUV);
    float3 brightColor = warpedTexel.xyz * uBrightness;
    float glowAmount = uGlowStrength * (1.0 - pow(abs((progress * 2.0) - 1.0), 2.0));
    float2 param_4 = warpedUV;
    float param_5 = glowAmount;
    float param_6 = ratio;
    float4 glowColor = softGlow(tDiffuse, tDiffuseSmplr, param_4, param_5, param_6);
    float3 finalRGB = mix(brightColor, glowColor.xyz, float3(glowAmount * 0.300000011920928955078125));
    return float4(finalRGB, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.uVortexStrength, in.vUv, tDiffuse, tDiffuseSmplr, buffer.uBrightness, buffer.uGlowStrength, buffer.ratio);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

