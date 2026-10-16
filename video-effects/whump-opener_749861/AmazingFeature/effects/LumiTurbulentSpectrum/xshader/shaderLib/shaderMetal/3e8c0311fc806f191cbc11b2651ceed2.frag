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
    float2 u_Scale;
    float u_Rotate;
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
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float2 _f2(thread float2& _p0, thread const float& _p1, constant float4& u_ScreenParams)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _202 = sin(_p1);
    float _205 = cos(_p1);
    _p0 -= float2(0.5);
    _p0 = float2x2(float2(_205, _202), float2(-_202, _205)) * _p0;
    _p0 += float2(0.5);
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    return _p0;
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    float2 _43 = fract(_p0 * 1324.5179443359375);
    float2 _t0 = _43 + float2(dot(_43, _43.yx + float2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float2& _p1, constant float& u_Cycle)
{
    float2 param = _p0;
    float _71 = _f0(param);
    float _78 = _p1.x + _71;
    float _81 = floor(_78);
    float _t4 = _81;
    float _t5 = _81 + 1.0;
    if (u_Cycle >= 2.0)
    {
        _t4 = floor(mod(_78, u_Cycle));
        _t5 = floor(mod(_78 + 1.0, u_Cycle));
    }
    float2 _116 = fract(_p0 * ((34.532001495361328125 + (_t4 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    float2 _126 = _116 + float2(dot(_116, _116.yx + float2(15.4340000152587890625)));
    float2 _130 = _126.yx;
    float2 _139 = float2(_71);
    float2 _153 = fract(_p0 * ((34.532001495361328125 + (_t5 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    float2 _162 = _153 + float2(dot(_153, _153.yx + float2(15.4340000152587890625)));
    float2 _166 = _162.yx;
    return (mix(fract((((_126 + _130) + float2(0.5230000019073486328125)) * _130) + _139), fract((((_162 + _166) + float2(0.5230000019073486328125)) * _166) + _139), float2(fract(_78))) * 2.0) - float2(1.0);
}

static inline __attribute__((always_inline))
float _f3(thread const float2& _p0, thread const float2& _p1, constant float& u_Cycle, constant float4& u_ScreenParams)
{
    float2 _252 = (float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y));
    float2 _260 = floor((_p0 * _252) / float2(100.0));
    float2 _267 = fract((_p0 * _252) / float2(100.0));
    float2 param = _260 + float2(0.0);
    float2 param_1 = _p1;
    float2 param_2 = _260 + float2(1.0, 0.0);
    float2 param_3 = _p1;
    float2 param_4 = _260 + float2(0.0, 1.0);
    float2 param_5 = _p1;
    float2 param_6 = _260 + float2(1.0);
    float2 param_7 = _p1;
    float2 _t21 = ((_267 * _267) * _267) * ((_267 * ((_267 * 6.0) - float2(15.0))) + float2(10.0));
    return (mix(mix(dot(_f1(param, param_1, u_Cycle), _267 - float2(0.0)), dot(_f1(param_2, param_3, u_Cycle), _267 - float2(1.0, 0.0)), _t21.x), mix(dot(_f1(param_4, param_5, u_Cycle), _267 - float2(0.0, 1.0)), dot(_f1(param_6, param_7, u_Cycle), _267 - float2(1.0)), _t21.x), _t21.y) * 0.5) + 0.5;
}

static inline __attribute__((always_inline))
float _f4(thread float2& _p0, thread const float& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, thread const float& _p5, thread const float2& _p6, constant float& u_Cycle, constant float4& u_ScreenParams)
{
    float2 _373 = (float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y));
    float _376 = floor(_p1);
    float _379 = fract(_p1);
    float2 _387 = float2(_p2, 1.0);
    float2 param = _p0;
    float2 param_1 = _387;
    float _t29 = 1.0;
    float _t30 = _p3;
    float _t31 = _f3(param, param_1, u_Cycle, u_ScreenParams) * 1.0;
    for (float _t32 = 2.0; _t32 <= 10.0; _t32 += 1.0)
    {
        if (_t32 > _376)
        {
            break;
        }
        _p0 -= (_p6 / _373);
        _p0 *= _p4;
        float2 param_2 = _p0;
        float param_3 = (_p5 * 3.141592502593994140625) / 180.0;
        float2 _428 = _f2(param_2, param_3, u_ScreenParams);
        _p0 = _428;
        float2 param_4 = _p0;
        float2 param_5 = _387;
        float _435 = _t30;
        _t29 += _435;
        _t30 = _435 * _p3;
        _t31 += (_f3(param_4, param_5, u_Cycle, u_ScreenParams) * _435);
    }
    _p0 -= (_p6 / _373);
    _p0 *= _p4;
    float2 param_6 = _p0;
    float param_7 = (_p5 * 3.141592502593994140625) / 180.0;
    float2 _462 = _f2(param_6, param_7, u_ScreenParams);
    _p0 = _462;
    float2 param_8 = _p0;
    float2 param_9 = _387;
    float _476 = _t29;
    float _477 = _476 + (_t30 * _379);
    _t29 = _477;
    float _479 = _t31;
    float _483 = (_479 + ((_f3(param_8, param_9, u_Cycle, u_ScreenParams) * _t30) * _379)) / _477;
    _t31 = _483;
    return fast::clamp(_483, 0.0, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float2 param = (in.v_uv - buffer.u_Offset) * (float2(1.0) / buffer.u_Scale);
    float param_1 = (buffer.u_Rotate * 3.141592502593994140625) / 180.0;
    float2 _510 = _f2(param, param_1, buffer.u_ScreenParams);
    float2 param_2 = _510 - float2(10.0);
    float param_3 = fast::clamp(buffer.u_Complexity, 1.0, 10.0);
    float param_4 = buffer.u_Evolution;
    float param_5 = buffer.u_SubImpact;
    float param_6 = 1.0 / buffer.u_SubScale;
    float param_7 = buffer.u_SubRotate;
    float2 param_8 = buffer.u_SubOffset;
    float _537 = _f4(param_2, param_3, param_4, param_5, param_6, param_7, param_8, buffer.u_Cycle, buffer.u_ScreenParams);
    float _t34 = _537 + buffer.u_Brightness;
    if (buffer.u_Contrast > 0.0)
    {
        _t34 = ((_t34 - 0.5) * ((buffer.u_Contrast * 10.0) + 1.0)) + 0.5;
    }
    else
    {
        _t34 = ((_t34 - 0.5) * (buffer.u_Contrast + 1.0)) + 0.5;
    }
    float _561 = _t34;
    float _562 = fast::clamp(_561, 0.0, 1.0);
    _t34 = _562;
    out.o_fragColor = float4(float3(_562), 1.0);
    return out;
}

