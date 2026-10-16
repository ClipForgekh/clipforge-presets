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
    int sliceCount;
    float delayPerSlice;
    float maxGlitch;
    float maxStretch;
    float maxBlur;
    float neonStrength;
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
float random(thread const float& seed)
{
    return fract(sin(seed) * 43758.546875);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlur(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurRadius)
{
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    float steps = 5.0;
    for (float i = -2.0; i <= 2.0; i += 1.0)
    {
        float weight = 1.0 - (abs(i) / 3.0);
        float2 offset = float2(0.0, (i * blurRadius) / steps);
        float2 param = uv + offset;
        float2 sampleUV = handleUVBounds(param);
        color += (tex.sample(texSmplr, sampleUV) * weight);
        totalWeight += weight;
    }
    return color / float4(totalWeight);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant int& sliceCount, thread float2& vUv, constant float& delayPerSlice, constant float& maxGlitch, constant float& maxStretch, constant float& maxBlur, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& neonStrength, constant float4& neonColor1, constant float4& neonColor2)
{
    float sliceFloat = float(sliceCount);
    float sliceWidth = 1.0 / sliceFloat;
    float sliceIndex = floor(vUv.x / sliceWidth);
    float slicePos = fract(vUv.x / sliceWidth);
    float maxTotalDelay = (sliceFloat - 1.0) * delayPerSlice;
    float sliceDelay = sliceIndex * delayPerSlice;
    float localProgress = fast::clamp((progress - sliceDelay) / (1.0 - maxTotalDelay), 0.0, 1.0);
    float param = localProgress;
    float tweenedProgress = tween(param);
    float effectStrength = 1.0 - tweenedProgress;
    float glitchSeed = (sliceIndex * 1234.5670166015625) + (progress * 1000.0);
    float param_1 = glitchSeed;
    float glitchRandom = random(param_1);
    float _179;
    if (glitchRandom > 0.949999988079071044921875)
    {
        _179 = (((glitchRandom - 0.949999988079071044921875) * 2.0) * maxGlitch) * effectStrength;
    }
    else
    {
        _179 = 0.0;
    }
    float glitchOffset = _179;
    float isOdd = mod(sliceIndex, 2.0);
    float direction = (isOdd > 0.5) ? (-1.0) : 1.0;
    float yOffset = (direction * effectStrength) * 1.2000000476837158203125;
    float stretch = effectStrength * maxStretch;
    float2 sampleUV = vUv;
    sampleUV.x += glitchOffset;
    sampleUV.y = (0.5 + ((sampleUV.y - 0.5) / (1.0 + stretch))) + yOffset;
    float2 param_2 = sampleUV;
    sampleUV = handleUVBounds(param_2);
    float blurRadius = effectStrength * maxBlur;
    float2 param_3 = sampleUV;
    float param_4 = blurRadius;
    float4 blurredColor = verticalBlur(tDiffuse, tDiffuseSmplr, param_3, param_4);
    float edgeDistance = fast::min(slicePos, 1.0 - slicePos);
    float neonMask = (smoothstep(0.0, 0.100000001490116119384765625, 0.100000001490116119384765625 - edgeDistance) * effectStrength) * neonStrength;
    float4 neonColor = mix(neonColor1, neonColor2, float4(vUv.y));
    float4 neonGlow = neonColor * neonMask;
    float alpha = 0.300000011920928955078125 + (0.699999988079071044921875 * tweenedProgress);
    float4 finalColor = blurredColor + neonGlow;
    finalColor.w *= alpha;
    return mix(finalColor, texel, float4(step(1.0, progress)));
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
    float4 effectColor = effect(param_1, param_2, buffer.sliceCount, in.vUv, buffer.delayPerSlice, buffer.maxGlitch, buffer.maxStretch, buffer.maxBlur, tDiffuse, tDiffuseSmplr, buffer.neonStrength, buffer.neonColor1, buffer.neonColor2);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

