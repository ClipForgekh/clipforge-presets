#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float maxScale;
    float maxBlurPx;
    float maxExposure;
    float3 warmColor;
    float maxSaturation;
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
    return 1.0 - pow(1.0 - p, 3.0);
}

static inline __attribute__((always_inline))
float2 handleUVBounds(thread const float2& uv)
{
    return fast::clamp(uv, float2(0.0), float2(1.0));
}

static inline __attribute__((always_inline))
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& blurPx, constant float& ratio)
{
    if (blurPx <= 9.9999997473787516355514526367188e-05)
    {
        float4 _104 = tex.sample(texSmplr, uv);
        return _104;
    }
    float stepBase = blurPx * 0.00120000005699694156646728515625;
    float2 delta = float2(stepBase, stepBase / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    float2 param = uv + float2(-delta.x, -delta.y);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0625);
    float2 param_1 = uv + float2(0.0, -delta.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.125);
    float2 param_2 = uv + float2(delta.x, -delta.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.0625);
    float2 param_3 = uv + float2(-delta.x, 0.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.125);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.25);
    float2 param_5 = uv + float2(delta.x, 0.0);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.125);
    float2 param_6 = uv + float2(-delta.x, delta.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.0625);
    float2 param_7 = uv + float2(0.0, delta.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.125);
    float2 param_8 = uv + float2(delta.x, delta.y);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0625);
    return c;
}

static inline __attribute__((always_inline))
float3 adjustSaturation(thread const float3& color, thread const float& sat)
{
    float luma = dot(color, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    return mix(float3(luma), color, float3(sat));
}

static inline __attribute__((always_inline))
float getHardBoundaryMask(thread const float2& uv)
{
    return ((step(0.0, uv.x) * step(uv.x, 1.0)) * step(0.0, uv.y)) * step(uv.y, 1.0);
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& ratio, constant float& maxScale, thread float2& vUv, constant float& maxBlurPx, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& maxExposure, constant float3& warmColor, constant float& maxSaturation)
{
    float strength = 1.0 - p;
    float scale = mix(1.0, maxScale, strength);
    float invScale = 1.0 / fast::max(scale, 9.9999997473787516355514526367188e-05);
    float2 uv = float2(0.5) + ((vUv - float2(0.5)) * invScale);
    float2 param = uv;
    float2 boundedUV = handleUVBounds(param);
    float blurPx = maxBlurPx * strength;
    float2 param_1 = boundedUV;
    float param_2 = blurPx;
    float4 col = gaussianBlur9(tDiffuse, tDiffuseSmplr, param_1, param_2, ratio);
    float exposure = mix(1.0, maxExposure, strength);
    float4 _291 = col;
    float3 _293 = _291.xyz * exposure;
    col.x = _293.x;
    col.y = _293.y;
    col.z = _293.z;
    float warmAmount = 0.449999988079071044921875 * strength;
    float4 _305 = col;
    float4 _307 = col;
    float3 _315 = mix(_305.xyz, _307.xyz * warmColor, float3(warmAmount));
    col.x = _315.x;
    col.y = _315.y;
    col.z = _315.z;
    float sat = mix(1.0, maxSaturation, strength);
    float3 param_3 = col.xyz;
    float param_4 = sat;
    float3 _332 = adjustSaturation(param_3, param_4);
    col.x = _332.x;
    col.y = _332.y;
    col.z = _332.z;
    float4 _339 = col;
    float3 _343 = fast::clamp(_339.xyz, float3(0.0), float3(1.0));
    col.x = _343.x;
    col.y = _343.y;
    col.z = _343.z;
    float2 param_5 = vUv;
    float borderMask = getHardBoundaryMask(param_5);
    return float4(col.xyz, col.w * borderMask);
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
    float4 effectColor = effect(param_1, param_2, buffer.ratio, buffer.maxScale, in.vUv, buffer.maxBlurPx, tDiffuse, tDiffuseSmplr, buffer.maxExposure, buffer.warmColor, buffer.maxSaturation);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

