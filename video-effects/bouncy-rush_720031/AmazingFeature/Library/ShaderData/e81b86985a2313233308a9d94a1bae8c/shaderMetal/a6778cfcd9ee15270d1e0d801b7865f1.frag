#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv [[user(uv)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_videoTex [[texture(0)]], sampler u_videoTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    out.gl_FragColor = u_videoTex.sample(u_videoTexSmplr, in.uv);
    return out;
}

