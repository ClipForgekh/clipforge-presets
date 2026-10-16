#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float maxGaussianBlur;
    float maxDirectionalBlur;
    float maxScale;
    float stretchStrength;
    float maxGlow;
    float ratio;
    float4 glowColor;
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
    return pow(progress, 2.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 9> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 2.0;
    kernel0[2] = 1.0;
    kernel0[3] = 2.0;
    kernel0[4] = 4.0;
    kernel0[5] = 2.0;
    kernel0[6] = 1.0;
    kernel0[7] = 2.0;
    kernel0[8] = 1.0;
    float baseStep = 0.001000000047497451305389404296875 * blurStrength;
    float2 stepSize = float2(baseStep, baseStep / ratio);
    for (int i = -1; i <= 1; i++)
    {
        for (int j = -1; j <= 1; j++)
        {
            float weight = kernel0[((i + 1) * 3) + (j + 1)];
            float2 offset = float2(float(i) * stepSize.x, float(j) * stepSize.y);
            float2 param = uv + offset;
            float2 sampleUV = handleUVBounds(param);
            color += (tex.sample(texSmplr, sampleUV) * weight);
            totalWeight += weight;
        }
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float4 directionalBlurVertical(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& ratio)
{
    float4 color = float4(0.0);
    float stepSize = (0.001000000047497451305389404296875 * blurStrength) / ratio;
    int samples = 15;
    int _175 = (-samples) / 2;
    for (int i = _175; i <= (samples / 2); i++)
    {
        float offset = float(i) * stepSize;
        float2 param = uv + float2(0.0, offset);
        float2 sampleUV = handleUVBounds(param);
        color += tex.sample(texSmplr, sampleUV);
    }
    return color / float4(float(samples + 1));
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& maxGaussianBlur, constant float& maxDirectionalBlur, constant float& maxScale, constant float& stretchStrength, constant float& maxGlow, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& ratio, constant float4& glowColor)
{
    float gaussianProgress = fast::clamp(progress / 0.300000011920928955078125, 0.0, 1.0);
    float _237;
    if (progress > 0.300000011920928955078125)
    {
        _237 = pow((progress - 0.300000011920928955078125) / 0.699999988079071044921875, 2.0);
    }
    else
    {
        _237 = 0.0;
    }
    float dirBlurProgress = _237;
    float currentGaussian = gaussianProgress * maxGaussianBlur;
    float currentDirBlur = dirBlurProgress * maxDirectionalBlur;
    float currentScale = 1.0 + (progress * (maxScale - 1.0));
    float currentStretch = 1.0 + (progress * stretchStrength);
    float currentGlow = 0.5 + (progress * (maxGlow - 0.5));
    float currentAlpha = 1.0 - (progress * 0.89999997615814208984375);
    float2 uv = float2(0.5) + ((vUv - float2(0.5)) / float2(currentScale));
    uv.y = 0.5 + ((uv.y - 0.5) / currentStretch);
    float2 param = uv;
    uv = handleUVBounds(param);
    float2 param_1 = uv;
    float param_2 = currentGaussian;
    float param_3 = ratio;
    float4 blurred = gaussianBlur(tDiffuse, tDiffuseSmplr, param_1, param_2, param_3);
    float2 param_4 = uv;
    float param_5 = currentDirBlur + currentGaussian;
    float param_6 = ratio;
    blurred = directionalBlurVertical(tDiffuse, tDiffuseSmplr, param_4, param_5, param_6);
    float gray = dot(blurred.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 saturated = mix(float3(gray), blurred.xyz, float3(1.0 + (progress * 0.20000000298023223876953125)));
    float3 brightened = saturated * (1.0 + (progress * 1.0));
    float3 glow = (glowColor.xyz * currentGlow) * blurred.w;
    float3 finalRgb = float3(1.0) - ((float3(1.0) - brightened) * (float3(1.0) - glow));
    float2 param_7 = vUv;
    float borderMask = getHardBoundaryMask(param_7);
    return float4(finalRgb, (blurred.w * currentAlpha) * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.maxGaussianBlur, buffer.maxDirectionalBlur, buffer.maxScale, buffer.stretchStrength, buffer.maxGlow, in.vUv, tDiffuse, tDiffuseSmplr, buffer.ratio, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

