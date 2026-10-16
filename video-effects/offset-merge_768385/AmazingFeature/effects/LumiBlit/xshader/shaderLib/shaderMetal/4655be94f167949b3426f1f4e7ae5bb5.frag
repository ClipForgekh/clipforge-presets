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
    float u_loveAngle0;
    float u_loveAngle1;
    float u_loveAngle2;
    float u_loveAngle3;
    float u_loveAngle4;
    float u_loveAngle5;
    float u_loveAngle6;
    float4 u_ScreenParams;
    int u_splitCount;
    int u_splitType;
    float u_lineWidth;
    int u_maskType;
    float2 u_maskCenter;
    float u_maskA;
    float u_maskB;
    float u_maskC;
    float u_lineMaskProgress;
    float u_showLine;
    float u_alpha;
    float4 u_lineColor;
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

static inline __attribute__((always_inline))
float _f1(thread const int& _p0, constant float& u_loveAngle0, constant float& u_loveAngle1, constant float& u_loveAngle2, constant float& u_loveAngle3, constant float& u_loveAngle4, constant float& u_loveAngle5, constant float& u_loveAngle6)
{
    if (_p0 == 0)
    {
        return u_loveAngle0;
    }
    if (_p0 == 1)
    {
        return u_loveAngle1;
    }
    if (_p0 == 2)
    {
        return u_loveAngle2;
    }
    if (_p0 == 3)
    {
        return u_loveAngle3;
    }
    if (_p0 == 4)
    {
        return u_loveAngle4;
    }
    if (_p0 == 5)
    {
        return u_loveAngle5;
    }
    return u_loveAngle6;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 _t0 = in.v_uv;
    float4 _133 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t1 = _133;
    float _t4 = 1.0;
    float _t5 = 0.0;
    float _t6 = 1.0;
    float _t15;
    for (int _t7 = 0; _t7 < 7; _t7++)
    {
        if (_t7 >= buffer.u_splitCount)
        {
            break;
        }
        int param = _t7;
        float4 _t8 = _f0(param, buffer.u_split0, buffer.u_split1, buffer.u_split2, buffer.u_split3, buffer.u_split4, buffer.u_split5, buffer.u_split6);
        if (buffer.u_splitType == 1)
        {
            float _181 = _t0.x - _t8.x;
            float _187 = _t0.y - _t8.y;
            _t15 = sqrt(fast::max((((_181 * _181) * buffer.u_ScreenParams.x) * buffer.u_ScreenParams.x) + (((_187 * _187) * buffer.u_ScreenParams.y) * buffer.u_ScreenParams.y), 0.0)) - (sqrt(fast::max(_t8.z, 0.0)) * fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y));
        }
        else
        {
            if (buffer.u_splitType == 2)
            {
                float _265 = fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y);
                float _271 = ((_t0.x - _t8.x) * buffer.u_ScreenParams.x) / _265;
                float _277 = ((_t0.y - _t8.y) * buffer.u_ScreenParams.y) / _265;
                int param_1 = _t7;
                float _281 = _f1(param_1, buffer.u_loveAngle0, buffer.u_loveAngle1, buffer.u_loveAngle2, buffer.u_loveAngle3, buffer.u_loveAngle4, buffer.u_loveAngle5, buffer.u_loveAngle6);
                float _284 = cos(_281);
                float _287 = sin(_281);
                float _308 = fast::max(_t8.z, 0.001000000047497451305389404296875);
                float _312 = ((_271 * _284) - (_277 * _287)) / _308;
                float _316 = ((_271 * _287) + (_277 * _284)) / _308;
                float _320 = _312 * _312;
                float _327 = (_320 + (_316 * _316)) - 1.0;
                float _342 = ((_327 * _327) * _327) - (((_320 * _316) * _316) * _316);
                _t15 = sign(_342) * (((abs(_342) * _308) * _265) * 0.20000000298023223876953125);
            }
            else
            {
                _t15 = (((((_t8.x * _t0.x) + (_t8.y * _t0.y)) + _t8.z) * buffer.u_ScreenParams.x) * buffer.u_ScreenParams.y) / fast::max(sqrt((((_t8.x * _t8.x) * buffer.u_ScreenParams.y) * buffer.u_ScreenParams.y) + (((_t8.y * _t8.y) * buffer.u_ScreenParams.x) * buffer.u_ScreenParams.x)), 9.9999997473787516355514526367188e-05);
            }
        }
        float _409 = fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y) / 720.0;
        float _410 = 3.0 * _409;
        _t4 *= mix(smoothstep(-_410, 0.0, _t15), 1.0 - smoothstep(0.0, _410, _t15), _t8.w);
        float _437 = 9.0 * _409;
        _t6 *= mix(smoothstep(-_437, 0.0, _t15), 1.0 - smoothstep(0.0, _437, _t15), _t8.w);
        float _462 = buffer.u_lineWidth * 0.5;
        _t5 = fast::max(_t5, 1.0 - smoothstep(_462, _462 + _410, abs(_t15)));
    }
    _t5 *= (_t1.w * _t6);
    float _t45;
    float _t48;
    if (buffer.u_maskType == 1)
    {
        float _505 = (_t0.x - buffer.u_maskCenter.x) * buffer.u_ScreenParams.z;
        float _511 = _t0.y - buffer.u_maskCenter.y;
        _t45 = sqrt((_505 * _505) + (_511 * _511));
        float _532 = fast::max(abs(buffer.u_maskCenter.x - 0.0), abs(buffer.u_maskCenter.x - 1.0)) * buffer.u_ScreenParams.z;
        float _542 = fast::max(abs(buffer.u_maskCenter.y - 0.0), abs(buffer.u_maskCenter.y - 1.0));
        _t48 = sqrt((_532 * _532) + (_542 * _542));
    }
    else
    {
        _t45 = abs(((buffer.u_maskA * _t0.x) + (buffer.u_maskB * _t0.y)) + buffer.u_maskC) / fast::max(sqrt((buffer.u_maskA * buffer.u_maskA) + (buffer.u_maskB * buffer.u_maskB)), 9.9999997473787516355514526367188e-05);
        _t48 = 0.75;
    }
    _t5 *= (1.0 - (1.0 - step(buffer.u_lineMaskProgress * _t48, _t45)));
    if (buffer.u_showLine < 0.5)
    {
        out.o_fragColor = float4(_133.xyz, (_t1.w * _t4) * buffer.u_alpha);
    }
    else
    {
        float4 _t51 = mix(float4(_133.xyz, _t1.w * _t4), buffer.u_lineColor, float4(_t5));
        _t51.w *= buffer.u_alpha;
        out.o_fragColor = _t51;
    }
    return out;
}

