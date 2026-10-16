#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float spiralDensity;
    float glowStrength;
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
float2 getSDFCoordinate(thread const float2& uv, thread const float2& center, constant float& ratio)
{
    float2 p = uv - center;
    if (ratio > 1.0)
    {
        p.y /= ratio;
    }
    else
    {
        p.x *= ratio;
    }
    return p;
}

static inline __attribute__((always_inline))
float getMaxShapeSize(constant float& ratio)
{
    if (ratio > 1.0)
    {
        return sqrt(1.0 + (1.0 / (ratio * ratio))) * 2.0;
    }
    else
    {
        return sqrt((ratio * ratio) + 1.0) * 2.0;
    }
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(34.450000762939453125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, thread float2& vUv, constant float& spiralDensity, constant float& glowStrength)
{
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 q = getSDFCoordinate(param, param_1, ratio);
    float r = length(q);
    float a = precise::atan2(q.y, q.x);
    float maxR = getMaxShapeSize(ratio) * 0.5;
    float revealR = p * maxR;
    float phase = (a + (r * spiralDensity)) - (p * 6.283185482025146484375);
    float ribbons = exp((-16.0) * pow(abs(sin(phase * 5.0)), 1.25));
    float streams = pow(fast::max(cos(phase * 5.0), 0.0), 2.5);
    float spiralMask = fast::max(ribbons, streams);
    float revealed = smoothstep(0.02999999932944774627685546875, -0.02999999932944774627685546875, r - revealR);
    float front = smoothstep(0.0900000035762786865234375, 0.0, abs(r - revealR));
    float revealMask = fast::clamp(revealed + ((front * spiralMask) * 0.89999997615814208984375), 0.0, 1.0);
    float rise = smoothstep(0.0199999995529651641845703125, 0.3499999940395355224609375, p);
    float fall = 1.0 - smoothstep(0.550000011920928955078125, 0.949999988079071044921875, p);
    float glowEnv = fast::max(rise * fall, (1.0 - p) * 0.3499999940395355224609375);
    float core = exp(((-65.0) * r) * r) * (1.0 - p);
    float2 param_2 = (vUv * float2(420.0, 310.0)) + float2(p * 17.0, p * 29.0);
    float _241 = hash21(param_2);
    float dustRnd = _241;
    float dust = (step(0.98500001430511474609375, dustRnd) * front) * (0.3499999940395355224609375 + (0.64999997615814208984375 * spiralMask));
    float tint = 0.5 + (0.5 * sin((phase * 1.7000000476837158203125) + (r * 8.0)));
    float3 auroraColor = mix(float3(0.25, 1.0, 0.85000002384185791015625), float3(0.949999988079071044921875, 0.550000011920928955078125, 1.0), float3(tint));
    float auroraLight = ((((spiralMask * front) + core) + dust) * glowEnv) * glowStrength;
    float3 scene = texel.xyz * revealMask;
    float3 glow = auroraColor * auroraLight;
    float finalFlash = ((1.0 - smoothstep(0.920000016689300537109375, 1.0, p)) * exp(((-120.0) * r) * r)) * 0.1500000059604644775390625;
    float3 rgb = (scene + glow) + (float3(0.699999988079071044921875, 0.89999997615814208984375, 1.0) * finalFlash);
    float settle = smoothstep(0.959999978542327880859375, 1.0, p);
    rgb = mix(rgb, texel.xyz, float3(settle));
    float alpha = fast::max(texel.w * revealMask, auroraLight * 0.3499999940395355224609375);
    alpha = mix(alpha, texel.w, settle);
    return float4(fast::clamp(rgb, float3(0.0), float3(1.0)), fast::clamp(alpha, 0.0, 1.0));
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.spiralDensity, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

