#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_grayscale;
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
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _33 = texColor;
    float3 _41 = mix(_33.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _41.x;
    texColor.y = _41.y;
    texColor.z = _41.z;
    float4 _54 = texColor;
    float3 _56 = _54.xyz * buffer.u_brightness;
    texColor.x = _56.x;
    texColor.y = _56.y;
    texColor.z = _56.z;
    out.gl_FragColor = texColor;
    return out;
}

