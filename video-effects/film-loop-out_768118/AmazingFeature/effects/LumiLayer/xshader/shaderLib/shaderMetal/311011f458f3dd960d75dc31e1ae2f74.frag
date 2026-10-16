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
float4 _f2(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float3& _p3, thread const float3& _p4)
{
    float3 _146 = _p3 - _p2;
    float3 _150 = _p4 - _p2;
    float3 _154 = cross(_p1, _150);
    float _158 = dot(_146, _154);
    if (_158 <= 1.0000000116860974230803549289703e-07)
    {
        return float4(-1.0);
    }
    float3 _170 = _p0 - _p2;
    float _176 = dot(_170, _154) / _158;
    if ((_176 < 0.0) || (_176 > 1.0))
    {
        return float4(-1.0);
    }
    float3 _188 = cross(_170, _146);
    float _194 = dot(_p1, _188) / _158;
    bool _196 = _194 < 0.0;
    bool _204;
    if (!_196)
    {
        _204 = (_176 + _194) > 1.0;
    }
    else
    {
        _204 = _196;
    }
    if (_204)
    {
        return float4(-1.0);
    }
    return float4(_176, _194, dot(_150, _188) / _158, 1.0);
}

static inline __attribute__((always_inline))
float2 _f3(thread const float4x4& _p0, thread const float4x4& _p1, thread const float2& _p2)
{
    float3 _243 = (_p0 * float4(10.0000095367431640625, -10.0, 0.0, 1.0)).xyz;
    float3 _249 = (_p0 * float4(10.0, -10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _254 = (_p0 * float4(-10.0, 10.0000095367431640625, 0.0, 1.0)).xyz;
    float3 _259 = (_p0 * float4(-10.0000095367431640625, 10.0, 0.0, 1.0)).xyz;
    float4 _270 = _p1 * float4((_p2 * 2.0) - float2(1.0), 0.0, 1.0);
    float4 _t20 = _270;
    float3 _286 = fast::normalize((_270.xyz / float3(_t20.w)) - float3(0.0));
    float3 param = float3(0.0);
    float3 param_1 = _286;
    float3 _294 = (_p0 * float4(-10.0, -10.0, 0.0, 1.0)).xyz;
    float3 param_2 = _294;
    float3 param_3 = _243;
    float3 param_4 = _254;
    float4 _t24 = _f2(param, param_1, param_2, param_3, param_4);
    float3 param_5 = float3(0.0);
    float3 param_6 = _286;
    float3 param_7 = _259;
    float3 param_8 = _249;
    float3 _311 = (_p0 * float4(10.0, 10.0, 0.0, 1.0)).xyz;
    float3 param_9 = _311;
    float4 _t25 = _f2(param_5, param_6, param_7, param_8, param_9);
    float3 param_10 = float3(0.0);
    float3 param_11 = _286;
    float3 param_12 = _294;
    float3 param_13 = _254;
    float3 param_14 = _243;
    float4 _t26 = _f2(param_10, param_11, param_12, param_13, param_14);
    float3 param_15 = float3(0.0);
    float3 param_16 = _286;
    float3 param_17 = _259;
    float3 param_18 = _311;
    float3 param_19 = _249;
    float4 _t27 = _f2(param_15, param_16, param_17, param_18, param_19);
    float2 _475 = (((((((float2(-4.5) * ((1.0 - _t24.x) - _t24.y)) + (float2(5.5, -4.5) * _t24.x)) + (float2(-4.5, 5.5) * _t24.y)) * step(0.0, _t24.w)) + ((((float2(-4.5, 5.5) * ((1.0 - _t25.x) - _t25.y)) + (float2(5.5, -4.5) * _t25.x)) + (float2(5.5) * _t25.y)) * (step(_t24.w, 0.0) * step(0.0, _t25.w)))) + ((((float2(-4.5) * ((1.0 - _t26.x) - _t26.y)) + (float2(-4.5, 5.5) * _t26.x)) + (float2(5.5, -4.5) * _t26.y)) * ((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(0.0, _t26.w)))) + ((((float2(-4.5, 5.5) * ((1.0 - _t27.x) - _t27.y)) + (float2(5.5) * _t27.x)) + (float2(5.5, -4.5) * _t27.y)) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(0.0, _t27.w)))) + (float2(-10000.0) * (((step(_t24.w, 0.0) * step(_t25.w, 0.0)) * step(_t26.w, 0.0)) * step(_t27.w, 0.0)));
    return _475;
}

static inline __attribute__((always_inline))
float2 _f5(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f4(thread const float2& _p0)
{
    float2 _t33 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t33.x * _t33.y;
}

static inline __attribute__((always_inline))
float _f0(thread const float3& _p0)
{
    return dot(_p0, float3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625));
}

static inline __attribute__((always_inline))
float4 _f6(thread const float4& _p0, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode)
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
        _t35 = _f0(param);
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
                _t35 = 1.0 - _f0(param_1);
            }
        }
    }
    return _p0 * _t35;
}

static inline __attribute__((always_inline))
float3 _f1(thread float3& _p0, thread float& _p1)
{
    float3 param = _p0;
    _p0 += float3(_p1 - _f0(param));
    float3 param_1 = _p0;
    _p1 = _f0(param_1);
    float _94 = fast::min(_p0.x, fast::min(_p0.y, _p0.z));
    float _97 = _p0.x;
    float _99 = _p0.y;
    float _101 = _p0.z;
    float _103 = fast::max(_97, fast::max(_99, _101));
    if (_94 < 0.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3(_p1 / (_p1 - _94)));
    }
    if (_103 > 1.0)
    {
        _p0 = mix(float3(_p1, _p1, _p1), _p0, float3((1.0 - _p1) / (_103 - _p1)));
    }
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f7(thread const float3& _p0, thread const float3& _p1)
{
    float3 param = _p1;
    float3 param_1 = _p0;
    float param_2 = _f0(param);
    float3 _566 = _f1(param_1, param_2);
    return _566;
}

static inline __attribute__((always_inline))
float4 _f8(thread float4& _p0, thread float4& _p1, constant int& u_enableMatte, texture2d<float> u_maskTexture, sampler u_maskTextureSmplr, thread float2& uv0, constant int& u_matteMode, constant int& u_blendMode, constant int& u_layerType, constant int& u_hasMatte, constant float& u_layerOpacity)
{
    float _570 = _p0.w;
    float4 _573 = _p0;
    float3 _576 = _573.xyz / float3(fast::max(_570, 9.9999997473787516355514526367188e-06));
    _p0.x = _576.x;
    _p0.y = _576.y;
    _p0.z = _576.z;
    float _584 = _p1.w;
    float4 _586 = _p1;
    float3 _589 = _586.xyz / float3(fast::max(_584, 9.9999997473787516355514526367188e-06));
    _p1.x = _589.x;
    _p1.y = _589.y;
    _p1.z = _589.z;
    float4 _t36 = _p1;
    if (u_blendMode == 1)
    {
        float3 _607 = _p0.xyz + _p1.xyz;
        _t36.x = _607.x;
        _t36.y = _607.y;
        _t36.z = _607.z;
    }
    else
    {
        if (u_blendMode == 2)
        {
            float3 _623 = _p0.xyz * _p1.xyz;
            _t36.x = _623.x;
            _t36.y = _623.y;
            _t36.z = _623.z;
        }
        else
        {
            if (u_blendMode == 6)
            {
                float3 _640 = fast::max(_p0.xyz, _p1.xyz);
                _t36.x = _640.x;
                _t36.y = _640.y;
                _t36.z = _640.z;
            }
            else
            {
                if (u_blendMode == 11)
                {
                    float3 param = _p0.xyz;
                    float3 param_1 = _p1.xyz;
                    float3 _659 = _f7(param, param_1);
                    _t36.x = _659.x;
                    _t36.y = _659.y;
                    _t36.z = _659.z;
                }
                else
                {
                    _t36.x = _p0.xyz.x;
                    _t36.y = _p0.xyz.y;
                    _t36.z = _p0.xyz.z;
                }
            }
        }
    }
    float4 _t37 = float4(0.0);
    if (u_layerType == 1)
    {
        float _t38 = 1.0;
        if (u_hasMatte == 1)
        {
            float4 param_2 = float4(1.0);
            _t38 = _f6(param_2, u_enableMatte, u_maskTexture, u_maskTextureSmplr, uv0, u_matteMode).w;
        }
        float4 _706 = mix(_p1, float4(_t36.xyz, _p0.w), float4(u_layerOpacity * _t38));
        _t37 = _706;
        float _708 = _t37.w;
        float3 _711 = _706.xyz * _708;
        _t37.x = _711.x;
        _t37.y = _711.y;
        _t37.z = _711.z;
    }
    else
    {
        float3 _746 = (((_p1.xyz * _p1.w) * (1.0 - _p0.w)) + ((_p0.xyz * _p0.w) * (1.0 - _p1.w))) + (_t36.xyz * (_p0.w * _p1.w));
        _t37.x = _746.x;
        _t37.y = _746.y;
        _t37.z = _746.z;
        _t37.w = _p0.w + (_p1.w * (1.0 - _p0.w));
    }
    return _t37;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTexture [[texture(0)]], texture2d<float> u_baseTexure [[texture(1)]], texture2d<float> u_sourceTexture [[texture(2)]], sampler u_maskTextureSmplr [[sampler(0)]], sampler u_baseTexureSmplr [[sampler(1)]], sampler u_sourceTextureSmplr [[sampler(2)]])
{
    main0_out out = {};
    float4 _t39 = float4(0.0);
    bool _769 = buffer.u_hasBlend == 1;
    if (_769)
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
        float2 _807 = _f3(param, param_1, param_2);
        float _811 = step(buffer.u_mirrorEdge, 0.5);
        float2 param_3 = _807;
        float2 _821 = (_807 * _811) + (_f5(param_3) * (1.0 - _811));
        float2 param_4 = _821;
        _t40 = (u_sourceTexture.sample(u_sourceTextureSmplr, _821) * buffer.u_alpha) * _f4(param_4);
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
        _t40 = _f6(param_5, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode);
    }
    if (_769)
    {
        float4 param_6 = _t40;
        float4 param_7 = _t39;
        float4 _859 = _f8(param_6, param_7, buffer.u_enableMatte, u_maskTexture, u_maskTextureSmplr, in.uv0, buffer.u_matteMode, buffer.u_blendMode, buffer.u_layerType, buffer.u_hasMatte, buffer.u_layerOpacity);
        _t40 = _859;
    }
    out.o_fragColor = _t40;
    return out;
}

