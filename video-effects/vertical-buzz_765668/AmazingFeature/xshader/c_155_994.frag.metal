#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_stretchAmount;
    float u_maxOffset;
    float ratio;
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
    float stretch = buffer.u_stretchAmount * buffer.u_maxOffset;
    float yStep = stretch / fast::max(buffer.ratio, 9.9999997473787516355514526367188e-05);
    float4 sum = float4(0.0);
    float total = 0.0;
    for (int i = -8; i <= 8; i++)
    {
        float fi = float(i);
        float w = 1.0 - (abs(fi) / 8.0);
        float2 sampleUv = float2(in.vUv.x, fast::clamp(in.vUv.y + (fi * yStep), 0.0, 1.0));
        sum += (texture1.sample(texture1Smplr, sampleUv) * w);
        total += w;
    }
    float4 blurColor = sum / float4(fast::max(total, 9.9999997473787516355514526367188e-05));
    float centerBand = smoothstep(0.5, 0.0, abs(in.vUv.x - 0.5));
    float bandGain = mix(1.0, 0.3499999940395355224609375 + (centerBand * 1.25), buffer.u_stretchAmount);
    float4 finalColor = blurColor;
    float4 _112 = finalColor;
    float3 _114 = _112.xyz * bandGain;
    finalColor.x = _114.x;
    finalColor.y = _114.y;
    finalColor.z = _114.z;
    out.gl_FragColor = finalColor;
    return out;
}

