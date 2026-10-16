#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float scaleOffset;
    float stretchStrength;
    float liftAmount;
    float blurStrength;
    float glowStrength;
    float exposureStrength;
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
float tween(thread const float& p)
{
    return 1.0 - pow(1.0 - p, 2.0);
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 directionalVerticalBlur(thread const float2& uv, thread const float& stepY, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 o1 = float2(0.0, stepY);
    float2 o2 = float2(0.0, stepY * 2.0);
    float2 o3 = float2(0.0, stepY * 3.0);
    float4 c = float4(0.0);
    float2 param = uv;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.2800000011920928955078125);
    float2 param_1 = uv + o1;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.20000000298023223876953125);
    float2 param_2 = uv - o1;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.20000000298023223876953125);
    float2 param_3 = uv + o2;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.119999997317790985107421875);
    float2 param_4 = uv - o2;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.119999997317790985107421875);
    float2 param_5 = uv + o3;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.039999999105930328369140625);
    float2 param_6 = uv - o3;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.039999999105930328369140625);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& progress, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& scaleOffset, constant float& stretchStrength, thread float2& vUv, constant float& liftAmount, constant float& blurStrength, constant float& glowStrength, constant float& exposureStrength, constant float3& glowColor)
{
    float strength = 1.0 - progress;
    float scale = fast::max(1.0 - (scaleOffset * strength), 0.001000000047497451305389404296875);
    float stretch = 1.0 + (stretchStrength * strength);
    float2 uvRaw = float2(0.5) + ((vUv - float2(0.5)) / float2(scale));
    uvRaw.y = 0.5 + ((uvRaw.y - 0.5) / stretch);
    uvRaw.y += (liftAmount * strength);
    float2 param = uvRaw;
    float borderMask = getHardBoundaryMask(param);
    float2 param_1 = uvRaw;
    float2 uv = handleUVBounds(param_1);
    float stepY = (blurStrength * strength) * 0.00120000005699694156646728515625;
    float2 param_2 = uv;
    float param_3 = stepY;
    float4 blurredTexel = directionalVerticalBlur(param_2, param_3, tDiffuse, tDiffuseSmplr);
    float glowBase = fast::max(fast::max(blurredTexel.x, blurredTexel.y), blurredTexel.z);
    float glow = (pow(glowBase, 1.60000002384185791015625) * glowStrength) * strength;
    float3 color = blurredTexel.xyz;
    color *= (1.0 + ((exposureStrength * 0.5) * strength));
    color += (glowColor * glow);
    color = fast::clamp(color, float3(0.0), float3(1.0));
    float fadeIn = smoothstep(0.0, 0.1599999964237213134765625, progress);
    float outAlpha = (texel.w * borderMask) * fadeIn;
    return float4(color, outAlpha);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, buffer.scaleOffset, buffer.stretchStrength, in.vUv, buffer.liftAmount, buffer.blurStrength, buffer.glowStrength, buffer.exposureStrength, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

