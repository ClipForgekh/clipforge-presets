#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float offset;
    float offsetRandom;
    float maxLength;
    float randomSeed;
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
float _f0(thread const float2& _p0)
{
    float2 _17 = fract(_p0 * 1324.5179443359375);
    float2 _t0 = _17 + float2(dot(_17, _17.yx + float2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> maskTexture [[texture(0)]], sampler maskTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _t1 = maskTexture.sample(maskTextureSmplr, in.v_uv);
    float2 _t2 = float2(0.00390625);
    _t2.y = 0.0;
    float _t3 = 0.0;
    float _t4 = 0.0;
    if (_t1.x < 0.5)
    {
        out.o_fragColor = _t1;
        return out;
    }
    if (((buffer.offset < 0.001000000047497451305389404296875) && (buffer.offsetRandom < 0.001000000047497451305389404296875)) && (buffer.maxLength >= 0.999000012874603271484375))
    {
        out.o_fragColor = _t1;
        return out;
    }
    for (float _t5 = 1.0; _t5 < 256.0; _t5 += 1.0)
    {
        float2 _106 = in.v_uv - (_t2 * _t5);
        if (any(_106 != fast::clamp(_106, float2(0.0), float2(1.0))))
        {
            break;
        }
        float4 _t7 = maskTexture.sample(maskTextureSmplr, _106);
        if (_t7.x < 0.5)
        {
            break;
        }
        _t3 = _t5;
    }
    for (float _t8 = 1.0; _t8 < 256.0; _t8 += 1.0)
    {
        float2 _144 = in.v_uv + (_t2 * _t8);
        if (any(_144 != fast::clamp(_144, float2(0.0), float2(1.0))))
        {
            break;
        }
        float4 _t10 = maskTexture.sample(maskTextureSmplr, _144);
        if (_t10.x < 0.5)
        {
            break;
        }
        _t4 = _t8;
    }
    float _172 = (_t3 + _t4) + 1.0;
    float2 param = float2(_172 + buffer.randomSeed, _172);
    float _190 = _172 * (buffer.offset + ((_f0(param) - 0.5) * buffer.offsetRandom));
    bool _193 = _t3 < _190;
    bool _204;
    if (!_193)
    {
        _204 = _t3 > (_190 + (_172 * buffer.maxLength));
    }
    else
    {
        _204 = _193;
    }
    if (_204)
    {
        _t1.x = 0.0;
    }
    out.o_fragColor = _t1;
    return out;
}

