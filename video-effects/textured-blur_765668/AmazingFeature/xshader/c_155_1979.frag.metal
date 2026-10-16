#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_blurRadius;
    float u_exposureGain;
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
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radius, constant float& ratio)
{
    float4 color = float4(0.0);
    float total = 0.0;
    float baseStep = 0.00150000001303851604461669921875 * radius;
    float2 stepSize = float2(baseStep, baseStep / fast::max(ratio, 9.9999997473787516355514526367188e-05));
    float2 o0 = float2(0.0);
    float2 o1 = float2(1.0, 0.0) * stepSize;
    float2 o2 = float2(-1.0, 0.0) * stepSize;
    float2 o3 = float2(0.0, 1.0) * stepSize;
    float2 o4 = float2(0.0, -1.0) * stepSize;
    float2 o5 = float2(1.0) * stepSize;
    float2 o6 = float2(-1.0, 1.0) * stepSize;
    float2 o7 = float2(1.0, -1.0) * stepSize;
    float2 o8 = float2(-1.0) * stepSize;
    float w0 = 4.0;
    float w1 = 2.0;
    float w2 = 2.0;
    float w3 = 2.0;
    float w4 = 2.0;
    float w5 = 1.0;
    float w6 = 1.0;
    float w7 = 1.0;
    float w8 = 1.0;
    color += (tex.sample(texSmplr, fast::clamp(uv + o0, float2(0.0), float2(1.0))) * w0);
    total += w0;
    color += (tex.sample(texSmplr, fast::clamp(uv + o1, float2(0.0), float2(1.0))) * w1);
    total += w1;
    color += (tex.sample(texSmplr, fast::clamp(uv + o2, float2(0.0), float2(1.0))) * w2);
    total += w2;
    color += (tex.sample(texSmplr, fast::clamp(uv + o3, float2(0.0), float2(1.0))) * w3);
    total += w3;
    color += (tex.sample(texSmplr, fast::clamp(uv + o4, float2(0.0), float2(1.0))) * w4);
    total += w4;
    color += (tex.sample(texSmplr, fast::clamp(uv + o5, float2(0.0), float2(1.0))) * w5);
    total += w5;
    color += (tex.sample(texSmplr, fast::clamp(uv + o6, float2(0.0), float2(1.0))) * w6);
    total += w6;
    color += (tex.sample(texSmplr, fast::clamp(uv + o7, float2(0.0), float2(1.0))) * w7);
    total += w7;
    color += (tex.sample(texSmplr, fast::clamp(uv + o8, float2(0.0), float2(1.0))) * w8);
    total += w8;
    return color / float4(total);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadius;
    float4 texColor = gaussianBlur9(texture1, texture1Smplr, param, param_1, buffer.ratio);
    float4 _240 = texColor;
    float3 _242 = _240.xyz * buffer.u_exposureGain;
    texColor.x = _242.x;
    texColor.y = _242.y;
    texColor.z = _242.z;
    out.gl_FragColor = texColor;
    return out;
}

