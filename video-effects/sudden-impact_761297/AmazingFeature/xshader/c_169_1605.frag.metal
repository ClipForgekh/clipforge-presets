#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float uIntensity;
    float uTime;
    float uBrightness;
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
float hash(thread const float& n)
{
    return fract(sin(n) * 43758.546875);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> uTexture [[texture(0)]], sampler uTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float2 center = float2(0.5);
    float shakeAmp = 0.0500000007450580596923828125 * buffer.uIntensity;
    float param = buffer.uTime;
    float param_1 = buffer.uTime + 1.0;
    float2 shake = float2(sin((buffer.uTime * 30.0) + hash(param)) * shakeAmp, cos((buffer.uTime * 35.0) + hash(param_1)) * shakeAmp);
    uv += shake;
    float2 dir = uv - center;
    float blurStrength = 0.1500000059604644775390625 * buffer.uIntensity;
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    for (int i = 0; i < 12; i++)
    {
        float t = float(i) / 11.0;
        float2 sampleUv = uv - ((dir * t) * blurStrength);
        float weight = 1.0 - (t * 0.5);
        color += (uTexture.sample(uTextureSmplr, fast::clamp(sampleUv, float2(0.0), float2(1.0))) * weight);
        totalWeight += weight;
    }
    color /= float4(totalWeight);
    float4 _133 = color;
    float3 _135 = _133.xyz * buffer.uBrightness;
    color.x = _135.x;
    color.y = _135.y;
    color.z = _135.z;
    out.gl_FragColor = color;
    return out;
}

