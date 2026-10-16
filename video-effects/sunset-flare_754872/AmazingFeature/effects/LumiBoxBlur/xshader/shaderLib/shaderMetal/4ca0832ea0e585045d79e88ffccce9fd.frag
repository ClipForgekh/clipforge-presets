#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_sampleX;
    float u_stepX;
    int u_borderType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.u_sampleX < 9.9999997473787516355514526367188e-06)
    {
        out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, in.uv0);
        return out;
    }
    float _t1 = 1.0;
    float4 _t2 = u_inputTexture.sample(u_inputTextureSmplr, in.uv0) * 1.0;
    float2 _t3 = in.uv0;
    for (int _t4 = 1; _t4 <= 1024; _t4++)
    {
        float _58 = float(_t4);
        if (_58 > buffer.u_sampleX)
        {
            break;
        }
        float _69 = _58 * buffer.u_stepX;
        _t3.x = in.uv0.x - _69;
        if (_t3.x < 0.0)
        {
            if (buffer.u_borderType == 1)
            {
                _t3.x = 0.0;
                _t2 += u_inputTexture.sample(u_inputTextureSmplr, _t3);
                _t1 += 1.0;
            }
            else
            {
                if (buffer.u_borderType == 2)
                {
                    _t1 += 1.0;
                }
                else
                {
                    if (buffer.u_borderType == 3)
                    {
                        _t3.x = -_t3.x;
                        _t2 += u_inputTexture.sample(u_inputTextureSmplr, _t3);
                        _t1 += 1.0;
                    }
                }
            }
        }
        else
        {
            _t2 += u_inputTexture.sample(u_inputTextureSmplr, _t3);
            _t1 += 1.0;
        }
        _t3.x = in.uv0.x + _69;
        if (_t3.x > 1.0)
        {
            if (buffer.u_borderType == 1)
            {
                _t3.x = 1.0;
                _t2 += u_inputTexture.sample(u_inputTextureSmplr, _t3);
                _t1 += 1.0;
            }
            else
            {
                if (buffer.u_borderType == 2)
                {
                    _t1 += 1.0;
                }
                else
                {
                    if (buffer.u_borderType == 3)
                    {
                        _t3.x = 2.0 - _t3.x;
                        _t2 += u_inputTexture.sample(u_inputTextureSmplr, _t3);
                        _t1 += 1.0;
                    }
                }
            }
        }
        else
        {
            _t2 += u_inputTexture.sample(u_inputTextureSmplr, _t3);
            _t1 += 1.0;
        }
    }
    float4 _188 = _t2;
    float4 _190 = _188 / float4(_t1);
    _t2 = _190;
    out.o_fragColor = _190;
    return out;
}

