#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float progress;
    int uIsMainCard;
    float uBrightness;
    float uColumnIndex;
    float uRippleMaxStrength;
    float uGrainMaxStrength;
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
    return 0.5 * (1.0 - cos((progress * 2.0) * 3.1415927410125732421875));
}

static inline __attribute__((always_inline))
float2 rippleWarp(thread const float2& uv, thread const float& strength, thread const float& phase)
{
    float warp = strength * sin((uv.y * 10.0) + ((phase * 2.0) * 3.1415927410125732421875));
    return float2(uv.x + warp, uv.y);
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float3 filmGrain(thread const float3& color, thread const float& strength, thread const float2& uv, constant float& progress)
{
    float2 param = uv + float2(progress * 100.0);
    float grain = random(param) * strength;
    return color + float3(grain - (0.5 * strength));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& progress, constant int& uIsMainCard, constant float& uBrightness, constant float& uColumnIndex, constant float& uRippleMaxStrength, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& uGrainMaxStrength)
{
    if (uIsMainCard == 1)
    {
        return float4(texel.xyz * uBrightness, 1.0);
    }
    float param = progress;
    float tweenVal = tween(param);
    float columnPhase = (uColumnIndex * 3.1415927410125732421875) / 16.0;
    float rippleStrength = (uRippleMaxStrength * tweenVal) * tweenVal;
    float2 param_1 = vUv;
    float param_2 = rippleStrength;
    float param_3 = progress + columnPhase;
    float2 warpedUV = rippleWarp(param_1, param_2, param_3);
    float4 warpedTexel = tDiffuse.sample(tDiffuseSmplr, warpedUV);
    float grainStrength = (uGrainMaxStrength * tweenVal) * tweenVal;
    float3 param_4 = warpedTexel.xyz;
    float param_5 = grainStrength;
    float2 param_6 = vUv;
    float3 grainedColor = filmGrain(param_4, param_5, param_6, progress_1);
    float brightnessMod = 0.180000007152557373046875 * pow(sin((3.1415927410125732421875 * progress) + columnPhase), 2.0);
    float finalBrightness = uBrightness + brightnessMod;
    return float4(grainedColor * finalBrightness, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = buffer.progress;
    float4 effectColor = effect(param_1, param_2, buffer.progress, buffer.uIsMainCard, buffer.uBrightness, buffer.uColumnIndex, buffer.uRippleMaxStrength, in.vUv, tDiffuse, tDiffuseSmplr, buffer.uGrainMaxStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

