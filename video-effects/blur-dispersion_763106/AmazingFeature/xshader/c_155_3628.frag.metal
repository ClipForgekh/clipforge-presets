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
    float u_ringCount;
    float u_ringDelay;
    float u_time;
    float u_ringFade;
    float u_maxBlurPx;
    float u_chromatic;
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
float2 getAspectCorrectUV(thread const float2& uv, constant float& ratio)
{
    float2 aspectUV = uv;
    if (ratio > 1.0)
    {
        aspectUV.y /= ratio;
        aspectUV.y += ((1.0 - (1.0 / ratio)) * 0.5);
    }
    else
    {
        aspectUV.x *= ratio;
        aspectUV.x += ((1.0 - ratio) * 0.5);
    }
    return aspectUV;
}

static inline __attribute__((always_inline))
float4 sampleBlurChromatic(thread const float2& uv, thread const float& blurPx, thread const float& chromaticAmount, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 texel = float2(0.00166666670702397823333740234375);
    float2 blurStep = texel * blurPx;
    float2 center = float2(0.5);
    float2 dir = uv - center;
    float dirLen = length(dir);
    float2 _84;
    if (dirLen > 9.9999997473787516355514526367188e-05)
    {
        _84 = dir / float2(dirLen);
    }
    else
    {
        _84 = float2(1.0, 0.0);
    }
    float2 dirNorm = _84;
    float2 chromaOffset = (((dirNorm * texel) * blurPx) * 0.3499999940395355224609375) * chromaticAmount;
    float2 o1 = blurStep * float2(1.0, 0.0);
    float2 o2 = blurStep * float2(0.0, 1.0);
    float2 o3 = blurStep * float2(0.707099974155426025390625);
    float2 o4 = blurStep * float2(-0.707099974155426025390625, 0.707099974155426025390625);
    float r = 0.0;
    float g = 0.0;
    float b = 0.0;
    float w = 0.0;
    float2 uv0 = fast::clamp(uv, float2(0.0), float2(1.0));
    float2 uv1 = fast::clamp(uv + o1, float2(0.0), float2(1.0));
    float2 uv2 = fast::clamp(uv - o1, float2(0.0), float2(1.0));
    float2 uv3 = fast::clamp(uv + o2, float2(0.0), float2(1.0));
    float2 uv4 = fast::clamp(uv - o2, float2(0.0), float2(1.0));
    float2 uv5 = fast::clamp(uv + o3, float2(0.0), float2(1.0));
    float2 uv6 = fast::clamp(uv - o3, float2(0.0), float2(1.0));
    float2 uv7 = fast::clamp(uv + o4, float2(0.0), float2(1.0));
    float2 uv8 = fast::clamp(uv - o4, float2(0.0), float2(1.0));
    spvUnsafeArray<float, 9> weights;
    weights[0] = 0.23999999463558197021484375;
    weights[1] = 0.119999997317790985107421875;
    weights[2] = 0.119999997317790985107421875;
    weights[3] = 0.119999997317790985107421875;
    weights[4] = 0.119999997317790985107421875;
    weights[5] = 0.070000000298023223876953125;
    weights[6] = 0.070000000298023223876953125;
    weights[7] = 0.070000000298023223876953125;
    weights[8] = 0.070000000298023223876953125;
    spvUnsafeArray<float2, 9> uvs;
    uvs[0] = uv0;
    uvs[1] = uv1;
    uvs[2] = uv2;
    uvs[3] = uv3;
    uvs[4] = uv4;
    uvs[5] = uv5;
    uvs[6] = uv6;
    uvs[7] = uv7;
    uvs[8] = uv8;
    for (int i = 0; i < 9; i++)
    {
        float2 sampleUv = uvs[i];
        float rr = texture1.sample(texture1Smplr, fast::clamp(sampleUv + chromaOffset, float2(0.0), float2(1.0))).x;
        float gg = texture1.sample(texture1Smplr, sampleUv).y;
        float bb = texture1.sample(texture1Smplr, fast::clamp(sampleUv - chromaOffset, float2(0.0), float2(1.0))).z;
        r += (rr * weights[i]);
        g += (gg * weights[i]);
        b += (bb * weights[i]);
        w += weights[i];
    }
    return float4(r / w, g / w, b / w, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 correctedUv = getAspectCorrectUV(param, buffer.ratio);
    float2 param_1 = float2(0.5);
    float2 correctedCenter = getAspectCorrectUV(param_1, buffer.ratio);
    float radius = length(correctedUv - correctedCenter);
    float2 param_2 = float2(1.0);
    float maxRadius = length(getAspectCorrectUV(param_2, buffer.ratio) - correctedCenter);
    float normalizedRadius = fast::clamp(radius / maxRadius, 0.0, 0.999998986721038818359375);
    float ringFloat = floor(normalizedRadius * buffer.u_ringCount);
    float ringIndex = fast::clamp(ringFloat, 0.0, buffer.u_ringCount - 1.0);
    float ringStart = 0.0500000007450580596923828125 + (ringIndex * buffer.u_ringDelay);
    float ringProgress = fast::clamp((buffer.u_time - ringStart) / buffer.u_ringFade, 0.0, 1.0);
    float blurPx = buffer.u_maxBlurPx * (1.0 - ringProgress);
    float chromaticAmount = (blurPx / buffer.u_maxBlurPx) + buffer.u_chromatic;
    float2 param_3 = in.vUv;
    float param_4 = blurPx;
    float param_5 = chromaticAmount;
    float4 color = sampleBlurChromatic(param_3, param_4, param_5, texture1, texture1Smplr);
    out.gl_FragColor = color;
    return out;
}

