#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float bandSoftness;
    float blurRadius;
    float grainAmount;
    float glowStrength;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusPx)
{
    float r = radiusPx * 0.001000000047497451305389404296875;
    float4 c = float4(0.0);
    float2 param = uv + float2(0.0, (-4.0) * r);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0500000007450580596923828125);
    float2 param_1 = uv + float2(0.0, (-3.0) * r);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv + float2(0.0, (-2.0) * r);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv + float2(0.0, (-1.0) * r);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.180000007152557373046875);
    float2 param_5 = uv + float2(0.0, 1.0 * r);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + float2(0.0, 2.0 * r);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + float2(0.0, 3.0 * r);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + float2(0.0, 4.0 * r);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0500000007450580596923828125);
    return c;
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& bandSoftness, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& blurRadius, constant float& grainAmount, constant float& glowStrength, constant float3& glowColor)
{
    float inv = 1.0 - p;
    float sweepPhase = fast::min(p / 0.699999988079071044921875, 1.0);
    float head = (-0.25) + (1.5 * sweepPhase);
    float clearMask = smoothstep(-bandSoftness, bandSoftness, head - vUv.y);
    float remainMask = 1.0 - clearMask;
    float localBlurFactor = inv * remainMask;
    float2 param = vUv;
    float param_1 = blurRadius * localBlurFactor;
    float4 blurTex = verticalBlur(tDiffuse, tDiffuseSmplr, param, param_1);
    float3 baseCol = mix(texel.xyz, blurTex.xyz, float3(fast::clamp(localBlurFactor * 1.2000000476837158203125, 0.0, 1.0)));
    float d = abs(vUv.y - head);
    float band = exp((-(d * d)) / fast::max(9.9999997473787516355514526367188e-05, (bandSoftness * bandSoftness) * 0.3499999940395355224609375));
    float glowFade = inv * (0.64999997615814208984375 + (0.3499999940395355224609375 * remainMask));
    float2 param_2 = vUv * float2(128.0, 256.0);
    float grain = ((hash12(param_2) - 0.5) * 2.0) * grainAmount;
    float glow = fast::max(0.0, ((band * glowStrength) * glowFade) * (1.0 + grain));
    float3 col = baseCol;
    float exposure = 1.0 + (glow * 0.449999988079071044921875);
    col *= exposure;
    float satKeep = 1.0 - (0.300000011920928955078125 * fast::clamp(glowFade, 0.0, 1.0));
    float luma = dot(col, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    col = mix(float3(luma), col, float3(satKeep));
    col += ((glowColor * glow) * 0.3499999940395355224609375);
    col = fast::clamp(col, float3(0.0), float3(1.0));
    float alphaRamp = smoothstep(0.0, 0.20000000298023223876953125, p);
    float outAlpha = texel.w * alphaRamp;
    return float4(col, outAlpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.bandSoftness, in.vUv, tDiffuse, tDiffuseSmplr, buffer.blurRadius, buffer.grainAmount, buffer.glowStrength, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

