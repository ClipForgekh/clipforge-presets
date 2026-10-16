#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_h;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv [[user(uv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> ganTexture [[texture(0)]], sampler ganTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 resultColor = ganTexture.sample(ganTextureSmplr, in.uv);
    resultColor.w *= buffer.u_h;
    out.gl_FragColor = resultColor;
    return out;
}

