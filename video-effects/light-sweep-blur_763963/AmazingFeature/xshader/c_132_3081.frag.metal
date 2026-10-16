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
    float maxBlurStrength;
    float feather;
    float glowWidth;
    float4 glowColor;
    float glowIntensity;
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
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& strength, thread const float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    float stepSize = (0.001000000047497451305389404296875 * strength) / ratio;
    spvUnsafeArray<float, 9> weights;
    weights[0] = 0.0199999995529651641845703125;
    weights[1] = 0.0500000007450580596923828125;
    weights[2] = 0.100000001490116119384765625;
    weights[3] = 0.180000007152557373046875;
    weights[4] = 0.300000011920928955078125;
    weights[5] = 0.180000007152557373046875;
    weights[6] = 0.100000001490116119384765625;
    weights[7] = 0.0500000007450580596923828125;
    weights[8] = 0.0199999995529651641845703125;
    for (int i = -4; i <= 4; i++)
    {
        float offset = float(i) * stepSize;
        float2 param = uv + float2(0.0, offset);
        float2 sampleUV = handleUVBounds(param);
        float weight = weights[i + 4];
        color += (tex.sample(texSmplr, sampleUV) * weight);
        totalWeight += weight;
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float getShortSideRelativeSize(thread const float& fraction, constant float& ratio)
{
    if (ratio > 1.0)
    {
        return fraction;
    }
    else
    {
        return fraction * ratio;
    }
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& maxBlurStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& feather, constant float& glowWidth, constant float4& glowColor, constant float& glowIntensity)
{
    float wipeY = progress;
    float currentBlur = (1.0 - progress) * maxBlurStrength;
    float4 clearTex = texel;
    float2 param = vUv;
    float param_1 = currentBlur;
    float param_2 = ratio;
    float4 blurTex = verticalBlur(tDiffuse, tDiffuseSmplr, param, param_1, param_2);
    float blurMask = smoothstep(wipeY - feather, wipeY + feather, vUv.y);
    float4 baseColor = mix(clearTex, blurTex, float4(blurMask));
    float param_3 = 1.0;
    float adjustedGlowWidth = glowWidth * getShortSideRelativeSize(param_3, ratio);
    float glowMask = 1.0 - (abs(vUv.y - wipeY) / adjustedGlowWidth);
    glowMask = fast::clamp(glowMask, 0.0, 1.0);
    glowMask = pow(glowMask, 2.0);
    float3 glow = (((glowColor.xyz * glowMask) * (1.0 - progress)) * glowIntensity) * glowColor.w;
    float4 _234 = baseColor;
    float3 _236 = _234.xyz + glow;
    baseColor.x = _236.x;
    baseColor.y = _236.y;
    baseColor.z = _236.z;
    float4 _245 = baseColor;
    float3 _249 = fast::clamp(_245.xyz, float3(0.0), float3(1.0));
    baseColor.x = _249.x;
    baseColor.y = _249.y;
    baseColor.z = _249.z;
    return baseColor;
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.maxBlurStrength, tDiffuse, tDiffuseSmplr, in.vUv, buffer.feather, buffer.glowWidth, buffer.glowColor, buffer.glowIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

