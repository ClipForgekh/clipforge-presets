#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float elasticity;
    float impactForce;
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
float4 effect(thread const float4& texel, thread const float& progress, thread float2& vUv, constant float& ratio, constant float& elasticity, constant float& impactForce, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float4& glowColor)
{
    float2 center = float2(0.5);
    float2 dir = vUv - center;
    float dist = length(dir * float2(ratio, 1.0));
    float mask = smoothstep(0.699999988079071044921875, 0.0, dist);
    float decay = exp((-progress) * 4.0);
    float bounce = cos(progress * elasticity) * decay;
    float2 distortedUV = vUv - (((dir * bounce) * impactForce) * mask);
    float blurAmount = ((0.0500000007450580596923828125 * decay) * mask) * impactForce;
    float4 finalColor = float4(0.0);
    float totalWeight = 0.0;
    for (float i = 0.0; i < 8.0; i += 1.0)
    {
        float percent = i / 7.0;
        float weight = 1.0 - percent;
        float2 sampleUV = distortedUV - ((dir * blurAmount) * percent);
        float2 rUV = sampleUV + (float2(0.00200000009499490261077880859375, 0.0) * decay);
        float2 bUV = sampleUV - (float2(0.00200000009499490261077880859375, 0.0) * decay);
        float r = tDiffuse.sample(tDiffuseSmplr, fast::clamp(rUV, float2(0.0), float2(1.0))).x;
        float g = tDiffuse.sample(tDiffuseSmplr, fast::clamp(sampleUV, float2(0.0), float2(1.0))).y;
        float b = tDiffuse.sample(tDiffuseSmplr, fast::clamp(bUV, float2(0.0), float2(1.0))).z;
        finalColor += (float4(r, g, b, 1.0) * weight);
        totalWeight += weight;
    }
    finalColor /= float4(totalWeight);
    finalColor = mix(finalColor, glowColor, float4((decay * 0.300000011920928955078125) * mask));
    return finalColor;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.100000001490116119384765625) / 0.800000011920928955078125, 0.0, 1.0);
    float4 param = texel;
    float param_1 = effectProgress;
    float4 effectColor = effect(param, param_1, in.vUv, buffer.ratio, buffer.elasticity, buffer.impactForce, tDiffuse, tDiffuseSmplr, buffer.glowColor);
    float fadeInStrength = smoothstep(0.0, 0.100000001490116119384765625, buffer.progress);
    float fadeOutStrength = 1.0 - smoothstep(0.89999997615814208984375, 1.0, buffer.progress);
    float effectStrength = fast::min(fadeInStrength, fadeOutStrength);
    float4 finalColor = mix(texel, effectColor, float4(effectStrength));
    out.gl_FragColor = finalColor;
    return out;
}

