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
    float2 u_screenRatio;
    float2 u_rotationSinCos;
    float2 u_amountRel;
    int u_wrapModeX;
    int u_wrapModeY;
    float u_blurInterval;
    float u_warpAmount;
    float u_blurAmount;
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
float _f1(thread const float4& _p0)
{
    return dot(_p0, float4(1.0, 0.0039215688593685626983642578125, 1.5378700481960549950599670410156e-05, 6.0308629201699659461155533790588e-08));
}

static inline __attribute__((always_inline))
float2 _f5(thread const float2& _p0, thread const float& _p1, constant float2& u_screenRatio, texture2d<float> u_lens, sampler u_lensSmplr)
{
    float2 _t6 = float2(abs(_p1)) / u_screenRatio;
    float4 param = u_lens.sample(u_lensSmplr, (_p0 + float2(_t6.x, 0.0)));
    float4 param_1 = u_lens.sample(u_lensSmplr, (_p0 - float2(_t6.x, 0.0)));
    float4 param_2 = u_lens.sample(u_lensSmplr, (_p0 + float2(0.0, _t6.y)));
    float4 param_3 = u_lens.sample(u_lensSmplr, (_p0 - float2(0.0, _t6.y)));
    return float2(_f1(param) - _f1(param_1), _f1(param_2) - _f1(param_3));
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float2& _p1)
{
    return float2((_p0.x * _p1.y) - (_p0.y * _p1.x), (_p0.x * _p1.x) + (_p0.y * _p1.y));
}

static inline __attribute__((always_inline))
float2 _f6(thread const float2& _p0, thread float2& _p1, thread const float& _p2, constant float2& u_rotationSinCos, constant float2& u_amountRel)
{
    float2 param = _p1;
    float2 param_1 = u_rotationSinCos;
    _p1 = _f2(param, param_1);
    return _p0 + ((_p1 * _p2) * u_amountRel);
}

static inline __attribute__((always_inline))
float _f3(thread const float& _p0)
{
    float _118 = fract(_p0);
    float _123 = floor(mod(_p0, 1.0));
    return (_118 + _123) - ((_118 * _123) * 1.0);
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
float4 _f7(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1, constant float2& u_screenRatio, constant int& u_wrapModeX, constant int& u_wrapModeY)
{
    float2 param = _p1;
    int param_1 = u_wrapModeX;
    int param_2 = u_wrapModeY;
    float2 param_3 = u_screenRatio;
    float2 _296 = _f4(param, param_1, param_2, param_3);
    _p1 = _296;
    return _p0.sample(_p0Smplr, _p1);
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0)
{
    return 0.0900000035762786865234375 / (0.0900000035762786865234375 + (0.5 * (_p0 * _p0)));
}

static inline __attribute__((always_inline))
float4 _f8(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1, thread const float2& _p2, thread const float& _p3, constant float2& u_screenRatio, constant float2& u_rotationSinCos, constant float2& u_amountRel, constant int& u_wrapModeX, constant int& u_wrapModeY, constant float& u_blurInterval)
{
    float2 param = _p1;
    int param_1 = u_wrapModeX;
    int param_2 = u_wrapModeY;
    float2 param_3 = u_screenRatio;
    float2 _312 = _f4(param, param_1, param_2, param_3);
    _p1 = _312;
    float4 _t15 = _p0.sample(_p0Smplr, _p1);
    float _320 = fast::min(_p3, 5.0);
    float _323 = 1.0 / _320;
    float _t18 = 1.0;
    for (float _t19 = u_blurInterval; _t19 <= _320; _t19 += (1.5 * u_blurInterval))
    {
        if (_t19 > _p3)
        {
            break;
        }
        float2 param_4 = _p2 * _t19;
        float2 param_5 = u_rotationSinCos;
        float2 _352 = _f2(param_4, param_5) * u_amountRel;
        float2 param_6 = _p1 - _352;
        float4 _363 = _f7(_p0, _p0Smplr, param_6, u_screenRatio, u_wrapModeX, u_wrapModeY);
        _t15 += _363;
        float2 param_7 = _p1 + _352;
        float4 _368 = _f7(_p0, _p0Smplr, param_7, u_screenRatio, u_wrapModeX, u_wrapModeY);
        _t15 += _368;
        float param_8 = _t19 * _323;
        _t18 += 2.0;
    }
    return _t15 / float4(_t18);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_lens [[texture(0)]], texture2d<float> u_inputTex [[texture(1)]], sampler u_lensSmplr [[sampler(0)]], sampler u_inputTexSmplr [[sampler(1)]])
{
    main0_out out = {};
    float _396 = fast::max(buffer.u_warpAmount, buffer.u_blurAmount);
    float2 param = in.v_uv;
    float param_1 = _396;
    float2 _404 = _f5(param, param_1, buffer.u_screenRatio, u_lens, u_lensSmplr);
    float2 param_2 = in.v_uv;
    float2 param_3 = _404;
    float param_4 = buffer.u_warpAmount;
    float2 _412 = _f6(param_2, param_3, param_4, buffer.u_rotationSinCos, buffer.u_amountRel);
    float2 param_5 = _412;
    float2 param_6 = _404;
    float param_7 = _396;
    float4 _422 = _f8(u_inputTex, u_inputTexSmplr, param_5, param_6, param_7, buffer.u_screenRatio, buffer.u_rotationSinCos, buffer.u_amountRel, buffer.u_wrapModeX, buffer.u_wrapModeY, buffer.u_blurInterval);
    out.o_fragColor = _422;
    return out;
}

