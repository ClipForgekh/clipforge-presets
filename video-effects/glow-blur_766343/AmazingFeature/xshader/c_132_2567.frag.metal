#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float blurRadius;
    float ratio;
    float3 glowColor;
    float glowStrength;
    float brightnessBoost;
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
float tween(thread float& p)
{
    p = fast::clamp(p, 0.0, 1.0);
    float holdEnd = 0.100000001490116119384765625;
    float effectEnd = 0.800000011920928955078125;
    if (p <= holdEnd)
    {
        return 0.0;
    }
    if (p >= effectEnd)
    {
        return 1.0;
    }
    float x = (p - holdEnd) / (effectEnd - holdEnd);
    return smoothstep(0.0, 1.0, x);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusUV)
{
    float4 c = float4(0.0);
    float2 param = uv + float2(0.0, (-4.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0500000007450580596923828125);
    float2 param_1 = uv + float2(0.0, (-3.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv + float2(0.0, (-2.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv + float2(0.0, (-1.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.180000007152557373046875);
    float2 param_5 = uv + float2(0.0, 1.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + float2(0.0, 2.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + float2(0.0, 3.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + float2(0.0, 4.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0500000007450580596923828125);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& blurRadius, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float3& glowColor, constant float& glowStrength, constant float& brightnessBoost)
{
    float effectStrength = 1.0 - fast::clamp(p, 0.0, 1.0);
    float radius = (blurRadius * effectStrength) / fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float2 param = vUv;
    float param_1 = radius;
    float4 blurred = verticalBlur9(tDiffuse, tDiffuseSmplr, param, param_1);
    float3 blurMix = mix(texel.xyz, blurred.xyz, float3(effectStrength));
    float lum = dot(blurred.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float3 glow = ((glowColor * lum) * glowStrength) * effectStrength;
    float gain = 1.0 + (brightnessBoost * effectStrength);
    float3 finalRgb = (blurMix * gain) + glow;
    finalRgb = fast::clamp(finalRgb, float3(0.0), float3(1.0));
    return float4(finalRgb, texel.w);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    float _286 = tween(param);
    effectProgress = _286;
    float4 param_1 = texel;
    float param_2 = effectProgress;
    float4 effectColor = effect(param_1, param_2, buffer.blurRadius, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.glowColor, buffer.glowStrength, buffer.brightnessBoost);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

