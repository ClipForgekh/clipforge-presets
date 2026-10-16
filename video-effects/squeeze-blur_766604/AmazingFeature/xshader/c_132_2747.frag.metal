#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxVerticalScale;
    float maxBlurStrength;
    float ratio;
    float maxBrightness;
    float maxSaturation;
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
    float _42;
    if (progress < 0.5)
    {
        _42 = (2.0 * progress) * progress;
    }
    else
    {
        _42 = 1.0 - (pow(((-2.0) * progress) + 2.0, 2.0) * 0.5);
    }
    return _42;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float weight = 1.0 - (abs(float(i)) / 5.0);
        float2 sampleUV = uv + float2(0.0, float(i) * blurStrength);
        float2 param = sampleUV;
        sampleUV = handleUVBounds(param);
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
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxVerticalScale, thread float2& vUv, constant float& maxBlurStrength, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& maxBrightness, constant float& maxSaturation)
{
    float param = progress;
    float t = tween(param);
    float scaleY = 1.0 + (t * (maxVerticalScale - 1.0));
    float2 stretchedUV = vUv;
    stretchedUV.y = 0.5 + ((stretchedUV.y - 0.5) * scaleY);
    float2 param_1 = stretchedUV;
    stretchedUV = handleUVBounds(param_1);
    float currentBlur = (t * maxBlurStrength) / ratio;
    float2 param_2 = stretchedUV;
    float param_3 = currentBlur;
    float4 blurredColor = verticalBlur(tDiffuse, tDiffuseSmplr, param_2, param_3);
    float4 _189 = blurredColor;
    float3 _191 = _189.xyz * (1.0 + (t * (maxBrightness - 1.0)));
    blurredColor.x = _191.x;
    blurredColor.y = _191.y;
    blurredColor.z = _191.z;
    float gray = dot(blurredColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _209 = blurredColor;
    float3 _218 = mix(float3(gray), _209.xyz, float3(1.0 + (t * (maxSaturation - 1.0))));
    blurredColor.x = _218.x;
    blurredColor.y = _218.y;
    blurredColor.z = _218.z;
    float alpha = 1.0 - t;
    float2 param_4 = vUv;
    float borderMask = getHardBoundaryMask(param_4);
    return float4(blurredColor.xyz, alpha * borderMask);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float4 param = texel;
    float param_1 = effectProgress;
    float4 effectColor = effect(param, param_1, buffer.maxVerticalScale, in.vUv, buffer.maxBlurStrength, buffer.ratio, tDiffuse, tDiffuseSmplr, buffer.maxBrightness, buffer.maxSaturation);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

