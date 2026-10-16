#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ballSize;
    float ratio;
    float bounceIntensity;
    float rollCycles;
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
float2 rotate(thread float2& uv, thread const float2& center, thread const float& angle)
{
    float s = sin(angle);
    float c = cos(angle);
    uv -= center;
    uv = float2((uv.x * c) - (uv.y * s), (uv.x * s) + (uv.y * c));
    uv += center;
    return uv;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ballSize, constant float& ratio, constant float& bounceIntensity, thread float2& vUv, constant float& rollCycles, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float stage1 = smoothstep(0.0, 0.699999988079071044921875, p);
    float stage2 = smoothstep(0.699999988079071044921875, 1.0, p);
    float startX = (-ballSize) * ratio;
    float posX = mix(startX, 0.5, stage1);
    float bounce = (abs(sin(stage1 * 10.0)) * bounceIntensity) * (1.0 - stage1);
    float posY = 0.5 + bounce;
    float2 center = float2(posX, posY);
    float currentRadius = mix(ballSize, 1.5, stage2);
    float2 aspectUv = vUv;
    aspectUv.x *= ratio;
    float2 aspectCenter = center;
    aspectCenter.x *= ratio;
    float dist = length(aspectUv - aspectCenter);
    if ((dist > currentRadius) && (stage2 < 0.00999999977648258209228515625))
    {
        return float4(0.0);
    }
    float distortion = 1.0 - stage2;
    float2 delta = vUv - center;
    float r = dist / currentRadius;
    float rho = r * 1.57079601287841796875;
    float zoom = mix(1.0, 0.4000000059604644775390625, distortion);
    float angle = ((1.0 - stage1) * rollCycles) * 6.28318500518798828125;
    float2 param = vUv;
    float2 param_1 = center;
    float param_2 = angle;
    float2 _194 = rotate(param, param_1, param_2);
    float2 uv = _194;
    if (r < 1.0)
    {
        float2 sphericalDelta = ((uv - center) * (sin(rho) / r)) * zoom;
        uv = center + mix(uv - center, sphericalDelta, float2(distortion));
    }
    float edgeAlpha = 1.0 - smoothstep(currentRadius - 0.00999999977648258209228515625, currentRadius, dist);
    float finalAlpha = mix(edgeAlpha, 1.0, stage2);
    float2 param_3 = uv;
    float4 finalTexel = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3));
    return float4(finalTexel.xyz, finalTexel.w * finalAlpha);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float param = effectProgress;
    float t = tween(param);
    float4 param_1 = texel;
    float param_2 = t;
    float4 effectColor = effect(param_1, param_2, buffer.ballSize, buffer.ratio, buffer.bounceIntensity, in.vUv, buffer.rollCycles, tDiffuse, tDiffuseSmplr);
    out.gl_FragColor = effectColor;
    return out;
}

