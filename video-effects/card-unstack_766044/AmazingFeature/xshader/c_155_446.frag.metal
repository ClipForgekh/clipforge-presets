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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> uTexture [[texture(0)]], sampler uTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 texColor = uTexture.sample(uTextureSmplr, in.vUv);
    float gray = dot(texColor.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
    float4 _30 = texColor;
    float3 _38 = mix(_30.xyz, float3(gray), float3(buffer.u_grayscale));
    texColor.x = _38.x;
    texColor.y = _38.y;
    texColor.z = _38.z;
    float4 _51 = texColor;
    float3 _53 = _51.xyz * buffer.u_brightness;
    texColor.x = _53.x;
    texColor.y = _53.y;
    texColor.z = _53.z;
    out.gl_FragColor = texColor;
    return out;
}

