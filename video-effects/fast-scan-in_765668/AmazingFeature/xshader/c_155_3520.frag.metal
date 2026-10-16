#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float u_stripCount;
    float u_scanProgress;
    float u_glitchAmount;
    float u_time;
    float u_blurRadiusPx;
    float3 neonColorA;
    float3 neonColorB;
    float u_glowStrength;
    float3 highlightColor;
    float u_exposure;
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
float hash(thread const float2& p)
{
    return fract(sin(dot(p, float2(127.09999847412109375, 311.70001220703125))) * 43758.546875);
}

static inline __attribute__((always_inline))
float3 sampleVerticalBlur(thread const float2& uv, thread const float& radiusPx, constant float2& u_resolution, texture2d<float> texture1, sampler texture1Smplr)
{
    float uvRadius = radiusPx / fast::max(u_resolution.y, 1.0);
    float3 c0 = texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-2.0) * uvRadius), float2(0.0), float2(1.0))).xyz;
    float3 c1 = texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, (-1.0) * uvRadius), float2(0.0), float2(1.0))).xyz;
    float3 c2 = texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))).xyz;
    float3 c3 = texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 1.0 * uvRadius), float2(0.0), float2(1.0))).xyz;
    float3 c4 = texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 2.0 * uvRadius), float2(0.0), float2(1.0))).xyz;
    return ((((c0 * 0.07999999821186065673828125) + (c1 * 0.2199999988079071044921875)) + (c2 * 0.4000000059604644775390625)) + (c3 * 0.2199999988079071044921875)) + (c4 * 0.07999999821186065673828125);
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& baseColor, thread const float3& blendColor)
{
    return float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - blendColor));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float strips = fast::max(buffer.u_stripCount, 1.0);
    float stripIndex = floor(in.vUv.x * strips);
    float localX = fract(in.vUv.x * strips);
    float2 stripUv = float2((stripIndex + localX) / strips, in.vUv.y);
    float stripeDelayNorm = (stripIndex / fast::max(strips - 1.0, 1.0)) * 0.550000011920928955078125;
    float stripeProgress = fast::clamp((buffer.u_scanProgress - stripeDelayNorm) / 0.449999988079071044921875, 0.0, 1.0);
    float startOnlyLeftStrip = 0.0;
    if ((buffer.u_scanProgress <= 9.9999997473787516355514526367188e-05) && (stripIndex < 0.5))
    {
        startOnlyLeftStrip = 1.0;
    }
    float isScanned = step(9.9999997473787516355514526367188e-05, stripeProgress);
    float visibleMask = fast::max(isScanned, startOnlyLeftStrip);
    float2 glitchDir = float2(1.0 / fast::max(buffer.u_resolution.x, 1.0), 0.0);
    float clarity = stripeProgress;
    float glitchFade = (1.0 - clarity) * buffer.u_glitchAmount;
    float2 param = float2(stripIndex * 11.13000011444091796875, floor(buffer.u_time * (20.0 - (14.0 * clarity))));
    float flicker = step(0.699999988079071044921875, hash(param));
    float glitchOffset = (glitchFade * flicker) * 6.0;
    float r = texture1.sample(texture1Smplr, fast::clamp(stripUv + (glitchDir * glitchOffset), float2(0.0), float2(1.0))).x;
    float g = texture1.sample(texture1Smplr, fast::clamp(stripUv, float2(0.0), float2(1.0))).y;
    float b = texture1.sample(texture1Smplr, fast::clamp(stripUv - (glitchDir * glitchOffset), float2(0.0), float2(1.0))).z;
    float3 baseRgb = float3(r, g, b);
    float stripBlurPx = mix(buffer.u_blurRadiusPx, fast::max(buffer.u_blurRadiusPx * 0.25, 0.0), stripeProgress);
    float2 param_1 = stripUv;
    float param_2 = stripBlurPx;
    float3 blurRgb = sampleVerticalBlur(param_1, param_2, buffer.u_resolution, texture1, texture1Smplr);
    float3 mixedBase = mix(blurRgb, baseRgb, float3(stripeProgress));
    float bottomGlow = pow(1.0 - stripUv.y, 2.2000000476837158203125);
    float3 neonGradient = mix(buffer.neonColorA, buffer.neonColorB, float3(stripUv.y));
    float3 glowRgb = (neonGradient * ((buffer.u_glowStrength * (1.0 - stripeProgress)) * bottomGlow)) + (buffer.highlightColor * 0.07999999821186065673828125);
    float3 param_3 = mixedBase;
    float3 param_4 = glowRgb;
    float3 colorRgb = screenBlend(param_3, param_4);
    if ((((buffer.u_exposure >= 0.999000012874603271484375) && (buffer.u_blurRadiusPx <= 0.001000000047497451305389404296875)) && (buffer.u_glowStrength <= 0.001000000047497451305389404296875)) && (buffer.u_glitchAmount <= 0.001000000047497451305389404296875))
    {
        colorRgb = texture1.sample(texture1Smplr, stripUv).xyz;
        visibleMask = 1.0;
    }
    colorRgb *= buffer.u_exposure;
    colorRgb *= visibleMask;
    out.gl_FragColor = float4(colorRgb, 1.0);
    return out;
}

