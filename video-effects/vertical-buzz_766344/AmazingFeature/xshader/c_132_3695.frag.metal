#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float maxBlur;
    float grainAmount;
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
    p3 += float3(dot(p3, p3.yzx + float3(19.1900005340576171875)));
    return fract((p3.x + p3.y) * p3.z);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float3 verticalStreakSample(thread const float2& uv, thread const float& radius, thread const float& jitter, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float3 col = float3(0.0);
    float wsum = 0.0;
    float stepY = radius * (0.699999988079071044921875 + (jitter * 0.60000002384185791015625));
    for (int i = -4; i <= 4; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 4.5);
        float2 suv = float2(uv.x, uv.y + (fi * stepY));
        float2 param = suv;
        suv = handleUVBounds(param);
        col += (tDiffuse.sample(tDiffuseSmplr, suv).xyz * w);
        wsum += w;
    }
    return col / float3(fast::max(wsum, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& ratio, constant float& maxBlur, constant float& grainAmount)
{
    if (p >= 0.99989998340606689453125)
    {
        return texel;
    }
    float2 center = float2(0.5);
    float2 d = vUv - center;
    if (ratio > 1.0)
    {
        d.y /= ratio;
    }
    else
    {
        d.x *= ratio;
    }
    float distNorm = fast::clamp(length(d) / 0.707106769084930419921875, 0.0, 1.0);
    float luma = dot(texel.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float mx = fast::max(texel.x, fast::max(texel.y, texel.z));
    float mn = fast::min(texel.x, fast::min(texel.y, texel.z));
    float sat = mx - mn;
    float fgW = smoothstep(0.180000007152557373046875, 0.85000002384185791015625, (sat * 0.89999997615814208984375) + (abs(luma - 0.5) * 1.10000002384185791015625));
    float bgW = smoothstep(0.25, 0.85000002384185791015625, 1.0 - sat) * (0.60000002384185791015625 + (0.4000000059604644775390625 * smoothstep(0.20000000298023223876953125, 0.89999997615814208984375, luma)));
    float mgW = fast::max(0.0, (1.0 - fgW) - bgW);
    float wSum = ((fgW + mgW) + bgW) + 9.9999997473787516355514526367188e-05;
    fgW /= wSum;
    mgW /= wSum;
    bgW /= wSum;
    float pFg = 1.0 - pow(1.0 - p, 3.0);
    float pMg = 1.0 - pow(1.0 - p, 2.0);
    float pBg = 1.0 - pow(1.0 - p, 1.35000002384185791015625);
    float endFade = 1.0 - p;
    float sFg = endFade * fast::clamp(1.0 - (pFg * (1.35000002384185791015625 - distNorm)), 0.0, 1.0);
    float sMg = endFade * fast::clamp(1.0 - (pMg * (1.25 - distNorm)), 0.0, 1.0);
    float sBg = endFade * fast::clamp(1.0 - (pBg * (1.14999997615814208984375 - distNorm)), 0.0, 1.0);
    float2 param = vUv * float2(913.0999755859375, 271.70001220703125);
    float n0 = hash12(param);
    float2 param_1 = (vUv * float2(521.29998779296875, 733.9000244140625)) + float2(0.37000000476837158203125);
    float n1 = hash12(param_1);
    float jitter = (n0 + n1) * 0.5;
    float2 param_2 = vUv;
    float param_3 = maxBlur * sFg;
    float param_4 = jitter;
    float3 fgCol = verticalStreakSample(param_2, param_3, param_4, tDiffuse, tDiffuseSmplr);
    float2 param_5 = vUv;
    float param_6 = maxBlur * sMg;
    float param_7 = (jitter * 0.89999997615814208984375) + 0.0500000007450580596923828125;
    float3 mgCol = verticalStreakSample(param_5, param_6, param_7, tDiffuse, tDiffuseSmplr);
    float2 param_8 = vUv;
    float param_9 = maxBlur * sBg;
    float param_10 = (jitter * 0.800000011920928955078125) + 0.100000001490116119384765625;
    float3 bgCol = verticalStreakSample(param_8, param_9, param_10, tDiffuse, tDiffuseSmplr);
    float3 layered = ((fgCol * fgW) + (mgCol * mgW)) + (bgCol * bgW);
    float blurMix = fast::clamp(((sFg + sMg) + sBg) / 3.0, 0.0, 1.0);
    float grainFade = grainAmount * blurMix;
    float2 param_11 = (vUv * float2(1280.0, 720.0)) + float2(0.12999999523162841796875, 0.709999978542327880859375);
    float gr = hash12(param_11) - 0.5;
    float2 param_12 = (vUv * float2(1220.0, 760.0)) + float2(0.4099999964237213134765625, 0.189999997615814208984375);
    float gg = hash12(param_12) - 0.5;
    float2 param_13 = (vUv * float2(1350.0, 690.0)) + float2(0.769999980926513671875, 0.5299999713897705078125);
    float gb = hash12(param_13) - 0.5;
    float3 grain = (float3(gr, gg, gb) * grainFade) * 0.800000011920928955078125;
    float3 finalRgb = fast::clamp(layered + grain, float3(0.0), float3(1.0));
    float2 param_14 = vUv;
    float borderMask = getHardBoundaryMask(param_14);
    return float4(finalRgb, texel.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.ratio, buffer.maxBlur, buffer.grainAmount);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

