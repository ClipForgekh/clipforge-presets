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
    float u_scaleEnd;
    float u_scaleStart;
    float u_angleEnd;
    float u_angleStart;
    float u_smoothness;
    float2 u_offsetStart;
    float2 u_offsetEnd;
    float u_globalTransform;
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
    float _43 = sin(_p0);
    float _46 = cos(_p0);
    return float2x2(float2(_46, -_43), float2(_43, _46));
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float2& _p1, thread const float& _p2, constant float4& u_ScreenParams)
{
    float2 _t2 = _p0 - _p1;
    float _74 = u_ScreenParams.x / u_ScreenParams.y;
    _t2.x *= _74;
    float param = _p2;
    _t2 *= _f0(param);
    _t2.x /= _74;
    return _t2 + _p1;
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, thread const float2& _p1, thread const float2x2& _p2, constant float4& u_ScreenParams)
{
    float2 _t3 = _p0 - _p1;
    float _106 = u_ScreenParams.x / u_ScreenParams.y;
    _t3.x *= _106;
    _t3 *= _p2;
    _t3.x /= _106;
    return _t3 + _p1;
}

static inline __attribute__((always_inline))
float3 _f4(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float& _p3)
{
    if (_p3 < 0.3333333432674407958984375)
    {
        float _149 = _p3 / 0.3333333432674407958984375;
        return (_p0 * fast::clamp(3.0 - _149, 0.0, 1.0)) + (_p1 * fast::clamp(3.0 * _149, 0.0, 1.0));
    }
    else
    {
        float _169 = (_p3 - 0.666666686534881591796875) / 0.3333333432674407958984375;
        return (_p1 * fast::clamp(3.0 - _169, 0.0, 1.0)) + (_p2 * fast::clamp(3.0 * _169, 0.0, 1.0));
    }
}

static inline __attribute__((always_inline))
float2 _f3(thread const float2& _p0)
{
    return abs(mod(_p0 + float2(1.0), float2(2.0)) - float2(1.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _t8 = float4(0.0);
    float4 _t9 = float4(0.0);
    float2 _198 = float2(buffer.u_center);
    float _t12 = fast::max(80.0 * abs(buffer.u_scaleEnd - buffer.u_scaleStart), mix(0.0, 79.0, abs(buffer.u_angleEnd - buffer.u_angleStart) / 0.5));
    float _232 = buffer.u_smoothness * buffer.u_smoothness;
    if (_232 > 0.300000011920928955078125)
    {
        _t12 = fast::max((_t12 * sqrt(length(in.v_uv - _198))) * 4.0, 6.0);
    }
    float _260 = _t12;
    float _268 = floor(mix(2.0, fast::max(length((buffer.u_offsetStart - buffer.u_offsetEnd) * (buffer.u_ScreenParams.xy / float2(fast::min(buffer.u_ScreenParams.y, buffer.u_ScreenParams.x)))) * 450.0, _260), fast::clamp(_232, 0.0, 1.0)));
    _t12 = _268;
    float _276 = buffer.u_angleStart * buffer.u_globalTransform;
    float param = ((buffer.u_angleEnd * buffer.u_globalTransform) - _276) / _268;
    float2x2 _281 = _f0(param);
    float2 param_1 = in.v_uv;
    float2 param_2 = _198;
    float param_3 = _276;
    float2 _t14 = _f1(param_1, param_2, param_3, buffer.u_ScreenParams);
    float2 _297 = (buffer.u_offsetStart - float2(0.5)) * buffer.u_globalTransform;
    float2 _302 = (buffer.u_offsetEnd - float2(0.5)) * buffer.u_globalTransform;
    for (int _t17 = 0; _t17 <= 1024; _t17++)
    {
        float _317 = float(_t17);
        if (_317 > _t12)
        {
            break;
        }
        float _327 = _317 / _t12;
        float2 _329 = _t14;
        float2 _331 = _329 - _198;
        float2 _354 = float2(_327);
        float2 param_4 = _329;
        float2 param_5 = _198;
        float2x2 param_6 = _281;
        _t14 = _f2(param_4, param_5, param_6, buffer.u_ScreenParams);
        float3 param_7 = buffer.u_colorStart;
        float3 param_8 = buffer.u_colorMid;
        float3 param_9 = buffer.u_colorEnd;
        float param_10 = _327;
        float2 param_11 = mix((_331 / float2(mix(1.0, buffer.u_scaleStart, buffer.u_globalTransform))) + _198, (_331 / float2(mix(1.0, buffer.u_scaleEnd, buffer.u_globalTransform))) + _198, _354) - mix(_297, _302, _354);
        float4 _413 = float4(mix(float3(1.0), _f4(param_7, param_8, param_9, param_10), float3(fast::clamp(buffer.u_weight, 0.0, 1.0))), 1.0);
        _t8 += ((u_inputTexture.sample(u_inputTextureSmplr, _f3(param_11)) * _413) * float4(float3(mix(1.0 - buffer.u_fallOff, 1.0 + buffer.u_fallOff, _327)), 1.0));
        _t9 += _413;
    }
    float4 _434 = _t8;
    float4 _435 = _434 / _t9;
    _t8 = _435;
    out.o_fragColor = float4(_435);
    return out;
}

