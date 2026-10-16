#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 uUvScale;
    float2 uUvOffset;
    float u_chromatic;
    float u_grayscale;
    float u_brightness;
    float u_opacity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 vUv [[user(vUv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_texture [[texture(0)]], sampler u_textureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.uUvScale) + buffer.uUvOffset;
    float2 dir = mappedUv - float2(0.5);
    float offset = buffer.u_chromatic * 0.0199999995529651641845703125;
    float r = u_texture.sample(u_textureSmplr, (mappedUv + (dir * offset))).x;
    float g = u_texture.sample(u_textureSmplr, mappedUv).y;
    float b = u_texture.sample(u_textureSmplr, (mappedUv - (dir * offset))).z;
    float4 texColor = float4(r, g, b, u_texture.sample(u_textureSmplr, mappedUv).w);
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
    texColor.w *= buffer.u_opacity;
    out.gl_FragColor = texColor;
    return out;
}

