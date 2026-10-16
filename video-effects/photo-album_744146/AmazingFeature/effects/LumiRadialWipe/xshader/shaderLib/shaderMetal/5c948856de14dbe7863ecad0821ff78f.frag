#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_mask [[texture(0)]], texture2d<float> u_inputTexture [[texture(1)]], sampler u_maskSmplr [[sampler(0)]], sampler u_inputTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _t0 = u_mask.sample(u_maskSmplr, in.v_uv);
    out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv) * _t0.x;
    return out;
}

