#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxBlur;
    float upwardDrift;
    float curtainThickness;
    float curtainIntensity;
    float3 goldColor;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(thread const float2& uv, thread const float& radius, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    if (radius <= 9.9999997473787516355514526367188e-06)
    {
        float4 _108 = tDiffuse.sample(tDiffuseSmplr, uv);
        return _108;
    }
    float4 c = float4(0.0);
    float w = 0.0;
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float k = exp((((-0.5) * fi) * fi) / 4.0);
        float2 param = uv + float2(0.0, fi * radius);
        float2 suv = handleUVBounds(param);
        c += (tDiffuse.sample(tDiffuseSmplr, suv) * k);
        w += k;
    }
    return c / float4(w);
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 345.45001220703125));
    p += float2(dot(p, p + float2(34.345001220703125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& maxBlur, thread float2& vUv, constant float& upwardDrift, constant float& curtainThickness, constant float& curtainIntensity, constant float3& goldColor)
{
    if (p >= 0.99989998340606689453125)
    {
        return texel;
    }
    float strength = 1.0 - p;
    float blurRadius = maxBlur * strength;
    float2 param = vUv;
    float param_1 = blurRadius;
    float4 blurred = verticalBlur(param, param_1, tDiffuse, tDiffuseSmplr);
    float zPush = p;
    float curtainY = mix(-0.3499999940395355224609375, 1.25, zPush) + (upwardDrift * p);
    float dy = abs(vUv.y - curtainY);
    float thickness = fast::max(curtainThickness * (0.64999997615814208984375 + (0.3499999940395355224609375 * strength)), 9.9999997473787516355514526367188e-05);
    float core = exp((-dy) / thickness);
    float soft = exp((-dy) / (thickness * 2.400000095367431640625));
    float2 param_2 = (vUv * float2(420.0, 900.0)) + float2(p * 17.0, p * 29.0);
    float _249 = hash21(param_2);
    float grainBase = _249;
    float2 param_3 = (vUv * float2(1200.0, 1800.0)) + float2(p * 53.0, p * 71.0);
    float _265 = hash21(param_3);
    float grainFine = _265;
    float tScatter = (grainBase * 0.64999997615814208984375) + (grainFine * 0.3499999940395355224609375);
    float edgeBand = exp((-abs(dy - (thickness * 0.85000002384185791015625))) / (thickness * 0.3499999940395355224609375));
    float particle = (edgeBand * smoothstep(0.449999988079071044921875, 1.0, tScatter)) * strength;
    float glow = (((core * 0.75) + (soft * 0.25)) * curtainIntensity) * strength;
    float3 fogGold = (goldColor * glow) * (0.550000011920928955078125 + (0.449999988079071044921875 * tScatter));
    float3 base = blurred.xyz;
    base += fogGold;
    base += ((goldColor * particle) * 0.60000002384185791015625);
    base = mix(base, texel.xyz, float3(p));
    float2 param_4 = vUv;
    return float4(fast::clamp(base, float3(0.0), float3(1.0)), texel.w * getHardBoundaryMask(param_4));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    effectProgress = tween(param);
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, buffer.maxBlur, in.vUv, buffer.upwardDrift, buffer.curtainThickness, buffer.curtainIntensity, buffer.goldColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

