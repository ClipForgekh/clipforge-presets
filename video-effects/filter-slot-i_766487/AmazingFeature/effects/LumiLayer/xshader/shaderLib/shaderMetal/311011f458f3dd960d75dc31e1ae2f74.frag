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
float4 _f1(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float3& _p3, thread const float3& _p4)
{
    float3 _80 = _p3 - _p2;
    float3 _84 = _p4 - _p2;
    float3 _88 = cross(_p1, _84);
    float _92 = dot(_80, _88);
    if (_92 <= 1.0000000116860974230803549289703e-07)
    {
        return float4(-1.0);
    }
    float3 _105 = _p0 - _p2;
    float _111 = dot(_105, _88) / _92;
    if ((_111 < 0.0) || (_111 > 1.0))
    {
        return float4(-1.0);
    }
    float3 _125 = cross(_105, _80);
    float _131 = dot(_p1, _125) / _92;
    bool _133 = _131 < 0.0;
    bool _141;
    if (!_133)
    {
        _141 = (_111 + _131) > 1.0;
    }
    else
    {
        _141 = _133;
    }
    if (_141)
    {
        return float4(-1.0);
    }
    return float4(_111, _131, dot(_84, _125) / _92, 1.0);
}

static inline __attribute__((always_inline))
float2 _f2(thread const float4x4& _p0, thread const float4x4& _p1, thread const float2& _p2)
{
    float3 _180 = (_p0 * float4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    float3 _186 = (_p0 * float4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _191 = (_p0 * float4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _196 = (_p0 * float4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    float4 _207 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t17 = _207;
    float3 _224 = fast::normalize((_207.xyz / float3(_t17.w)) - float3(0.0));
    float3 param = float3(0.0);
    float3 param_1 = _224;
    float3 _232 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float3 param_2 = _232;
    float3 param_3 = _180;
    float3 param_4 = _191;
    float4 _t21 = _f1(param, param_1, param_2, param_3, param_4);
    float3 param_5 = float3(0.0);
    float3 param_6 = _224;
    float3 param_7 = _196;
    float3 param_8 = _186;
    float3 _249 = (_p0 * float4(10.0, 10.0, 0.0, 1.0)).xyz;
    float3 param_9 = _249;
    float4 _t22 = _f1(param_5, param_6, param_7, param_8, param_9);
    float3 param_10 = float3(0.0);
    float3 param_11 = _224;
    float3 param_12 = _232;
    float3 param_13 = _191;
    float3 param_14 = _180;
    float4 _t23 = _f1(param_10, param_11, param_12, param_13, param_14);
    float3 param_15 = float3(0.0);
    float3 param_16 = _224;
    float3 param_17 = _196;
    float3 param_18 = _249;
    float3 param_19 = _186;
    float4 _t24 = _f1(param_15, param_16, param_17, param_18, param_19);
    float2 _415 = (((((((float2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (float2(5.5, -4.5) * _t21.x)) + (float2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((float2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (float2(5.5, -4.5) * _t22.x)) + (float2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((float2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (float2(-4.5, 5.5) * _t23.x)) + (float2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((float2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (float2(5.5) * _t24.x)) + (float2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (float2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _415;
}

static inline __attribute__((always_inline))
float2 _f4(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f3(thread const float2& _p0)
{
    float2 _t30 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t30.x * _t30.y;
}

static inline __attribute__((always_inline))
float _f0(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float4 _f5(thread const float4& _p0, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode)
{
    float4 _t31 = float4(0.0);
    if (u_enableMatte == 1)
    {
        _t31 = u_maskTexture.sample(u_maskTextureSmplr, uv0);
    }
    float _t32 = _t31.w;
    if (u_matteMode == 1)
    {
        float3 param = _t31.xyz;
        _t32 = _f0(param);
    }
    else
    {
        if (u_matteMode == 2)
        {
            _t32 = 1.0 - _t31.w;
        }
        else
        {
            if (u_matteMode == 3)
            {
                float3 param_1 = _t31.xyz;
                _t32 = 1.0 - _f0(param_1);
            }
        }
    }
    return _p0 * _t32;
}

static inline __attribute__((always_inline))
float _f6(thread const float& _p0, thread const float& _p1)
{
    if (_p1 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        if (_p0 <= 0.0)
        {
            return 0.0;
        }
        else
        {
            return 1.0 - fast::min(1.0, (1.0 - _p1) / _p0);
        }
    }
}

static inline __attribute__((always_inline))
float _f7(thread const float& _p0, thread const float& _p1)
{
    if (_p1 <= 0.0)
    {
        return 0.0;
    }
    if (_p0 >= 1.0)
    {
        return 1.0;
    }
    else
    {
        return fast::min(1.0, _p1 / (1.0 - _p0));
    }
}

static inline __attribute__((always_inline))
float _f8(thread const float& _p0, thread const float& _p1)
{
    float _541;
    if (_p0 <= 0.5)
    {
        float param = _p1;
        float param_1 = 2.0 * _p0;
        _541 = _f6(param, param_1);
    }
    else
    {
        float param_2 = _p1;
        float param_3 = 2.0 * (_p0 - 0.5);
        _541 = _f7(param_2, param_3);
    }
    return _541;
}

static inline __attribute__((always_inline))
float3 _f9(thread const float3& _p0, thread const float3& _p1)
{
    float param = _p0.x;
    float param_1 = _p1.x;
    float param_2 = _p0.y;
    float param_3 = _p1.y;
    float param_4 = _p0.z;
    float param_5 = _p1.z;
    return float3(_f8(param, param_1), _f8(param_2, param_3), _f8(param_4, param_5));
}

static inline __attribute__((always_inline))
float4 _f10(thread float4& _p0, thread float4& _p1, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode, constant int& u_blendMode, constant int& u_layerType, constant int& u_hasMatte, constant float& u_layerOpacity)
{
    float _587 = _p0.w;
    float4 _590 = _p0;
    float3 _593 = _590.xyz / float3(fast::max(_587, 9.9999997473787516355514526367188e-06));
    _p0.x = _593.x;
    _p0.y = _593.y;
    _p0.z = _593.z;
    float _601 = _p1.w;
    float4 _603 = _p1;
    float3 _606 = _603.xyz / float3(fast::max(_601, 9.9999997473787516355514526367188e-06));
    _p1.x = _606.x;
    _p1.y = _606.y;
    _p1.z = _606.z;
    float4 _t33 = _p1;
    if (u_blendMode == 2)
    {
        float3 _624 = _p0.xyz * _p1.xyz;
        _t33.x = _624.x;
        _t33.y = _624.y;
        _t33.z = _624.z;
    }
    else
    {
        if (u_blendMode == 17)
        {
            float3 param = _p0.xyz;
            float3 param_1 = _p1.xyz;
            float3 _643 = _f9(param, param_1);
            _t33.x = _643.x;
            _t33.y = _643.y;
            _t33.z = _643.z;
        }
        else
        {
            _t33.x = _p0.xyz.x;
            _t33.y = _p0.xyz.y;
            _t33.z = _p0.xyz.z;
        }
    }
    float4 _t34 = float4(0.0);
    if (u_layerType == 1)
    {
        float _t35 = 1.0;
        if (u_hasMatte == 1)
        {
            float4 param_2 = float4(1.0);
            _t35 = _f5(param_2, u_enableMatte, u_maskTexture, u_maskTextureSmplr, uv0, u_matteMode).w;
        }
        float4 _690 = mix(_p1, float4(_t33.xyz, _p0.w), float4(u_layerOpacity * _t35));
        _t34 = _690;
        float _692 = _t34.w;
        float3 _695 = _690.xyz * _692;
        _t34.x = _695.x;
        _t34.y = _695.y;
        _t34.z = _695.z;
    }
    else
    {
        float3 _730 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t33.xyz * (_p0.w * _p1.w));
        _t34.x = _730.x;
        _t34.y = _730.y;
        _t34.z = _730.z;
        _t34.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t34;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTexture [[texture(0)]], texture2d<float> u_baseTexure [[texture(1)]], texture2d<float> u_sourceTexture [[texture(2)]], sampler u_maskTextureSmplr [[sampler(0)]], sampler u_baseTexureSmplr [[sampler(1)]], sampler u_sourceTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _t36 = float4(0.0);
    bool _753 = buffer.u_hasBlend == 1;
    if (_753)
    {
        if (buffer.u_hasBaseTexture == 1)
        {
            _t36 = u_baseTexure.sample(u_baseTexureSmplr, in.uv0);
        }
        if (buffer.u_hasSourceTexture == 0)
        {
            out.o_fragColor = _t36;
            return out;
        }
    }
    float4 _t37 = float4(0.0);
    if (buffer.u_hasTrs == 1)
    {
        float4x4 param = buffer.u_mvMat;
        float4x4 param_1 = buffer.u_pMat;
        float2 param_2 = in.uv0;
        float2 _791 = _f2(param, param_1, param_2);
        float _794 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_3 = _791;
        float2 _804 = (_791 * _794) + (_f4(param_3) * (1.0 - _794));
        float2 param_4 = _804;
        _t37 = (u_sourceTexture.sample(u_sourceTextureSmplr, _804) * buffer.u_alpha) * _f3(param_4);
    }
    else
    {
        if (buffer.u_hasSourceTexture == 1)
        {
            _t37 = u_sourceTexture.sample(u_sourceTextureSmplr, in.uv0);
        }
    }
    if ((buffer.u_layerType != 1) && (buffer.u_hasMatte == 1))
    {
        float4 param_5 = _t37;
        _t37 = _f5(param_5, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode);
    }
    if (_753)
    {
        float4 param_6 = _t37;
        float4 param_7 = _t36;
        float4 _842 = _f10(param_6, param_7, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode, buffer.u_blendMode, buffer.u_layerType, buffer.u_hasMatte, buffer.u_layerOpacity);
        _t37 = _842;
    }
    out.o_fragColor = _t37;
    return out;
}

