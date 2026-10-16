#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float intensity;
    float opacity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 sucaiTexCoord [[user(sucaiTexCoord)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> sucaiImageTexture [[texture(0)]], sampler sucaiImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 sucai = sucaiImageTexture.sample(sucaiImageTextureSmplr, in.sucaiTexCoord);
    out.gl_FragColor = float4(sucai.xyz, buffer.intensity * buffer.opacity);
    return out;
}

