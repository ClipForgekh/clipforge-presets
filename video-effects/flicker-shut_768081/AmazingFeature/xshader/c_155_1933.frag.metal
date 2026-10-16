#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_blurRadius;
    float u_horizontalGlowBand;
    float u_glowIntensity;
    float u_matteCloseProgress;
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
float4 sampleBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, constant float& ratio)
{
    float2 stepSize = float2(0.00150000001303851604461669921875 * blurStrength, (0.00150000001303851604461669921875 * blurStrength) / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 color = float4(0.0);
    float total = 0.0;
    for (int x = -2; x <= 2; x++)
    {
        for (int y = -2; y <= 2; y++)
        {
            float2 offset = float2(float(x), float(y)) * stepSize;
            float dist = length(float2(float(x), float(y)));
            float weight = exp(((-dist) * dist) * 0.3499999940395355224609375);
            color += (tex.sample(texSmplr, fast::clamp(uv + offset, float2(0.0), float2(1.0))) * weight);
            total += weight;
        }
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 sharpColor = texture1.sample(texture1Smplr, uv);
    float2 param = uv;
    float param_1 = buffer.u_blurRadius;
    float4 blurColor = sampleBlur(texture1, texture1Smplr, param, param_1, buffer.ratio);
    float glowBand = exp(-pow((uv.y - 0.5) * 8.0, 2.0)) * buffer.u_horizontalGlowBand;
    float3 glowAdd = blurColor.xyz * ((buffer.u_glowIntensity * 1.5) + (glowBand * 2.2000000476837158203125));
    float3 baseMixed = mix(sharpColor.xyz, blurColor.xyz, float3(fast::clamp(buffer.u_blurRadius, 0.0, 1.0)));
    float3 screenGlow = float3(1.0) - ((float3(1.0) - baseMixed) * (float3(1.0) - fast::clamp(glowAdd, float3(0.0), float3(4.0))));
    float3 addGlow = baseMixed + glowAdd;
    float3 finalRgb = mix(screenGlow, addGlow, float3(0.449999988079071044921875));
    finalRgb = fast::clamp(finalRgb, float3(0.0), float3(1.0));
    float halfGap = 0.5 * (1.0 - fast::clamp(buffer.u_matteCloseProgress, 0.0, 1.0));
    float topMask = step(halfGap, uv.y);
    float bottomMask = step(uv.y, 1.0 - halfGap);
    float visibleCenter = topMask * bottomMask;
    finalRgb = mix(float3(0.0), finalRgb, float3(visibleCenter));
    out.gl_FragColor = float4(finalRgb, 1.0);
    return out;
}

