#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float blurStrength;
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
    return (progress * progress) * progress;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& blurStrength, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float p = fast::clamp(progress, 0.0, 1.0);
    float stretch = blurStrength * p;
    float4 col = float4(0.0);
    float wsum = 0.0;
    for (int i = -6; i <= 6; i++)
    {
        float fi = float(i) / 6.0;
        float w = 1.0 - abs(fi);
        float2 param = vUv + float2(0.0, fi * stretch);
        float2 suv = handleUVBounds(param);
        col += (tDiffuse.sample(tDiffuseSmplr, suv) * w);
        wsum += w;
    }
    float4 blurred = col / float4(fast::max(wsum, 9.9999997473787516355514526367188e-05));
    float vanish = 1.0 - p;
    return float4(blurred.xyz * vanish, texel.w * vanish);
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
    float4 effectColor = effect(param_1, param_2, buffer.blurStrength, in.vUv, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

