#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_Reverse;
    float u_Alpha;
    float3 u_Color;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_InputTexture [[texture(0)]], sampler u_InputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    out.o_fragColor = float4(buffer.u_Color, 1.0) * (abs(buffer.u_Reverse - u_InputTexture.sample(u_InputTextureSmplr, in.v_uv).w) * buffer.u_Alpha);
    return out;
}

