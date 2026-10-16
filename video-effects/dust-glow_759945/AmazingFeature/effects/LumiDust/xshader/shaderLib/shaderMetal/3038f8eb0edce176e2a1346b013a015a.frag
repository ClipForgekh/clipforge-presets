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
    float u_Cycle;
    float4 u_ScreenParams;
    float2 u_Offset;
    float u_Rotate;
    float2 u_Scale;
    float u_Complexity;
    float u_Evolution;
    float u_SubImpact;
    float u_SubScale;
    float u_SubRotate;
    float2 u_SubOffset;
    float u_Brightness;
    float u_Contrast;
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
float2 _f3(thread float2& _p0, thread const float& _p1, constant float4& u_ScreenParams)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _277 = sin(_p1);
    float _280 = cos(_p1);
    _p0 -= float2(0.5);
    _p0 = float2x2(float2(_280, _277), float2(-_277, _280)) * _p0;
    _p0 += float2(0.5);
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    return _p0;
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    float2 _49 = fract(_p0 * 1213.2430419921875);
    float2 _t0 = _49 + float2(dot(_49, _49.yx + float2(11.12300014495849609375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float2& _p1, constant float& u_Cycle)
{
    float2 param = _p0;
    float _107 = _f0(param);
    float2 _117 = float2((_p1.x * 0.125) + (_107 * 0.5));
    float2 _t6 = _117;
    float2 _120 = floor(_117);
    float2 _t7 = _120;
    float2 _t8 = _120 + float2(1.0);
    if (u_Cycle >= 2.0)
    {
        float2 _136 = float2(u_Cycle);
        _t7 = mod(_t7, _136);
        _t8 = mod(_t8, _136);
    }
    float2 _169 = fract(_p0 * ((float2(17.2660007476806640625) + (_t7 * 1.0)) + float2((_p1.y * 0.80309998989105224609375) * 0.5)));
    float2 _174 = fract(_p0 * ((float2(17.2660007476806640625) + (_t8 * 1.0)) + float2((_p1.y * 0.80309998989105224609375) * 0.5)));
    float2 _186 = _169 + float2(dot(_169, _169.yx + float2(7.71700000762939453125)) * 0.699999988079071044921875);
    float2 _196 = _174 + float2(dot(_174, _174.yx + float2(7.71700000762939453125)) * 0.699999988079071044921875);
    float2 _200 = _186.yx;
    float2 _209 = float2(_107);
    float2 _t13 = fract((((_186 + _200) + float2(0.26150000095367431640625)) * _200) + _209);
    float2 _215 = _196.yx;
    float2 _t14 = fract((((_196 + _215) + float2(0.26150000095367431640625)) * _215) + _209);
    float _241 = mix(_t13.y, _t14.y + 0.5, smoothstep(0.0, 1.0, fract(_t6.x))) * 6.28318023681640625;
    return float2(cos(_241), sin(_241)) * mix(0.85000002384185791015625, 1.0, smoothstep(0.0, 1.0, fract((_p1.x + (_107 * 0.300000011920928955078125)) * 7.672500133514404296875)));
}

static inline __attribute__((always_inline))
float _f4(thread const float2& _p0, thread const float2& _p1, constant float& u_Cycle, constant float4& u_ScreenParams)
{
    float2 _329 = _p0 * ((float2(7.19999980926513671875) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y)));
    float2 _332 = floor(_329);
    float2 _335 = fract(_329);
    float2 param = _332 + float2(0.0);
    float2 param_1 = _p1;
    float2 param_2 = _332 + float2(1.0, 0.0);
    float2 param_3 = _p1;
    float2 param_4 = _332 + float2(0.0, 1.0);
    float2 param_5 = _p1;
    float2 param_6 = _332 + float2(1.0);
    float2 param_7 = _p1;
    float2 _t33 = smoothstep(float2(0.0), float2(1.0), _335);
    return (mix(mix(dot(_f2(param, param_1, u_Cycle), _335 - float2(0.0)), dot(_f2(param_2, param_3, u_Cycle), _335 - float2(1.0, 0.0)), _t33.x), mix(dot(_f2(param_4, param_5, u_Cycle), _335 - float2(0.0, 1.0)), dot(_f2(param_6, param_7, u_Cycle), _335 - float2(1.0)), _t33.x), _t33.y) * 0.5) + 0.5;
}

static inline __attribute__((always_inline))
float _f5(thread float2& _p0, thread const float& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, thread const float& _p5, thread const float& _p6, thread const float2& _p7, constant float& u_Cycle, constant float4& u_ScreenParams)
{
    float _439 = floor(_p1);
    float _442 = fract(_p1);
    float2 _448 = _p7 / ((float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y)));
    float _454 = (_p5 * 3.141592502593994140625) / 180.0;
    float _457 = sin(_454);
    float _460 = cos(_454);
    float2x2 _469 = float2x2(float2(_460, _457), float2(-_457, _460));
    float2 param = _p0;
    float2 param_1 = float2(_p2, 1.0 + _p6);
    float _t51 = 1.0;
    float _t52 = _p3;
    float _t53 = _f4(param, param_1, u_Cycle, u_ScreenParams);
    for (float _t54 = 2.0; (_t54 <= _439) && (_t54 <= 10.0); _t54 += 1.0)
    {
        _p0 -= _448;
        _p0 -= float2(0.5);
        _p0 = _469 * _p0;
        _p0 += float2(0.5);
        _p0 *= _p4;
        float2 param_2 = _p0;
        float2 param_3 = float2(_p2, 1.0 + _p6);
        float _520 = _t52;
        _t51 += _520;
        _t52 = _520 * _p3;
        _t53 += (_f4(param_2, param_3, u_Cycle, u_ScreenParams) * _520);
    }
    if (_442 > 0.0)
    {
        _p0 -= _448;
        _p0 -= float2(0.5);
        _p0 = _469 * _p0;
        _p0 += float2(0.5);
        _p0 *= _p4;
        float2 param_4 = _p0;
        float2 param_5 = float2(_p2, 1.0 + _p6);
        _t51 += (_t52 * _442);
        _t53 += ((_f4(param_4, param_5, u_Cycle, u_ScreenParams) * _t52) * _442);
    }
    return fast::clamp(_t53 / _t51, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float4 _f1(thread const float2& _p0)
{
    return float4(floor(_p0.x * 255.0) / 255.0, fract(_p0.x * 255.0), floor(_p0.y * 255.0) / 255.0, fract(_p0.y * 255.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float2 param = in.uv0 - buffer.u_Offset;
    float param_1 = (buffer.u_Rotate * 3.141592502593994140625) / 180.0;
    float2 _594 = _f3(param, param_1, buffer.u_ScreenParams);
    float _t56 = 0.5;
    float2 param_2 = (_594 * (float2(1.0) / buffer.u_Scale)) - float2(10.0);
    float param_3 = fast::clamp(buffer.u_Complexity, 1.0, 10.0);
    float param_4 = buffer.u_Evolution;
    float param_5 = buffer.u_SubImpact;
    float param_6 = 100.0 / buffer.u_SubScale;
    float param_7 = buffer.u_SubRotate;
    float param_8 = 2.1099998950958251953125;
    float2 param_9 = buffer.u_SubOffset;
    float _630 = _f5(param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, buffer.u_Cycle, buffer.u_ScreenParams);
    _t56 = _630 + buffer.u_Brightness;
    if (buffer.u_Contrast > 0.0)
    {
        _t56 = ((_t56 - 0.5) * ((buffer.u_Contrast * 10.0) + 1.0)) + 0.5;
    }
    else
    {
        _t56 = ((_t56 - 0.5) * (buffer.u_Contrast + 1.0)) + 0.5;
    }
    float _654 = _t56;
    float _655 = fast::clamp(_654, 0.0, 1.0);
    _t56 = _655;
    float2 param_10 = float2(_655, 0.5);
    out.o_fragColor = _f1(param_10);
    return out;
}

