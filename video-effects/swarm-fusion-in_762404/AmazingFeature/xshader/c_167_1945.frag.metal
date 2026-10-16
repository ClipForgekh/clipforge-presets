#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_chromatic;
    float2 u_shadowOffset;
    float u_shadowStrength;
    float u_borderThickness;
    float3 u_shadowColor;
    float3 u_borderColor;
    float u_grayscale;
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
float4 sampleChromatic(thread const float2& mappedUv, constant float& u_chromatic, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 dir = mappedUv - float2(0.5);
    float offset = u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, (mappedUv + (dir * offset))).x;
    float g = texture1.sample(texture1Smplr, mappedUv).y;
    float b = texture1.sample(texture1Smplr, (mappedUv - (dir * offset))).z;
    float a = texture1.sample(texture1Smplr, mappedUv).w;
    return float4(r, g, b, a);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = in.vUv;
    float4 shadowSample = texture1.sample(texture1Smplr, (mappedUv - buffer.u_shadowOffset));
    float shadowAlpha = step(0.001000000047497451305389404296875, shadowSample.w) * buffer.u_shadowStrength;
    float2 param = mappedUv;
    float4 texColor = sampleChromatic(param, buffer.u_chromatic, texture1, texture1Smplr);
    float alpha = texColor.w;
    float borderMask = 0.0;
    if (buffer.u_borderThickness > 0.0)
    {
        float leftEdge = step(mappedUv.x, buffer.u_borderThickness);
        float rightEdge = step(1.0 - mappedUv.x, buffer.u_borderThickness);
        float bottomEdge = step(mappedUv.y, buffer.u_borderThickness);
        float topEdge = step(1.0 - mappedUv.y, buffer.u_borderThickness);
        borderMask = fast::clamp(((leftEdge + rightEdge) + bottomEdge) + topEdge, 0.0, 1.0) * step(0.001000000047497451305389404296875, alpha);
    }
    float3 color = mix(buffer.u_shadowColor, texColor.xyz, float3(alpha));
    color = mix(color, buffer.u_borderColor, float3(borderMask));
    float gray = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    color = mix(color, float3(gray), float3(buffer.u_grayscale));
    color *= buffer.u_brightness;
    float outAlpha = fast::max(alpha, shadowAlpha);
    out.gl_FragColor = float4(color, outAlpha);
    return out;
}

