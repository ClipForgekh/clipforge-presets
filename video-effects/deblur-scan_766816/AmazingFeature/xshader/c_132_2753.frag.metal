#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float stripCount;
    float stripDelay;
    float maxBlurPx;
    float pixelToUv;
    float tintStrength;
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
float4 verticalBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusUV)
{
    float4 c = float4(0.0);
    float2 param = uv + float2(0.0, (-4.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param)) * 0.0500000007450580596923828125);
    float2 param_1 = uv + float2(0.0, (-3.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_1)) * 0.0900000035762786865234375);
    float2 param_2 = uv + float2(0.0, (-2.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_2)) * 0.119999997317790985107421875);
    float2 param_3 = uv + float2(0.0, (-1.0) * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_3)) * 0.1500000059604644775390625);
    float2 param_4 = uv;
    c += (tex.sample(texSmplr, handleUVBounds(param_4)) * 0.180000007152557373046875);
    float2 param_5 = uv + float2(0.0, 1.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_5)) * 0.1500000059604644775390625);
    float2 param_6 = uv + float2(0.0, 2.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_6)) * 0.119999997317790985107421875);
    float2 param_7 = uv + float2(0.0, 3.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_7)) * 0.0900000035762786865234375);
    float2 param_8 = uv + float2(0.0, 4.0 * radiusUV);
    c += (tex.sample(texSmplr, handleUVBounds(param_8)) * 0.0500000007450580596923828125);
    return c;
}

static inline __attribute__((always_inline))
float4 effect(thread const float4& texel, thread const float& p, constant float& stripCount, thread float2& vUv, constant float& stripDelay, constant float& maxBlurPx, constant float& pixelToUv, texture2d<float> tDiffuse, sampler tDiffuseSmplr, constant float& tintStrength)
{
    float n = fast::max(stripCount, 1.0);
    float idx = floor(vUv.x * n);
    idx = fast::clamp(idx, 0.0, n - 1.0);
    float totalDelay = stripDelay * fast::max(n - 1.0, 0.0);
    float duration = fast::max(1.0 - totalDelay, 9.9999997473787516355514526367188e-05);
    float start = idx * stripDelay;
    float lp = fast::clamp((p - start) / duration, 0.0, 1.0);
    float lpWarp = sqrt(lp);
    float clearK = smoothstep(0.0, 1.0, lpWarp);
    float blurK = 1.0 - clearK;
    float radiusUV = (maxBlurPx * pixelToUv) * blurK;
    float2 param = vUv;
    float param_1 = radiusUV;
    float4 blurred = verticalBlur9(tDiffuse, tDiffuseSmplr, param, param_1);
    float tintGate = 1.0 - smoothstep(0.959999978542327880859375, 1.0, p);
    float scan = 0.5 + (0.5 * sin((vUv.y * 900.0) + (idx * 0.699999988079071044921875)));
    float tint = (tintStrength * tintGate) * (0.85000002384185791015625 + (0.1500000059604644775390625 * scan));
    float3 color = blurred.xyz + (float3(-0.3499999940395355224609375, 0.2199999988079071044921875, 0.449999988079071044921875) * tint);
    color = fast::clamp(color, float3(0.0), float3(1.0));
    return float4(color, blurred.w);
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
    float4 effectColor = effect(param_1, param_2, buffer.stripCount, in.vUv, buffer.stripDelay, buffer.maxBlurPx, buffer.pixelToUv, tDiffuse, tDiffuseSmplr, buffer.tintStrength);
    float4 finalColor = effectColor;
    out.gl_FragColor = finalColor;
    return out;
}

