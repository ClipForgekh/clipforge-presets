#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_chromatic;
    float uBrightness;
    float uAlpha;
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
    float2 dir = mappedUv - float2(0.5);
    float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, (mappedUv + (dir * offset))).x;
    float g = texture1.sample(texture1Smplr, mappedUv).y;
    float b = texture1.sample(texture1Smplr, (mappedUv - (dir * offset))).z;
    float4 texColor = float4(r, g, b, texture1.sample(texture1Smplr, mappedUv).w);
    float4 _71 = texColor;
    float3 _73 = _71.xyz * buffer.uBrightness;
    texColor.x = _73.x;
    texColor.y = _73.y;
    texColor.z = _73.z;
    texColor.w *= buffer.uAlpha;
    out.gl_FragColor = texColor;
    return out;
}

