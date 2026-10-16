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
    float ratio;
    float breathFreq;
    float fogInitRadius;
    float fogFeather;
    float glowIntensity;
    float maxBlur;
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
float2 getAspectCorrectUV(thread const float2& uv, constant float& ratio)
{
    float2 aspectUV = uv;
    if (ratio > 1.0)
    {
        aspectUV.y /= ratio;
        aspectUV.y += ((1.0 - (1.0 / ratio)) * 0.5);
    }
    else
    {
        aspectUV.x *= ratio;
        aspectUV.x += ((1.0 - ratio) * 0.5);
    }
    return aspectUV;
}

static inline __attribute__((always_inline))
float circleSDF(thread const float2& uv, thread const float2& center, thread const float& radius, constant float& ratio)
{
    float2 param = uv;
    float2 aspectUV = getAspectCorrectUV(param, ratio);
    return length(aspectUV - center) - radius;
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
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& breathFreq, constant float& fogInitRadius, thread float2& vUv, constant float& fogFeather, constant float& glowIntensity, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float t = progress;
    float breathWave = 0.100000001490116119384765625 * sin((t * breathFreq) * 3.1415927410125732421875);
    float currentRadius = fogInitRadius + (t * (1.5 + breathWave));
    float2 param = vUv;
    float2 param_1 = float2(0.5);
    float param_2 = currentRadius;
    float dist = circleSDF(param, param_1, param_2, ratio);
    float fogMask = smoothstep(fogFeather, -fogFeather, dist);
    float glow = smoothstep(fogFeather * 0.5, (-fogFeather) * 0.5, dist + 0.0500000007450580596923828125) * glowIntensity;
    float blurStrength = (1.0 - t) * maxBlur;
    float2 param_3 = vUv;
    float param_4 = blurStrength;
    float param_5 = ratio;
    float4 blurredTex = gaussianBlur(tDiffuse, tDiffuseSmplr, param_3, param_4, param_5);
    float4 mixedTex = mix(blurredTex, texel, float4(t));
    float brightness = t + ((fogMask * (1.0 - t)) * 0.800000011920928955078125);
    float3 finalRGB = (mixedTex.xyz * brightness) + (float3(glow) * (1.0 - t));
    return float4(finalRGB, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.breathFreq, buffer.fogInitRadius, in.vUv, buffer.fogFeather, buffer.glowIntensity, buffer.maxBlur, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

