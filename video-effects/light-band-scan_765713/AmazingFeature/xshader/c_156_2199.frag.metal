#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_scanProgress;
    float u_blurStrength;
    float u_glowBandWidth;
    float u_maskSoftness;
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
float4 sampleVerticalDirectionalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& strength)
{
    float4 color = float4(0.0);
    float total = 0.0;
    float maxOffset = 0.100000001490116119384765625 * strength;
    for (int i = -6; i <= 6; i++)
    {
        float fi = float(i);
        float weight = 1.0 - (abs(fi) / 6.0);
        float2 sampleUv = uv + float2(0.0, (fi * maxOffset) / 6.0);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        color += (tex.sample(texSmplr, sampleUv) * weight);
        total += weight;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float progress = fast::clamp(buffer.u_scanProgress, 0.0, 1.0);
    float blurStrength = fast::clamp(buffer.u_blurStrength, 0.0, 1.0);
    float bandWidth = buffer.u_glowBandWidth;
    float softness = buffer.u_maskSoftness;
    float revealMask = smoothstep(progress - softness, progress + softness, uv.y);
    revealMask = 1.0 - revealMask;
    float4 sharpColor = texture1.sample(texture1Smplr, uv);
    float2 param = uv;
    float param_1 = blurStrength;
    float4 blurColor = sampleVerticalDirectionalBlur(texture1, texture1Smplr, param, param_1);
    float localBlurInfluence = revealMask * blurStrength;
    float4 revealedColor = mix(sharpColor, blurColor, float4(localBlurInfluence));
    float bandCore = 1.0 - smoothstep(0.0, bandWidth, abs(uv.y - progress));
    float bandGlow = 1.0 - smoothstep(0.0, bandWidth * 2.0, abs(uv.y - progress));
    bandGlow *= (1.0 - (progress * progress));
    float3 baseRgb = revealedColor.xyz * revealMask;
    float3 glowRgb = float3(0.939999997615814208984375) * ((bandCore * 0.85000002384185791015625) + (bandGlow * 0.449999988079071044921875));
    float3 screened = float3(1.0) - ((float3(1.0) - baseRgb) * (float3(1.0) - glowRgb));
    float3 finalRgb = fast::min(screened + (glowRgb * 0.1500000059604644775390625), float3(1.0));
    if ((progress >= 0.999000012874603271484375) && (blurStrength <= 0.001000000047497451305389404296875))
    {
        finalRgb = sharpColor.xyz;
    }
    finalRgb *= buffer.u_brightness;
    out.gl_FragColor = float4(finalRgb, 1.0);
    return out;
}

