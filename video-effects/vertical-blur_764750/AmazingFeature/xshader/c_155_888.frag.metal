#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blurRadiusY;
    float ratio;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> texture1 [[texture(0)]], sampler texture1Smplr [[sampler(0)]])
{
    main0_out out = {};
    float2 uv = in.vUv;
    float4 color = float4(0.0);
    float totalWeight = 0.0;
    float radius = fast::max(buffer.u_blurRadiusY, 0.0);
    float texelY = 0.0009765625;
    texelY /= fast::max(buffer.ratio, 9.9999997473787516355514526367188e-05);
    for (int i = -9; i <= 9; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 10.0);
        float2 offset = float2(0.0, (fi * texelY) * radius);
        float2 sampleUv = fast::clamp(uv + offset, float2(0.0), float2(1.0));
        color += (texture1.sample(texture1Smplr, sampleUv) * w);
        totalWeight += w;
    }
    float4 texColor = color / float4(fast::max(totalWeight, 9.9999997473787516355514526367188e-05));
    float4 _96 = texColor;
    float3 _98 = _96.xyz * buffer.u_brightness;
    texColor.x = _98.x;
    texColor.y = _98.y;
    texColor.z = _98.z;
    out.gl_FragColor = texColor;
    return out;
}

