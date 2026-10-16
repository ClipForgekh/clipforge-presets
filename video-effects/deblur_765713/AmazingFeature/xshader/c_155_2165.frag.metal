#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_texSize;
    float ratio;
    float u_blurRadiusPx;
    float u_exposure;
    float u_reveal;
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
float4 gaussianBlur9(texture2d<float> tex, sampler texSmplr, thread const float2& uv, thread const float& radiusPx, constant float2& u_texSize, constant float& ratio)
{
    float2 texel = float2(1.0 / fast::max(u_texSize.x, 1.0), 1.0 / fast::max(u_texSize.y, 1.0));
    float2 stepSize = texel * radiusPx;
    stepSize.y /= fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float4 color = float4(0.0);
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    color += (tex.sample(texSmplr, uv) * w0);
    color += (tex.sample(texSmplr, (uv + (float2(stepSize.x, 0.0) * 1.0))) * w1);
    color += (tex.sample(texSmplr, (uv - (float2(stepSize.x, 0.0) * 1.0))) * w1);
    color += (tex.sample(texSmplr, (uv + (float2(0.0, stepSize.y) * 1.0))) * w1);
    color += (tex.sample(texSmplr, (uv - (float2(0.0, stepSize.y) * 1.0))) * w1);
    color += (tex.sample(texSmplr, (uv + (float2(stepSize.x, 0.0) * 2.0))) * w2);
    color += (tex.sample(texSmplr, (uv - (float2(stepSize.x, 0.0) * 2.0))) * w2);
    color += (tex.sample(texSmplr, (uv + (float2(0.0, stepSize.y) * 2.0))) * w2);
    color += (tex.sample(texSmplr, (uv - (float2(0.0, stepSize.y) * 2.0))) * w2);
    color += (tex.sample(texSmplr, (uv + (float2(stepSize.x, 0.0) * 3.0))) * w3);
    color += (tex.sample(texSmplr, (uv - (float2(stepSize.x, 0.0) * 3.0))) * w3);
    color += (tex.sample(texSmplr, (uv + (float2(0.0, stepSize.y) * 3.0))) * w3);
    color += (tex.sample(texSmplr, (uv - (float2(0.0, stepSize.y) * 3.0))) * w3);
    color += (tex.sample(texSmplr, (uv + (float2(stepSize.x, 0.0) * 4.0))) * w4);
    color += (tex.sample(texSmplr, (uv - (float2(stepSize.x, 0.0) * 4.0))) * w4);
    color += (tex.sample(texSmplr, (uv + (float2(0.0, stepSize.y) * 4.0))) * w4);
    color += (tex.sample(texSmplr, (uv - (float2(0.0, stepSize.y) * 4.0))) * w4);
    return color;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float param_1 = buffer.u_blurRadiusPx;
    float4 blurColor = gaussianBlur9(texture1, texture1Smplr, param, param_1, buffer.u_texSize, buffer.ratio);
    float4 _281 = blurColor;
    float3 _283 = _281.xyz * buffer.u_exposure;
    blurColor.x = _283.x;
    blurColor.y = _283.y;
    blurColor.z = _283.z;
    float4 _292 = blurColor;
    float3 _298 = mix(float3(0.0), _292.xyz, float3(fast::clamp(buffer.u_reveal, 0.0, 1.0)));
    blurColor.x = _298.x;
    blurColor.y = _298.y;
    blurColor.z = _298.z;
    out.gl_FragColor = float4(blurColor.xyz, 1.0);
    return out;
}

