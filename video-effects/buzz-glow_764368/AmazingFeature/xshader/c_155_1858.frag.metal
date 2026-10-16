#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float u_blurRadiusY;
    float ratio;
    float u_flashRadius;
    float u_flashIntensity;
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
float4 verticalBlurSample(thread const float2& uv, thread const float& radiusPx, constant float2& u_resolution, texture2d<float> texture1, sampler texture1Smplr)
{
    float pxToUv = 1.0 / fast::max(u_resolution.y, 1.0);
    float offset = radiusPx * pxToUv;
    float4 c = float4(0.0);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, (-4.0) * offset))) * 0.0599999986588954925537109375);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, (-3.0) * offset))) * 0.0900000035762786865234375);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, (-2.0) * offset))) * 0.119999997317790985107421875);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, (-1.0) * offset))) * 0.1500000059604644775390625);
    c += (texture1.sample(texture1Smplr, uv) * 0.1599999964237213134765625);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, 1.0 * offset))) * 0.1500000059604644775390625);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, 2.0 * offset))) * 0.119999997317790985107421875);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, 3.0 * offset))) * 0.0900000035762786865234375);
    c += (texture1.sample(texture1Smplr, (uv + float2(0.0, 4.0 * offset))) * 0.0599999986588954925537109375);
    return c;
}

static inline __attribute__((always_inline))
float3 screenBlend(thread const float3& baseColor, thread const float3& blendColor)
{
    return float3(1.0) - ((float3(1.0) - baseColor) * (float3(1.0) - blendColor));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = fast::max(buffer.u_blurRadiusY, 0.0);
    float4 baseColor = verticalBlurSample(param, param_1, buffer.u_resolution, texture1, texture1Smplr);
    float2 center = float2(0.5);
    float2 d = in.vUv - center;
    if (buffer.ratio > 1.0)
    {
        d.y /= buffer.ratio;
    }
    else
    {
        d.x *= buffer.ratio;
    }
    float dist = length(d);
    float flashMask = 1.0 - smoothstep(0.0, buffer.u_flashRadius, dist);
    float flashValue = fast::clamp(flashMask * buffer.u_flashIntensity, 0.0, 1.0);
    float3 flashColor = float3(flashValue);
    float3 param_2 = baseColor.xyz;
    float3 param_3 = flashColor;
    float3 finalRgb = screenBlend(param_2, param_3);
    out.gl_FragColor = float4(finalRgb, baseColor.w);
    return out;
}

