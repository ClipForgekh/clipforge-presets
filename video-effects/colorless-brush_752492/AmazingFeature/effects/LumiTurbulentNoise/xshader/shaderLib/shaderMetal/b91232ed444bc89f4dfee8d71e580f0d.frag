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
    float u_cycle;
    float4 u_ScreenParams;
    float u_interpolationUVMap;
    float u_type;
    float2 u_offset;
    float2 u_scale;
    float u_rotate;
    float u_complexity;
    float u_evolution;
    float u_subImpact;
    float u_subScale;
    float u_subRotate;
    float2 u_subOffset;
    float u_brightness;
    float u_contrast;
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
float2 _f2(thread float2& _p0, thread const float& _p1, constant float4& u_ScreenParams)
{
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _217 = sin(_p1);
    float _220 = cos(_p1);
    _p0 -= float2(0.5);
    _p0 = float2x2(float2(_220, _217), float2(-_217, _220)) * _p0;
    _p0 += float2(0.5);
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    return _p0;
}

static inline __attribute__((always_inline))
float _f0(thread const float2& _p0)
{
    float2 _58 = fract(_p0 * 1324.5179443359375);
    float2 _t0 = _58 + float2(dot(_58, _58.yx + float2(22.5410003662109375)));
    return fract((_t0.x + _t0.y) * _t0.y);
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float2& _p1, constant float& u_cycle)
{
    float2 param = _p0;
    float _86 = _f0(param);
    float _93 = _p1.x + _86;
    float _96 = floor(_93);
    float _t4 = _96;
    float _t5 = _96 + 1.0;
    if (u_cycle >= 2.0)
    {
        _t4 = floor(mod(_93, u_cycle));
        _t5 = floor(mod(_93 + 1.0, u_cycle));
    }
    float2 _131 = fract(_p0 * ((34.532001495361328125 + (_t4 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    float2 _141 = _131 + float2(dot(_131, _131.yx + float2(15.4340000152587890625)));
    float2 _145 = _141.yx;
    float2 _154 = float2(_86);
    float2 _168 = fract(_p0 * ((34.532001495361328125 + (_t5 * 4.412000179290771484375)) + (_p1.y * 0.3973000049591064453125)));
    float2 _177 = _168 + float2(dot(_168, _168.yx + float2(15.4340000152587890625)));
    float2 _181 = _177.yx;
    return (mix(fract((((_141 + _145) + float2(0.5230000019073486328125)) * _145) + _154), fract((((_177 + _181) + float2(0.5230000019073486328125)) * _181) + _154), float2(fract(_93))) * 2.0) - float2(1.0);
}

static inline __attribute__((always_inline))
float _f4(thread const float2& _p0, thread const float2& _p1, constant float& u_cycle, constant float4& u_ScreenParams, constant float& u_interpolationUVMap)
{
    float2 _387 = (float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y));
    float2 _394 = floor((_p0 * _387) / float2(100.0));
    float2 _402 = fract((_p0 * _387) / float2(u_interpolationUVMap));
    float2 param = _394 + float2(0.0);
    float2 param_1 = _p1;
    float2 param_2 = _394 + float2(1.0, 0.0);
    float2 param_3 = _p1;
    float2 param_4 = _394 + float2(0.0, 1.0);
    float2 param_5 = _p1;
    float2 param_6 = _394 + float2(1.0);
    float2 param_7 = _p1;
    float2 _t31 = smoothstep(float2(0.0), float2(1.0), _402);
    return (mix(mix(dot(_f1(param, param_1, u_cycle), _402 - float2(0.0)), dot(_f1(param_2, param_3, u_cycle), _402 - float2(1.0, 0.0)), _t31.x), mix(dot(_f1(param_4, param_5, u_cycle), _402 - float2(0.0, 1.0)), dot(_f1(param_6, param_7, u_cycle), _402 - float2(1.0)), _t31.x), _t31.y) * 0.5) + 0.5;
}

static inline __attribute__((always_inline))
float _f6(thread float2& _p0, thread const float& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, thread const float& _p5, thread const float& _p6, thread const float2& _p7, constant float& u_cycle, constant float4& u_ScreenParams, constant float& u_interpolationUVMap)
{
    float2 _629 = (float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y));
    float2 _t43 = _629;
    float _632 = floor(_p1);
    float2 _643 = float2(_p2, 1.0);
    float2 param = _p0;
    float2 param_1 = _643;
    float _t49 = 1.0;
    float _t50 = _p3;
    float _t51 = _f4(param, param_1, u_cycle, u_ScreenParams, u_interpolationUVMap) * 1.0;
    for (float _t52 = 2.0; _t52 <= 7.0; _t52 += 1.0)
    {
        if (_t52 > _632)
        {
            break;
        }
        _p0 -= (_p7 / _629);
        float2 param_2 = _p0;
        float param_3 = (_p5 * 3.141592502593994140625) / 180.0;
        float2 _680 = _f2(param_2, param_3, u_ScreenParams);
        _p0 = _680;
        _p0 *= _p4;
        float2 param_4 = _p0 + float2(1.0 / _t43.x, 0.0);
        float2 param_5 = _643;
        float2 param_6 = _p0 - float2(1.0 / _t43.x, 0.0);
        float2 param_7 = _643;
        float2 param_8 = _p0 + float2(0.0, 1.0 / _t43.y);
        float2 param_9 = _643;
        float2 param_10 = _p0 - float2(0.0, 1.0 / _t43.y);
        float2 param_11 = _643;
        _p0 -= float2(_f4(param_6, param_7, u_cycle, u_ScreenParams, u_interpolationUVMap) - _f4(param_4, param_5, u_cycle, u_ScreenParams, u_interpolationUVMap), _f4(param_10, param_11, u_cycle, u_ScreenParams, u_interpolationUVMap) - _f4(param_8, param_9, u_cycle, u_ScreenParams, u_interpolationUVMap));
        float2 param_12 = _p0;
        float2 param_13 = _643;
        float _749 = _t50;
        _t49 += _749;
        _t50 = _749 * _p3;
        _t51 += (_f4(param_12, param_13, u_cycle, u_ScreenParams, u_interpolationUVMap) * _749);
    }
    float _763 = _t51;
    float _764 = _763 / _t49;
    _t51 = _764;
    return fast::clamp(_764, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float _f3(thread const float2& _p0, thread const float2& _p1, constant float& u_cycle, constant float4& u_ScreenParams, constant float& u_interpolationUVMap, constant float& u_type)
{
    float2 _267 = (float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y));
    float2 _275 = floor((_p0 * _267) / float2(100.0));
    float2 _284 = fract((_p0 * _267) / float2(u_interpolationUVMap));
    float2 param = _275 + float2(0.0);
    float2 param_1 = _p1;
    float2 param_2 = _275 + float2(1.0, 0.0);
    float2 param_3 = _p1;
    float2 param_4 = _275 + float2(0.0, 1.0);
    float2 param_5 = _p1;
    float2 param_6 = _275 + float2(1.0);
    float2 param_7 = _p1;
    float2 _t21 = smoothstep(float2(0.0), float2(1.0), _284);
    float _361 = mix(mix(dot(_f1(param, param_1, u_cycle), _284 - float2(0.0)), dot(_f1(param_2, param_3, u_cycle), _284 - float2(1.0, 0.0)), _t21.x), mix(dot(_f1(param_4, param_5, u_cycle), _284 - float2(0.0, 1.0)), dot(_f1(param_6, param_7, u_cycle), _284 - float2(1.0)), _t21.x), _t21.y);
    float _365;
    if (u_type == 1.0)
    {
        _365 = abs(_361);
    }
    else
    {
        _365 = (_361 * 0.5) + 0.5;
    }
    return _365;
}

static inline __attribute__((always_inline))
float _f5(thread float2& _p0, thread const float& _p1, thread const float& _p2, thread const float& _p3, thread const float& _p4, thread const float& _p5, thread const float& _p6, thread const float2& _p7, constant float& u_cycle, constant float4& u_ScreenParams, constant float& u_interpolationUVMap, constant float& u_type)
{
    float2 _493 = (float2(720.0) * u_ScreenParams.xy) / float2(fast::min(u_ScreenParams.x, u_ScreenParams.y));
    float _496 = floor(_p1);
    float _499 = fract(_p1);
    float2 _507 = float2(_p2, 1.0);
    float2 param = _p0;
    float2 param_1 = _507;
    float _t39 = 1.0;
    float _t40 = _p3;
    float _t41 = _f3(param, param_1, u_cycle, u_ScreenParams, u_interpolationUVMap, u_type) * 1.0;
    for (float _t42 = 2.0; _t42 <= 10.0; _t42 += 1.0)
    {
        if (_t42 > _496)
        {
            break;
        }
        _p0 -= (_p7 / _493);
        _p0 *= _p4;
        float2 param_2 = _p0;
        float param_3 = (_p5 * 3.141592502593994140625) / 180.0;
        float2 _549 = _f2(param_2, param_3, u_ScreenParams);
        _p0 = _549;
        float2 param_4 = _p0;
        float2 param_5 = _507;
        float _556 = _t40;
        _t39 += _556;
        _t40 = _556 * _p3;
        _t41 += (_f3(param_4, param_5, u_cycle, u_ScreenParams, u_interpolationUVMap, u_type) * _556);
    }
    _p0 -= (_p7 / _493);
    _p0 *= _p4;
    float2 param_6 = _p0;
    float param_7 = (_p5 * 3.141592502593994140625) / 180.0;
    float2 _583 = _f2(param_6, param_7, u_ScreenParams);
    _p0 = _583;
    float2 param_8 = _p0;
    float2 param_9 = _507;
    _t39 += (_t40 * _499);
    _t41 += ((_f3(param_8, param_9, u_cycle, u_ScreenParams, u_interpolationUVMap, u_type) * _t40) * _499);
    if (u_type == 0.0)
    {
        _t41 /= _t39;
    }
    else
    {
        _t41 = (_t41 * 0.60000002384185791015625) + 0.300000011920928955078125;
    }
    return fast::clamp(_t41, 0.0, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer)
{
    main0_out out = {};
    float2 _783 = (in.uv0 - buffer.u_offset) * (float2(1.0) / buffer.u_scale);
    float2 _t58 = _783;
    float2 param = _783;
    float param_1 = (buffer.u_rotate * 3.141592502593994140625) / 180.0;
    float2 _791 = _f2(param, param_1, buffer.u_ScreenParams);
    _t58 = _791 - float2(10.0);
    float _t61 = 0.0;
    if (buffer.u_type == 2.0)
    {
        float2 param_2 = _t58;
        float param_3 = fast::clamp(buffer.u_complexity, 1.0, 10.0);
        float param_4 = buffer.u_evolution;
        float param_5 = buffer.u_subImpact;
        float param_6 = 1.0 / buffer.u_subScale;
        float param_7 = buffer.u_subRotate;
        float param_8 = 2.1099998950958251953125;
        float2 param_9 = buffer.u_subOffset;
        float _826 = _f6(param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, buffer.u_cycle, buffer.u_ScreenParams, buffer.u_interpolationUVMap);
        _t61 = _826;
    }
    else
    {
        float2 param_10 = _t58;
        float param_11 = fast::clamp(buffer.u_complexity, 1.0, 10.0);
        float param_12 = buffer.u_evolution;
        float param_13 = buffer.u_subImpact;
        float param_14 = 1.0 / buffer.u_subScale;
        float param_15 = buffer.u_subRotate;
        float param_16 = 2.1099998950958251953125;
        float2 param_17 = buffer.u_subOffset;
        float _845 = _f5(param_10, param_11, param_12, param_13, param_14, param_15, param_16, param_17, buffer.u_cycle, buffer.u_ScreenParams, buffer.u_interpolationUVMap, buffer.u_type);
        _t61 = _845;
    }
    _t61 += buffer.u_brightness;
    if (buffer.u_contrast > 0.0)
    {
        _t61 = ((_t61 - 0.5) * ((buffer.u_contrast * 10.0) + 1.0)) + 0.5;
    }
    else
    {
        _t61 = ((_t61 - 0.5) * (buffer.u_contrast + 1.0)) + 0.5;
    }
    float _869 = _t61;
    float _870 = fast::clamp(_869, 0.0, 1.0);
    _t61 = _870;
    out.o_fragColor = float4(float3(_870), 1.0);
    return out;
}

