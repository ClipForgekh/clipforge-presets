#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float blurMax;
    float ratio;
    float particleDensity;
    float3 particleColor;
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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusPx, thread const float& screenRatio)
{
    float r = fast::max(radiusPx, 0.0) * 0.001000000047497451305389404296875;
    float2 stepSize = float2(r, r / fast::max(screenRatio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + (stepSize * float2(-1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.07500000298023223876953125);
    float2 param_1 = uv + (stepSize * float2(0.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.119999997317790985107421875);
    float2 param_2 = uv + (stepSize * float2(1.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.07500000298023223876953125);
    float2 param_3 = uv + (stepSize * float2(-1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.119999997317790985107421875);
    float2 param_4 = uv + (stepSize * float2(0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.2199999988079071044921875);
    float2 param_5 = uv + (stepSize * float2(1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.119999997317790985107421875);
    float2 param_6 = uv + (stepSize * float2(-1.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.07500000298023223876953125);
    float2 param_7 = uv + (stepSize * float2(0.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.119999997317790985107421875);
    float2 param_8 = uv + (stepSize * float2(1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.07500000298023223876953125);
    return c;
}

static inline __attribute__((always_inline))
float hash21(thread float2& p)
{
    p = fract(p * float2(123.339996337890625, 456.209991455078125));
    p += float2(dot(p, p + float2(34.450000762939453125)));
    return fract(p.x * p.y);
}

static inline __attribute__((always_inline))
float2 hash22(thread const float2& p)
{
    float2 param = p;
    float _86 = hash21(param);
    float n = _86;
    float2 param_1 = (p + float2(n)) + float2(17.3099994659423828125);
    float _96 = hash21(param_1);
    return float2(n, _96);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& blurMax, constant float& ratio, constant float& particleDensity, constant float3& particleColor, constant float& glowStrength)
{
    float reveal = fast::clamp(p / 0.800000011920928955078125, 0.0, 1.0);
    float effectAmt = 1.0 - smoothstep(0.0, 0.800000011920928955078125, p);
    float2 param = vUv;
    float param_1 = blurMax * effectAmt;
    float param_2 = ratio;
    float4 blurredTexel = gaussianBlur9(tDiffuse, tDiffuseSmplr, param, param_1, param_2);
    float brightness = reveal;
    float saturation = mix(0.699999988079071044921875, 1.0, reveal);
    float3 baseColor = blurredTexel.xyz * brightness;
    float luma = dot(baseColor, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    baseColor = mix(float3(luma), baseColor, float3(saturation));
    float2 uv = vUv;
    float sweepX = (-0.25) + (1.4500000476837158203125 * p);
    float bandWidth = mix(0.2599999904632568359375, 0.070000000298023223876953125, p);
    float band = exp((-pow((uv.x - sweepX) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05), 2.0)) * 3.0);
    float2 flowUV = uv;
    flowUV.x -= (p * 0.550000011920928955078125);
    float2 param_3 = floor(uv * 40.0);
    float _321 = hash21(param_3);
    flowUV.y += (((_321 - 0.5) * 0.119999997317790985107421875) * (1.0 - p));
    float2 grid = float2(120.0, 72.0);
    float2 cell = floor(flowUV * grid);
    float2 f = fract(flowUV * grid);
    float2 param_4 = cell;
    float2 rnd = hash22(param_4);
    float alive = step(rnd.x, particleDensity * effectAmt);
    float2 center = rnd;
    float2 d = (f - center) * float2(1.0, ratio);
    float size = mix(0.119999997317790985107421875, 0.4199999868869781494140625, rnd.y);
    float spark = smoothstep(size, 0.0, length(d));
    float twinkle = 0.64999997615814208984375 + (0.3499999940395355224609375 * sin(((rnd.x * 31.0) + (p * 28.0)) * 6.283185482025146484375));
    float particleMask = (((spark * band) * alive) * twinkle) * effectAmt;
    float3 glowColor = mix(particleColor, float3(1.0), float3(smoothstep(0.75, 1.0, spark)));
    float3 particleAdd = glowColor * (glowStrength * particleMask);
    float3 finalRgb = baseColor + particleAdd;
    float baseAlpha = texel.w * reveal;
    float particleAlpha = fast::clamp(particleMask * 0.89999997615814208984375, 0.0, 1.0);
    float finalAlpha = fast::clamp(baseAlpha + (particleAlpha * (1.0 - reveal)), 0.0, 1.0);
    return float4(fast::clamp(finalRgb, float3(0.0), float3(1.0)), finalAlpha);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.blurMax, buffer.ratio, buffer.particleDensity, buffer.particleColor, buffer.glowStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

