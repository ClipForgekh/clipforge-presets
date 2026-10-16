#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float ratio;
    float u_stretchY;
    float u_blurRadiusY;
    float u_fadeToBlack;
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
float4 sampleVerticalBlur(thread const float2& uv, thread const float& radiusY, constant float& ratio, texture2d<float> texture1, sampler texture1Smplr)
{
    float4 sum = float4(0.0);
    float total = 0.0;
    float stepY = (0.0199999995529651641845703125 * radiusY) / fast::max(ratio, 9.9999997473787516355514526367188e-05);
    float w0 = 0.227026998996734619140625;
    float w1 = 0.19459460675716400146484375;
    float w2 = 0.121621601283550262451171875;
    float w3 = 0.054053999483585357666015625;
    float w4 = 0.01621600054204463958740234375;
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv, float2(0.0), float2(1.0))) * w0);
    total += w0;
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 1.0 * stepY), float2(0.0), float2(1.0))) * w1);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, 1.0 * stepY), float2(0.0), float2(1.0))) * w1);
    total += (2.0 * w1);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 2.0 * stepY), float2(0.0), float2(1.0))) * w2);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, 2.0 * stepY), float2(0.0), float2(1.0))) * w2);
    total += (2.0 * w2);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 3.0 * stepY), float2(0.0), float2(1.0))) * w3);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, 3.0 * stepY), float2(0.0), float2(1.0))) * w3);
    total += (2.0 * w3);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv + float2(0.0, 4.0 * stepY), float2(0.0), float2(1.0))) * w4);
    sum += (texture1.sample(texture1Smplr, fast::clamp(uv - float2(0.0, 4.0 * stepY), float2(0.0), float2(1.0))) * w4);
    total += (2.0 * w4);
    return sum / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = float2(in.vUv.x, ((in.vUv.y - 0.5) / fast::max(buffer.u_stretchY, 9.9999997473787516355514526367188e-05)) + 0.5);
    mappedUv = fast::clamp(mappedUv, float2(0.0), float2(1.0));
    float2 param = mappedUv;
    float param_1 = buffer.u_blurRadiusY;
    float4 texColor = sampleVerticalBlur(param, param_1, buffer.ratio, texture1, texture1Smplr);
    float4 _228 = texColor;
    float3 _235 = mix(_228.xyz, float3(0.0), float3(fast::clamp(buffer.u_fadeToBlack, 0.0, 1.0)));
    texColor.x = _235.x;
    texColor.y = _235.y;
    texColor.z = _235.z;
    out.gl_FragColor = float4(texColor.xyz, 1.0);
    return out;
}

