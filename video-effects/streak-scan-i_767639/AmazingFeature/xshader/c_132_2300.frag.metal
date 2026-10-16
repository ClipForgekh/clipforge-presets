#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float flowTurbulence;
    float3 particleColor;
    float glowIntensity;
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
float hash12(thread const float2& p)
{
    float3 p3 = fract(float3(p.xyx) * 0.103100001811981201171875);
    p3 += float3(dot(p3, p3.yzx + float3(33.3300018310546875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float _noise2(thread const float2& p)
{
    float2 i = floor(p);
    float2 f = fract(p);
    float2 param = i;
    float a = hash12(param);
    float2 param_1 = i + float2(1.0, 0.0);
    float b = hash12(param_1);
    float2 param_2 = i + float2(0.0, 1.0);
    float c = hash12(param_2);
    float2 param_3 = i + float2(1.0);
    float d = hash12(param_3);
    float2 u = (f * f) * (float2(3.0) - (f * 2.0));
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float& flowTurbulence, constant float3& particleColor, constant float& glowIntensity)
{
    float param = p;
    float e = tween(param);
    float strength = 1.0 - e;
    float flow = (-0.25) + (e * 1.5499999523162841796875);
    float2 param_1 = (vUv * float2(16.0, 10.0)) + float2(e * 9.0, e * 3.0);
    float n = _noise2(param_1);
    float wave = (sin((vUv.y * 22.0) + (e * 9.0)) * 0.5) + (sin((vUv.y * 41.0) - (e * 7.0)) * 0.5);
    float warp = (((wave * 0.5) + (n - 0.5)) * flowTurbulence) * (0.5 + (0.5 * strength));
    float reveal = 1.0 - smoothstep(flow + warp, (flow + 0.2199999988079071044921875) + warp, vUv.x);
    reveal = fast::clamp(reveal, 0.0, 1.0);
    float front = flow + (warp * 0.3499999940395355224609375);
    float dFront = abs(vUv.x - front);
    float trail = exp((-dFront) * 45.0) * (0.3499999940395355224609375 + (0.64999997615814208984375 * n));
    float2 param_2 = floor((vUv * float2(120.0, 68.0)) + float2(e * 70.0));
    float sparkCell = hash12(param_2);
    float spark = step(0.98500001430511474609375 - (0.07999999821186065673828125 * strength), sparkCell) * exp((-dFront) * 85.0);
    float3 glow = (particleColor * ((trail * glowIntensity) + (spark * (1.2000000476837158203125 + (glowIntensity * 0.4000000059604644775390625))))) * strength;
    float3 revealed = texel.xyz * reveal;
    float4 stylized = float4(fast::clamp(revealed + glow, float3(0.0), float3(1.0)), texel.w * reveal);
    return mix(stylized, texel, float4(e));
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.flowTurbulence, buffer.particleColor, buffer.glowIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

