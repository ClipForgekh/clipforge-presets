#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurRadiusY;
    float u_sweepY;
    float u_reveal;
    float u_glowIntensity;
    float u_brightness;
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
float4 sampleVerticalDirectionalBlur(thread const float2& uv, thread const float& radius, texture2d<float> texture1, sampler texture1Smplr)
{
    float4 col = float4(0.0);
    float weightSum = 0.0;
    for (int i = 0; i < 21; i++)
    {
        float fi = float(i);
        float t = (fi - 10.0) / 10.0;
        float w = 1.0 - abs(t);
        float2 suv = uv + float2(0.0, t * radius);
        suv = fast::clamp(suv, float2(0.0), float2(1.0));
        col += (texture1.sample(texture1Smplr, suv) * w);
        weightSum += w;
    }
    return col / float4(fast::max(weightSum, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadiusY;
    float4 blurredTexel = sampleVerticalDirectionalBlur(param, param_1, texture1, texture1Smplr);
    float sweepReveal = smoothstep(buffer.u_sweepY - 0.180000007152557373046875, buffer.u_sweepY + 0.0199999995529651641845703125, in.vUv.y);
    float reveal = fast::clamp(fast::max(buffer.u_reveal * 0.89999997615814208984375, sweepReveal), 0.0, 1.0);
    float band = exp(-pow((in.vUv.y - buffer.u_sweepY) * 28.0, 2.0));
    float glow = buffer.u_glowIntensity * band;
    float3 glowColor = float3(1.0, 0.980000019073486328125, 0.949999988079071044921875) * glow;
    float3 baseColor = mix(float3(0.0), blurredTexel.xyz, float3(reveal));
    float3 screenColor = float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - glowColor));
    float3 addColor = baseColor + (glowColor * 0.3499999940395355224609375);
    float3 finalColor = mix(addColor, screenColor, float3(0.64999997615814208984375));
    finalColor *= buffer.u_brightness;
    out.gl_FragColor = float4(finalColor, 1.0);
    return out;
}

