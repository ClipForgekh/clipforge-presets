#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

struct buffer_t
{
    float reverseSort;
    float cycle;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> infoTexture [[texture(0)]], texture2d<float> maskTexture [[texture(1)]], texture2d<float> inputImageTexture [[texture(2)]], sampler infoTextureSmplr [[sampler(0)]], sampler maskTextureSmplr [[sampler(1)]], sampler inputImageTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float2 _t0 = float2(0.00390625);
    _t0.y = 0.0;
    float4 _t1 = infoTexture.sample(infoTextureSmplr, in.v_uv);
    float _34 = _t1.x * 255.0;
    float _38 = _t1.y * 255.0;
    float _t5 = _34;
    if (buffer.reverseSort > 0.5)
    {
        _t5 = _38;
    }
    float _65 = floor((_34 + _38) + 1.0);
    _t5 = mod(_t5 + (_65 * mod(buffer.cycle, 1.0)), _65);
    float4 _t6 = float4(0.0, 0.0, 0.0, 1.0);
    float4 _t7 = maskTexture.sample(maskTextureSmplr, in.v_uv);
    bool _86 = _t7.x < 0.5;
    bool _95;
    if (!_86)
    {
        _95 = abs(((_t1.z + _t1.w) * 255.0) - _t5) < 1.0;
    }
    else
    {
        _95 = _86;
    }
    if (_95)
    {
        float3 _103 = inputImageTexture.sample(inputImageTextureSmplr, in.v_uv).xyz;
        _t6.x = _103.x;
        _t6.y = _103.y;
        _t6.z = _103.z;
        out.o_fragColor = _t6;
        return out;
    }
    float _t8 = 0.0;
    float _t9 = 1024.0;
    float _t10 = 0.0;
    for (float _t11 = 1.0; _t11 < 256.0; _t11 += 1.0)
    {
        float2 _132 = in.v_uv - (_t0 * _t11);
        if (any(_132 != fast::clamp(_132, float2(0.0), float2(1.0))) || (_t11 > _34))
        {
            break;
        }
        float4 _t13 = infoTexture.sample(infoTextureSmplr, _132);
        float _163 = abs(((_t13.z + _t13.w) * 255.0) - _t5);
        if (_163 < 1.0)
        {
            _t8 = -_t11;
            _t10 = 1.0;
            break;
        }
        else
        {
            if (_163 < _t9)
            {
                _t9 = _163;
                _t8 = -_t11;
            }
        }
    }
    if (_t10 < 0.5)
    {
        for (float _t16 = 1.0; _t16 < 256.0; _t16 += 1.0)
        {
            float2 _199 = in.v_uv + (_t0 * _t16);
            if (any(_199 != fast::clamp(_199, float2(0.0), float2(1.0))) || (_t16 > _38))
            {
                break;
            }
            float4 _t18 = infoTexture.sample(infoTextureSmplr, _199);
            float _229 = abs(((_t18.z + _t18.w) * 255.0) - _t5);
            if (_229 < 1.0)
            {
                _t8 = _t16;
                _t10 = 1.0;
                break;
            }
            else
            {
                if (_229 < _t9)
                {
                    _t9 = _229;
                    _t8 = _t16;
                }
            }
        }
    }
    float3 _255 = inputImageTexture.sample(inputImageTextureSmplr, (in.v_uv + (_t0 * _t8))).xyz;
    _t6.x = _255.x;
    _t6.y = _255.y;
    _t6.z = _255.z;
    out.o_fragColor = _t6;
    return out;
}

