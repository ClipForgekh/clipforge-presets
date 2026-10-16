#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float delayStep;
    float maxBlur;
    float neonStrength;
    float3 neonColor;
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
float4 sampleVerticalBlur(thread const float2& uv, thread const float& radius, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 d = float2(0.0, radius);
    float2 param = uv;
    float4 c0 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param));
    float2 param_1 = uv + d;
    float4 c1 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1));
    float2 param_2 = uv - d;
    float4 c2 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2));
    float2 param_3 = uv + (d * 2.0);
    float4 c3 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3));
    float2 param_4 = uv - (d * 2.0);
    float4 c4 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4));
    return ((c0 * 0.4000000059604644775390625) + ((c1 + c2) * 0.23999999463558197021484375)) + ((c3 + c4) * 0.0599999986588954925537109375);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& delayStep, constant float& maxBlur, constant float& neonStrength, constant float3& neonColor)
{
    if (p >= 0.99989998340606689453125)
    {
        return texel;
    }
    float bands = 8.0;
    float bandIdx = floor(fast::clamp(vUv.y, 0.0, 0.999998986721038818359375) * bands);
    float localY = fract(vUv.y * bands);
    float distCenter = fast::min(abs(bandIdx - 3.0), abs(bandIdx - 4.0));
    float delay = distCenter * delayStep;
    float localP = fast::clamp((p - delay) / fast::max(1.0 - delay, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    float moveOffset = (1.0 - localP) * (1.0 + (1.0 / bands));
    float2 rawUV = float2(vUv.x, vUv.y + moveOffset);
    float2 param = rawUV;
    float stripMask = getHardBoundaryMask(param);
    float centerFactor = 1.0 - fast::clamp(distCenter / 3.0, 0.0, 1.0);
    float blurRadius = (maxBlur * (1.0 - localP)) * mix(1.14999997615814208984375, 0.64999997615814208984375, centerFactor);
    float2 param_1 = rawUV;
    float param_2 = blurRadius;
    float4 stripTexel = sampleVerticalBlur(param_1, param_2, tDiffuse, tDiffuseSmplr) * stripMask;
    float edgeDist = fast::min(localY, 1.0 - localY);
    float edgeMask = 1.0 - smoothstep(0.0, 0.07999999821186065673828125, edgeDist);
    float neon = (neonStrength * (1.0 - localP)) * edgeMask;
    float3 edgeGlow = neonColor * neon;
    float gapGlowStrength = ((1.0 - stripMask) * (1.0 - p)) * (0.25 + (0.3499999940395355224609375 * edgeMask));
    float3 gapGlow = float3(0.7400000095367431640625, 0.560000002384185791015625, 1.0) * gapGlowStrength;
    float3 base = stripTexel.xyz;
    float3 glow = fast::clamp(edgeGlow + gapGlow, float3(0.0), float3(1.0));
    float3 rgb = float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - glow));
    float alpha = fast::clamp((mix(0.300000011920928955078125, 1.0, p) * stripMask) + gapGlowStrength, 0.0, 1.0);
    return float4(rgb, alpha);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.delayStep, buffer.maxBlur, buffer.neonStrength, buffer.neonColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

