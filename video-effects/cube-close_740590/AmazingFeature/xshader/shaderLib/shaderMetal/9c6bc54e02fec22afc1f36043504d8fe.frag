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

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_inputTexture0 [[texture(0)]], texture2d<float> u_inputTexture1 [[texture(1)]], sampler u_inputTexture0Smplr [[sampler(0)]], sampler u_inputTexture1Smplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _t0 = u_inputTexture0.sample(u_inputTexture0Smplr, in.v_uv);
    float4 _24 = u_inputTexture1.sample(u_inputTexture1Smplr, in.v_uv);
    if (in.v_uv.y < 0.5)
    {
        _t0 = float4(0.0);
    }
    float4 _37 = _t0;
    float _43 = _t0.w;
    float4 _46 = _37 + (_24 * (1.0 - _43));
    _t0 = _46;
    out.o_fragColor = _46;
    return out;
}

