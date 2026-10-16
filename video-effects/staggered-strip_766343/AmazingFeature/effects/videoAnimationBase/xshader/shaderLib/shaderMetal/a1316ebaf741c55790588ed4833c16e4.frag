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

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_videoTex [[texture(0)]], texture2d<float> u_inputTex [[texture(1)]], sampler u_videoTexSmplr [[sampler(0)]], sampler u_inputTexSmplr [[sampler(1)]])
{
    main0_out out = {};
    out.o_fragColor = u_videoTex.sample(u_videoTexSmplr, in.v_uv);
    out.o_fragColor.w = u_inputTex.sample(u_inputTexSmplr, in.v_uv).w;
    return out;
}

