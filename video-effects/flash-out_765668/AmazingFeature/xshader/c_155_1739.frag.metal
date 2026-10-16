#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uResolution;
    float ratio;
    float blurRadiusPx;
    float exposureGain;
    float yellowTintMix;
    float fadeToBlack;
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
float4 sampleBlurredColor(thread const float2& uv, thread const float& radiusPx, constant float2& uResolution, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    float2 texel = float2(1.0) / fast::max(uResolution, float2(1.0));
    float2 offset = float2(radiusPx) * texel;
    float2 offsetY = float2(offset.x, offset.y / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float4 c = float4(0.0);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * 0.20000000298023223876953125);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(offset.x, 0.0), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(-offset.x, 0.0), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, offsetY.y), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, -offsetY.y), float2(0.0), float2(1.0))) * 0.119999997317790985107421875);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(offset.x, offsetY.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(-offset.x, offsetY.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(offset.x, -offsetY.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    c += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(-offset.x, -offsetY.y), float2(0.0), float2(1.0))) * 0.07999999821186065673828125);
    return c;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.blurRadiusPx;
    float4 baseColor = sampleBlurredColor(param, param_1, buffer.uResolution, buffer.ratio, texture1, texture1Smplr);
    float4 _198 = baseColor;
    float3 _200 = _198.xyz * buffer.exposureGain;
    baseColor.x = _200.x;
    baseColor.y = _200.y;
    baseColor.z = _200.z;
    float3 brightYellow = float3(0.949999988079071044921875, 0.85000002384185791015625, 0.3499999940395355224609375) * buffer.exposureGain;
    float4 _216 = baseColor;
    float3 _222 = mix(_216.xyz, brightYellow, float3(buffer.yellowTintMix));
    baseColor.x = _222.x;
    baseColor.y = _222.y;
    baseColor.z = _222.z;
    float4 _229 = baseColor;
    float3 _235 = mix(_229.xyz, float3(0.0), float3(buffer.fadeToBlack));
    baseColor.x = _235.x;
    baseColor.y = _235.y;
    baseColor.z = _235.z;
    out.gl_FragColor = float4(baseColor.xyz, 1.0);
    return out;
}

