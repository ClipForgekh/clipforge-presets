#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurRadiusY;
    float2 u_resolution;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float radiusUV = buffer.u_blurRadiusY / fast::max(buffer.u_resolution.y, 1.0);
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    for (int i = -10; i <= 10; i++)
    {
        float fi = float(i);
        float t = abs(fi) / 10.0;
        float w = 1.0 - t;
        float2 sampleUv = float2(uv.x, uv.y + (fi * radiusUV));
        sampleUv = fast::clamp(sampleUv, float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * w);
        totalWeight += w;
    }
    color /= float4(fast::max(totalWeight, 9.9999997473787516355514526367188e-05));
    float4 _98 = color;
    float3 _100 = _98.xyz * buffer.u_exposure;
    color.x = _100.x;
    color.y = _100.y;
    color.z = _100.z;
    out.gl_FragColor = color;
    return out;
}

