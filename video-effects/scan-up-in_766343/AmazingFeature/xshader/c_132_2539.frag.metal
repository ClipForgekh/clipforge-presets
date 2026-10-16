#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float blurAmount;
    float ratio;
    float3 glowColor;
    float glowIntensity;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& blurAmount, constant float& ratio, thread float2& vUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float3& glowColor, constant float& glowIntensity)
{
    float inv = 1.0 - p;
    float blurStrength = inv * blurAmount;
    float yStep = (0.0040000001899898052215576171875 * blurStrength) / fast::max(ratio, 0.5);
    float2 param = vUv;
    float2 uv0 = handleUVBounds(param);
    float2 param_1 = vUv + float2(0.0, yStep);
    float2 uv1 = handleUVBounds(param_1);
    float2 param_2 = vUv - float2(0.0, yStep);
    float2 uv2 = handleUVBounds(param_2);
    float2 param_3 = vUv + float2(0.0, yStep * 2.0);
    float2 uv3 = handleUVBounds(param_3);
    float2 param_4 = vUv - float2(0.0, yStep * 2.0);
    float2 uv4 = handleUVBounds(param_4);
    float2 param_5 = vUv + float2(0.0, yStep * 3.0);
    float2 uv5 = handleUVBounds(param_5);
    float2 param_6 = vUv - float2(0.0, yStep * 3.0);
    float2 uv6 = handleUVBounds(param_6);
    float2 param_7 = vUv + float2(0.0, yStep * 4.0);
    float2 uv7 = handleUVBounds(param_7);
    float2 param_8 = vUv - float2(0.0, yStep * 4.0);
    float2 uv8 = handleUVBounds(param_8);
    float4 blurred = ((((((((tDiffuse.sample(tDiffuseSmplr, uv0) * 0.2199999988079071044921875) + (tDiffuse.sample(tDiffuseSmplr, uv1) * 0.189999997615814208984375)) + (tDiffuse.sample(tDiffuseSmplr, uv2) * 0.189999997615814208984375)) + (tDiffuse.sample(tDiffuseSmplr, uv3) * 0.119999997317790985107421875)) + (tDiffuse.sample(tDiffuseSmplr, uv4) * 0.119999997317790985107421875)) + (tDiffuse.sample(tDiffuseSmplr, uv5) * 0.070000000298023223876953125)) + (tDiffuse.sample(tDiffuseSmplr, uv6) * 0.070000000298023223876953125)) + (tDiffuse.sample(tDiffuseSmplr, uv7) * 0.00999999977648258209228515625)) + (tDiffuse.sample(tDiffuseSmplr, uv8) * 0.00999999977648258209228515625);
    float4 base = mix(blurred, texel, float4(p));
    float wipeY = p;
    float edgeSoft = mix(0.1599999964237213134765625, 0.00999999977648258209228515625, p);
    float reveal = smoothstep(-edgeSoft, edgeSoft, (wipeY - vUv.y) + edgeSoft);
    float bandWidth = mix(0.119999997317790985107421875, 0.0199999995529651641845703125, p);
    float edgeBand = exp((-abs(vUv.y - wipeY)) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05));
    float glowMask = edgeBand * inv;
    float3 glow = (glowColor * glowIntensity) * glowMask;
    float3 rgb = float3(1.0) - ((float3(1.0) - base.xyz) * (float3(1.0) - fast::clamp(glow, float3(0.0), float3(1.5))));
    rgb = fast::clamp(rgb * reveal, float3(0.0), float3(1.0));
    return float4(rgb, base.w * reveal);
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
    float4 effectColor = effect(param_1, param_2, buffer.blurAmount, buffer.ratio, in.vUv, tDiffuse, tDiffuseSmplr, buffer.glowColor, buffer.glowIntensity);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

