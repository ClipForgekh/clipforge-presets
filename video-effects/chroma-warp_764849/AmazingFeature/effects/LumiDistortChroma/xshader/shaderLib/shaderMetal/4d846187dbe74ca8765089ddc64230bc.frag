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

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct buffer_t
{
    float u_rotateWarpDir;
    float u_amountRelX;
    float u_amountRelY;
    int u_wrapModeX;
    int u_wrapModeY;
    int u_steps;
    float u_warpRed;
    float u_warpBlue;
    float4 u_ScreenParams;
    float u_amount;
    float3 u_color1;
    float3 u_color2;
    float3 u_color3;
    float u_mix;
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
float _f0(thread const float4& _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

static inline __attribute__((always_inline))
float2 _f5(thread const float2& _p0, thread const float& _p1, thread const float2& _p2, texture2d<float> u_lens, sampler u_lensSmplr)
{
    float2 _t10 = float2(abs(_p1)) / (_p2 * 1080.0);
    float4 param = u_lens.sample(u_lensSmplr, (_p0 + float2(_t10.x, 0.0)));
    float4 param_1 = u_lens.sample(u_lensSmplr, (_p0 - float2(_t10.x, 0.0)));
    float4 param_2 = u_lens.sample(u_lensSmplr, (_p0 + float2(0.0, _t10.y)));
    float4 param_3 = u_lens.sample(u_lensSmplr, (_p0 - float2(0.0, _t10.y)));
    return float2(_f0(param) - _f0(param_1), _f0(param_2) - _f0(param_3));
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float& _p1)
{
    float _142 = sin(_p1);
    float _145 = cos(_p1);
    return float2((_p0.x * _145) - (_p0.y * _142), (_p0.x * _142) + (_p0.y * _145));
}

static inline __attribute__((always_inline))
float2 _f6(thread const float2& _p0, thread float2& _p1, thread const float& _p2, constant float& u_rotateWarpDir, constant float& u_amountRelX, constant float& u_amountRelY)
{
    float2 param = _p1;
    float param_1 = radians(u_rotateWarpDir);
    _p1 = _f2(param, param_1);
    return (_p1 * _p2) * float2(u_amountRelX, u_amountRelY);
}

static inline __attribute__((always_inline))
float _f3(thread const float& _p0)
{
    float _169 = fract(_p0);
    float _173 = floor(mod(_p0, 2.0));
    return (_169 + _173) - ((_169 * _173) * 2.0);
}

static inline __attribute__((always_inline))
float2 _f4(thread float2& _p0, thread const int& _p1, thread const int& _p2, thread const float2& _p3)
{
    if (_p1 == 0)
    {
        _p0.x = fast::clamp(_p0.x, 0.0, 1.0);
    }
    else
    {
        if (_p1 == 1)
        {
            _p0.x = mod(_p0.x, _p3.x);
        }
        else
        {
            if (_p1 == 2)
            {
                float param = _p0.x;
                _p0.x = _f3(param);
            }
        }
    }
    if (_p2 == 0)
    {
        _p0.y = fast::clamp(_p0.y, 0.0, 1.0);
    }
    else
    {
        if (_p2 == 1)
        {
            _p0.y = mod(_p0.y, _p3.y);
        }
        else
        {
            if (_p2 == 2)
            {
                float param_1 = _p0.y;
                _p0.y = _f3(param_1);
            }
        }
    }
    return _p0;
}

static inline __attribute__((always_inline))
float4 _f7(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1, thread const float2& _p2, constant int& u_wrapModeX, constant int& u_wrapModeY)
{
    float2 param = _p1;
    int param_1 = u_wrapModeX;
    int param_2 = u_wrapModeY;
    float2 param_3 = _p2;
    float2 _354 = _f4(param, param_1, param_2, param_3);
    _p1 = _354;
    return _p0.sample(_p0Smplr, _p1);
}

static inline __attribute__((always_inline))
float3 _f1(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float& _p3)
{
    float3 _t2;
    if (_p3 < 0.5)
    {
        float _108 = 2.0 * (_p3 * 2.0);
        _t2 = (_p0 * fast::clamp(2.0 - _108, 0.0, 1.0)) + (_p1 * fast::clamp(_108, 0.0, 1.0));
    }
    else
    {
        float _126 = 2.0 * ((_p3 - 0.5) * 2.0);
        _t2 = (_p1 * fast::clamp(2.0 - _126, 0.0, 1.0)) + (_p2 * fast::clamp(_126, 0.0, 1.0));
    }
    return _t2;
}

static inline __attribute__((always_inline))
float4 _f8(thread const float2& _p0, thread const float2& _p1, constant int& u_wrapModeX, constant int& u_wrapModeY, constant int& u_steps, constant float& u_warpRed, constant float& u_warpBlue, texture2d<float> u_inputTex, sampler u_inputTexSmplr, thread float2& v_uv)
{
    float4 _t22 = float4(0.0);
    float4 _t23 = float4(0.0);
    float _368 = float(u_steps);
    for (int _t25 = 0; _t25 < 100; _t25++)
    {
        if (_t25 >= u_steps)
        {
            break;
        }
        float _388 = float(_t25) / _368;
        float2 param = v_uv + (_p0 * mix(u_warpRed, u_warpBlue, _388));
        float2 param_1 = _p1;
        float4 _409 = _f7(u_inputTex, u_inputTexSmplr, param, param_1, u_wrapModeX, u_wrapModeY);
        float3 param_2 = float3(1.0, 0.0, 0.0);
        float3 param_3 = float3(0.0, 1.0, 0.0);
        float3 param_4 = float3(0.0, 0.0, 1.0);
        float param_5 = _388;
        float4 _423 = float4(_f1(param_2, param_3, param_4, param_5), 1.0);
        _t22 += (_409 * _423);
        _t23 += _423;
    }
    float4 _435 = _t22;
    float4 _436 = _435 / _t23;
    _t22 = _436;
    return _436;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_lens [[texture(0)]], texture2d<float> u_inputTex [[texture(1)]], sampler u_lensSmplr [[sampler(0)]], sampler u_inputTexSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _450 = buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.x, buffer.u_ScreenParams.y));
    float2 param = in.v_uv;
    float param_1 = buffer.u_amount;
    float2 param_2 = _450;
    float2 param_3 = in.v_uv;
    float2 param_4 = _f5(param, param_1, param_2, u_lens, u_lensSmplr) * float2(buffer.u_amountRelX, buffer.u_amountRelY);
    float param_5 = buffer.u_amount;
    float2 _471 = _f6(param_3, param_4, param_5, buffer.u_rotateWarpDir, buffer.u_amountRelX, buffer.u_amountRelY);
    float2 param_6 = _471;
    float2 param_7 = _450;
    float4 _477 = _f8(param_6, param_7, buffer.u_wrapModeX, buffer.u_wrapModeY, buffer.u_steps, buffer.u_warpRed, buffer.u_warpBlue, u_inputTex, u_inputTexSmplr, in.v_uv);
    float4 _t33 = _477;
    out.o_fragColor = mix(_477, float4(_477.xyz * ((buffer.u_color1 + buffer.u_color2) + buffer.u_color3), _t33.w), float4(buffer.u_mix));
    return out;
}

