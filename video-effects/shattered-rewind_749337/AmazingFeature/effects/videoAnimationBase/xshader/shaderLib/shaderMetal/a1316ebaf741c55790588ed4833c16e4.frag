#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_blendAlpha;
    float u_prograss;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_blendTex [[texture(0)]], texture2d<float> u_bgTex [[texture(1)]], texture2d<float> u_videoTex [[texture(2)]], sampler u_blendTexSmplr [[sampler(0)]], sampler u_bgTexSmplr [[sampler(1)]], sampler u_videoTexSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _29 = u_videoTex.sample(u_videoTexSmplr, in.v_uv);
    float4 _t2 = _29;
    float _44 = _t2.w;
    float4 _48 = float4((u_blendTex.sample(u_blendTexSmplr, in.v_uv).xyz * buffer.u_blendAlpha) + _29.xyz, _44);
    _t2 = _48;
    out.o_fragColor = mix(_48, u_bgTex.sample(u_bgTexSmplr, in.v_uv), float4(buffer.u_prograss));
    return out;
}

