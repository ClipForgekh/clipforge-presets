#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float2 u_uvScale;
    float2 u_uvOffset;
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

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_texture [[texture(0)]], sampler u_textureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 mappedUv = (in.vUv * buffer.u_uvScale) + buffer.u_uvOffset;
    float4 texColor = u_texture.sample(u_textureSmplr, mappedUv);
    float4 _34 = texColor;
    float3 _36 = _34.xyz * buffer.u_brightness;
    texColor.x = _36.x;
    texColor.y = _36.y;
    texColor.z = _36.z;
    out.gl_FragColor = texColor;
    return out;
}

