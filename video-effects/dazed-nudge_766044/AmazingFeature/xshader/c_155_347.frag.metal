#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
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
    float2 mappedUv = in.vUv;
    float4 texColor = texture1.sample(texture1Smplr, mappedUv);
    float4 _27 = texColor;
    float3 _29 = _27.xyz * buffer.u_brightness;
    texColor.x = _29.x;
    texColor.y = _29.y;
    texColor.z = _29.z;
    out.gl_FragColor = texColor;
    return out;
}

