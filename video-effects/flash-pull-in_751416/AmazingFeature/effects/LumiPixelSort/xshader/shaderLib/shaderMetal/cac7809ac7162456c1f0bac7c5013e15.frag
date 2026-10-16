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

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> maskTexture [[texture(0)]], sampler maskTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _t0 = maskTexture.sample(maskTextureSmplr, in.v_uv);
    float2 _t1 = float2(0.00390625);
    _t1.y = 0.0;
    float4 _t2 = float4(0.0);
    float _t3 = 0.0;
    if (_t0.x < 0.5)
    {
        out.o_fragColor = _t2;
        return out;
    }
    for (float _t4 = 1.0; _t4 < 256.0; _t4 += 1.0)
    {
        float2 _59 = in.v_uv - (_t1 * _t4);
        if (any(_59 != fast::clamp(_59, float2(0.0), float2(1.0))))
        {
            break;
        }
        float4 _t6 = maskTexture.sample(maskTextureSmplr, _59);
        if (_t6.x < 0.5)
        {
            break;
        }
        _t2.x = _t4;
        if (_t6.y <= _t0.y)
        {
            _t3 += 1.0;
        }
    }
    for (float _t7 = 1.0; _t7 < 256.0; _t7 += 1.0)
    {
        float2 _107 = in.v_uv + (_t1 * _t7);
        if (any(_107 != fast::clamp(_107, float2(0.0), float2(1.0))))
        {
            break;
        }
        float4 _t9 = maskTexture.sample(maskTextureSmplr, _107);
        if (_t9.x < 0.5)
        {
            break;
        }
        _t2.y = _t7;
        if (_t9.y < _t0.y)
        {
            _t3 += 1.0;
        }
    }
    _t2.z = fast::clamp(_t3, 0.0, 255.0);
    _t2.w = fast::clamp(_t3 - 255.0, 0.0, 255.0);
    out.o_fragColor = _t2 / float4(255.0);
    return out;
}

