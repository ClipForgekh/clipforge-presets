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
    float3 _256 = (_p0 * float4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    float3 _262 = (_p0 * float4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _267 = (_p0 * float4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _272 = (_p0 * float4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    float4 _282 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t17 = _282;
    float3 _298 = fast::normalize((_282.xyz / float3(_t17.w)) - float3(0.0));
    float3 param = float3(0.0);
    float3 param_1 = _298;
    float3 _306 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float3 param_2 = _306;
    float3 param_3 = _256;
    float3 param_4 = _267;
    float4 _t21 = _f3(param, param_1, param_2, param_3, param_4);
    float3 param_5 = float3(0.0);
    float3 param_6 = _298;
    float3 param_7 = _272;
    float3 param_8 = _262;
    float3 _323 = (_p0 * float4(10.0, 10.0, 0.0, 1.0)).xyz;
    float3 param_9 = _323;
    float4 _t22 = _f3(param_5, param_6, param_7, param_8, param_9);
    float3 param_10 = float3(0.0);
    float3 param_11 = _298;
    float3 param_12 = _306;
    float3 param_13 = _267;
    float3 param_14 = _256;
    float4 _t23 = _f3(param_10, param_11, param_12, param_13, param_14);
    float3 param_15 = float3(0.0);
    float3 param_16 = _298;
    float3 param_17 = _272;
    float3 param_18 = _323;
    float3 param_19 = _262;
    float4 _t24 = _f3(param_15, param_16, param_17, param_18, param_19);
    float2 _487 = (((((((float2(-4.5) * ((1.0 - _t21.x) - _t21.y)) + (float2(5.5, -4.5) * _t21.x)) + (float2(-4.5, 5.5) * _t21.y)) * step(0.0, _t21.w)) + ((((float2(-4.5, 5.5) * ((1.0 - _t22.x) - _t22.y)) + (float2(5.5, -4.5) * _t22.x)) + (float2(5.5) * _t22.y)) * (step(_t21.w, 0.0) * step(0.0, _t22.w)))) + ((((float2(-4.5) * ((1.0 - _t23.x) - _t23.y)) + (float2(-4.5, 5.5) * _t23.x)) + (float2(5.5, -4.5) * _t23.y)) * ((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(0.0, _t23.w)))) + ((((float2(-4.5, 5.5) * ((1.0 - _t24.x) - _t24.y)) + (float2(5.5) * _t24.x)) + (float2(5.5, -4.5) * _t24.y)) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(0.0, _t24.w)))) + (float2(-10000.0) * (((step(_t21.w, 0.0) * step(_t22.w, 0.0)) * step(_t23.w, 0.0)) * step(_t24.w, 0.0)));
    return _487;
}

static inline __attribute__((always_inline))
float2 _f6(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f5(thread const float2& _p0)
{
    float2 _t30 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t30.x * _t30.y;
}

static inline __attribute__((always_inline))
float _f2(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float4 _f7(thread const float4& _p0, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode)
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
        _t32 = _f2(param);
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
                _t32 = 1.0 - _f2(param_1);
            }
        }
    }
    return _p0 * _t32;
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
    float _573 = _p0.w;
    float4 _576 = _p0;
    float3 _579 = _576.xyz / float3(fast::max(_573, 9.9999997473787516355514526367188e-06));
    _p0.x = _579.x;
    _p0.y = _579.y;
    _p0.z = _579.z;
    float _587 = _p1.w;
    float4 _589 = _p1;
    float3 _592 = _589.xyz / float3(fast::max(_587, 9.9999997473787516355514526367188e-06));
    _p1.x = _592.x;
    _p1.y = _592.y;
    _p1.z = _592.z;
    float4 _t33 = _p1;
    if (u_blendMode == 1)
    {
        float3 _610 = _p0.xyz + _p1.xyz;
        _t33.x = _610.x;
        _t33.y = _610.y;
        _t33.z = _610.z;
    }
    else
    {
        if (u_blendMode == 7)
        {
            float3 param = _p0.xyz;
            float3 param_1 = _p1.xyz;
            float3 _629 = _f1(param, param_1);
            _t33.x = _629.x;
            _t33.y = _629.y;
            _t33.z = _629.z;
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
            _t35 = _f7(param_2, u_enableMatte, u_maskTexture, u_maskTextureSmplr, uv0, u_matteMode).w;
        }
        float4 _676 = mix(_p1, float4(_t33.xyz, _p0.w), float4(u_layerOpacity * _t35));
        _t34 = _676;
        float _678 = _t34.w;
        float3 _681 = _676.xyz * _678;
        _t34.x = _681.x;
        _t34.y = _681.y;
        _t34.z = _681.z;
    }
    else
    {
        float3 _716 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t33.xyz * (_p0.w * _p1.w));
        _t34.x = _716.x;
        _t34.y = _716.y;
        _t34.z = _716.z;
        _t34.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t34;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTexture [[texture(0)]], texture2d<float> u_baseTexure [[texture(1)]], texture2d<float> u_sourceTexture [[texture(2)]], sampler u_maskTextureSmplr [[sampler(0)]], sampler u_baseTexureSmplr [[sampler(1)]], sampler u_sourceTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _t36 = float4(0.0);
    bool _739 = buffer.u_hasBlend == 1;
    if (_739)
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
        float2 _777 = _f4(param, param_1, param_2);
        float _780 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_3 = _777;
        float2 _790 = (_777 * _780) + (_f6(param_3) * (1.0 - _780));
        float2 param_4 = _790;
        _t37 = (u_sourceTexture.sample(u_sourceTextureSmplr, _790) * buffer.u_alpha) * _f5(param_4);
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
        _t37 = _f7(param_5, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode);
    }
    if (_739)
    {
        float4 param_6 = _t37;
        float4 param_7 = _t36;
        float4 _828 = _f8(param_6, param_7, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode, buffer.u_blendMode, buffer.u_layerType, buffer.u_hasMatte, buffer.u_layerOpacity);
        _t37 = _828;
    }
    out.o_fragColor = _t37;
    return out;
}

