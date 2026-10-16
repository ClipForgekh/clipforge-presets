#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    int u_inverseGammaCorrection;
    float u_gamma;
    float u_sampleY;
    float u_sigmaY;
    float u_stepY;
    int u_borderType;
    int u_blurAlpha;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv0 [[user(locn0)]];
};

static inline __attribute__((always_inline))
float4 _f1(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, constant int& u_inverseGammaCorrection, constant float& u_gamma)
{
    float4 _t0 = _p0.sample(_p0Smplr, _p1);
    if (u_inverseGammaCorrection == 1)
    {
        float4 _51 = _t0;
        float3 _57 = pow(_51.xyz, float3(u_gamma));
        _t0.x = _57.x;
        _t0.y = _57.y;
        _t0.z = _57.z;
    }
    return _t0;
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0, thread const float& _p1)
{
    return exp((((-0.5) * _p0) * _p0) / (_p1 * _p1));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    if (buffer.u_sampleY < 9.9999997473787516355514526367188e-06)
    {
        out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, in.uv0);
        return out;
    }
    float2 param = in.uv0;
    float4 _89 = _f1(u_inputTexture, u_inputTextureSmplr, param, buffer.u_inverseGammaCorrection, buffer.u_gamma);
    float4 _t1 = _89;
    float param_1 = 0.0;
    float param_2 = buffer.u_sigmaY;
    float _96 = _f0(param_1, param_2);
    float _t2 = _96;
    float4 _t3 = _89 * _96;
    float2 _t4 = in.uv0;
    for (int _t5 = 1; _t5 <= 1024; _t5++)
    {
        float _115 = float(_t5);
        if (_115 > buffer.u_sampleY)
        {
            break;
        }
        float _126 = _115 * buffer.u_stepY;
        float param_3 = _126;
        float param_4 = buffer.u_sigmaY;
        float _132 = _f0(param_3, param_4);
        _t4.y = in.uv0.y - _126;
        if (_t4.y < 0.0)
        {
            if (buffer.u_borderType == 1)
            {
                _t4.y = 0.0;
                float2 param_5 = _t4;
                _t3 += (_f1(u_inputTexture, u_inputTextureSmplr, param_5, buffer.u_inverseGammaCorrection, buffer.u_gamma) * _132);
                _t2 += _132;
            }
            else
            {
                if (buffer.u_borderType == 2)
                {
                    _t2 += _132;
                }
                else
                {
                    if (buffer.u_borderType == 3)
                    {
                        _t4.y = -_t4.y;
                        float2 param_6 = _t4;
                        _t3 += (_f1(u_inputTexture, u_inputTextureSmplr, param_6, buffer.u_inverseGammaCorrection, buffer.u_gamma) * _132);
                        _t2 += _132;
                    }
                }
            }
        }
        else
        {
            float2 param_7 = _t4;
            _t3 += (_f1(u_inputTexture, u_inputTextureSmplr, param_7, buffer.u_inverseGammaCorrection, buffer.u_gamma) * _132);
            _t2 += _132;
        }
        _t4.y = in.uv0.y + _126;
        if (_t4.y > 1.0)
        {
            if (buffer.u_borderType == 1)
            {
                _t4.y = 1.0;
                float2 param_8 = _t4;
                _t3 += (_f1(u_inputTexture, u_inputTextureSmplr, param_8, buffer.u_inverseGammaCorrection, buffer.u_gamma) * _132);
                _t2 += _132;
            }
            else
            {
                if (buffer.u_borderType == 2)
                {
                    _t2 += _132;
                }
                else
                {
                    if (buffer.u_borderType == 3)
                    {
                        _t4.y = 2.0 - _t4.y;
                        float2 param_9 = _t4;
                        _t3 += (_f1(u_inputTexture, u_inputTextureSmplr, param_9, buffer.u_inverseGammaCorrection, buffer.u_gamma) * _132);
                        _t2 += _132;
                    }
                }
            }
        }
        else
        {
            float2 param_10 = _t4;
            _t3 += (_f1(u_inputTexture, u_inputTextureSmplr, param_10, buffer.u_inverseGammaCorrection, buffer.u_gamma) * _132);
            _t2 += _132;
        }
    }
    _t3 /= float4(_t2);
    if (buffer.u_inverseGammaCorrection == 1)
    {
        float4 _275 = _t3;
        float3 _280 = pow(_275.xyz, float3(1.0 / buffer.u_gamma));
        _t3.x = _280.x;
        _t3.y = _280.y;
        _t3.z = _280.z;
    }
    if (buffer.u_blurAlpha == 0)
    {
        _t3.w = _t1.w;
    }
    out.o_fragColor = _t3;
    return out;
}

