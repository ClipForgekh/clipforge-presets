#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_binary;
    float u_threshold;
    float u_grayrange;
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
    float _24 = _t0.w;
    float3 _31 = _19.xyz / float3(fast::max(_24, 0.001000000047497451305389404296875));
    _t0.x = _31.x;
    _t0.y = _31.y;
    _t0.z = _31.z;
    if (buffer.u_binary > 0.5)
    {
        if (dot(_t0.xyz, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)) < buffer.u_threshold)
        {
            out.o_fragColor = float4(0.0, 0.0, 0.0, 1.0) * _t0.w;
        }
        else
        {
            out.o_fragColor = float4(1.0) * _t0.w;
        }
    }
    else
    {
        out.o_fragColor = float4(float3(fast::max((dot(_t0.xyz, float3(0.333000004291534423828125)) - buffer.u_threshold) / fast::max(buffer.u_grayrange, 0.001000000047497451305389404296875), fast::min((fast::max(_t0.x, fast::max(_t0.y, _t0.z)) - fast::min(_t0.x, fast::min(_t0.y, _t0.z))) * 5.0, 1.0))), 1.0);
    }
    return out;
}

