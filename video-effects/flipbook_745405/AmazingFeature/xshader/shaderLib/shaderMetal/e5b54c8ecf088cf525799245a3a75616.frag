#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_sizex;
    float u_sizey;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_bgTex [[texture(0)]], sampler u_bgTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t0 = in.uv0 - float2(0.5);
    _t0.x *= buffer.u_sizex;
    _t0.y *= buffer.u_sizey;
    float2 _33 = _t0;
    float2 _35 = _33 + float2(0.5);
    _t0 = _35;
    out.o_fragColor = u_bgTex.sample(u_bgTexSmplr, _35);
    return out;
}

