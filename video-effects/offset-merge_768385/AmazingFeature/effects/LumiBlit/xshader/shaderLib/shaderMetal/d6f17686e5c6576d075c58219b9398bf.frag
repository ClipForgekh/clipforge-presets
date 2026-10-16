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
    float u_mirrorEdge;
    float u_tileEdge;
    float2 u_transformPosition;
    float4 u_ScreenParams;
    float u_transformRotation;
    float2 u_transformScale;
    float u_overlayProgress;
    float u_blackWhiteContrast;
    float u_blackWhiteIntensity;
    float u_rgbSeparation;
    float u_rgbSeparationAngle;
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
float2 _f3(thread const float2& _p0, constant float2& u_transformPosition, constant float4& u_ScreenParams, constant float& u_transformRotation, constant float2& u_transformScale)
{
    float2 _t0 = (_p0 - float2(0.5)) - u_transformPosition;
    float _100 = fast::max(u_ScreenParams.z, 9.9999997473787516355514526367188e-05);
    _t0.x *= _100;
    float _111 = radians(-u_transformRotation);
    float _114 = sin(_111);
    float _117 = cos(_111);
    _t0 = (float2x2(float2(_117, -_114), float2(_114, _117)) * _t0) / fast::max(abs(u_transformScale), float2(9.9999997473787516355514526367188e-05));
    _t0.x /= _100;
    return _t0 + float2(0.5);
}

static inline __attribute__((always_inline))
bool _f1(thread const float2& _p0)
{
    bool _51 = all(_p0 >= float2(0.0));
    bool _58;
    if (_51)
    {
        _58 = all(_p0 <= float2(1.0));
    }
    else
    {
        _58 = _51;
    }
    return _58;
}

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float2 _f2(thread const float2& _p0, constant float& u_mirrorEdge, constant float& u_tileEdge)
{
    if (u_mirrorEdge > 0.5)
    {
        float2 param = _p0;
        return _f0(param);
    }
    if (u_tileEdge > 0.5)
    {
        return fract(_p0);
    }
    return _p0;
}

static inline __attribute__((always_inline))
float4 _f4(thread const float2& _p0, constant float& u_mirrorEdge, constant float& u_tileEdge, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr)
{
    bool _149 = (u_mirrorEdge <= 0.5) && (u_tileEdge <= 0.5);
    bool _156;
    if (_149)
    {
        float2 param = _p0;
        _156 = !_f1(param);
    }
    else
    {
        _156 = _149;
    }
    if (_156)
    {
        return float4(0.0);
    }
    float2 param_1 = _p0;
    return u_inputTexture.sample(u_inputTextureSmplr, _f2(param_1, u_mirrorEdge, u_tileEdge));
}

static inline __attribute__((always_inline))
float3 _f5(thread const float2& _p0, constant float& u_mirrorEdge, constant float& u_tileEdge, texture2d<float> u_inputTexture, sampler u_inputTextureSmplr, constant float& u_overlayProgress, constant float& u_blackWhiteContrast, constant float& u_blackWhiteIntensity)
{
    float2 param = _p0;
    float _182 = fast::clamp(u_overlayProgress, 0.0, 1.0);
    float2 param_1 = ((_p0 - float2(0.5)) / float2(1.0 + _182)) + float2(0.5);
    float4 _196 = _f4(param_1, u_mirrorEdge, u_tileEdge, u_inputTexture, u_inputTextureSmplr);
    float4 _t9 = _196;
    float3 _212 = mix(_f4(param, u_mirrorEdge, u_tileEdge, u_inputTexture, u_inputTextureSmplr).xyz, _196.xyz, float3((1.0 - _182) * _t9.w));
    return mix(_212, float3(fast::clamp(((dot(_212, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625)) - 0.5) * fast::clamp(1.0 + u_blackWhiteContrast, 0.0, 4.0)) + 0.5, 0.0, 1.0)), float3(fast::clamp(u_blackWhiteIntensity, 0.0, 1.0)));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float2 param = in.v_uv;
    float2 _250 = _f3(param, buffer.u_transformPosition, buffer.u_ScreenParams, buffer.u_transformRotation, buffer.u_transformScale);
    bool _255 = (buffer.u_mirrorEdge <= 0.5) && (buffer.u_tileEdge <= 0.5);
    bool _262;
    if (_255)
    {
        float2 param_1 = _250;
        _262 = !_f1(param_1);
    }
    else
    {
        _262 = _255;
    }
    if (_262)
    {
        out.o_fragColor = float4(0.0);
        return out;
    }
    float2 param_2 = _250;
    float4 _t17 = _f4(param_2, buffer.u_mirrorEdge, buffer.u_tileEdge, u_inputTexture, u_inputTextureSmplr);
    float2 param_3 = _250;
    float3 _t18 = _f5(param_3, buffer.u_mirrorEdge, buffer.u_tileEdge, u_inputTexture, u_inputTextureSmplr, buffer.u_overlayProgress, buffer.u_blackWhiteContrast, buffer.u_blackWhiteIntensity);
    float _279 = fast::max(buffer.u_rgbSeparation, 0.0);
    if (_279 > 9.9999997473787516355514526367188e-05)
    {
        float2 _287 = fast::max(buffer.u_ScreenParams.xy, float2(1.0));
        float2 _t20 = _287;
        float _304 = radians(buffer.u_rgbSeparationAngle);
        float2 _316 = (float2(cos(_304), sin(_304)) * (_279 * (fast::min(_t20.x, _t20.y) / 720.0))) / _287;
        float2 param_4 = _250 + _316;
        float3 _t28 = _f5(param_4, buffer.u_mirrorEdge, buffer.u_tileEdge, u_inputTexture, u_inputTextureSmplr, buffer.u_overlayProgress, buffer.u_blackWhiteContrast, buffer.u_blackWhiteIntensity);
        float2 param_5 = _250 - _316;
        float3 _t29 = _f5(param_5, buffer.u_mirrorEdge, buffer.u_tileEdge, u_inputTexture, u_inputTextureSmplr, buffer.u_overlayProgress, buffer.u_blackWhiteContrast, buffer.u_blackWhiteIntensity);
        _t18.x = _t28.x;
        _t18.z = _t29.z;
    }
    out.o_fragColor = float4(_t18, _t17.w);
    return out;
}

