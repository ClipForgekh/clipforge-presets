#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct buffer_t
{
    float ratio;
    float reuleauxRoundness;
    float chromaStrength;
    float blurStrength;
    float brightnessWave;
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
float tween(thread const float& progress)
{
    return progress;
}

static inline __attribute__((always_inline))
float2 getAspectCorrectUV(thread const float2& uv, constant float& ratio)
{
    float2 aspectUV = uv - float2(0.5);
    if (ratio > 1.0)
    {
        aspectUV.y /= ratio;
    }
    else
    {
        aspectUV.x *= ratio;
    }
    return aspectUV + float2(0.5);
}

static inline __attribute__((always_inline))
float reuleauxSDF(thread const float2& uv, thread const float2& center, thread const float& size, thread const float& roundness, constant float& ratio)
{
    float2 param = uv;
    float2 p = getAspectCorrectUV(param, ratio) - center;
    p *= (2.0 / size);
    float k = 1.73205077648162841796875;
    p.x = abs(p.x);
    if ((p.y + (p.x * k)) > 1.0)
    {
        p = float2((p.x * k) - p.y, (-p.x) - (p.y * k)) / float2(2.0);
    }
    p.x -= fast::clamp(p.x, -roundness, roundness);
    return ((length(p) * sign(p.y)) * size) * 0.5;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& strength, thread const float& ratio)
{
    float4 color = float4(0.0);
    spvUnsafeArray<float, 9> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 2.0;
    kernel0[2] = 1.0;
    kernel0[3] = 2.0;
    kernel0[4] = 4.0;
    kernel0[5] = 2.0;
    kernel0[6] = 1.0;
    kernel0[7] = 2.0;
    kernel0[8] = 1.0;
    float totalWeight = 16.0;
    float _step = strength * 0.004999999888241291046142578125;
    float2 stepSize = float2(_step, _step / ratio);
    for (int i = -1; i <= 1; i++)
    {
        for (int j = -1; j <= 1; j++)
        {
            float weight = kernel0[((i + 1) * 3) + (j + 1)];
            float2 offset = float2(float(i) * stepSize.x, float(j) * stepSize.y);
            float2 param = uv + offset;
            color += (tex.sample(texSmplr, handleUVBounds(param)) * weight);
        }
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, thread float2& vUv, constant float& reuleauxRoundness, constant float& chromaStrength, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& blurStrength, constant float& brightnessWave)
{
    float cycle = (progress * 2.0) * 3.1415927410125732421875;
    float effectCycle = 0.5 * (1.0 - cos(2.0 * cycle));
    float2 center = float2(0.5);
    float rotation = 6.283185482025146484375 * progress;
    float s = sin(rotation);
    float c = cos(rotation);
    float2 rotatedUV = float2(dot(vUv - center, float2(c, -s)), dot(vUv - center, float2(s, c))) + center;
    float2 param = rotatedUV;
    float2 param_1 = center;
    float param_2 = 0.800000011920928955078125;
    float param_3 = reuleauxRoundness;
    float dist = reuleauxSDF(param, param_1, param_2, param_3, ratio);
    float edgeMask = smoothstep(0.0, 0.0199999995529651641845703125, abs(dist) - 0.004999999888241291046142578125);
    float chromaOffset = (chromaStrength * effectCycle) * edgeMask;
    float2 param_4 = vUv + float2(chromaOffset, 0.0);
    float r = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)).x;
    float g = texel.y;
    float2 param_5 = vUv + float2(-chromaOffset, 0.0);
    float b = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)).z;
    float3 chromaColor = float3(r, g, b);
    float currentBlur = (blurStrength * effectCycle) * (1.0 - edgeMask);
    float2 param_6 = vUv;
    float param_7 = currentBlur;
    float param_8 = ratio;
    float4 blurredColor = gaussianBlur(tDiffuse, tDiffuseSmplr, param_6, param_7, param_8);
    float3 finalColor = mix(blurredColor.xyz, chromaColor, float3(edgeMask));
    float brightness = 1.0 + (brightnessWave * sin(cycle + (dist * 10.0)));
    finalColor *= brightness;
    return float4(finalColor, texel.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.reuleauxRoundness, buffer.chromaStrength, tDiffuse, tDiffuseSmplr, buffer.blurStrength, buffer.brightnessWave);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

