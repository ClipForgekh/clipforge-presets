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
    float2 u_resolution;
    float u_verticalBlurRadiusPx;
    float u_glowRiseProgress;
    float u_glowFeather;
    float3 u_glowColorBottom;
    float3 u_glowColorTop;
    float u_glowIntensity;
    float u_glowAlphaFade;
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
float4 sampleVerticalBlur(thread const float2& uv, thread const float& blurRadiusPx, texture2d<float> texture1, sampler texture1Smplr, constant float2& u_resolution)
{
    if (blurRadiusPx <= 9.9999997473787516355514526367188e-05)
    {
        return texture1.sample(texture1Smplr, uv);
    }
    float pixelStep = 1.0 / fast::max(u_resolution.y, 1.0);
    float radiusUv = blurRadiusPx * pixelStep;
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 9> offsets;
    offsets[0] = -4.0;
    offsets[1] = -3.0;
    offsets[2] = -2.0;
    offsets[3] = -1.0;
    offsets[4] = 0.0;
    offsets[5] = 1.0;
    offsets[6] = 2.0;
    offsets[7] = 3.0;
    offsets[8] = 4.0;
    spvUnsafeArray<float, 9> weights;
    weights[0] = 0.0500000007450580596923828125;
    weights[1] = 0.0900000035762786865234375;
    weights[2] = 0.119999997317790985107421875;
    weights[3] = 0.1500000059604644775390625;
    weights[4] = 0.180000007152557373046875;
    weights[5] = 0.1500000059604644775390625;
    weights[6] = 0.119999997317790985107421875;
    weights[7] = 0.0900000035762786865234375;
    weights[8] = 0.0500000007450580596923828125;
    for (int i = 0; i < 9; i++)
    {
        float2 sampleUv = uv + float2(0.0, (offsets[i] * radiusUv) / 4.0);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * weights[i]);
        totalWeight += weights[i];
    }
    return color / float4(fast::max(totalWeight, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& base, thread const float3& blend)
{
    return float3(1.0) - ((float3(1.0) - base) * (float3(1.0) - blend));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 originalTexel = texture1.sample(texture1Smplr, uv);
    float2 param = uv;
    float param_1 = buffer.u_verticalBlurRadiusPx;
    float4 blurredTexel = sampleVerticalBlur(param, param_1, texture1, texture1Smplr, buffer.u_resolution);
    float blurMix = fast::clamp(buffer.u_verticalBlurRadiusPx / 220.0, 0.0, 1.0);
    float4 imageTexel = mix(originalTexel, blurredTexel, float4(blurMix));
    float riseMask = smoothstep(0.0, fast::max(buffer.u_glowRiseProgress, 9.9999997473787516355514526367188e-05), uv.y);
    float bottomMask = 1.0 - smoothstep(0.0, fast::max(9.9999997473787516355514526367188e-05, buffer.u_glowRiseProgress + buffer.u_glowFeather), uv.y);
    float glowGradient = mix(1.0, 0.0, fast::clamp(uv.y, 0.0, 1.0));
    float3 glowColor = mix(buffer.u_glowColorBottom, buffer.u_glowColorTop, float3(fast::clamp(uv.y, 0.0, 1.0)));
    float glowCoverage = (1.0 - riseMask) + (bottomMask * 0.64999997615814208984375);
    glowCoverage = fast::clamp(glowCoverage, 0.0, 1.0);
    float featherAlpha = smoothstep(0.0, 1.0, glowCoverage);
    float glowAlpha = ((buffer.u_glowIntensity * glowGradient) * featherAlpha) * buffer.u_glowAlphaFade;
    float3 glowLayer = glowColor * glowAlpha;
    float3 param_2 = imageTexel.xyz;
    float3 param_3 = glowLayer;
    float3 finalRgb = screenBlend(param_2, param_3);
    out.gl_FragColor = float4(finalRgb, 1.0);
    return out;
}

