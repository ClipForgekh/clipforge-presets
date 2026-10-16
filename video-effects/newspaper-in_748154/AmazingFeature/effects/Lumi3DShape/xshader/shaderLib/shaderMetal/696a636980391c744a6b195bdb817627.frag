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
    float2 u_uvScale;
    int u_uvWrapMode;
    int u_maskChannel;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_mask [[texture(1)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_maskSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _20 = fma(in.v_uv - float2(0.5), buffer.u_uvScale, float2(0.5));
    float2 _130;
    if (buffer.u_uvWrapMode == 1)
    {
        _130 = fract(_20);
    }
    else
    {
        float2 _131;
        if (buffer.u_uvWrapMode == 2)
        {
            _131 = abs(mod(_20 + float2(1.0), float2(2.0)) - float2(1.0));
        }
        else
        {
            _131 = _20;
        }
        _130 = _131;
    }
    float4 _57 = u_inputTexture.sample(u_inputTextureSmplr, _130);
    float4 inputMask = u_mask.sample(u_maskSmplr, in.v_uv);
    bool _68 = _130.x > 1.0;
    bool _76;
    if (!_68)
    {
        _76 = _130.x < 0.0;
    }
    else
    {
        _76 = _68;
    }
    bool _84;
    if (!_76)
    {
        _84 = _130.y > 1.0;
    }
    else
    {
        _84 = _76;
    }
    bool _91;
    if (!_84)
    {
        _91 = _130.y < 0.0;
    }
    else
    {
        _91 = _84;
    }
    float4 _134;
    if (_91)
    {
        float4 _138;
        if (buffer.u_uvWrapMode == 3)
        {
            _138 = float4(0.0);
        }
        else
        {
            float4 _139;
            if (buffer.u_uvWrapMode == 4)
            {
                _139 = float4(1.0);
            }
            else
            {
                bool _110 = buffer.u_uvWrapMode == 5;
                if (_110)
                {
                    inputMask = float4(0.0);
                }
                _139 = select(_57, float4(0.0), bool4(_110));
            }
            _138 = _139;
        }
        _134 = _138;
    }
    else
    {
        _134 = _57;
    }
    out.o_fragColor = float4(_134.xyz, inputMask[buffer.u_maskChannel]);
    return out;
}

