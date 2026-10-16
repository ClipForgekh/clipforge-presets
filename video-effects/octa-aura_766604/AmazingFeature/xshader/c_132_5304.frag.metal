#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float wedgeSoftness;
    float scanWidth;
    float blurMax;
    float centerBloom;
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
float getMaxRadius(constant float& ratio)
{
    float2 c = float2(0.5);
    float2 param = float2(0.0);
    float2 param_1 = c;
    float r1 = length(getSDFCoordinate(param, param_1, ratio));
    float2 param_2 = float2(1.0, 0.0);
    float2 param_3 = c;
    float r2 = length(getSDFCoordinate(param_2, param_3, ratio));
    float2 param_4 = float2(0.0, 1.0);
    float2 param_5 = c;
    float r3 = length(getSDFCoordinate(param_4, param_5, ratio));
    float2 param_6 = float2(1.0);
    float2 param_7 = c;
    float r4 = length(getSDFCoordinate(param_6, param_7, ratio));
    return fast::max(fast::max(r1, r2), fast::max(r3, r4));
}

static inline __attribute__((always_inline))
float2 dirFromIndex(thread const int& i)
{
    if (i == 0)
    {
        return float2(1.0, 0.0);
    }
    if (i == 1)
    {
        return float2(-1.0, 0.0);
    }
    if (i == 2)
    {
        return float2(0.0, 1.0);
    }
    if (i == 3)
    {
        return float2(0.0, -1.0);
    }
    if (i == 4)
    {
        return float2(0.707106769084930419921875);
    }
    if (i == 5)
    {
        return float2(-0.707106769084930419921875, 0.707106769084930419921875);
    }
    if (i == 6)
    {
        return float2(0.707106769084930419921875, -0.707106769084930419921875);
    }
    return float2(-0.707106769084930419921875);
}

static inline __attribute__((always_inline))
float3 neonColor(thread const int& i)
{
    if ((i == 0) || (i == 4))
    {
        return float3(1.0, 0.1500000059604644775390625, 0.75);
    }
    if ((i == 1) || (i == 6))
    {
        return float3(0.119999997317790985107421875, 0.64999997615814208984375, 1.0);
    }
    if ((i == 2) || (i == 7))
    {
        return float3(0.449999988079071044921875, 0.180000007152557373046875, 0.85000002384185791015625);
    }
    return float3(0.680000007152557373046875, 1.0, 0.180000007152557373046875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 multiDirBlur(thread const float2& uv, thread const float2& p, thread const float& strength, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float4 acc = float4(0.0);
    float wsum = 0.0;
    acc += (tDiffuse.sample(tDiffuseSmplr, uv) * 0.180000007152557373046875);
    wsum += 0.180000007152557373046875;
    float _279;
    float _302;
    float _324;
    float _346;
    float _368;
    float _390;
    for (int i = 0; i < 8; i++)
    {
        int param = i;
        float2 d = dirFromIndex(param);
        float2 o1 = (d * strength) * 0.800000011920928955078125;
        float2 o2 = (d * strength) * 1.60000002384185791015625;
        float2 o3 = (d * strength) * 2.400000095367431640625;
        if (ratio > 1.0)
        {
            _279 = ratio;
        }
        else
        {
            _279 = 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05);
        }
        float2 param_1 = uv + float2(o1.x, o1.y * _279);
        float2 uv1 = handleUVBounds(param_1);
        if (ratio > 1.0)
        {
            _302 = ratio;
        }
        else
        {
            _302 = 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05);
        }
        float2 param_2 = uv - float2(o1.x, o1.y * _302);
        float2 uv2 = handleUVBounds(param_2);
        if (ratio > 1.0)
        {
            _324 = ratio;
        }
        else
        {
            _324 = 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05);
        }
        float2 param_3 = uv + float2(o2.x, o2.y * _324);
        float2 uv3 = handleUVBounds(param_3);
        if (ratio > 1.0)
        {
            _346 = ratio;
        }
        else
        {
            _346 = 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05);
        }
        float2 param_4 = uv - float2(o2.x, o2.y * _346);
        float2 uv4 = handleUVBounds(param_4);
        if (ratio > 1.0)
        {
            _368 = ratio;
        }
        else
        {
            _368 = 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05);
        }
        float2 param_5 = uv + float2(o3.x, o3.y * _368);
        float2 uv5 = handleUVBounds(param_5);
        if (ratio > 1.0)
        {
            _390 = ratio;
        }
        else
        {
            _390 = 1.0 / fast::max(ratio, 9.9999997473787516355514526367188e-05);
        }
        float2 param_6 = uv - float2(o3.x, o3.y * _390);
        float2 uv6 = handleUVBounds(param_6);
        acc += (tDiffuse.sample(tDiffuseSmplr, uv1) * 0.100000001490116119384765625);
        acc += (tDiffuse.sample(tDiffuseSmplr, uv2) * 0.100000001490116119384765625);
        acc += (tDiffuse.sample(tDiffuseSmplr, uv3) * 0.070000000298023223876953125);
        acc += (tDiffuse.sample(tDiffuseSmplr, uv4) * 0.070000000298023223876953125);
        acc += (tDiffuse.sample(tDiffuseSmplr, uv5) * 0.039999999105930328369140625);
        acc += (tDiffuse.sample(tDiffuseSmplr, uv6) * 0.039999999105930328369140625);
        wsum += 0.4199999868869781494140625;
    }
    return acc / float4(wsum);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& wedgeSoftness, constant float& scanWidth, constant float& blurMax, constant float& centerBloom, constant float& glowStrength)
{
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 q = getSDFCoordinate(param, param_1, ratio);
    float r = length(q);
    float2 n = q / float2(fast::max(r, 9.9999997473787516355514526367188e-06));
    float sweepPhase = fast::min(p / 0.800000011920928955078125, 1.0);
    float sweepFront = sweepPhase * getMaxRadius(ratio);
    float clearMask = 0.0;
    float edgeGlow = 0.0;
    float3 neonAccum = float3(0.0);
    float cosCore = 0.92387950420379638671875;
    float cosSoft = cos(0.3926990926265716552734375 + wedgeSoftness);
    for (int i = 0; i < 8; i++)
    {
        int param_2 = i;
        float2 d = dirFromIndex(param_2);
        float ang = dot(n, d);
        float wedge = smoothstep(cosSoft, cosCore, ang);
        float proj = dot(q, d);
        float swept = smoothstep(-scanWidth, scanWidth, sweepFront - proj);
        clearMask = fast::max(clearMask, wedge * swept);
        float edge = exp((-abs(proj - sweepFront)) / fast::max(scanWidth * 0.699999988079071044921875, 9.9999997473787516355514526367188e-05)) * wedge;
        edgeGlow += edge;
        int param_3 = i;
        neonAccum += (neonColor(param_3) * edge);
    }
    float blurAmount = (((1.0 - clearMask) * (1.0 - sweepPhase)) * blurMax) + (((1.0 - clearMask) * blurMax) * 0.3499999940395355224609375);
    float2 param_4 = vUv;
    float2 param_5 = q;
    float param_6 = blurAmount;
    float4 blurred = multiDirBlur(param_4, param_5, param_6, ratio, tDiffuse, tDiffuseSmplr);
    float sat = 1.4500000476837158203125 - (0.449999988079071044921875 * sweepPhase);
    float3 vivid = blurred.xyz;
    float luma = dot(vivid, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    vivid = mix(float3(luma), vivid, float3(sat));
    float centerHot = (exp((-r) * 18.0) * centerBloom) * (1.0 - sweepPhase);
    float trailFade = 1.0 - smoothstep(0.800000011920928955078125, 1.0, p);
    float3 glowColor = ((neonAccum * glowStrength) * trailFade) * 0.550000011920928955078125;
    float glowInt = fast::min(((edgeGlow * 0.2199999988079071044921875) * glowStrength) * trailFade, 1.0);
    float3 staged = (vivid + glowColor) + float3(centerHot + (glowInt * 0.25));
    staged = fast::clamp(staged, float3(0.0), float3(1.0));
    float3 finalRgb = mix(staged, texel.xyz, float3(clearMask));
    finalRgb = mix(finalRgb, texel.xyz, float3(smoothstep(0.800000011920928955078125, 1.0, p)));
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.wedgeSoftness, buffer.scanWidth, buffer.blurMax, buffer.centerBloom, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

