#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float blurSize;
    float3 warmColor;
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
    if (ratio > 1.0)
    {
        return sqrt(0.25 + (0.25 / (ratio * ratio)));
    }
    return sqrt(((0.25 * ratio) * ratio) + 0.25);
}

static inline __attribute__((always_inline))
float easeOutCubic(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(thread const float2& uv, thread const float& amount, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 stepV = float2(0.0, amount / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 col = float4(0.0);
    float2 param = uv - (stepV * 4.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.0500000007450580596923828125);
    float2 param_1 = uv - (stepV * 3.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv - (stepV * 2.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv - (stepV * 1.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.180000007152557373046875);
    float2 param_5 = uv + (stepV * 1.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + (stepV * 2.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + (stepV * 3.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + (stepV * 4.0);
    col += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_8)) * 0.0500000007450580596923828125);
    return col;
}

static inline __attribute__((always_inline))
float3 applyContrast(thread const float3& color, thread const float& c)
{
    return ((color - float3(0.5)) * c) + float3(0.5);
}

static inline __attribute__((always_inline))
float rand(thread const float2& co)
{
    return fract(sin(dot(co, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& blurSize, constant float3& warmColor, constant float& grainAmount)
{
    if (p >= 0.99989998340606689453125)
    {
        return texel;
    }
    float2 center = float2(0.5);
    float2 param = vUv;
    float2 param_1 = center;
    float2 pc = getSDFCoordinate(param, param_1, ratio);
    float maxR = getMaxRadius(ratio);
    float rNorm = fast::clamp(length(pc) / maxR, 0.0, 0.999998986721038818359375);
    float ringIndex = floor(rNorm * 8.0);
    float ringPos = fract(rNorm * 8.0);
    float startT = ringIndex * 0.111111111938953399658203125;
    float local = fast::clamp((p - startT) / 0.22222222387790679931640625, 0.0, 1.0);
    float param_2 = local;
    float k = easeOutCubic(param_2);
    float blurFactor = 1.0 - k;
    float contrast = mix(0.4000000059604644775390625, 1.0, k);
    float exposure;
    if (local < 0.5)
    {
        float param_3 = local * 2.0;
        float a = easeOutCubic(param_3);
        exposure = mix(2.7999999523162841796875, 3.2000000476837158203125, a);
    }
    else
    {
        float param_4 = (local - 0.5) * 2.0;
        float b = easeOutCubic(param_4);
        exposure = mix(3.2000000476837158203125, 1.0, b);
    }
    float2 param_5 = vUv;
    float param_6 = blurSize * blurFactor;
    float4 base = verticalBlur(param_5, param_6, ratio, tDiffuse, tDiffuseSmplr);
    float3 param_7 = base.xyz;
    float param_8 = contrast;
    float3 col = applyContrast(param_7, param_8);
    col *= exposure;
    float edge = 1.0 - smoothstep(0.0, 0.14000000059604644775390625, fast::min(ringPos, 1.0 - ringPos));
    float leak = smoothstep(0.5, 0.62000000476837158203125, local) * (1.0 - smoothstep(0.62000000476837158203125, 0.920000016689300537109375, local));
    col += (warmColor * ((0.1599999964237213134765625 * leak) * edge));
    float globalRemain = 1.0 - p;
    float2 param_9 = (vUv * float2(1280.0, 720.0)) + float2(p * 37.0);
    float g = (rand(param_9) - 0.5) * 2.0;
    col += float3(((g * grainAmount) * globalRemain) * 0.119999997317790985107421875);
    col = mix(col, texel.xyz, float3(smoothstep(0.9700000286102294921875, 1.0, p)));
    col = fast::clamp(col, float3(0.0), float3(1.0));
    return float4(col, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, in.vUv, buffer.blurSize, buffer.warmColor, buffer.grainAmount);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

