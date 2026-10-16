#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_verticalDistortStrength;
    float u_verticalBlurRadiusPx;
    float u_radialBlurStrength;
    float u_exposure;
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
float4 sampleVerticalBlur(thread const float2& uv, thread const float& radiusPx, texture2d<float> texture1, sampler texture1Smplr)
{
    float px = 0.00166666670702397823333740234375;
    float radius = radiusPx * px;
    float4 color = float4(0.0);
    float total = 0.0;
    for (int i = -6; i <= 6; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 6.0);
        float2 sampleUv = uv + float2(0.0, (fi * radius) / 6.0);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * w);
        total += w;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

static inline __attribute__((always_inline))
float4 sampleRadialBlur(thread const float2& uv, thread const float& strength, texture2d<float> texture1, sampler texture1Smplr, constant float& ratio)
{
    float2 center = float2(0.5);
    float2 dir = uv - center;
    if (ratio > 1.0)
    {
        dir.y /= ratio;
    }
    else
    {
        dir.x *= ratio;
    }
    float4 color = float4(0.0);
    float total = 0.0;
    for (int i = 0; i < 5; i++)
    {
        float t = float(i) / 4.0;
        float2 sampleUv = uv - (((dir * strength) * t) * 0.3499999940395355224609375);
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        float w = 1.0 - (t * 0.180000007152557373046875);
        color += (texture1.sample(texture1Smplr, sampleUv) * w);
        total += w;
    }
    return color / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float wave1 = (sin((uv.x * 22.0) + (uv.y * 8.0)) * 0.5) + 0.5;
    float wave2 = (sin((uv.x * 47.0) - (uv.y * 6.0)) * 0.5) + 0.5;
    float stripeMix = mix(wave1, wave2, 0.5);
    float verticalOffset = ((stripeMix - 0.5) * buffer.u_verticalDistortStrength) * 0.2199999988079071044921875;
    float2 distortedUv = uv + float2(0.0, verticalOffset);
    distortedUv = fast::clamp(distortedUv, float2(0.0), float2(1.0));
    float2 param = distortedUv;
    float param_1 = buffer.u_verticalBlurRadiusPx;
    float4 verticalBlurColor = sampleVerticalBlur(param, param_1, texture1, texture1Smplr);
    float2 param_2 = distortedUv;
    float param_3 = buffer.u_radialBlurStrength;
    float4 radialBlurColor = sampleRadialBlur(param_2, param_3, texture1, texture1Smplr, buffer.ratio);
    float radialMix = fast::clamp(buffer.u_radialBlurStrength / 0.180000007152557373046875, 0.0, 1.0) * 0.3499999940395355224609375;
    float4 texColor = mix(verticalBlurColor, radialBlurColor, float4(radialMix));
    float4 _251 = texColor;
    float3 _253 = _251.xyz * buffer.u_exposure;
    texColor.x = _253.x;
    texColor.y = _253.y;
    texColor.z = _253.z;
    out.gl_FragColor = float4(texColor.xyz, 1.0);
    return out;
}

