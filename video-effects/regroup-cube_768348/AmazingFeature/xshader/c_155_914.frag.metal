#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 repeat;
    float2 offset;
    float u_chromatic;
    float u_grayscale;
    float u_brightness;
    float opacity;
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
    float2 mappedUv = (in.vUv * buffer.repeat) + buffer.offset;
    float2 dir = mappedUv - float2(0.5);
    float chromaOffset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = texture1.sample(texture1Smplr, (mappedUv + (dir * chromaOffset))).x;
    float g = texture1.sample(texture1Smplr, mappedUv).y;
    float b = texture1.sample(texture1Smplr, (mappedUv - (dir * chromaOffset))).z;
    float4 texColor = float4(r, g, b, texture1.sample(texture1Smplr, mappedUv).w);
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _84 = texColor;
    float3 _91 = mix(_84.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _91.x;
    texColor.y = _91.y;
    texColor.z = _91.z;
    float4 _100 = texColor;
    float3 _102 = _100.xyz * buffer.u_brightness;
    texColor.x = _102.x;
    texColor.y = _102.y;
    texColor.z = _102.z;
    texColor.w *= buffer.opacity;
    out.gl_FragColor = texColor;
    return out;
}

