#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float echoInterval;
    float echoDuration;
    float echoDecay;
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
    return progress;
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
float4 effect(thread const float4& texel, thread const float& p, constant float& echoInterval, constant float& echoDuration, constant float& echoDecay, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float baseScale = mix(0.20000000298023223876953125, 1.0, smoothstep(0.0, 1.0, p));
    float4 finalColor = float4(0.0, 0.0, 0.0, 1.0);
    float spawnLimit = 0.7799999713897705078125;
    int currentMaxK = int(fast::min(p, spawnLimit) / echoInterval);
    for (int i = 5; i >= 0; i--)
    {
        int k = currentMaxK - i;
        if (k < 0)
        {
            continue;
        }
        float tk = float(k) * echoInterval;
        float age = p - tk;
        float lk = fast::clamp(age / echoDuration, 0.0, 1.0);
        if ((age < 0.0) || (lk >= 1.0))
        {
            continue;
        }
        float scale_k = baseScale * (1.0 + (0.699999988079071044921875 * lk));
        float layerAlpha = 0.800000011920928955078125 * pow(echoDecay, float(i));
        layerAlpha *= (1.0 - smoothstep(0.0, 1.0, lk));
        if (p > 0.7799999713897705078125)
        {
            layerAlpha *= (1.0 - smoothstep(0.7799999713897705078125, 1.0, p));
        }
        float2 uv_k = float2(0.5) + ((vUv - float2(0.5)) / float2(scale_k));
        float2 param = uv_k;
        float mask_k = getHardBoundaryMask(param);
        float2 param_1 = uv_k;
        uv_k = handleUVBounds(param_1);
        float4 col_k = tDiffuse.sample(tDiffuseSmplr, uv_k);
        finalColor = mix(finalColor, col_k, float4((layerAlpha * col_k.w) * mask_k));
    }
    float2 uv_main = float2(0.5) + ((vUv - float2(0.5)) / float2(baseScale));
    float2 param_2 = uv_main;
    float mask_main = getHardBoundaryMask(param_2);
    float2 param_3 = uv_main;
    uv_main = handleUVBounds(param_3);
    float4 col_main = tDiffuse.sample(tDiffuseSmplr, uv_main);
    float alpha_main = mix(0.800000011920928955078125, 1.0, p);
    finalColor = mix(finalColor, col_main, float4((alpha_main * col_main.w) * mask_main));
    return finalColor;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp(buffer.progress, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 finalColor = effect(param_1, param_2, buffer.echoInterval, buffer.echoDuration, buffer.echoDecay, in.vUv, tDiffuse, tDiffuseSmplr);
    out.gl_FragColor = finalColor;
    return out;
}

