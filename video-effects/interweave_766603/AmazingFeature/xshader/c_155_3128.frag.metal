#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uvOffset;
    float2 uvScale;
    float u_blurRadius;
    float u_chromatic;
    float u_glitchStrength;
    float u_direction;
    float u_coverProgress;
    float3 u_glowColorA;
    float3 u_glowColorB;
    float3 u_glowColorC;
    float u_glowIntensity;
    float u_exposureEV;
    float u_brightness;
    float u_grayscale;
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
float2 getMappedUv(thread const float2& uv, constant float2& uvOffset, constant float2& uvScale)
{
    return uvOffset + (uv * uvScale);
}

static inline __attribute__((always_inline))
float4 sampleVerticalBlur(thread const float2& mappedUv, thread const float& blurRadius, texture2d<float> texture1, sampler texture1Smplr)
{
    float4 color = float4(0.0);
    float total = 0.0;
    float radius = blurRadius / 1000.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float weight = 1.0 - (abs(fi) / 5.0);
        float2 sampleUv = mappedUv + float2(0.0, fi * radius);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * weight);
        total += weight;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float4 sampleChromatic(thread const float2& mappedUv, thread const float& amount, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 dir = mappedUv - float2(0.5);
    float dist = length(dir);
    float2 _113;
    if (dist > 9.9999997473787516355514526367188e-05)
    {
        _113 = fast::normalize(dir);
    }
    else
    {
        _113 = float2(1.0, 0.0);
    }
    float2 nDir = _113;
    float offset = amount * 0.0199999995529651641845703125;
    float2 shift = nDir * offset;
    float r = texture1.sample(texture1Smplr, fast::clamp(mappedUv + shift, float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, fast::clamp(mappedUv, float2(0.0), float2(1.0))).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(mappedUv - shift, float2(0.0), float2(1.0))).z;
    float a = texture1.sample(texture1Smplr, fast::clamp(mappedUv, float2(0.0), float2(1.0))).w;
    return float4(r, g, b, a);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 mappedUv = getMappedUv(param, buffer.uvOffset, buffer.uvScale);
    float4 originalTexel = texture1.sample(texture1Smplr, mappedUv);
    float2 param_1 = mappedUv;
    float param_2 = buffer.u_blurRadius;
    float4 blurredTexel = sampleVerticalBlur(param_1, param_2, texture1, texture1Smplr);
    float2 param_3 = mappedUv;
    float param_4 = buffer.u_chromatic + buffer.u_glitchStrength;
    float4 chromaTexel = sampleChromatic(param_3, param_4, texture1, texture1Smplr);
    float dirUv = mix(in.vUv.x, 1.0 - in.vUv.x, step(0.5, buffer.u_direction));
    float revealEdge = fast::clamp(buffer.u_coverProgress, 0.0, 1.0);
    float revealMask = smoothstep(revealEdge - 0.119999997317790985107421875, revealEdge, dirUv);
    float coverMask = 1.0 - revealMask;
    float3 neonGradient = mix(buffer.u_glowColorA, buffer.u_glowColorB, float3(in.vUv.x));
    neonGradient = mix(neonGradient, buffer.u_glowColorC, float3(abs(in.vUv.x - 0.5) * 1.39999997615814208984375));
    float edgeBand = 1.0 - smoothstep(0.0, 0.119999997317790985107421875, abs(dirUv - revealEdge));
    float glowMask = (edgeBand * coverMask) * buffer.u_glowIntensity;
    float3 effected = mix(blurredTexel.xyz, chromaTexel.xyz, float3(0.449999988079071044921875 + (0.3499999940395355224609375 * fast::clamp(buffer.u_glitchStrength, 0.0, 1.0))));
    effected *= pow(2.0, buffer.u_exposureEV);
    effected += ((neonGradient * glowMask) * 1.7999999523162841796875);
    effected *= buffer.u_brightness;
    float gray = dot(effected, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    effected = mix(effected, float3(gray), float3(buffer.u_grayscale));
    float3 finalRgb = mix(originalTexel.xyz, effected, float3(coverMask));
    out.gl_FragColor = float4(finalRgb, originalTexel.w);
    return out;
}

