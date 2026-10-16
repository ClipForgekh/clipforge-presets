#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float depthSpread;
    float waveFreq;
    float waveAmp;
    float blurStrength;
    float radialBlur;
    float goldIntensity;
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
float2 getAspectVec(thread const float2& uv, thread const float2& center, constant float& ratio)
{
    float2 d = uv - center;
    if (ratio > 1.0)
    {
        d.y /= ratio;
    }
    else
    {
        d.x *= ratio;
    }
    return d;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& depthSpread, thread float2& vUv, constant float& waveFreq, constant float& waveAmp, constant float& blurStrength, constant float& radialBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& goldIntensity)
{
    float2 center = float2(0.5);
    float3 gold = float3(1.0, 0.7799999713897705078125, 0.449999988079071044921875);
    float3 layeredColor = float3(0.0);
    float layeredWeight = 0.0;
    for (int i = 0; i < 5; i++)
    {
        float fi = float(i);
        float layerT = fi / 4.0;
        float delay = 0.2800000011920928955078125;
        float localP = fast::clamp((p - (layerT * delay)) / (1.0 - (layerT * delay)), 0.0, 1.0);
        float layerStrength = 1.0 - smoothstep(0.0, 1.0, localP);
        float zDepth = ((1.0 - p) * (0.25 + layerT)) * depthSpread;
        float2 d = vUv - center;
        float phase = ((1.0 - p) * 6.283185482025146484375) + (fi * 1.10000002384185791015625);
        float wave = ((sin(((vUv.y + (fi * 0.070000000298023223876953125)) * waveFreq) + phase) * waveAmp) * (1.0 + (zDepth * 8.0))) * layerStrength;
        float2 uv = center + (d * (1.0 + (zDepth * 2.2000000476837158203125)));
        uv.x += wave;
        float2 param = vUv;
        float2 param_1 = center;
        float2 dir = getAspectVec(param, param_1, ratio);
        float dirLen = fast::max(length(dir), 9.9999997473787516355514526367188e-05);
        float2 rdir = dir / float2(dirLen);
        if (ratio > 1.0)
        {
            rdir.y *= ratio;
        }
        else
        {
            rdir.x /= ratio;
        }
        float vBlur = (blurStrength * (1.0 + (layerT * 0.60000002384185791015625))) * layerStrength;
        float rBlur = radialBlur * layerStrength;
        float2 param_2 = uv;
        float2 uv0 = handleUVBounds(param_2);
        float2 param_3 = uv + float2(0.0, vBlur);
        float2 uv1 = handleUVBounds(param_3);
        float2 param_4 = uv - float2(0.0, vBlur);
        float2 uv2 = handleUVBounds(param_4);
        float2 param_5 = uv + (rdir * rBlur);
        float2 uv3 = handleUVBounds(param_5);
        float2 param_6 = uv - (rdir * rBlur);
        float2 uv4 = handleUVBounds(param_6);
        float3 c0 = tDiffuse.sample(tDiffuseSmplr, uv0).xyz;
        float3 c1 = tDiffuse.sample(tDiffuseSmplr, uv1).xyz;
        float3 c2 = tDiffuse.sample(tDiffuseSmplr, uv2).xyz;
        float3 c3 = tDiffuse.sample(tDiffuseSmplr, uv3).xyz;
        float3 c4 = tDiffuse.sample(tDiffuseSmplr, uv4).xyz;
        float3 blurred = ((((c0 * 0.300000011920928955078125) + (c1 * 0.2199999988079071044921875)) + (c2 * 0.2199999988079071044921875)) + (c3 * 0.12999999523162841796875)) + (c4 * 0.12999999523162841796875);
        float2 param_7 = vUv;
        float2 param_8 = center;
        float radius = length(getAspectVec(param_7, param_8, ratio));
        float th = smoothstep(1.0499999523162841796875, 0.0, radius);
        float glow = (goldIntensity * layerStrength) * (0.3499999940395355224609375 + (0.64999997615814208984375 * th));
        float3 watercolor = mix(blurred, gold, float3(fast::clamp((0.550000011920928955078125 * layerStrength) + (0.25 * glow), 0.0, 1.0)));
        watercolor += ((gold * glow) * 0.3499999940395355224609375);
        float layerOpacity = 1.0 - (fi * 0.1500000059604644775390625);
        layeredColor += (watercolor * layerOpacity);
        layeredWeight += layerOpacity;
    }
    float3 stylized = layeredColor / float3(fast::max(layeredWeight, 9.9999997473787516355514526367188e-05));
    float masterStrength = 1.0 - p;
    float3 finalRgb = mix(texel.xyz, stylized, float3(masterStrength));
    return float4(finalRgb, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.depthSpread, in.vUv, buffer.waveFreq, buffer.waveAmp, buffer.blurStrength, buffer.radialBlur, tDiffuse, tDiffuseSmplr, buffer.goldIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

