#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float glowThreshold;
    float glowRadius;
    float progress;
    float3 glowColor;
    float glowIntensity;
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
float4 extractHighlight(thread const float4& color, thread const float& threshold)
{
    float luminance = dot(color.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float highlight = fast::max(0.0, luminance - threshold) / (1.0 - threshold);
    return float4(color.xyz * highlight, color.w);
}

static inline __attribute__((always_inline))
float gaussian(thread const float& x, thread const float& sigma)
{
    return exp((-(x * x)) / ((2.0 * sigma) * sigma));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& direction, thread const float& radius)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    float sigma = radius / 3.0;
    int samples = int(fast::min(radius, 20.0));
    int _94 = -samples;
    for (int i = _94; i <= samples; i++)
    {
        float param = float(i);
        float param_1 = sigma;
        float weight = gaussian(param, param_1);
        float2 offset = ((direction * float(i)) / float2(512.0)) * radius;
        color += (tex.sample(texSmplr, (uv + offset)) * weight);
        totalWeight += weight;
    }
    return color / float4(totalWeight);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 baseColor = tDiffuse.sample(tDiffuseSmplr, uv);
    float4 param = baseColor;
    float param_1 = buffer.glowThreshold;
    float4 highlight = extractHighlight(param, param_1);
    float animatedRadius = buffer.glowRadius * buffer.progress;
    float2 param_2 = uv;
    float2 param_3 = float2(1.0, 0.0);
    float param_4 = animatedRadius;
    float4 blurH = gaussianBlur(tDiffuse, tDiffuseSmplr, param_2, param_3, param_4);
    float4 param_5 = blurH;
    float param_6 = buffer.glowThreshold;
    blurH = extractHighlight(param_5, param_6);
    float2 param_7 = uv;
    float2 param_8 = float2(0.0, 1.0);
    float param_9 = animatedRadius;
    float4 blurV = gaussianBlur(tDiffuse, tDiffuseSmplr, param_7, param_8, param_9);
    float4 param_10 = blurV;
    float param_11 = buffer.glowThreshold;
    blurV = extractHighlight(param_10, param_11);
    float4 glow = mix(blurH, blurV, float4(0.5));
    float4 _203 = glow;
    float3 _205 = _203.xyz * (buffer.glowColor * buffer.glowIntensity);
    glow.x = _205.x;
    glow.y = _205.y;
    glow.z = _205.z;
    float3 finalColor = baseColor.xyz + glow.xyz;
    finalColor = fast::clamp(finalColor, float3(0.0), float3(1.0));
    out.gl_FragColor = float4(finalColor, baseColor.w);
    return out;
}

