#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_opacity;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(v_uv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_src [[texture(0)]], sampler u_srcSmplr [[sampler(0)]])
{
    main0_out out = {};
    out.gl_FragColor = u_src.sample(u_srcSmplr, in.v_uv) * buffer.u_opacity;
    return out;
}

