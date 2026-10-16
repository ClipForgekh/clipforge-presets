#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float swirlStrength;
    float ratio;
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
float tween(thread const float& progress)
{
    return 1.0 - pow(1.0 - progress, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& swirlStrength, thread float2& vUv, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float param = progress;
    float intensity = (1.0 - tween(param)) * swirlStrength;
    float2 uv = vUv - float2(0.5);
    if (ratio > 1.0)
    {
        uv.y /= ratio;
    }
    else
    {
        uv.x *= ratio;
    }
    float dist = length(uv);
    float angle = (intensity * exp((-dist) * 2.5)) * sin((dist * 5.0) - intensity);
    float s = sin(angle);
    float c = cos(angle);
    float2 rotatedUV = float2((uv.x * c) - (uv.y * s), (uv.x * s) + (uv.y * c));
    if (ratio > 1.0)
    {
        rotatedUV.y *= ratio;
    }
    else
    {
        rotatedUV.x /= ratio;
    }
    float2 finalUV = rotatedUV + float2(0.5);
    float2 param_1 = finalUV;
    finalUV = handleUVBounds(param_1);
    float4 _149 = tDiffuse.sample(tDiffuseSmplr, finalUV);
    return _149;
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
    float4 finalColor = effect(param_1, param_2, buffer.swirlStrength, in.vUv, buffer.ratio, tDiffuse, tDiffuseSmplr);
    out.gl_FragColor = finalColor;
    return out;
}

