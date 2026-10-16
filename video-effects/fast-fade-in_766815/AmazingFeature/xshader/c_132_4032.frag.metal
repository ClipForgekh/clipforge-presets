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
    float outlineThreshold;
    float particleSize;
    float particleFlowSpeed;
    float bleedStrength;
    float3 goldColor;
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
    return 0.5 * (1.0 + sin((progress - 0.5) * 3.1415927410125732421875));
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float getGray(thread const float3& color)
{
    return dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float sobelEdgeDetection(thread const float2& uv, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& outlineThreshold)
{
    float2 texel = float2(1.0 / (1000.0 * ratio), 0.001000000047497451305389404296875);
    spvUnsafeArray<float, 9> kernel0;
    kernel0[0] = -1.0;
    kernel0[1] = -2.0;
    kernel0[2] = -1.0;
    kernel0[3] = 0.0;
    kernel0[4] = 0.0;
    kernel0[5] = 0.0;
    kernel0[6] = 1.0;
    kernel0[7] = 2.0;
    kernel0[8] = 1.0;
    float gx = 0.0;
    float gy = 0.0;
    for (int i = -1; i <= 1; i++)
    {
        for (int j = -1; j <= 1; j++)
        {
            float2 param = uv + (float2(float(i), float(j)) * texel);
            float3 param_1 = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)).xyz;
            float gray = getGray(param_1);
            int idx = ((i + 1) * 3) + (j + 1);
            gx += (gray * kernel0[idx]);
            gy += (gray * kernel0[((j + 1) * 3) + (i + 1)]);
        }
    }
    float edge = sqrt((gx * gx) + (gy * gy));
    return smoothstep(outlineThreshold, outlineThreshold * 2.0, edge);
}

static inline __attribute__((always_inline))
float random(thread const float2& st)
{
    return fract(sin(dot(st, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float generateGoldParticles(thread const float2& uv, thread const float& edgeMask, thread const float& flowOffset, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& particleSize, constant float& particleFlowSpeed)
{
    float2 gridUV = uv / float2(particleSize * ratio, particleSize);
    gridUV.y += (flowOffset * particleFlowSpeed);
    float2 cellID = floor(gridUV);
    float2 cellUV = fract(gridUV) - float2(0.5);
    float2 param = cellID * float2(particleSize * ratio, particleSize);
    float cellEdge = tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)).w;
    if (cellEdge < 0.100000001490116119384765625)
    {
        return 0.0;
    }
    float2 param_1 = cellID;
    float rand = random(param_1);
    float particle = smoothstep(0.300000011920928955078125 + (rand * 0.300000011920928955078125), 0.0, length(cellUV));
    particle *= (rand * edgeMask);
    return particle;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& outlineThreshold, constant float& particleSize, constant float& particleFlowSpeed, thread float2& vUv, constant float& bleedStrength, constant float3& goldColor)
{
    if (progress >= 1.0)
    {
        return texel;
    }
    float param = progress;
    float t = tween(param);
    float2 param_1 = vUv;
    float edgeMask = sobelEdgeDetection(param_1, ratio, tDiffuse, tDiffuseSmplr, outlineThreshold);
    float flowOffset = fract(progress * 3.0);
    float2 param_2 = vUv;
    float param_3 = edgeMask;
    float param_4 = flowOffset;
    float particles = generateGoldParticles(param_2, param_3, param_4, ratio, tDiffuse, tDiffuseSmplr, particleSize, particleFlowSpeed);
    particles *= (1.0 - smoothstep(0.699999988079071044921875, 1.0, progress));
    float fillRange = smoothstep(0.20000000298023223876953125, 0.800000011920928955078125, t) * (1.0 + bleedStrength);
    float bleedMask = smoothstep(fillRange, fillRange - bleedStrength, edgeMask);
    float imageAlpha = smoothstep(0.20000000298023223876953125, 1.0, t) * bleedMask;
    float3 goldParticleColor = (goldColor * particles) * 1.5;
    float3 bleedColor = ((goldColor * bleedMask) * 0.300000011920928955078125) * (1.0 - smoothstep(0.699999988079071044921875, 1.0, progress));
    float3 finalColor = mix(float3(0.0), texel.xyz, float3(imageAlpha));
    finalColor = float3(1.0) - ((float3(1.0) - finalColor) * (float3(1.0) - goldParticleColor));
    finalColor = mix(finalColor, bleedColor, float3(0.300000011920928955078125 * (1.0 - imageAlpha)));
    return float4(finalColor, 1.0);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, tDiffuse, tDiffuseSmplr, buffer.outlineThreshold, buffer.particleSize, buffer.particleFlowSpeed, in.vUv, buffer.bleedStrength, buffer.goldColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

