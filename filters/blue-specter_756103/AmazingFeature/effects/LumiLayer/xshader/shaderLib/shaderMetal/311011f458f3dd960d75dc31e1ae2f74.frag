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
float4 _f3(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float3& _p3, thread const float3& _p4)
{
    float3 _158 = _p3 - _p2;
    float3 _162 = _p4 - _p2;
    float3 _166 = cross(_p1, _162);
    float _170 = dot(_158, _166);
    if (_170 <= 1.0000000116860974230803549289703e-07)
    {
        return float4(-1.0);
    }
    float3 _182 = _p0 - _p2;
    float _188 = dot(_182, _166) / _170;
    if ((_188 < 0.0) || (_188 > 1.0))
    {
        return float4(-1.0);
    }
    float3 _201 = cross(_182, _158);
    float _207 = dot(_p1, _201) / _170;
    bool _209 = _207 < 0.0;
    bool _217;
    if (!_209)
    {
        _217 = (_188 + _207) > 1.0;
    }
    else
    {
        _217 = _209;
    }
    if (_217)
    {
        return float4(-1.0);
    }
    return float4(_188, _207, dot(_162, _201) / _170, 1.0);
}

static inline __attribute__((always_inline))
float2 _f4(thread const float4x4& _p0, thread const float4x4& _p1, thread const float2& _p2)
{
    float4 _260 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t13 = _260;
    float3 _276 = fast::normalize((_260.xyz / float3(_t13.w)) - float3(0.0));
    float3 _279 = (_p0 * float4(10.0, -10.0, 0.0, 1.0)).xyz;
    float3 _282 = _279 + float3(9.9999997473787516355514526367188e-06, 0.0, 0.0);
    float3 _284 = (_p0 * float4(-10.0, 10.0, 0.0, 1.0)).xyz;
    float3 _286 = _284 + float3(0.0, 9.9999997473787516355514526367188e-06, 0.0);
    float3 param = float3(0.0);
    float3 param_1 = _276;
    float3 _293 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float3 param_2 = _293;
    float3 param_3 = _282;
    float3 param_4 = _286;
    float4 _t17 = _f3(param, param_1, param_2, param_3, param_4);
    float3 _300 = _284 - float3(9.9999997473787516355514526367188e-06, 0.0, 0.0);
    float3 _303 = _279 - float3(0.0, 9.9999997473787516355514526367188e-06, 0.0);
    float3 param_5 = float3(0.0);
    float3 param_6 = _276;
    float3 param_7 = _300;
    float3 param_8 = _303;
    float3 _312 = (_p0 * float4(10.0, 10.0, 0.0, 1.0)).xyz;
    float3 param_9 = _312;
    float4 _t18 = _f3(param_5, param_6, param_7, param_8, param_9);
    float3 param_10 = float3(0.0);
    float3 param_11 = _276;
    float3 param_12 = _293;
    float3 param_13 = _286;
    float3 param_14 = _282;
    float4 _t19 = _f3(param_10, param_11, param_12, param_13, param_14);
    float3 param_15 = float3(0.0);
    float3 param_16 = _276;
    float3 param_17 = _300;
    float3 param_18 = _312;
    float3 param_19 = _303;
    float4 _t20 = _f3(param_15, param_16, param_17, param_18, param_19);
    float2 _484 = (((((((float2(-4.5) * ((1.0 - _t17.x) - _t17.y)) + (float2(5.5, -4.5) * _t17.x)) + (float2(-4.5, 5.5) * _t17.y)) * step(0.0, _t17.w)) + ((((float2(-4.5, 5.5) * ((1.0 - _t18.x) - _t18.y)) + (float2(5.5, -4.5) * _t18.x)) + (float2(5.5) * _t18.y)) * (step(_t17.w, 0.0) * step(0.0, _t18.w)))) + ((((float2(-4.5) * ((1.0 - _t19.x) - _t19.y)) + (float2(-4.5, 5.5) * _t19.x)) + (float2(5.5, -4.5) * _t19.y)) * ((step(_t17.w, 0.0) * step(_t18.w, 0.0)) * step(0.0, _t19.w)))) + ((((float2(-4.5, 5.5) * ((1.0 - _t20.x) - _t20.y)) + (float2(5.5) * _t20.x)) + (float2(5.5, -4.5) * _t20.y)) * (((step(_t17.w, 0.0) * step(_t18.w, 0.0)) * step(_t19.w, 0.0)) * step(0.0, _t20.w)))) + (float2(-10000.0) * (((step(_t17.w, 0.0) * step(_t18.w, 0.0)) * step(_t19.w, 0.0)) * step(_t20.w, 0.0)));
    return _484;
}

static inline __attribute__((always_inline))
float2 _f6(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f5(thread const float2& _p0)
{
    float2 _t26 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t26.x * _t26.y;
}

static inline __attribute__((always_inline))
float _f2(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float4 _f7(thread const float4& _p0, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode)
{
    float4 _t27 = float4(0.0);
    if (u_enableMatte == 1)
    {
        _t27 = u_maskTexture.sample(u_maskTextureSmplr, uv0);
    }
    float _t28 = _t27.w;
    if (u_matteMode == 1)
    {
        float3 param = _t27.xyz;
        _t28 = _f2(param);
    }
    else
    {
        if (u_matteMode == 2)
        {
            _t28 = 1.0 - _t27.w;
        }
        else
        {
            if (u_matteMode == 3)
            {
                float3 param_1 = _t27.xyz;
                _t28 = 1.0 - _f2(param_1);
            }
        }
    }
    return _p0 * _t28;
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0, thread const float& _p1)
{
    float _65;
    if (_p0 < 0.5)
    {
        _65 = _p1 - (((1.0 - (2.0 * _p0)) * _p1) * (1.0 - _p1));
    }
    else
    {
        float _84;
        if (_p1 < 0.25)
        {
            _84 = _p1 + ((((2.0 * _p0) - 1.0) * _p1) * ((((16.0 * _p1) - 12.0) * _p1) + 3.0));
        }
        else
        {
            _84 = _p1 + (((2.0 * _p0) - 1.0) * (sqrt(_p1) - _p1));
        }
        _65 = _84;
    }
    return _65;
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
float4 _f8(thread float4& _p0, thread float4& _p1, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode, constant int& u_blendMode, constant int& u_layerType, constant int& u_hasMatte, constant float& u_layerOpacity)
{
    float _570 = _p0.w;
    float4 _572 = _p0;
    float3 _575 = _572.xyz / float3(fast::max(_570, 9.9999997473787516355514526367188e-06));
    _p0.x = _575.x;
    _p0.y = _575.y;
    _p0.z = _575.z;
    float _583 = _p1.w;
    float4 _585 = _p1;
    float3 _588 = _585.xyz / float3(fast::max(_583, 9.9999997473787516355514526367188e-06));
    _p1.x = _588.x;
    _p1.y = _588.y;
    _p1.z = _588.z;
    float4 _t29 = _p1;
    if (u_blendMode == 7)
    {
        float3 param = _p0.xyz;
        float3 param_1 = _p1.xyz;
        float3 _609 = _f1(param, param_1);
        _t29.x = _609.x;
        _t29.y = _609.y;
        _t29.z = _609.z;
    }
    else
    {
        _t29.x = _p0.xyz.x;
        _t29.y = _p0.xyz.y;
        _t29.z = _p0.xyz.z;
    }
    float4 _t30 = float4(0.0);
    if (u_layerType == 1)
    {
        float _t31 = 1.0;
        if (u_hasMatte == 1)
        {
            float4 param_2 = float4(1.0);
            _t31 = _f7(param_2, u_enableMatte, u_maskTexture, u_maskTextureSmplr, uv0, u_matteMode).w;
        }
        float4 _656 = mix(_p1, float4(_t29.xyz, _p0.w), float4(u_layerOpacity * _t31));
        _t30 = _656;
        float _658 = _t30.w;
        float3 _661 = _656.xyz * _658;
        _t30.x = _661.x;
        _t30.y = _661.y;
        _t30.z = _661.z;
    }
    else
    {
        float3 _696 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t29.xyz * (_p0.w * _p1.w));
        _t30.x = _696.x;
        _t30.y = _696.y;
        _t30.z = _696.z;
        _t30.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t30;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTexture [[texture(0)]], texture2d<float> u_baseTexure [[texture(1)]], texture2d<float> u_sourceTexture [[texture(2)]], sampler u_maskTextureSmplr [[sampler(0)]], sampler u_baseTexureSmplr [[sampler(1)]], sampler u_sourceTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _t32 = float4(0.0);
    bool _719 = buffer.u_hasBlend == 1;
    if (_719)
    {
        if (buffer.u_hasBaseTexture == 1)
        {
            _t32 = u_baseTexure.sample(u_baseTexureSmplr, in.uv0);
        }
        if (buffer.u_hasSourceTexture == 0)
        {
            out.o_fragColor = _t32;
            return out;
        }
    }
    float4 _t33 = float4(0.0);
    if (buffer.u_hasTrs == 1)
    {
        float4x4 param = buffer.u_mvMat;
        float4x4 param_1 = buffer.u_pMat;
        float2 param_2 = in.uv0;
        float2 _757 = _f4(param, param_1, param_2);
        float _760 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_3 = _757;
        float2 _770 = (_757 * _760) + (_f6(param_3) * (1.0 - _760));
        float2 param_4 = _770;
        _t33 = (u_sourceTexture.sample(u_sourceTextureSmplr, _770) * buffer.u_alpha) * _f5(param_4);
    }
    else
    {
        if (buffer.u_hasSourceTexture == 1)
        {
            _t33 = u_sourceTexture.sample(u_sourceTextureSmplr, in.uv0);
        }
    }
    if ((buffer.u_layerType != 1) && (buffer.u_hasMatte == 1))
    {
        float4 param_5 = _t33;
        _t33 = _f7(param_5, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode);
    }
    if (_719)
    {
        float4 param_6 = _t33;
        float4 param_7 = _t32;
        float4 _808 = _f8(param_6, param_7, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode, buffer.u_blendMode, buffer.u_layerType, buffer.u_hasMatte, buffer.u_layerOpacity);
        _t33 = _808;
    }
    out.o_fragColor = _t33;
    return out;
}

