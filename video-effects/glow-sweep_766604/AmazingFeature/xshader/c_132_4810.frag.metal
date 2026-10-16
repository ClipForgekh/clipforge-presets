#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float zoomAmount;
    float blurRadius;
    float sweepJitter;
    float glowIntensity;
    float3 glowColor;
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
    return ((3.0 * p) * p) - (((2.0 * p) * p) * p);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& strength, constant float& ratio)
{
    float2 stepSize = float2(strength, strength / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + (float2(-1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 1.0);
    float2 param_1 = uv + (float2(0.0, -1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 2.0);
    float2 param_2 = uv + (float2(1.0, -1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 1.0);
    float2 param_3 = uv + (float2(-1.0, 0.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 2.0);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 4.0);
    float2 param_5 = uv + (float2(1.0, 0.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 2.0);
    float2 param_6 = uv + (float2(-1.0, 1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 1.0);
    float2 param_7 = uv + (float2(0.0, 1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 2.0);
    float2 param_8 = uv + (float2(1.0) * stepSize);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 1.0);
    return c / float4(16.0);
}

static inline __attribute__((always_inline))
float3 adjustContrast(thread const float3& color, thread const float& contrast)
{
    return ((color - float3(0.5)) * contrast) + float3(0.5);
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& saturation)
{
    float luma = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(luma), color, float3(saturation));
}

static inline __attribute__((always_inline))
float hash11(thread const float& n)
{
    return fract(sin(n * 127.09999847412109375) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 getSDFCoordinate(thread const float2& uv, thread const float2& center, constant float& ratio)
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
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& zoomAmount, thread float2& vUv, constant float& blurRadius, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& sweepJitter, constant float& glowIntensity, constant float3& glowColor)
{
    float p = fast::clamp(progress, 0.0, 1.0);
    float strength = 1.0 - p;
    float scale = 1.0 + (strength * zoomAmount);
    float2 uvRaw = float2(0.5) + ((vUv - float2(0.5)) * scale);
    float2 param = uvRaw;
    float2 uv = handleUVBounds(param);
    float2 param_1 = uvRaw;
    float borderMask = getHardBoundaryMask(param_1);
    float currentBlur = strength * blurRadius;
    float2 param_2 = uv;
    float param_3 = currentBlur;
    float4 baseTex = gaussianBlur9(tDiffuse, tDiffuseSmplr, param_2, param_3, ratio);
    float brightness = mix(0.20000000298023223876953125, 1.0, p);
    float contrast = mix(0.60000002384185791015625, 1.0, p);
    float saturation = mix(0.800000011920928955078125, 1.0, p);
    float3 baseColor = baseTex.xyz * brightness;
    float3 param_4 = baseColor;
    float param_5 = contrast;
    baseColor = adjustContrast(param_4, param_5);
    float3 param_6 = baseColor;
    float param_7 = saturation;
    baseColor = adjustSaturation(param_6, param_7);
    float moveP = 1.0 - pow(1.0 - p, 2.0);
    float headX = mix(-0.1500000059604644775390625, 1.14999997615814208984375, moveP);
    float fadeWindow = 1.0 - smoothstep(0.4000000059604644775390625, 1.0, p);
    float particleEnvelope = strength * fadeWindow;
    float spread = mix(0.100000001490116119384765625, 0.0, p) + (0.119999997317790985107421875 * sin(p * 3.1415927410125732421875));
    float trailWidth = mix(0.2800000011920928955078125, 0.02999999932944774627685546875, p);
    float glow = 0.0;
    float2 center;
    for (int i = 0; i < 14; i++)
    {
        float fi = float(i);
        float param_8 = fi + 1.230000019073486328125;
        float r1 = hash11(param_8);
        float param_9 = (fi * 2.1700000762939453125) + 3.71000003814697265625;
        float r2 = hash11(param_9);
        float param_10 = (fi * 3.1099998950958251953125) + 9.13000011444091796875;
        float r3 = hash11(param_10);
        center.x = (headX - (r1 * trailWidth)) + (((r2 - 0.5) * sweepJitter) * strength);
        center.y = 0.5 + ((r2 - 0.5) * (spread + (0.100000001490116119384765625 * r3)));
        float2 param_11 = vUv;
        float2 param_12 = center;
        float2 d = getSDFCoordinate(param_11, param_12, ratio);
        float rad = mix(0.00999999977648258209228515625, 0.0030000000260770320892333984375, p) * (0.699999988079071044921875 + (0.89999997615814208984375 * r3));
        float core = exp((-dot(d, d)) / fast::max(rad * rad, 9.9999997473787516355514526367188e-06));
        float sx = exp((-abs(d.x)) / fast::max(rad * 0.25, 9.9999997473787516355514526367188e-06));
        float sy = exp((-abs(d.y)) / fast::max(rad * 0.25, 9.9999997473787516355514526367188e-06));
        float star = (sx * exp((-abs(d.y)) / fast::max(rad * 1.7999999523162841796875, 9.9999997473787516355514526367188e-06))) + (sy * exp((-abs(d.x)) / fast::max(rad * 1.7999999523162841796875, 9.9999997473787516355514526367188e-06)));
        glow += ((core * 1.10000002384185791015625) + (star * 0.3499999940395355224609375));
    }
    float sweepBand = exp(-pow((vUv.x - headX) / fast::max(mix(0.300000011920928955078125, 0.039999999105930328369140625, p), 9.9999997473787516355514526367188e-06), 2.0));
    sweepBand *= (0.64999997615814208984375 + (0.3499999940395355224609375 * exp(-pow((vUv.y - 0.5) / 0.449999988079071044921875, 2.0))));
    float glowAmount = (((glow / 14.0) + (sweepBand * 0.89999997615814208984375)) * glowIntensity) * particleEnvelope;
    float3 outColor = baseColor + (glowColor * glowAmount);
    outColor = fast::clamp(outColor, float3(0.0), float3(1.0));
    float baseAlpha = mix(0.0, 1.0, p) * borderMask;
    return float4(outColor, baseTex.w * baseAlpha);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.zoomAmount, in.vUv, buffer.blurRadius, tDiffuse, tDiffuseSmplr, buffer.sweepJitter, buffer.glowIntensity, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

