#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uvScale;
    float2 uvOffset;
    float u_blurStrength;
    float2 u_blurDirection;
    float u_brightness;
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
float2 getMappedUv(thread const float2& uv, constant float2& uvScale, constant float2& uvOffset)
{
    return (uv * uvScale) + uvOffset;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.vUv;
    float2 mappedUv = getMappedUv(param, buffer.uvScale, buffer.uvOffset);
    float4 sum = float4(0.0);
    float totalWeight = 0.0;
    float radius = 0.180000007152557373046875 * buffer.u_blurStrength;
    float stepScale = 1.0 + (11.0 * buffer.u_blurStrength);
    for (int i = -8; i <= 8; i++)
    {
        float fi = float(i);
        float weight = 1.0 - (abs(fi) / 8.0);
        float2 offset = (((buffer.u_blurDirection * fi) * radius) * stepScale) / float2(8.0);
        float2 sampleUv = fast::clamp(mappedUv + offset, float2(0.0), float2(1.0));
        sum += (texture1.sample(texture1Smplr, sampleUv) * weight);
        totalWeight += weight;
    }
    float4 texColor = sum / float4(fast::max(totalWeight, 9.9999997473787516355514526367188e-05));
    float4 _115 = texColor;
    float3 _117 = _115.xyz * buffer.u_brightness;
    texColor.x = _117.x;
    texColor.y = _117.y;
    texColor.z = _117.z;
    out.gl_FragColor = texColor;
    return out;
}

