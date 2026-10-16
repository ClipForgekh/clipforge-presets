#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float sliceJitter;
    float blurStrength;
    float leakIntensity;
    float ratio;
    float grainIntensity;
    float3 leakColor;
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, thread float2& vUv, constant float& sliceJitter, constant float& blurStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& leakIntensity, constant float& ratio, constant float& grainIntensity, constant float3& leakColor)
{
    float remain = 1.0 - p;
    float sliceCount = 36.0;
    float stripId = floor(vUv.x * sliceCount);
    float edgeCell = abs(fract(vUv.x * sliceCount) - 0.5);
    float gapMask = smoothstep(0.23999999463558197021484375, 0.5, edgeCell);
    float4 accum = float4(0.0);
    float wsum = 0.0;
    float remainDepthSum = 0.0;
    for (int i = 0; i < 8; i++)
    {
        float fi = float(i);
        float layerStart = fi / 8.0;
        float layerSettle = fast::clamp((p - layerStart) * 8.0, 0.0, 1.0);
        float layerRemain = 1.0 - layerSettle;
        remainDepthSum += layerRemain;
        float base = (fi - 3.5) / 3.5;
        float2 param = float2(stripId + (fi * 13.1700000762939453125), (fi * 2.71000003814697265625) + floor(p * 120.0));
        float n = hash12(param);
        float wobble = (((n - 0.5) * sliceJitter) * layerRemain) * remain;
        float yOffset = (((base * blurStrength) * layerRemain) * remain) + wobble;
        float xOffset = wobble * 0.25;
        float2 param_1 = vUv + float2(xOffset, yOffset);
        float2 suv = handleUVBounds(param_1);
        float4 c = tDiffuse.sample(tDiffuseSmplr, suv);
        float w = 1.0;
        accum += (c * w);
        wsum += w;
    }
    float4 layered = accum / float4(fast::max(wsum, 9.9999997473787516355514526367188e-05));
    float remainDepth = remainDepthSum / 8.0;
    float leakFlow = 0.75 + (0.25 * sin((((vUv.y * 20.0) + (vUv.x * 9.0)) + (p * 6.283185482025146484375)) * 1.2000000476837158203125));
    float leak = (((leakIntensity * remainDepth) * remain) * gapMask) * leakFlow;
    float grainSeed = floor(p * 180.0);
    float2 param_2 = (vUv * float2(420.0, 420.0 / fast::max(ratio, 0.001000000047497451305389404296875))) + float2(grainSeed);
    float grain = ((hash12(param_2) - 0.5) * grainIntensity) * remain;
    float3 rgb = layered.xyz;
    rgb += (leakColor * leak);
    rgb += float3(grain);
    rgb = fast::clamp(rgb, float3(0.0), float3(1.0));
    return float4(rgb, layered.w);
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.sliceJitter, buffer.blurStrength, tDiffuse, tDiffuseSmplr, buffer.leakIntensity, buffer.ratio, buffer.grainIntensity, buffer.leakColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

