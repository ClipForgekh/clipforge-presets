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
    float waveStrength;
    float maxBlurStrength;
    float ratio;
    float maxGlowIntensity;
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
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.1415927410125732421875));
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
    spvUnsafeArray<float, 25> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 4.0;
    kernel0[2] = 6.0;
    kernel0[3] = 4.0;
    kernel0[4] = 1.0;
    kernel0[5] = 4.0;
    kernel0[6] = 16.0;
    kernel0[7] = 24.0;
    kernel0[8] = 16.0;
    kernel0[9] = 4.0;
    kernel0[10] = 6.0;
    kernel0[11] = 24.0;
    kernel0[12] = 36.0;
    kernel0[13] = 24.0;
    kernel0[14] = 6.0;
    kernel0[15] = 4.0;
    kernel0[16] = 16.0;
    kernel0[17] = 24.0;
    kernel0[18] = 16.0;
    kernel0[19] = 4.0;
    kernel0[20] = 1.0;
    kernel0[21] = 4.0;
    kernel0[22] = 6.0;
    kernel0[23] = 4.0;
    kernel0[24] = 1.0;
    float baseStep = 0.001000000047497451305389404296875 * blurStrength;
    float2 stepSize = float2(baseStep, baseStep / ratio);
    for (int i = -2; i <= 2; i++)
    {
        for (int j = -2; j <= 2; j++)
        {
            float weight = kernel0[((i + 2) * 5) + (j + 2)];
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
float4 effect(thread const float4& texel, thread const float& progress, thread float2& vUv, constant float& waveStrength, constant float& maxBlurStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& ratio, constant float& maxGlowIntensity, constant float4& glowColor)
{
    float effectStrength = 1.0 - progress;
    float waveX = sin((vUv.x * 12.0) + (progress * 25.0)) * cos((vUv.y * 8.0) + (progress * 18.0));
    float waveY = cos((vUv.x * 9.0) + (progress * 22.0)) * sin((vUv.y * 11.0) + (progress * 16.0));
    float2 waveOffset = (float2(waveX, waveY) * effectStrength) * waveStrength;
    float2 uv = vUv + waveOffset;
    float2 param = uv;
    uv = handleUVBounds(param);
    float currentBlur = effectStrength * maxBlurStrength;
    float2 param_1 = uv;
    float param_2 = currentBlur;
    float param_3 = ratio;
    float4 blurredTex = gaussianBlur(tDiffuse, tDiffuseSmplr, param_1, param_2, param_3);
    float currentGlow = (effectStrength * maxGlowIntensity) * (0.60000002384185791015625 + (0.4000000059604644775390625 * sin(((progress * 12.0) + (vUv.x * 4.0)) + (vUv.y * 3.0))));
    float3 glow = glowColor.xyz * currentGlow;
    float3 blendedColor = float3(1.0) - ((float3(1.0) - blurredTex.xyz) * (float3(1.0) - glow));
    blendedColor *= (1.0 + (effectStrength * 1.5));
    blendedColor = fast::clamp(blendedColor, float3(0.0), float3(1.0));
    return float4(blendedColor, texel.w);
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.waveStrength, buffer.maxBlurStrength, tDiffuse, tDiffuseSmplr, buffer.ratio, buffer.maxGlowIntensity, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

