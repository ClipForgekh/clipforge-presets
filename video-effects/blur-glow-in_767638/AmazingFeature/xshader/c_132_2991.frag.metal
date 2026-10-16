#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float zoomStrength;
    float2 blurDirection;
    float ratio;
    float maxBlur;
    float3 glowColor;
    float glowStrength;
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
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 directionalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& dir, thread const float& radius)
{
    float4 col = float4(0.0);
    float wsum = 0.0;
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    float2 stepDir = dir * radius;
    float2 param = uv;
    col += (tex.sample(texSmplr, handleUVBounds(param)) * w0);
    wsum += w0;
    float2 param_1 = uv + (stepDir * 1.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_1)) * w1);
    float2 param_2 = uv - (stepDir * 1.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_2)) * w1);
    wsum += (2.0 * w1);
    float2 param_3 = uv + (stepDir * 2.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_3)) * w2);
    float2 param_4 = uv - (stepDir * 2.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_4)) * w2);
    wsum += (2.0 * w2);
    float2 param_5 = uv + (stepDir * 3.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_5)) * w3);
    float2 param_6 = uv - (stepDir * 3.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_6)) * w3);
    wsum += (2.0 * w3);
    float2 param_7 = uv + (stepDir * 4.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_7)) * w4);
    float2 param_8 = uv - (stepDir * 4.0);
    col += (tex.sample(texSmplr, handleUVBounds(param_8)) * w4);
    wsum += (2.0 * w4);
    return col / float4(fast::max(wsum, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& zoomStrength, thread float2& vUv, constant float2& blurDirection, constant float& ratio, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float3& glowColor, constant float& glowStrength)
{
    float strength = 1.0 - progress;
    float scale = 1.0 + (zoomStrength * strength);
    float2 uv = float2(0.5) + ((vUv - float2(0.5)) * scale);
    float2 param = uv;
    float borderMask = getHardBoundaryMask(param);
    float2 param_1 = uv;
    uv = handleUVBounds(param_1);
    float2 dir = fast::normalize(float2(blurDirection.x, blurDirection.y / fast::max(ratio, 9.9999997473787516355514526367188e-05)));
    float blurRadius = maxBlur * strength;
    float4 baseCol = tDiffuse.sample(tDiffuseSmplr, uv);
    float2 param_2 = uv;
    float2 param_3 = dir;
    float param_4 = blurRadius;
    float4 blurCol = directionalBlur(tDiffuse, tDiffuseSmplr, param_2, param_3, param_4);
    float luma = dot(blurCol.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 glow = ((glowColor * luma) * glowStrength) * strength;
    float3 mixed = mix(baseCol.xyz, blurCol.xyz, float3(fast::clamp(strength * 0.949999988079071044921875, 0.0, 1.0)));
    float3 finalRgb = fast::clamp(mixed + glow, float3(0.0), float3(1.0));
    return float4(finalRgb, baseCol.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.zoomStrength, in.vUv, buffer.blurDirection, buffer.ratio, buffer.maxBlur, tDiffuse, tDiffuseSmplr, buffer.glowColor, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

