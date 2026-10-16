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
    float blockCount;
    float delayPerBlock;
    float sweepWidth;
    float blurStrength;
    float ratio;
    float rgbOffset;
    float4 neonColor1;
    float4 neonColor2;
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
    return 1.0 - pow(1.0 - progress, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, thread float2& vUv, constant float& blockCount, constant float& delayPerBlock, constant float& sweepWidth, constant float& blurStrength, constant float& ratio, constant float& rgbOffset, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float4& neonColor1, constant float4& neonColor2)
{
    if (progress >= 1.0)
    {
        return texel;
    }
    float blockIndex = floor(vUv.y * blockCount);
    float totalDelay = (blockCount - 1.0) * delayPerBlock;
    float delay = blockIndex * delayPerBlock;
    float localProgress = fast::clamp((progress - delay) / (1.0 - totalDelay), 0.0, 1.0);
    float param = localProgress;
    float p = tween(param);
    bool isOdd = mod(blockIndex, 2.0) == 1.0;
    float _90;
    if (isOdd)
    {
        _90 = (p * (1.0 + sweepWidth)) - (sweepWidth * 0.5);
    }
    else
    {
        _90 = (1.0 - (p * (1.0 + sweepWidth))) + (sweepWidth * 0.5);
    }
    float sweepPos = _90;
    float sweepMask = 1.0 - smoothstep(0.0, sweepWidth * 0.5, abs(vUv.x - sweepPos));
    float currentBlur = (blurStrength * (1.0 - p)) / ratio;
    float currentOffset = (rgbOffset * (1.0 - p)) / ratio;
    float brightness = 1.0 + (0.89999997615814208984375 * (1.0 - p));
    float4 finalTexel = float4(0.0);
    float totalWeight = 0.0;
    for (int i = -2; i <= 2; i++)
    {
        float blurOffset = float(i) * currentBlur;
        float2 sampleUV = float2(vUv.x + blurOffset, vUv.y);
        float2 param_1 = sampleUV;
        sampleUV = handleUVBounds(param_1);
        float r = tDiffuse.sample(tDiffuseSmplr, (sampleUV + float2(currentOffset, 0.0))).x;
        float g = tDiffuse.sample(tDiffuseSmplr, sampleUV).y;
        float b = tDiffuse.sample(tDiffuseSmplr, (sampleUV - float2(currentOffset, 0.0))).z;
        float a = tDiffuse.sample(tDiffuseSmplr, sampleUV).w;
        float weight = 1.0 - (abs(float(i)) / 3.0);
        finalTexel += (float4(r, g, b, a) * weight);
        totalWeight += weight;
    }
    finalTexel /= float4(totalWeight);
    float4 _236 = finalTexel;
    float3 _238 = _236.xyz * brightness;
    finalTexel.x = _238.x;
    finalTexel.y = _238.y;
    finalTexel.z = _238.z;
    float _247;
    if (isOdd)
    {
        _247 = ((vUv.x - sweepPos) + (sweepWidth * 0.5)) / sweepWidth;
    }
    else
    {
        _247 = ((sweepPos - vUv.x) + (sweepWidth * 0.5)) / sweepWidth;
    }
    float neonGradientPos = _247;
    float4 neonColor = mix(neonColor1, neonColor2, float4(fast::clamp(neonGradientPos, 0.0, 1.0)));
    float4 _280 = finalTexel;
    float3 _290 = mix(_280.xyz, neonColor.xyz, float3((sweepMask * (1.0 - p)) * 0.5));
    finalTexel.x = _290.x;
    finalTexel.y = _290.y;
    finalTexel.z = _290.z;
    finalTexel.w *= p;
    return finalTexel;
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
    float4 effectColor = effect(param_1, param_2, in.vUv, buffer.blockCount, buffer.delayPerBlock, buffer.sweepWidth, buffer.blurStrength, buffer.ratio, buffer.rgbOffset, tDiffuse, tDiffuseSmplr, buffer.neonColor1, buffer.neonColor2);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

