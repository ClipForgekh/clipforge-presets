#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float ratio;
    float u_blurRadiusPx;
    float u_timeNorm;
    float u_glowIntensity;
    float u_exposure;
    float3 u_glowColor;
    float u_brightness;
    float u_occlusionAlpha;
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
float3 getVerticalBlurColor(thread const float2& uv, thread const float& radiusPx, constant float2& u_resolution, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    float3 sum = float3(0.0);
    float total = 0.0;
    float stepY = (radiusPx / fast::max(u_resolution.y, 1.0)) / fast::max(ratio, 9.9999997473787516355514526367188e-05);
    for (int i = -8; i <= 8; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 8.0);
        w = fast::max(w, 0.0);
        float2 sampleUv = float2(uv.x, fast::clamp(uv.y + (fi * stepY), 0.0, 1.0));
        sum += (texture1.sample(texture1Smplr, sampleUv).xyz * w);
        total += w;
    }
    return sum / float3(fast::max(total, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 baseTexel = texture1.sample(texture1Smplr, uv);
    float2 param = uv;
    float param_1 = buffer.u_blurRadiusPx;
    float3 blurColor = getVerticalBlurColor(param, param_1, buffer.u_resolution, buffer.ratio, texture1, texture1Smplr);
    float bottomMask = 1.0 - smoothstep(0.0, 0.85000002384185791015625, uv.y);
    float upwardSpread = 1.0 - smoothstep(0.0, 1.0, uv.y - (buffer.u_timeNorm * 0.3499999940395355224609375));
    float glowMask = (bottomMask * upwardSpread) * buffer.u_glowIntensity;
    float3 effectColor = (blurColor * buffer.u_exposure) + (buffer.u_glowColor * glowMask);
    effectColor *= buffer.u_brightness;
    float trigger = smoothstep(0.0, 0.0500000007450580596923828125, buffer.u_timeNorm);
    float3 triggeredEffect = effectColor * trigger;
    float occ = fast::clamp(buffer.u_occlusionAlpha, 0.0, 1.0);
    float3 finalRgb = mix(baseTexel.xyz, triggeredEffect, float3(occ));
    out.gl_FragColor = float4(finalRgb, 1.0);
    return out;
}

