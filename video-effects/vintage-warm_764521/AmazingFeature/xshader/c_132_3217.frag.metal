#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float maxBlur;
    float maxExposure;
    float maxSaturation;
    float3 glowColor;
    float glowStrength;
    float noiseStrength;
    float startAlpha;
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
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, constant float& ratio)
{
    float2 stepSize = float2(radius, radius / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + (float2(-1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0625);
    float2 param_1 = uv + (float2(0.0, -1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.125);
    float2 param_2 = uv + (float2(1.0, -1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.0625);
    float2 param_3 = uv + (float2(-1.0, 0.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.125);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.25);
    float2 param_5 = uv + (float2(1.0, 0.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.125);
    float2 param_6 = uv + (float2(-1.0, 1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.0625);
    float2 param_7 = uv + (float2(0.0, 1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.125);
    float2 param_8 = uv + (float2(1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0625);
    return c;
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& sat)
{
    float l = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(l), color, float3(sat));
}

static inline __attribute__((always_inline))
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& maxExposure, constant float& maxSaturation, constant float3& glowColor, constant float& glowStrength, constant float& noiseStrength, constant float& startAlpha)
{
    if (p >= 0.99989998340606689453125)
    {
        return texel;
    }
    float strength = 1.0 - p;
    float blurAmount = maxBlur * strength;
    float2 param = vUv;
    float param_1 = blurAmount;
    float4 blurred = gaussianBlur9(tDiffuse, tDiffuseSmplr, param, param_1, ratio);
    float exposure = mix(1.0, maxExposure, strength);
    float saturation = mix(1.0, maxSaturation, strength);
    float3 param_2 = blurred.xyz;
    float param_3 = saturation;
    float3 color = adjustSaturation(param_2, param_3) * exposure;
    float lum = dot(blurred.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float glowMask = smoothstep(0.20000000298023223876953125, 1.0, lum);
    float3 glow = ((glowColor * glowStrength) * strength) * (0.60000002384185791015625 + (0.4000000059604644775390625 * glowMask));
    color += glow;
    float2 param_4 = vUv * float2(1280.0, 720.0);
    float grain = (hash12(param_4) - 0.5) * 2.0;
    color += float3(((grain * 0.07999999821186065673828125) * noiseStrength) * strength);
    color = fast::clamp(color, float3(0.0), float3(1.0));
    float alphaFactor = mix(1.0, startAlpha, strength);
    return float4(color, texel.w * alphaFactor);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.maxBlur, tDiffuse, tDiffuseSmplr, in.vUv, buffer.maxExposure, buffer.maxSaturation, buffer.glowColor, buffer.glowStrength, buffer.noiseStrength, buffer.startAlpha);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

