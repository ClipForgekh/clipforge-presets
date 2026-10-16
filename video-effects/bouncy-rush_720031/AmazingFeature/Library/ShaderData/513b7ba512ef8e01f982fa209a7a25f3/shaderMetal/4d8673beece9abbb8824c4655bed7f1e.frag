#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(uv0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> mainTex [[texture(0)]], sampler mainTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    out.gl_FragColor = mainTex.sample(mainTexSmplr, in.uv0);
    return out;
}

