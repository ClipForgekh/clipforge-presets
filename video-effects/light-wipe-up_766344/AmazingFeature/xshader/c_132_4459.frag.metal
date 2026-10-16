#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float blurMax;
    float chromaAmount;
    float3 glowColor;
    float glowStrength;
    float wipeSoftness;
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
float4 verticalBlurRGB(thread const float2& uv, thread const float& radius, thread const float& chromaOffset, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 stepY = float2(0.0, radius);
    float2 offR = float2(0.0, chromaOffset);
    float2 offB = float2(0.0, -chromaOffset);
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    float3 c = float3(0.0);
    float2 param = uv;
    float2 uv0 = handleUVBounds(param);
    float2 param_1 = uv + (stepY * 1.0);
    float2 uv1p = handleUVBounds(param_1);
    float2 param_2 = uv - (stepY * 1.0);
    float2 uv1n = handleUVBounds(param_2);
    float2 param_3 = uv + (stepY * 2.0);
    float2 uv2p = handleUVBounds(param_3);
    float2 param_4 = uv - (stepY * 2.0);
    float2 uv2n = handleUVBounds(param_4);
    float2 param_5 = uv + (stepY * 3.0);
    float2 uv3p = handleUVBounds(param_5);
    float2 param_6 = uv - (stepY * 3.0);
    float2 uv3n = handleUVBounds(param_6);
    float2 param_7 = uv + (stepY * 4.0);
    float2 uv4p = handleUVBounds(param_7);
    float2 param_8 = uv - (stepY * 4.0);
    float2 uv4n = handleUVBounds(param_8);
    float2 param_9 = uv0 + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_9)).x * w0);
    float2 param_10 = uv1p + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_10)).x * w1);
    float2 param_11 = uv1n + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_11)).x * w1);
    float2 param_12 = uv2p + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_12)).x * w2);
    float2 param_13 = uv2n + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_13)).x * w2);
    float2 param_14 = uv3p + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_14)).x * w3);
    float2 param_15 = uv3n + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_15)).x * w3);
    float2 param_16 = uv4p + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_16)).x * w4);
    float2 param_17 = uv4n + offR;
    c.x += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_17)).x * w4);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv0).y * w0);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv1p).y * w1);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv1n).y * w1);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv2p).y * w2);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv2n).y * w2);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv3p).y * w3);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv3n).y * w3);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv4p).y * w4);
    c.y += (tDiffuse.sample(tDiffuseSmplr, uv4n).y * w4);
    float2 param_18 = uv0 + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_18)).z * w0);
    float2 param_19 = uv1p + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_19)).z * w1);
    float2 param_20 = uv1n + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_20)).z * w1);
    float2 param_21 = uv2p + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_21)).z * w2);
    float2 param_22 = uv2n + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_22)).z * w2);
    float2 param_23 = uv3p + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_23)).z * w3);
    float2 param_24 = uv3n + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_24)).z * w3);
    float2 param_25 = uv4p + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_25)).z * w4);
    float2 param_26 = uv4n + offB;
    c.z += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_26)).z * w4);
    float a = tDiffuse.sample(tDiffuseSmplr, uv0).w;
    return float4(c, a);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, texture2d<float> tDiffuse, sampler tDiffuseSmplr, thread float2& vUv, constant float& blurMax, constant float& chromaAmount, constant float3& glowColor, constant float& glowStrength, constant float& wipeSoftness)
{
    if (progress >= 0.99989998340606689453125)
    {
        return texel;
    }
    float strength = 1.0 - progress;
    float bottomBias = pow(1.0 - vUv.y, 1.60000002384185791015625);
    float blurRadius = (blurMax * strength) * (0.75 + (0.25 * bottomBias));
    float chroma = (chromaAmount * strength) * (0.60000002384185791015625 + (0.4000000059604644775390625 * bottomBias));
    float2 param = vUv;
    float param_1 = blurRadius;
    float param_2 = chroma;
    float4 blurred = verticalBlurRGB(param, param_1, param_2, tDiffuse, tDiffuseSmplr);
    float glowMask = bottomBias * (0.5 + (0.5 * strength));
    float3 glow = (((blurred.xyz * glowColor) * glowStrength) * strength) * glowMask;
    float3 combined = blurred.xyz + glow;
    combined = mix(combined, texel.xyz, float3(progress));
    float reveal = progress;
    float edge = fast::max(0.001000000047497451305389404296875, wipeSoftness * (0.300000011920928955078125 + (0.699999988079071044921875 * strength)));
    float wipe = smoothstep(vUv.y - edge, vUv.y + edge, reveal);
    float3 finalRgb = mix(float3(0.0), combined, float3(wipe));
    float finalA = texel.w * wipe;
    return float4(fast::clamp(finalRgb, float3(0.0), float3(1.0)), finalA);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, in.vUv, buffer.blurMax, buffer.chromaAmount, buffer.glowColor, buffer.glowStrength, buffer.wipeSoftness);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

