#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float rotate;
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
float2 _f0(thread float2& _p0, thread const float& _p1)
{
    float _17 = sin(_p1);
    float _20 = cos(_p1);
    _p0 -= float2(0.5);
    _p0 = float2x2(float2(_20, _17), float2(-_17, _20)) * _p0;
    _p0 += float2(0.5);
    return _p0;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> inputImageTexture [[texture(0)]], sampler inputImageTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _54 = (buffer.rotate * 3.141592502593994140625) / 180.0;
    float2 param = in.v_uv;
    float param_1 = _54;
    float2 _62 = _f0(param, param_1);
    float2 _79 = ((_62 - float2(0.5)) * (abs(cos(_54)) + abs(sin(_54)))) + float2(0.5);
    out.o_fragColor = inputImageTexture.sample(inputImageTextureSmplr, _79);
    if (any(_79 != fast::clamp(_79, float2(0.0), float2(1.0))))
    {
        out.o_fragColor.w = 0.0;
    }
    return out;
}

