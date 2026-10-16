#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float tiltAmount;
    float perspectiveAmount;
    float swayAmount;
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
    return progress;
}

static inline __attribute__((always_inline))
float2 rotateAspect(thread const float2& p, thread const float& angle, constant float& ratio)
{
    float2 q = p;
    q.x *= ratio;
    float s = sin(angle);
    float c = cos(angle);
    q = float2x2(float2(c, -s), float2(s, c)) * q;
    q.x /= ratio;
    return q;
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, thread float2& vUv, constant float& tiltAmount, constant float& perspectiveAmount, constant float& swayAmount, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float phase = (progress * 6.283185482025146484375) - 1.57079637050628662109375;
    float swing = sin(phase);
    float2 p = vUv - float2(0.5);
    float2 param = p;
    float param_1 = swing * tiltAmount;
    p = rotateAspect(param, param_1, ratio);
    p.x += ((p.y * perspectiveAmount) * swing);
    p.x += (swayAmount * swing);
    float2 uvRaw = p + float2(0.5);
    float2 param_2 = uvRaw;
    float borderMask = getHardBoundaryMask(param_2);
    float2 param_3 = uvRaw;
    float2 uv = handleUVBounds(param_3);
    float4 swungTexel = tDiffuse.sample(tDiffuseSmplr, uv);
    return float4(swungTexel.xyz, swungTexel.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.tiltAmount, buffer.perspectiveAmount, buffer.swayAmount, tDiffuse, tDiffuseSmplr);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

