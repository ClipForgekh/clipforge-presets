#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float ratio;
    float bandCount;
    float maxOffset;
    float maxBlur;
    float leakStrength;
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
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 fastBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, constant float& ratio)
{
    float2 stepSize = float2(radius, radius / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + (stepSize * float2(-1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.07500000298023223876953125);
    float2 param_1 = uv + (stepSize * float2(0.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.125);
    float2 param_2 = uv + (stepSize * float2(1.0, -1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.07500000298023223876953125);
    float2 param_3 = uv + (stepSize * float2(-1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.125);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.20000000298023223876953125);
    float2 param_5 = uv + (stepSize * float2(1.0, 0.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.125);
    float2 param_6 = uv + (stepSize * float2(-1.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.07500000298023223876953125);
    float2 param_7 = uv + (stepSize * float2(0.0, 1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.125);
    float2 param_8 = uv + (stepSize * float2(1.0));
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.07500000298023223876953125);
    return c;
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& sat)
{
    float l = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(l), color, float3(sat));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& bandCount, thread float2& vUv, constant float& maxOffset, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& leakStrength)
{
    float bands = fast::max(2.0, floor(bandCount + 0.5));
    float b = floor(vUv.y * bands);
    float fromEdge = fast::min(b, (bands - 1.0) - b);
    float edgeNorm = abs(((b + 0.5) / bands) - 0.5) * 2.0;
    float pairDelay = 0.0500000007450580596923828125;
    float neighborDelay = mod(b, 2.0) * 0.02500000037252902984619140625;
    float delay = (fromEdge * pairDelay) + neighborDelay;
    delay = fast::min(delay, 0.85000002384185791015625);
    float localP = fast::clamp((p - delay) / (1.0 - delay), 0.0, 1.0);
    float param = localP;
    float localEase = tween(param);
    float strength = 1.0 - localEase;
    float wave = sin(((b * 1.7000000476837158203125) + (p * 10.0)) * 3.1415927410125732421875);
    float xOffset = ((maxOffset * strength) * edgeNorm) * wave;
    float scale = 1.0 + ((0.20000000298023223876953125 * strength) * (0.64999997615814208984375 + (0.3499999940395355224609375 * edgeNorm)));
    float2 uv = float2(0.5) + ((vUv - float2(0.5)) * scale);
    uv.x += xOffset;
    float2 param_1 = uv;
    float borderMask = getHardBoundaryMask(param_1);
    float2 param_2 = uv;
    uv = handleUVBounds(param_2);
    float blurR = (maxBlur * strength) * (0.800000011920928955078125 + (0.20000000298023223876953125 * edgeNorm));
    float2 param_3 = uv;
    float param_4 = blurR;
    float4 col = fastBlur9(tDiffuse, tDiffuseSmplr, param_3, param_4, ratio);
    float brightness = mix(1.0, 2.099999904632568359375, strength);
    float saturation = mix(1.0, 1.89999997615814208984375, strength);
    float3 param_5 = col.xyz * brightness;
    float param_6 = saturation;
    float3 graded = adjustSaturation(param_5, param_6);
    float3 warm = float3(1.0, 0.560000002384185791015625, 0.20000000298023223876953125);
    float leak = (leakStrength * strength) * (0.550000011920928955078125 + (0.449999988079071044921875 * edgeNorm));
    graded = mix(graded, fast::min(float3(1.0), graded + (warm * 0.75)), float3(fast::clamp(leak, 0.0, 1.0)));
    float f = fract(vUv.y * bands);
    float edgeLine = 1.0 - smoothstep(0.0, 0.07999999821186065673828125, fast::min(f, 1.0 - f));
    float scratch = (sin(((vUv.x * 420.0) + (b * 31.700000762939453125)) * 1.16999995708465576171875) * 0.5) + 0.5;
    float scratchMask = ((edgeLine * scratch) * strength) * 0.25;
    graded += (float3(0.119999997317790985107421875, 0.07999999821186065673828125, 0.02999999932944774627685546875) * scratchMask);
    graded = fast::clamp(graded, float3(0.0), float3(1.0));
    return float4(graded, col.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.bandCount, in.vUv, buffer.maxOffset, buffer.maxBlur, tDiffuse, tDiffuseSmplr, buffer.leakStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

