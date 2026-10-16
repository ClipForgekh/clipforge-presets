#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float rotationStrength;
    float spiralCount;
    float depthIntensity;
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
    return 1.0 - pow(1.0 - p, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& rotationStrength, thread float2& vUv, constant float& spiralCount, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& depthIntensity)
{
    float4 accumColor = float4(0.0);
    float totalWeight = 0.0;
    for (int i = 0; i < 40; i++)
    {
        float fi = float(i);
        float n = fi / 40.0;
        float layerDelay = n * 0.699999988079071044921875;
        float layerProgress = fast::clamp((p - layerDelay) / 0.300000011920928955078125, 0.0, 1.0);
        layerProgress = 1.0 - pow(1.0 - layerProgress, 2.0);
        if (layerProgress < 0.001000000047497451305389404296875)
        {
            continue;
        }
        float scale = mix(0.0500000007450580596923828125, 1.0, layerProgress);
        float angle = ((((1.0 - layerProgress) * rotationStrength) * 3.1415927410125732421875) * 2.0) * (1.0 + n);
        float2 center = float2(0.5);
        float2 uv = vUv - center;
        float s = sin(angle);
        float c = cos(angle);
        uv = float2((uv.x * c) - (uv.y * s), (uv.x * s) + (uv.y * c));
        uv /= float2(fast::max(scale, 0.001000000047497451305389404296875));
        float spiralPhase = ((n * spiralCount) * 3.1415927410125732421875) * 2.0;
        float spiralOffset = ((1.0 - layerProgress) * 0.1500000059604644775390625) * n;
        uv += (float2(cos(spiralPhase), sin(spiralPhase)) * spiralOffset);
        uv += center;
        float2 param = uv;
        uv = handleUVBounds(param);
        float4 sampleColor = tDiffuse.sample(tDiffuseSmplr, uv);
        float alpha = layerProgress * (1.0 - ((depthIntensity * n) * (1.0 - layerProgress)));
        float4 _197 = accumColor;
        float3 _199 = _197.xyz + (sampleColor.xyz * alpha);
        accumColor.x = _199.x;
        accumColor.y = _199.y;
        accumColor.z = _199.z;
        totalWeight += alpha;
    }
    float4 result;
    if (totalWeight > 0.0)
    {
        result = float4(accumColor.xyz / float3(totalWeight), texel.w);
    }
    else
    {
        result = float4(0.0);
    }
    return mix(result, texel, float4(step(0.999000012874603271484375, p)));
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
    float4 effectColor = effect(param_1, param_2, buffer.rotationStrength, in.vUv, buffer.spiralCount, tDiffuse, tDiffuseSmplr, buffer.depthIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

