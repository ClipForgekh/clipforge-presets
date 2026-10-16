#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float maxBlur;
    float glowStrength;
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
    return smoothstep(0.0, 1.0, p);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 verticalBlurSample(thread const float2& uv, thread const float& blurAmount, texture2d<float> tDiffuse, sampler tDiffuseSmplr)
{
    float2 o = float2(0.0, blurAmount);
    float4 c = float4(0.0);
    float2 param = uv - (o * 4.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param)) * 0.0500000007450580596923828125);
    float2 param_1 = uv - (o * 3.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv - (o * 2.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv - (o * 1.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_4)) * 0.180000007152557373046875);
    float2 param_5 = uv + (o * 1.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + (o * 2.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + (o * 3.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + (o * 4.0);
    c += (tDiffuse.sample(tDiffuseSmplr, handleUVBounds(param_8)) * 0.0500000007450580596923828125);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& maxBlur, thread float2& vUv, constant float& glowStrength, constant float3& glowColor)
{
    float strength = 1.0 - smoothstep(0.300000011920928955078125, 1.0, p);
    float blurAmount = maxBlur * strength;
    float stretch = 0.119999997317790985107421875 * strength;
    float2 uv = vUv;
    uv.y = 0.5 + ((vUv.y - 0.5) * (1.0 + stretch));
    float2 param = uv;
    uv = handleUVBounds(param);
    float2 param_1 = uv;
    float param_2 = blurAmount;
    float4 blurred = verticalBlurSample(param_1, param_2, tDiffuse, tDiffuseSmplr);
    float reveal = smoothstep(0.0, 0.3499999940395355224609375, p);
    float3 baseColor = blurred.xyz * reveal;
    float scanY = mix(-0.25, 1.25, p);
    float rise = smoothstep(0.0, 0.300000011920928955078125, p);
    float fall = 1.0 - smoothstep(0.300000011920928955078125, 1.0, p);
    float pulse = rise * fall;
    float bandWidth = mix(0.039999999105930328369140625, 0.3499999940395355224609375, rise) * fast::max(0.0500000007450580596923828125, fall);
    float d = (vUv.y - scanY) / fast::max(bandWidth, 9.9999997473787516355514526367188e-05);
    float band = exp((-d) * d);
    float glow = (band * glowStrength) * pulse;
    float3 color = baseColor + (glowColor * glow);
    return float4(fast::clamp(color, float3(0.0), float3(1.0)), texel.w);
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
    float4 effectColor = effect(param_1, param_2, tDiffuse, tDiffuseSmplr, buffer.maxBlur, in.vUv, buffer.glowStrength, buffer.glowColor);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

