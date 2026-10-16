#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float w;
    float h;
    float strength;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0, thread const float2& _p1, thread const float& _p2)
{
    return length(fast::max((abs(_p0) - _p1) + float2(_p2), float2(0.0))) - _p2;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputImageTexture [[texture(0)]], sampler u_inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _37 = float2(buffer.w, buffer.h);
    float2 _t1 = _37;
    float2 _44 = _37 / float2(2.0);
    float2 param = (in.v_uv * _37) - _44;
    float2 param_1 = _44;
    float param_2 = buffer.strength * _t1.x;
    out.o_fragColor = u_inputImageTexture.sample(u_inputImageTextureSmplr, in.v_uv) * (1.0 - smoothstep(0.0, 0.0, _f0(param, param_1, param_2)));
    return out;
}

