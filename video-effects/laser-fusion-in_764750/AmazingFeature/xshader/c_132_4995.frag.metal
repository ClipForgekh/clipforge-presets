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
    float chromaAberrationStrength;
    float stripeMaxWidth;
    float4 neonColor1;
    float4 neonColor2;
    float glowIntensity;
    float maxBlurRadius;
    float ratio;
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
    return 1.0 - pow(1.0 - progress, 2.5);
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
float4 effect(thread const float4& texel, thread const float& progress, constant float& chromaAberrationStrength, thread float2& vUv, constant float& stripeMaxWidth, constant float4& neonColor1, constant float4& neonColor2, constant float& glowIntensity, constant float& maxBlurRadius, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& ratio)
{
    float stripeProgress = fast::clamp(progress / 0.300000011920928955078125, 0.0, 1.0);
    float stripeAlpha = 1.0 - smoothstep(0.300000011920928955078125, 0.4000000059604644775390625, progress);
    float baseAlpha = smoothstep(0.0, 0.300000011920928955078125, progress);
    float chromaAmount = chromaAberrationStrength * smoothstep(0.0, 1.0, 1.0 - (abs(progress - 0.300000011920928955078125) / 0.100000001490116119384765625));
    float angle = -0.785398185253143310546875;
    float s = sin(angle);
    float c = cos(angle);
    float2 rotatedUV = float2(dot(vUv - float2(0.5), float2(c, -s)), dot(vUv - float2(0.5), float2(s, c))) + float2(0.5);
    spvUnsafeArray<float, 5> stripePositions;
    stripePositions[0] = -0.20000000298023223876953125;
    stripePositions[1] = 1.2000000476837158203125;
    stripePositions[2] = -0.300000011920928955078125;
    stripePositions[3] = 1.2999999523162841796875;
    stripePositions[4] = -0.100000001490116119384765625;
    spvUnsafeArray<float, 5> stripeWidths;
    stripeWidths[0] = stripeMaxWidth * 0.800000011920928955078125;
    stripeWidths[1] = stripeMaxWidth * 1.2000000476837158203125;
    stripeWidths[2] = stripeMaxWidth * 0.89999997615814208984375;
    stripeWidths[3] = stripeMaxWidth * 1.10000002384185791015625;
    stripeWidths[4] = stripeMaxWidth * 1.0;
    float3 stripeColor = float3(0.0);
    for (int i = 0; i < 5; i++)
    {
        float currentPos = mix(stripePositions[i], 0.5, stripeProgress);
        float dist = abs(rotatedUV.x - currentPos);
        float stripeMask = smoothstep(stripeWidths[i], 0.0, dist);
        float3 colorMix = mix(neonColor1.xyz, neonColor2.xyz, float3(fract(float(i) * 0.31400001049041748046875)));
        stripeColor += ((colorMix * stripeMask) * glowIntensity);
    }
    float currentBlur = (1.0 - progress) * maxBlurRadius;
    float4 blurredTexel;
    if (chromaAmount > 0.0)
    {
        float2 param = vUv + float2(chromaAmount, 0.0);
        float param_1 = currentBlur;
        float param_2 = ratio;
        float4 r = gaussianBlur(tDiffuse, tDiffuseSmplr, param, param_1, param_2);
        float2 param_3 = vUv;
        float param_4 = currentBlur;
        float param_5 = ratio;
        float4 g = gaussianBlur(tDiffuse, tDiffuseSmplr, param_3, param_4, param_5);
        float2 param_6 = vUv - float2(chromaAmount, 0.0);
        float param_7 = currentBlur;
        float param_8 = ratio;
        float4 b = gaussianBlur(tDiffuse, tDiffuseSmplr, param_6, param_7, param_8);
        blurredTexel = float4(r.x, g.y, b.z, ((r.w + g.w) + b.w) / 3.0);
    }
    else
    {
        float2 param_9 = vUv;
        float param_10 = currentBlur;
        float param_11 = ratio;
        blurredTexel = gaussianBlur(tDiffuse, tDiffuseSmplr, param_9, param_10, param_11);
    }
    float currentBrightness = mix(2.0, 1.0, progress);
    float currentSaturation = mix(0.699999988079071044921875, 1.0, progress);
    float4 _415 = blurredTexel;
    float3 _417 = _415.xyz * currentBrightness;
    blurredTexel.x = _417.x;
    blurredTexel.y = _417.y;
    blurredTexel.z = _417.z;
    float gray = dot(blurredTexel.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _434 = blurredTexel;
    float3 _438 = mix(float3(gray), _434.xyz, float3(currentSaturation));
    blurredTexel.x = _438.x;
    blurredTexel.y = _438.y;
    blurredTexel.z = _438.z;
    float3 finalRGB = (blurredTexel.xyz * baseAlpha) + (stripeColor * stripeAlpha);
    float finalA = baseAlpha + ((fast::max(stripeColor.x, fast::max(stripeColor.y, stripeColor.z)) * stripeAlpha) * 0.5);
    return float4(finalRGB, finalA);
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
    float4 effectColor = effect(param_1, param_2, buffer.chromaAberrationStrength, in.vUv, buffer.stripeMaxWidth, buffer.neonColor1, buffer.neonColor2, buffer.glowIntensity, buffer.maxBlurRadius, tDiffuse, tDiffuseSmplr, buffer.ratio);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

