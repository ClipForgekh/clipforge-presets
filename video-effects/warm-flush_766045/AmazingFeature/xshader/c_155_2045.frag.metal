#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uvScale;
    float2 uvOffset;
    float2 u_center;
    float u_radialBlur;
    float u_exposure;
    float u_warmTint;
    float u_addBlendStrength;
    float u_finalFade;
    float u_opacity;
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
float2 getMappedUv(thread const float2& uv, constant float2& uvScale, constant float2& uvOffset)
{
    return (uv * uvScale) + uvOffset;
}

static inline __attribute__((always_inline))
float4 sampleRadialBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float2& center, thread const float& blurAmount)
{
    float2 dir = uv - center;
    float4 color = float4(0.0);
    float total = 0.0;
    for (int i = 0; i < 12; i++)
    {
        float t = float(i) / 11.0;
        float2 sampleUv = uv - (((dir * blurAmount) * 0.001000000047497451305389404296875) * t);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        float weight = 1.0 - (t * 0.5);
        color += (tex.sample(texSmplr, sampleUv) * weight);
        total += weight;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 mappedUv = getMappedUv(param, buffer.uvScale, buffer.uvOffset);
    mappedUv = fast::clamp(mappedUv, float2(0.0), float2(1.0));
    float4 baseColor = texture1.sample(texture1Smplr, mappedUv);
    float2 param_1 = mappedUv;
    float2 param_2 = buffer.u_center;
    float param_3 = buffer.u_radialBlur;
    float4 blurredColor = sampleRadialBlur(texture1, texture1Smplr, param_1, param_2, param_3);
    float3 warmColor = float3(1.0, 0.839999973773956298828125, 0.3499999940395355224609375);
    float3 exposedBase = baseColor.xyz * buffer.u_exposure;
    float3 exposedBlur = blurredColor.xyz * buffer.u_exposure;
    float3 warmShifted = mix(exposedBlur, exposedBlur + ((warmColor * buffer.u_exposure) * 0.3499999940395355224609375), float3(buffer.u_warmTint));
    float3 addMixed = exposedBase + (warmShifted * buffer.u_addBlendStrength);
    float luminance = dot(blurredColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 halo = ((warmColor * luminance) * buffer.u_exposure) * (0.4000000059604644775390625 + (0.60000002384185791015625 * buffer.u_addBlendStrength));
    float3 finalRgb = addMixed + halo;
    finalRgb = mix(finalRgb, float3(0.0), float3(buffer.u_finalFade));
    float finalAlpha = buffer.u_opacity * (1.0 - buffer.u_finalFade);
    out.gl_FragColor = float4(finalRgb, finalAlpha);
    return out;
}

