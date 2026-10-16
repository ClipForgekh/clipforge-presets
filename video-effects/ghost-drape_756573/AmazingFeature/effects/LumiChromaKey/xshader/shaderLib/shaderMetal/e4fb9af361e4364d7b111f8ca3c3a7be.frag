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

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_blurTexture [[texture(1)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_blurTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _t1 = u_blurTexture.sample(u_blurTextureSmplr, in.v_uv);
    float3 _t2 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv).xyz * _t1.w;
    if (_t1.w < 0.001000000047497451305389404296875)
    {
        _t2 = float3(0.0);
    }
    out.o_fragColor = float4(_t2, _t1.w);
    return out;
}

