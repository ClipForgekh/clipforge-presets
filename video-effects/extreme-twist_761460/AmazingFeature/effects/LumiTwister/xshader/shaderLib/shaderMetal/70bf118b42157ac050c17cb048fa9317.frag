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

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_inputTexture1 [[texture(1)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_inputTexture1Smplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _19 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t0 = _19;
    out.o_fragColor = mix(_19, u_inputTexture1.sample(u_inputTexture1Smplr, in.v_uv), float4(1.0 - _t0.w));
    return out;
}

