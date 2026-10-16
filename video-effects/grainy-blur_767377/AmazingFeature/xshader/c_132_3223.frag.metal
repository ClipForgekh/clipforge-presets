#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float heatStrength;
    float glowIntensity;
    float waveAmplitude;
    float noiseScale;
    float3 glowColor;
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
float _noise(thread const float2& p)
{
    return fract(sin(dot(p, float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875);
}

static inline __attribute__((always_inline))
float turbulence(thread const float2& p)
{
    float val = 0.0;
    float freq = 1.0;
    for (int i = 0; i < 3; i++)
    {
        float2 param = p * freq;
        val += (abs((_noise(param) * 2.0) - 1.0) / freq);
        freq *= 2.0;
    }
    return val;
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, constant float& ratio, constant float& heatStrength, constant float& glowIntensity, thread float2& vUv, constant float& waveAmplitude, constant float& noiseScale, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float3& glowColor)
{
    float phaseTotal = (progress * 2.0) * 3.1415927410125732421875;
    float phaseUpper = phaseTotal;
    float phaseMiddle = phaseTotal + 2.094395160675048828125;
    float phaseLower = phaseTotal + 4.18879032135009765625;
    float dynamicFactor = sin(progress * 3.1415927410125732421875);
    float currentHeat = dynamicFactor * heatStrength;
    float currentGlow = dynamicFactor * glowIntensity;
    float2 param = vUv;
    float2 param_1 = float2(0.5);
    float2 p = getSDFCoordinate(param, param_1, ratio);
    float dist = length(p);
    float upperWave = (sin(phaseUpper + (dist * 3.0)) * waveAmplitude) * smoothstep(0.300000011920928955078125, 0.5, dist);
    float middleWave = (sin(phaseMiddle + (dist * 5.0)) * waveAmplitude) * smoothstep(0.5, 0.699999988079071044921875, dist);
    float lowerWave = (sin(phaseLower + (dist * 7.0)) * waveAmplitude) * smoothstep(0.699999988079071044921875, 1.0, dist);
    float totalWave = (upperWave + middleWave) + lowerWave;
    float2 param_2 = (vUv * noiseScale) + float2(progress * 0.5, 0.0);
    float2 param_3 = (vUv * noiseScale) + float2(0.0, progress * 0.5);
    float2 heatOffset = (float2(turbulence(param_2), turbulence(param_3)) * currentHeat) - float2(currentHeat * 0.5);
    float2 uv = (vUv + (fast::normalize(p + float2(9.9999997473787516355514526367188e-05)) * totalWave)) + heatOffset;
    float2 param_4 = uv;
    uv = handleUVBounds(param_4);
    float4 baseColor = tDiffuse.sample(tDiffuseSmplr, uv);
    float edgeMask = smoothstep(0.800000011920928955078125, 0.20000000298023223876953125, dist) - smoothstep(0.89999997615814208984375, 0.100000001490116119384765625, dist);
    edgeMask *= (1.0 + (sin(phaseTotal + (dist * 10.0)) * 0.20000000298023223876953125));
    float3 glow = (glowColor * edgeMask) * currentGlow;
    float3 finalRGB = baseColor.xyz + glow;
    return float4(finalRGB, baseColor.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.heatStrength, buffer.glowIntensity, in.vUv, buffer.waveAmplitude, buffer.noiseScale, tDiffuse, tDiffuseSmplr, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

