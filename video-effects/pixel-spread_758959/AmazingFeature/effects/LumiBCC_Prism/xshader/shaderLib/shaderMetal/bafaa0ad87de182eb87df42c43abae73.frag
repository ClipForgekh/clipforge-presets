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
    float2 u_center;
    float u_globalTransform;
    float u_scaleEnd;
    float u_scaleStart;
    float u_angleEnd;
    float u_angleStart;
    float u_smoothness;
    float2 u_offsetStart;
    float2 u_offsetEnd;
    float3 u_colorStart;
    float3 u_colorMid;
    float3 u_colorEnd;
    float u_weight;
    float u_fallOff;
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
float2x2 _f0(thread const float& _p0)
{
    float _50 = sin(_p0);
    float _53 = cos(_p0);
    return float2x2(float2(_53, -_50), float2(_50, _53));
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float2& _p1, thread const float& _p2, constant float4& u_ScreenParams)
{
    float2 _t2 = _p0 - _p1;
    float _81 = u_ScreenParams.x / u_ScreenParams.y;
    _t2.x *= _81;
    float param = _p2;
    _t2 *= _f0(param);
    _t2.x /= _81;
    return _t2 + _p1;
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float2& _p1, thread const float2x2& _p2, constant float4& u_ScreenParams)
{
    float2 _t3 = _p0 - _p1;
    float _113 = u_ScreenParams.x / u_ScreenParams.y;
    _t3.x *= _113;
    _t3 *= _p2;
    _t3.x /= _113;
    return _t3 + _p1;
}

static inline __attribute__((always_inline))
float _f4(thread const float& _p0, thread const float& _p1, thread const float& _p2, thread const float& _p3)
{
    return fast::clamp((1.0 - (abs(_p3 - _p0) / _p2)) * _p1, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float3 _f5(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float& _p3)
{
    float param = 0.0;
    float param_1 = 1.0;
    float param_2 = 0.5;
    float param_3 = _p3;
    float param_4 = 0.5;
    float param_5 = 1.0;
    float param_6 = 0.5;
    float param_7 = _p3;
    float param_8 = 1.0;
    float param_9 = 1.0;
    float param_10 = 0.5;
    float param_11 = _p3;
    return ((_p0 * _f4(param, param_1, param_2, param_3)) + (_p1 * _f4(param_4, param_5, param_6, param_7))) + (_p2 * _f4(param_8, param_9, param_10, param_11));
}

static inline __attribute__((always_inline))
float2 _f3(thread const float2& _p0)
{
    return abs(mod(_p0 + float2(1.0), float2(2.0)) - float2(1.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _t7 = float4(0.0);
    float4 _t8 = float4(0.0);
    float4 _t9 = float4(0.0);
    float4 _t10 = float4(0.0);
    float2 _210 = mix(float2(0.5), float2(buffer.u_center), float2(buffer.u_globalTransform));
    float _227 = buffer.u_scaleEnd - buffer.u_scaleStart;
    float _t13 = fast::max(80.0 * abs(_227), mix(0.0, 79.0, abs(buffer.u_angleEnd - buffer.u_angleStart) / 0.5));
    float _243 = buffer.u_smoothness * buffer.u_smoothness;
    if (_243 > 0.300000011920928955078125)
    {
        _t13 = fast::max((_t13 * sqrt(length(in.v_uv - _210))) * 4.0, 6.0);
    }
    float _272 = _t13;
    float _284 = floor(mix(2.0, fast::max(2.0, fast::max(length((buffer.u_offsetStart - buffer.u_offsetEnd) * (buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.y, buffer.u_ScreenParams.x)))) * 450.0, _272) * buffer.u_globalTransform), fast::clamp(_243, 0.0, 1.0)));
    _t13 = _284;
    float _291 = buffer.u_angleStart * buffer.u_globalTransform;
    float param = ((buffer.u_angleEnd * buffer.u_globalTransform) - _291) / _284;
    float2x2 _296 = _f0(param);
    float2 param_1 = in.v_uv;
    float2 param_2 = _210;
    float param_3 = _291;
    float2 _t15 = _f1(param_1, param_2, param_3, buffer.u_ScreenParams);
    float2 _311 = (buffer.u_offsetStart - float2(0.5)) * buffer.u_globalTransform;
    float2 _316 = (buffer.u_offsetEnd - float2(0.5)) * buffer.u_globalTransform;
    for (int _t18 = 0; _t18 <= 1024; _t18++)
    {
        float _331 = float(_t18);
        if (_331 > _t13)
        {
            break;
        }
        float _341 = _331 / _t13;
        float2 _343 = _t15;
        float2 _345 = _343 - _210;
        float2 _368 = float2(_341);
        float2 param_4 = _343;
        float2 param_5 = _210;
        float2x2 param_6 = _296;
        _t15 = _f2(param_4, param_5, param_6, buffer.u_ScreenParams);
        float _390 = 1.0 - _341;
        float3 param_7 = buffer.u_colorStart;
        float3 param_8 = buffer.u_colorMid;
        float3 param_9 = buffer.u_colorEnd;
        float param_10 = _390;
        float3 _t24 = mix(float3(0.00999999977648258209228515625), _f5(param_7, param_8, param_9, param_10), float3(fast::clamp(buffer.u_weight, 0.0, 1.0)));
        float _t25 = 0.00999999977648258209228515625;
        if (buffer.u_scaleStart > buffer.u_scaleEnd)
        {
            _t25 = pow(fast::clamp(_390, 0.001000000047497451305389404296875, 1.0), 1.0 + ((buffer.u_scaleStart - buffer.u_scaleEnd) * 2.0));
        }
        else
        {
            _t25 = pow(fast::clamp(_341, 0.001000000047497451305389404296875, 1.0), 1.0 + (_227 * 2.0));
        }
        _t24 *= _t25;
        float2 param_11 = mix((_345 / float2(mix(1.0, buffer.u_scaleStart, buffer.u_globalTransform))) + _210, (_345 / float2(mix(1.0, buffer.u_scaleEnd, buffer.u_globalTransform))) + _210, _368) - mix(_311, _316, _368);
        float4 _453 = u_inputTexture.sample(u_inputTextureSmplr, _f3(param_11));
        float4 _459 = float4(_t24, 1.0);
        _t7 += ((_453 * _459) * float4(float3(mix(1.0 - buffer.u_fallOff, 1.0 + buffer.u_fallOff, _341)), 1.0));
        _t8 += _459;
        _t9 += (_453 * _t25);
        _t10 += float4(_t25);
    }
    float4 _489 = _t7;
    float4 _490 = _489 / _t8;
    _t7 = _490;
    float4 _492 = _t9;
    float4 _493 = _492 / _t10;
    _t9 = _493;
    out.o_fragColor = float4(mix(_493, _490, float4(buffer.u_weight)));
    return out;
}

