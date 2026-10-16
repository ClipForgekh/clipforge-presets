#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_resolution;
    float u_blurRadiusPx;
    float u_exposureGain;
    float u_glowAddIntensity;
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
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusPx, constant float2& u_resolution)
{
    if (radiusPx <= 9.9999997473787516355514526367188e-05)
    {
        return tex.sample(texSmplr, uv);
    }
    float2 texel = float2(1.0 / fast::max(u_resolution.x, 1.0), 1.0 / fast::max(u_resolution.y, 1.0));
    float2 stepUV = texel * radiusPx;
    float4 color = float4(0.0);
    color += (tex.sample(texSmplr, (uv + (float2(-1.0) * stepUV))) * 0.0625);
    color += (tex.sample(texSmplr, (uv + (float2(0.0, -1.0) * stepUV))) * 0.125);
    color += (tex.sample(texSmplr, (uv + (float2(1.0, -1.0) * stepUV))) * 0.0625);
    color += (tex.sample(texSmplr, (uv + (float2(-1.0, 0.0) * stepUV))) * 0.125);
    color += (tex.sample(texSmplr, uv) * 0.25);
    color += (tex.sample(texSmplr, (uv + (float2(1.0, 0.0) * stepUV))) * 0.125);
    color += (tex.sample(texSmplr, (uv + (float2(-1.0, 1.0) * stepUV))) * 0.0625);
    color += (tex.sample(texSmplr, (uv + (float2(0.0, 1.0) * stepUV))) * 0.125);
    color += (tex.sample(texSmplr, (uv + (float2(1.0) * stepUV))) * 0.0625);
    return color;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadiusPx;
    float4 blurColor = gaussianBlur9(texture1, texture1Smplr, param, param_1, buffer.u_resolution);
    float3 exposed = blurColor.xyz * buffer.u_exposureGain;
    float3 glowAdd = fast::max(exposed - blurColor.xyz, float3(0.0)) * buffer.u_glowAddIntensity;
    float3 finalRgb = exposed + glowAdd;
    out.gl_FragColor = float4(finalRgb, blurColor.w);
    return out;
}

