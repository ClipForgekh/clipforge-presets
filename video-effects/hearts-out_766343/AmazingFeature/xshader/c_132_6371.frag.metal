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
    float pixelSizeMax;
    float blurMax;
    float heartCount;
    float spreadSpeed;
    float3 heartColorTint;
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
    if (progress < 0.699999988079071044921875)
    {
        return (progress * progress) * 1.7999999523162841796875;
    }
    else
    {
        return 1.0 - pow(1.0 - progress, 3.0);
    }
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    spvUnsafeArray<float, 25> kernel0;
    kernel0[0] = 1.0;
    kernel0[1] = 4.0;
    kernel0[2] = 6.0;
    kernel0[3] = 4.0;
    kernel0[4] = 1.0;
    kernel0[5] = 4.0;
    kernel0[6] = 16.0;
    kernel0[7] = 24.0;
    kernel0[8] = 16.0;
    kernel0[9] = 4.0;
    kernel0[10] = 6.0;
    kernel0[11] = 24.0;
    kernel0[12] = 36.0;
    kernel0[13] = 24.0;
    kernel0[14] = 6.0;
    kernel0[15] = 4.0;
    kernel0[16] = 16.0;
    kernel0[17] = 24.0;
    kernel0[18] = 16.0;
    kernel0[19] = 4.0;
    kernel0[20] = 1.0;
    kernel0[21] = 4.0;
    kernel0[22] = 6.0;
    kernel0[23] = 4.0;
    kernel0[24] = 1.0;
    float baseStep = 0.001000000047497451305389404296875 * blurStrength;
    float2 stepSize = float2(baseStep, baseStep / ratio);
    for (int i = -2; i <= 2; i++)
    {
        for (int j = -2; j <= 2; j++)
        {
            float weight = kernel0[((i + 2) * 5) + (j + 2)];
            float2 offset = float2(float(i) * stepSize.x, float(j) * stepSize.y);
            float2 param = uv + offset;
            float2 sampleUV = handleUVBounds(param);
            color += (tex.sample(texSmplr, sampleUV) * weight);
            totalWeight += weight;
        }
    }
    return color / float4(totalWeight);
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
float sdHeart(thread float2& p)
{
    p.x = abs(p.x);
    if ((p.y + p.x) > 1.0)
    {
        return sqrt(dot(p - float2(0.25, 0.75), p - float2(0.25, 0.75))) - 0.3535533845424652099609375;
    }
    return sqrt(fast::min(dot(p - float2(0.0, 1.0), p - float2(0.0, 1.0)), dot(p - float2(0.5), p - float2(0.5)))) * sign(p.x - p.y);
}

static inline __attribute__((always_inline))
float heartSDF(thread const float2& uv, thread const float2& center, thread const float& size, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float2 p = getSDFCoordinate(param, param_1, ratio);
    p /= float2(fast::max(size, 9.9999997473787516355514526367188e-05));
    p.y += 0.449999988079071044921875;
    float2 param_2 = p;
    float _179 = sdHeart(param_2);
    return _179 * size;
}

static inline __attribute__((always_inline))
float generateHeartMask(thread const float2& uv, thread const float2& center, thread const float& size, thread const float& blurEdge, constant float& ratio)
{
    float2 param = uv;
    float2 param_1 = center;
    float param_2 = size;
    float dist = heartSDF(param, param_1, param_2, ratio);
    return 1.0 - smoothstep(-blurEdge, blurEdge, dist);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& pixelSizeMax, thread float2& vUv, constant float& blurMax, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& heartCount, constant float& spreadSpeed, constant float3& heartColorTint)
{
    if (progress <= 0.001000000047497451305389404296875)
    {
        return texel;
    }
    float param = progress;
    float t = tween(param);
    float pixelSize = t * pixelSizeMax;
    float2 _356;
    if (pixelSize > 0.001000000047497451305389404296875)
    {
        _356 = (floor(vUv / float2(pixelSize)) * pixelSize) + float2(pixelSize * 0.5);
    }
    else
    {
        _356 = vUv;
    }
    float2 pixelUV = _356;
    float2 param_1 = pixelUV;
    pixelUV = handleUVBounds(param_1);
    float blurStrength = t * blurMax;
    float2 param_2 = pixelUV;
    float param_3 = blurStrength;
    float param_4 = ratio;
    float4 blurredTex = gaussianBlur(tDiffuse, tDiffuseSmplr, param_2, param_3, param_4);
    float baseAlpha = 1.0 - t;
    float4 baseColor = float4(blurredTex.xyz, blurredTex.w * baseAlpha);
    float4 heartsColor = float4(0.0);
    float _412;
    if (progress < 0.5)
    {
        _412 = progress * 2.0;
    }
    else
    {
        float _421;
        if (progress < 0.699999988079071044921875)
        {
            _421 = 1.0;
        }
        else
        {
            _421 = (1.0 - progress) * 3.3329999446868896484375;
        }
        _412 = _421;
    }
    float heartAlpha = _412;
    float _512;
    for (int i = 0; i < 15; i++)
    {
        if (float(i) >= heartCount)
        {
            break;
        }
        float angle = (((float(i) * 2.0) * 3.1415927410125732421875) / heartCount) + (sin(float(i) * 123.4499969482421875) * 0.20000000298023223876953125);
        float randomScale = 0.800000011920928955078125 + (0.4000000059604644775390625 * fract(sin(float(i) * 456.779998779296875)));
        float randomSpeed = 0.800000011920928955078125 + (0.4000000059604644775390625 * fract(cos(float(i) * 789.010009765625)));
        float spreadDist = ((t * spreadSpeed) * randomSpeed) * 0.5;
        if (progress > 0.699999988079071044921875)
        {
            spreadDist *= ((1.0 - progress) * 3.3329999446868896484375);
        }
        float2 heartCenter = float2(0.5) + (float2(cos(angle), sin(angle)) * spreadDist);
        if (progress < 0.699999988079071044921875)
        {
            _512 = (t * 0.25) * randomScale;
        }
        else
        {
            _512 = ((1.0 - progress) * 0.699999988079071044921875) * randomScale;
        }
        float heartSize = _512;
        if (heartSize < 0.001000000047497451305389404296875)
        {
            continue;
        }
        float2 param_5 = vUv;
        float2 param_6 = heartCenter;
        float param_7 = heartSize;
        float param_8 = 0.001000000047497451305389404296875;
        float heartMask = generateHeartMask(param_5, param_6, param_7, param_8, ratio);
        if (heartMask < 0.00999999977648258209228515625)
        {
            continue;
        }
        float2 param_9 = heartCenter;
        float4 heartTex = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_9));
        float gray = dot(heartTex.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
        float3 saturated = mix(float3(gray), heartTex.xyz, float3(1.5));
        float3 tinted = (saturated * heartColorTint) * 1.2000000476837158203125;
        tinted = fast::clamp(tinted, float3(0.0), float3(1.0));
        float4 _586 = heartsColor;
        float3 _588 = _586.xyz + ((tinted * heartMask) * heartAlpha);
        heartsColor.x = _588.x;
        heartsColor.y = _588.y;
        heartsColor.z = _588.z;
        heartsColor.w += (heartMask * heartAlpha);
    }
    heartsColor.w = fast::clamp(heartsColor.w, 0.0, 1.0);
    float _613;
    if (progress < 0.60000002384185791015625)
    {
        _613 = progress * 1.66600000858306884765625;
    }
    else
    {
        _613 = (1.0 - progress) * 2.5;
    }
    float glowIntensity = _613;
    float glowMask = 1.0 - smoothstep(0.0, 0.800000011920928955078125, length(vUv - float2(0.5)));
    float3 glowColor = ((heartColorTint * glowMask) * glowIntensity) * 0.300000011920928955078125;
    float3 finalRGB = ((baseColor.xyz * baseColor.w) + (heartsColor.xyz * heartsColor.w)) + glowColor;
    float finalAlpha = fast::clamp(baseColor.w + heartsColor.w, 0.0, 1.0);
    finalRGB = fast::clamp(finalRGB, float3(0.0), float3(1.0));
    if (progress > 0.949999988079071044921875)
    {
        finalAlpha *= ((1.0 - progress) * 20.0);
    }
    return float4(finalRGB, finalAlpha);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> tDiffuse [[texture(0)]], sampler tDiffuseSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texel = tDiffuse.sample(tDiffuseSmplr, in.vUv);
    float effectProgress = fast::clamp((buffer.progress - 0.0) / 1.0, 0.0, 1.0);
    float4 param = texel;
    float param_1 = effectProgress;
    float4 effectColor = effect(param, param_1, buffer.ratio, buffer.pixelSizeMax, in.vUv, buffer.blurMax, tDiffuse, tDiffuseSmplr, buffer.heartCount, buffer.spreadSpeed, buffer.heartColorTint);
    out.gl_FragColor = effectColor;
    return out;
}

