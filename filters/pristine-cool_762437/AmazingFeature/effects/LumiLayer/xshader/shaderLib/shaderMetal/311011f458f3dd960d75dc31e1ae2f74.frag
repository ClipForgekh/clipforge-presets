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
    int u_enableMatte;
    int u_matteMode;
    int u_blendMode;
    int u_layerType;
    int u_hasMatte;
    float u_layerOpacity;
    int u_hasBlend;
    int u_hasBaseTexture;
    int u_hasSourceTexture;
    int u_hasTrs;
    float4x4 u_mvMat;
    float4x4 u_pMat;
    float u_mirrorEdge;
    float u_alpha;
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
float4 _f4(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float3& _p3, thread const float3& _p4)
{
    float3 _235 = _p3 - _p2;
    float3 _239 = _p4 - _p2;
    float3 _243 = cross(_p1, _239);
    float _247 = dot(_235, _243);
    if (_247 <= 1.0000000116860974230803549289703e-07)
    {
        return float4(-1.0);
    }
    float3 _259 = _p0 - _p2;
    float _265 = dot(_259, _243) / _247;
    if ((_265 < 0.0) || (_265 > 1.0))
    {
        return float4(-1.0);
    }
    float3 _277 = cross(_259, _235);
    float _283 = dot(_p1, _277) / _247;
    bool _285 = _283 < 0.0;
    bool _293;
    if (!_285)
    {
        _293 = (_265 + _283) > 1.0;
    }
    else
    {
        _293 = _285;
    }
    if (_293)
    {
        return float4(-1.0);
    }
    return float4(_265, _283, dot(_239, _277) / _247, 1.0);
}

static inline __attribute__((always_inline))
float2 _f5(thread const float4x4& _p0, thread const float4x4& _p1, thread const float2& _p2)
{
    float3 _332 = (_p0 * float4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    float3 _338 = (_p0 * float4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _343 = (_p0 * float4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _348 = (_p0 * float4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    float4 _358 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t20 = _358;
    float3 _374 = fast::normalize((_358.xyz / float3(_t20.w)) - float3(0.0));
    float3 param = float3(0.0);
    float3 param_1 = _374;
    float3 _382 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float3 param_2 = _382;
    float3 param_3 = _332;
    float3 param_4 = _343;
    float4 _t24 = _f4(param, param_1, param_2, param_3, param_4);
    float3 param_5 = float3(0.0);
    float3 param_6 = _374;
    float3 param_7 = _348;
    float3 param_8 = _338;
    float3 _399 = (_p0 * float4(10.0, 10.0, 0.0, 1.0)).xyz;
    float3 param_9 = _399;
    float4 _t25 = _f4(param_5, param_6, param_7, param_8, param_9);
    float3 param_10 = float3(0.0);
    float3 param_11 = _374;
    float3 param_12 = _382;
    float3 param_13 = _343;
    float3 param_14 = _332;
    float4 _t26 = _f4(param_10, param_11, param_12, param_13, param_14);
    float3 param_15 = float3(0.0);
    float3 param_16 = _374;
    float3 param_17 = _348;
    float3 param_18 = _399;
    float3 param_19 = _338;
    float4 _t27 = _f4(param_15, param_16, param_17, param_18, param_19);
    float2 _563 = (((((((float2(-4.5) * ((1.0 - _t24.x) - _t24.y)) + (float2(5.5, -4.5) * _t24.x)) + (float2(-4.5, 5.5) * _t24.y)) * step(0.0, _t24.w)) + ((((float2(-4.5, 5.5) * ((1.0 - _t25.x) - _t25.y)) + (float2(5.5, -4.5) * _t25.x)) + (float2(5.5) * _t25.y)) * (step(_t24.w, 0.0) * step(0.0, _t25.w)))) + ((((float2(-4.5) * ((1.0 - _t26.x) - _t26.y)) + (float2(-4.5, 5.5) * _t26.x)) + (float2(5.5, -4.5) * _t26.y)) * ((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(0.0, _t26.w)))) + ((((float2(-4.5, 5.5) * ((1.0 - _t27.x) - _t27.y)) + (float2(5.5) * _t27.x)) + (float2(5.5, -4.5) * _t27.y)) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(0.0, _t27.w)))) + (float2(-10000.0) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(_t27.w, 0.0)));
    return _563;
}

static inline __attribute__((always_inline))
float2 _f7(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f6(thread const float2& _p0)
{
    float2 _t33 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t33.x * _t33.y;
}

static inline __attribute__((always_inline))
float _f2(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float4 _f8(thread const float4& _p0, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode)
{
    float4 _t34 = float4(0.0);
    if (u_enableMatte == 1)
    {
        _t34 = u_maskTexture.sample(u_maskTextureSmplr, uv0);
    }
    float _t35 = _t34.w;
    if (u_matteMode == 1)
    {
        float3 param = _t34.xyz;
        _t35 = _f2(param);
    }
    else
    {
        if (u_matteMode == 2)
        {
            _t35 = 1.0 - _t34.w;
        }
        else
        {
            if (u_matteMode == 3)
            {
                float3 param_1 = _t34.xyz;
                _t35 = 1.0 - _f2(param_1);
            }
        }
    }
    return _p0 * _t35;
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0, thread const float& _p1)
{
    float _74;
    if (_p0 < 0.5)
    {
        _74 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _93;
        if (_p1 < 0.25)
        {
            _93 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _93 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _74 = _93;
    }
    return _74;
}

static inline __attribute__((always_inline))
float3 _f1(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f0(param, param_1), _f0(param_2, param_3), _f0(param_4, param_5));
}

static inline __attribute__((always_inline))
float3 _f3(thread float3& _p0, thread float& _p1)
{
    float3 param = _p0;
    _p0 += float3(_p1 - _f2(param));
    float3 param_1 = _p0;
    _p1 = _f2(param_1);
    float _185 = fast::min(_p0.x, fast::min(_p0.y, _p0.z));
    float _188 = _p0.x;
    float _190 = _p0.y;
    float _192 = _p0.z;
    float _194 = fast::max(_188, fast::max(_190, _192));
    if (_185 < 0.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3(_p1 / (_p1 - _185)));
    }
    if (_194 > 1.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3((1.0 - _p1) / (_194 - _p1)));
    }
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f9(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f2(param);
    float3 _654 = _f3(param_1, param_2);
    return _654;
}

static inline __attribute__((always_inline))
float4 _f10(thread float4& _p0, thread float4& _p1, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode, constant int& u_blendMode, constant int& u_layerType, constant int& u_hasMatte, constant float& u_layerOpacity)
{
    float _658 = _p0.w;
    float4 _661 = _p0;
    float3 _664 = _661.xyz / float3(fast::max(_658, 9.9999997473787516355514526367188e-06));
    _p0.x = _664.x;
    _p0.y = _664.y;
    _p0.z = _664.z;
    float _672 = _p1.w;
    float4 _674 = _p1;
    float3 _677 = _674.xyz / float3(fast::max(_672, 9.9999997473787516355514526367188e-06));
    _p1.x = _677.x;
    _p1.y = _677.y;
    _p1.z = _677.z;
    float4 _t36 = _p1;
    if (u_blendMode == 7)
    {
        float3 param = _p0.xyz;
        float3 param_1 = _p1.xyz;
        float3 _698 = _f1(param, param_1);
        _t36.x = _698.x;
        _t36.y = _698.y;
        _t36.z = _698.z;
    }
    else
    {
        if (u_blendMode == 11)
        {
            float3 param_2 = _p0.xyz;
            float3 param_3 = _p1.xyz;
            float3 _717 = _f9(param_2, param_3);
            _t36.x = _717.x;
            _t36.y = _717.y;
            _t36.z = _717.z;
        }
        else
        {
            _t36.x = _p0.xyz.x;
            _t36.y = _p0.xyz.y;
            _t36.z = _p0.xyz.z;
        }
    }
    float4 _t37 = float4(0.0);
    if (u_layerType == 1)
    {
        float _t38 = 1.0;
        if (u_hasMatte == 1)
        {
            float4 param_4 = float4(1.0);
            _t38 = _f8(param_4, u_enableMatte, u_maskTexture, u_maskTextureSmplr, uv0, u_matteMode).w;
        }
        float4 _764 = mix(_p1, float4(_t36.xyz, _p0.w), float4(u_layerOpacity * _t38));
        _t37 = _764;
        float _766 = _t37.w;
        float3 _769 = _764.xyz * _766;
        _t37.x = _769.x;
        _t37.y = _769.y;
        _t37.z = _769.z;
    }
    else
    {
        float3 _804 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t36.xyz * (_p0.w * _p1.w));
        _t37.x = _804.x;
        _t37.y = _804.y;
        _t37.z = _804.z;
        _t37.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t37;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTexture [[texture(0)]], texture2d<float> u_baseTexure [[texture(1)]], texture2d<float> u_sourceTexture [[texture(2)]], sampler u_maskTextureSmplr [[sampler(0)]], sampler u_baseTexureSmplr [[sampler(1)]], sampler u_sourceTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _t39 = float4(0.0);
    bool _827 = buffer.u_hasBlend == 1;
    if (_827)
    {
        if (buffer.u_hasBaseTexture == 1)
        {
            _t39 = u_baseTexure.sample(u_baseTexureSmplr, in.uv0);
        }
        if (buffer.u_hasSourceTexture == 0)
        {
            out.o_fragColor = _t39;
            return out;
        }
    }
    float4 _t40 = float4(0.0);
    if (buffer.u_hasTrs == 1)
    {
        float4x4 param = buffer.u_mvMat;
        float4x4 param_1 = buffer.u_pMat;
        float2 param_2 = in.uv0;
        float2 _865 = _f5(param, param_1, param_2);
        float _868 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_3 = _865;
        float2 _878 = (_865 * _868) + (_f7(param_3) * (1.0 - _868));
        float2 param_4 = _878;
        _t40 = (u_sourceTexture.sample(u_sourceTextureSmplr, _878) * buffer.u_alpha) * _f6(param_4);
    }
    else
    {
        if (buffer.u_hasSourceTexture == 1)
        {
            _t40 = u_sourceTexture.sample(u_sourceTextureSmplr, in.uv0);
        }
    }
    if ((buffer.u_layerType != 1) && (buffer.u_hasMatte == 1))
    {
        float4 param_5 = _t40;
        _t40 = _f8(param_5, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode);
    }
    if (_827)
    {
        float4 param_6 = _t40;
        float4 param_7 = _t39;
        float4 _916 = _f10(param_6, param_7, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode, buffer.u_blendMode, buffer.u_layerType, buffer.u_hasMatte, buffer.u_layerOpacity);
        _t40 = _916;
    }
    out.o_fragColor = _t40;
    return out;
}

