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
    float bandWidth;
    float glitchStrength;
    float blurIntensity;
    float3 neonColor1;
    float3 neonColor2;
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
    return 1.0 - pow(1.0 - progress, 2.0);
}

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
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurStrength, thread const float& ratio)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
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
    float baseStep = 0.001000000047497451305389404296875 * blurStrength;
    float2 stepSize = float2(baseStep, baseStep / ratio);
    for (int i = -1; i <= 1; i++)
    {
        for (int j = -1; j <= 1; j++)
        {
            float weight = kernel0[((i + 1) * 3) + (j + 1)];
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
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, thread float2& vUv, constant float& bandWidth, constant float& glitchStrength, constant float& blurIntensity, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float3& neonColor1, constant float3& neonColor2)
{
    float t = progress;
    float2 param = vUv;
    float2 p = getAspectCorrectUV(param, ratio);
    float scan1Pos = (-1.7999999523162841796875) * (1.0 - t);
    float scan2Pos = 1.7999999523162841796875 * (1.0 - t);
    float scan3Pos = (-0.800000011920928955078125) * (1.0 - t);
    float lineDist = p.x - p.y;
    float d1 = abs(lineDist - scan1Pos);
    float d2 = abs(lineDist - scan2Pos);
    float d3 = abs(lineDist - scan3Pos);
    float minDist = fast::min(d1, fast::min(d2, d3));
    float showMask = (step(scan1Pos, lineDist) * step(lineDist, scan2Pos)) * step(scan3Pos, lineDist);
    float currentBandWidth = bandWidth * ((1.0 - t) + 0.100000001490116119384765625);
    float inBand = smoothstep(currentBandWidth, 0.0, minDist);
    float2 glitchDir = float2(0.707106769084930419921875, -0.707106769084930419921875);
    float offset = (glitchStrength * (1.0 - t)) * inBand;
    float2 param_1 = vUv + (glitchDir * offset);
    float2 uvR = handleUVBounds(param_1);
    float2 param_2 = vUv;
    float2 uvG = handleUVBounds(param_2);
    float2 param_3 = vUv - (glitchDir * offset);
    float2 uvB = handleUVBounds(param_3);
    float currentBlur = (blurIntensity * (1.0 - t)) * inBand;
    float2 param_4 = uvR;
    float param_5 = currentBlur;
    float param_6 = ratio;
    float4 colR = gaussianBlur(tDiffuse, tDiffuseSmplr, param_4, param_5, param_6);
    float2 param_7 = uvG;
    float param_8 = currentBlur;
    float param_9 = ratio;
    float4 colG = gaussianBlur(tDiffuse, tDiffuseSmplr, param_7, param_8, param_9);
    float2 param_10 = uvB;
    float param_11 = currentBlur;
    float param_12 = ratio;
    float4 colB = gaussianBlur(tDiffuse, tDiffuseSmplr, param_10, param_11, param_12);
    float4 baseCol = float4(colR.x, colG.y, colB.z, 1.0);
    float3 neonGrad = mix(neonColor1, neonColor2, float3(minDist / currentBandWidth));
    float neonAlpha = (inBand * (1.0 - t)) * 1.5;
    float3 neonCol = neonGrad * neonAlpha;
    float flash = (smoothstep(0.89999997615814208984375, 0.949999988079071044921875, t) * smoothstep(1.0, 0.949999988079071044921875, t)) * 2.5;
    float3 finalCol = mix((baseCol.xyz + neonCol) + float3(flash), float3(0.0), float3(1.0 - showMask));
    return float4(finalCol, 1.0);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, in.vUv, buffer.bandWidth, buffer.glitchStrength, buffer.blurIntensity, tDiffuse, tDiffuseSmplr, buffer.neonColor1, buffer.neonColor2);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

