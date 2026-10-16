#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_intensity;
    float u_lowerLimit;
    float u_upperLimit;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _19 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t0 = _19;
    float _51 = mix(fast::max(fast::max(_t0.x, _t0.y), _t0.z), ((_t0.x + _t0.y) + _t0.z) / 3.0, buffer.u_intensity);
    if (_51 < buffer.u_lowerLimit)
    {
        out.o_fragColor = float4(0.0);
    }
    else
    {
        if (_51 > buffer.u_upperLimit)
        {
            out.o_fragColor = float4(_19.xyz, 1.0);
        }
        else
        {
            out.o_fragColor = float4(_19.xyz, (_51 - buffer.u_lowerLimit) / (buffer.u_upperLimit - buffer.u_lowerLimit));
        }
    }
    return out;
}

