#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxRotation;
    float displacementStrength;
    float minScale;
    float maxBlurRadius;
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
    return pow(progress, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 directionBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread float2& dir, thread const float& radius, thread const float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    dir.y /= ratio;
    if (length(dir) < 0.001000000047497451305389404296875)
    {
        dir = float2(1.0, 0.0);
    }
    dir = (fast::normalize(dir) * radius) * 0.001000000047497451305389404296875;
    for (int i = -2; i <= 2; i++)
    {
        float offset = float(i);
        float weight = 1.0 - (abs(offset) / 3.0);
        float2 param = uv + (dir * offset);
        float2 sampleUV = handleUVBounds(param);
        color += (tex.sample(texSmplr, sampleUV) * weight);
        totalWeight += weight;
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxRotation, constant float& displacementStrength, constant float& minScale, constant float& maxBlurRadius, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& ratio)
{
    float t = progress;
    float currentAngle = t * maxRotation;
    float2 currentDisplacement = (float2(1.0) * t) * displacementStrength;
    float currentScale = 1.0 - (t * (1.0 - minScale));
    float currentBlurRadius = t * maxBlurRadius;
    float s = sin(currentAngle);
    float c = cos(currentAngle);
    float2 transformedUV = vUv - float2(0.5);
    transformedUV *= currentScale;
    transformedUV = float2((transformedUV.x * c) - (transformedUV.y * s), (transformedUV.x * s) + (transformedUV.y * c));
    transformedUV += currentDisplacement;
    transformedUV += float2(0.5);
    float2 param = transformedUV;
    float2 param_1 = currentDisplacement;
    float param_2 = currentBlurRadius;
    float param_3 = ratio;
    float4 _219 = directionBlur(tDiffuse, tDiffuseSmplr, param, param_1, param_2, param_3);
    float4 blurredColor = _219;
    float2 param_4 = transformedUV;
    float boundaryMask = getHardBoundaryMask(param_4);
    float alpha = 1.0 - t;
    return float4(blurredColor.xyz, (blurredColor.w * boundaryMask) * alpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.maxRotation, buffer.displacementStrength, buffer.minScale, buffer.maxBlurRadius, in.vUv, tDiffuse, tDiffuseSmplr, buffer.ratio);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

