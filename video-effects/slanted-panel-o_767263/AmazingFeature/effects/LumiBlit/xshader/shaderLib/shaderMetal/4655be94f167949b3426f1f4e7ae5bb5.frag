#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float4 u_split0;
    float4 u_split1;
    float4 u_split2;
    float4 u_split3;
    float4 u_split4;
    float4 u_split5;
    float4 u_split6;
    float4 u_ScreenParams;
    int u_splitCount;
    float u_lineWidth;
    int u_maskType;
    float2 u_maskCenter;
    float u_maskA;
    float u_maskB;
    float u_maskC;
    float u_lineMaskProgress;
    float u_showLine;
    float4 u_lineColor;
    float u_alpha;
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
float4 _f0(thread const int& _p0, constant float4& u_split0, constant float4& u_split1, constant float4& u_split2, constant float4& u_split3, constant float4& u_split4, constant float4& u_split5, constant float4& u_split6)
{
    if (_p0 == 0)
    {
        return u_split0;
    }
    if (_p0 == 1)
    {
        return u_split1;
    }
    if (_p0 == 2)
    {
        return u_split2;
    }
    if (_p0 == 3)
    {
        return u_split3;
    }
    if (_p0 == 4)
    {
        return u_split4;
    }
    if (_p0 == 5)
    {
        return u_split5;
    }
    return u_split6;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t0 = in.v_uv;
    float4 _82 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t1 = _82;
    float _t4 = 1.0;
    float _t5 = 0.0;
    for (int _t6 = 0; _t6 < 7; _t6++)
    {
        if (_t6 >= buffer.u_splitCount)
        {
            break;
        }
        int param = _t6;
        float4 _t7 = _f0(param, buffer.u_split0, buffer.u_split1, buffer.u_split2, buffer.u_split3, buffer.u_split4, buffer.u_split5, buffer.u_split6);
        float _166 = (((((_t7.x * _t0.x) + (_t7.y * _t0.y)) + _t7.z) * buffer.u_ScreenParams.x) * buffer.u_ScreenParams.y) / fast::max(sqrt((((_t7.x * _t7.x) * buffer.u_ScreenParams.y) * buffer.u_ScreenParams.y) + (((_t7.y * _t7.y) * buffer.u_ScreenParams.x) * buffer.u_ScreenParams.x)), 9.9999997473787516355514526367188e-05);
        float _176 = 3.0 * (fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y) / 720.0);
        _t4 *= mix(smoothstep(-_176, 0.0, _166), 1.0 - smoothstep(0.0, _176, _166), _t7.w);
        float _202 = buffer.u_lineWidth * 0.5;
        _t5 = fast::max(_t5, 1.0 - smoothstep(_202, _202 + _176, abs(_166)));
    }
    _t5 *= _t1.w;
    float _t20;
    float _t23;
    if (buffer.u_maskType == 1)
    {
        float _243 = (_t0.x - buffer.u_maskCenter.x) * buffer.u_ScreenParams.z;
        float _249 = _t0.y - buffer.u_maskCenter.y;
        _t20 = sqrt((_243 * _243) + (_249 * _249));
        float _270 = fast::max(abs(buffer.u_maskCenter.x - 0.0), abs(buffer.u_maskCenter.x - 1.0)) * buffer.u_ScreenParams.z;
        float _280 = fast::max(abs(buffer.u_maskCenter.y - 0.0), abs(buffer.u_maskCenter.y - 1.0));
        _t23 = sqrt((_270 * _270) + (_280 * _280));
    }
    else
    {
        _t20 = abs(((buffer.u_maskA * _t0.x) + (buffer.u_maskB * _t0.y)) + buffer.u_maskC) / fast::max(sqrt((buffer.u_maskA * buffer.u_maskA) + (buffer.u_maskB * buffer.u_maskB)), 9.9999997473787516355514526367188e-05);
        _t23 = 0.75;
    }
    _t5 *= (1.0 - (1.0 - step(buffer.u_lineMaskProgress * _t23, _t20)));
    if (buffer.u_showLine < 0.5)
    {
        out.o_fragColor = float4(_82.xyz, _t1.w * _t4);
    }
    else
    {
        float4 _t26 = mix(float4(_82.xyz, _t1.w * _t4), buffer.u_lineColor, float4(_t5));
        _t26.w *= buffer.u_alpha;
        out.o_fragColor = _t26;
    }
    return out;
}

