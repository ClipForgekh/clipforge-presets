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
    float4 u_ScreenParams;
    float u_rotate;
    float2 u_offset;
    float2 u_scale;
    float2 u_padding;
    int u_edgeType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv0 [[user(locn4)]];
};

static inline __attribute__((always_inline))
float2 _f3(thread float2& _p0, thread const float& _p1, thread const float2& _p2, thread const float2& _p3, constant float4& u_ScreenParams)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _103 = sin(_p1);
    float _106 = cos(_p1);
    _p0 = float2x2(float2(_106, _103), float2(-_103, _106)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0)
{
    float2 _56 = mod(_p0, float2(1.0));
    return _56 + (float2(1.0) - step(float2(0.0), _56));
}

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f2(thread const float2& _p0)
{
    float2 _t1 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t1.x * _t1.y;
}

static inline __attribute__((always_inline))
float4 _f4(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float2& _p2, thread const int& _p3)
{
    float2 _t5 = _p1;
    bool _144 = _p2.x < 0.0;
    bool _151;
    if (!_144)
    {
        _151 = _p2.y < 0.0;
    }
    else
    {
        _151 = _144;
    }
    if (_151)
    {
        if (_p3 == 0)
        {
            float2 param = _p1;
            _t5 = _f1(param);
        }
        else
        {
            if (_p3 == 1)
            {
                float2 param_1 = _p1;
                _t5 = _f0(param_1);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t5 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_2 = _p1;
                    if (_f2(param_2) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t5 = _p1;
                }
            }
        }
        return _p0.sample(_p0Smplr, _t5);
    }
    bool _202 = _p1.x < _p2.x;
    bool _212;
    if (!_202)
    {
        _212 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _212 = _202;
    }
    bool _222;
    if (!_212)
    {
        _222 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _222 = _212;
    }
    if (_222)
    {
        if (_p3 == 0)
        {
            float2 param_3 = _p1;
            _t5 = _f1(param_3);
        }
        else
        {
            if (_p3 == 1)
            {
                float2 param_4 = _p1;
                _t5 = _f0(param_4);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t5 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_5 = _p1;
                    if (_f2(param_5) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t5 = _p1;
                }
            }
        }
    }
    return _p0.sample(_p0Smplr, _t5);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTex [[texture(0)]], sampler u_inputTexSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.v_uv0;
    float param_1 = buffer.u_rotate;
    float2 param_2 = buffer.u_offset;
    float2 param_3 = buffer.u_scale;
    float2 _306 = _f3(param, param_1, param_2, param_3, buffer.u_ScreenParams);
    float2 param_4 = _306;
    float2 param_5 = buffer.u_padding;
    int param_6 = buffer.u_edgeType;
    out.o_fragColor = _f4(u_inputTex, u_inputTexSmplr, param_4, param_5, param_6);
    return out;
}

