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

struct SurfaceParams
{
    float3 albedo;
    float opacity;
    float emission;
    float3 nDirWS;
    float2 metalParams;
    float3 roughParams;
    float3 clearCoatRoughParams;
    float2 occParams;
    float3 diffCol;
    float3 specCol;
    float2 anisoParams;
    float thickness;
};

struct WorldSpaceVectors
{
    float3 pos;
    float3 nDir;
    float3 vnDir;
    float3 tDir;
    float3 bDir;
    float3 vDir;
    float3 rDir;
};

struct EnvironmentParams
{
    float intensity;
    float rotation;
};

struct LightParams
{
    float3 lDir;
    float3 color;
    float intensity;
    float attenuate;
};

struct buffer_t
{
    float4x4 u_Model;
    float u_envMipLevel;
    float4 u_ScreenParams;
    float4 u_albedoColor;
    int u_enableAlbedoTex;
    float2 u_padding;
    float3 u_WorldSpaceCameraPos;
    float u_rotate;
    float2 u_offset;
    float2 u_scale;
    int u_enableNormTex;
    float u_normInt;
    float u_metallic;
    float u_roughness;
    float u_envInt;
    float u_envEnabled;
    float u_envRot;
    float u_dirLightEnabled;
    float3 u_dirLightDirection;
    float3 u_dirLightColor;
    float u_dirLightIntensity;
    float u_pointLightEnabled;
    float3 u_pointLightPosition;
    float3 u_pointLightColor;
    float u_pointLightIntensity;
    float u_pointLightAttenRangeInv;
    float u_spotLightEnabled;
    float3 u_spotLightPosition;
    float3 u_spotLightColor;
    float u_spotLightIntensity;
    float u_spotLightAttenRangeInv;
    float3 u_spotLightDirection;
    float u_spotLightOuterAngleCos;
    float u_spotLightInnerAngleCos;
    int u_enableToneMapping;
    int u_toneMappingType;
    float u_lightingBlend;
    float3 u_hightLightColor;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float3 v_posWS [[user(locn0)]];
    float3 v_nDirWS [[user(locn1)]];
    float3 v_tDirWS [[user(locn2)]];
    float3 v_bDirWS [[user(locn3)]];
    float2 v_uv0 [[user(locn4)]];
};

static inline __attribute__((always_inline))
float3 _f6(thread const float3& _p0)
{
    return float3(pow(_p0.x, 2.2000000476837158203125), pow(_p0.y, 2.2000000476837158203125), pow(_p0.z, 2.2000000476837158203125));
}

static inline __attribute__((always_inline))
float2 _f34(thread const float2& _p0)
{
    float2 _1599 = mod(_p0, float2(1.0));
    return _1599 + (float2(1.0) - step(float2(0.0), _1599));
}

static inline __attribute__((always_inline))
float2 _f33(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f35(thread const float2& _p0)
{
    float2 _t103 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t103.x * _t103.y;
}

static inline __attribute__((always_inline))
float4 _f37(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float2& _p2, thread const int& _p3)
{
    float2 _t107 = _p1;
    bool _1680 = _p2.x < 0.0;
    bool _1687;
    if (!_1680)
    {
        _1687 = _p2.y < 0.0;
    }
    else
    {
        _1687 = _1680;
    }
    if (_1687)
    {
        if (_p3 == 0)
        {
            float2 param = _p1;
            _t107 = _f34(param);
        }
        else
        {
            if (_p3 == 1)
            {
                float2 param_1 = _p1;
                _t107 = _f33(param_1);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t107 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_2 = _p1;
                    if (_f35(param_2) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t107 = _p1;
                }
            }
        }
        return _p0.sample(_p0Smplr, _t107);
    }
    bool _1734 = _p1.x < _p2.x;
    bool _1744;
    if (!_1734)
    {
        _1744 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _1744 = _1734;
    }
    bool _1754;
    if (!_1744)
    {
        _1754 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _1754 = _1744;
    }
    if (_1754)
    {
        if (_p3 == 0)
        {
            float2 param_3 = _p1;
            _t107 = _f34(param_3);
        }
        else
        {
            if (_p3 == 1)
            {
                float2 param_4 = _p1;
                _t107 = _f33(param_4);
            }
            else
            {
                if (_p3 == 2)
                {
                    _t107 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_5 = _p1;
                    if (_f35(param_5) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t107 = _p1;
                }
            }
        }
    }
    return _p0.sample(_p0Smplr, _t107);
}

static inline __attribute__((always_inline))
float2 _f36(thread float2& _p0, thread const float& _p1, thread const float2& _p2, thread const float2& _p3, constant float4& u_ScreenParams)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _1640 = sin(_p1);
    float _1643 = cos(_p1);
    _p0 = float2x2(float2(_1643, _1640), float2(-_1640, _1643)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0)
{
    return _p0 * _p0;
}

static inline __attribute__((always_inline))
float _f3(thread const float& _p0)
{
    return fast::clamp(_p0, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float _f17(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1)
{
    float param = (pow(fast::max(0.0, dot(_p1.nDir, _p1.vDir)) + _p0.occParams.x, exp2(((-16.0) * _p0.roughParams.x) - 1.0)) - 1.0) + _p0.occParams.x;
    float _615 = fast::min(1.0 + dot(_p1.rDir, _p1.nDir), 1.0);
    return _f3(param) * (_615 * _615);
}

static inline __attribute__((always_inline))
float _f1(thread const float& _p0)
{
    float _197 = _p0 * _p0;
    return _197 * _197;
}

static inline __attribute__((always_inline))
float _f5(thread const float& _p0, thread const float& _p1)
{
    return ((_p0 < 0.0) ? (-1.0) : 1.0) * acos(fast::clamp(_p1 / length(float2(_p0, _p1)), -1.0, 1.0));
}

static inline __attribute__((always_inline))
float2 _f18(thread float3& _p0, thread const float& _p1)
{
    _p0 = fast::normalize(_p0);
    float param = _p0.x;
    float param_1 = -_p0.z;
    float2 _t40;
    _t40.x = (_f5(param, param_1) - 1.57079637050628662109375) / 6.283185482025146484375;
    _t40.y = acos(_p0.y) / 3.1415927410125732421875;
    _t40.x += _p1;
    _t40.x = fract((_t40.x + floor(_t40.x)) + 1.0);
    return _t40;
}

static inline __attribute__((always_inline))
float3 _f19(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2)
{
    float _666 = floor(_p2);
    float2 _t43 = _p1;
    float2 _t44 = _p1;
    if (abs(_666 - 0.0) < 0.001000000047497451305389404296875)
    {
        _t43.x = ((((_p1.x * 511.0) / 512.0) + 0.0009765625) * 1.0) + 0.0;
        _t43.y = ((((_p1.y * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t44.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t44.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
    }
    else
    {
        if (abs(_666 - 1.0) < 0.001000000047497451305389404296875)
        {
            _t43.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
            _t43.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
            _t44.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
            _t44.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
        }
        else
        {
            if (abs(_666 - 2.0) < 0.001000000047497451305389404296875)
            {
                _t43.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
                _t43.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                _t44.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                _t44.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
            }
            else
            {
                if (abs(_666 - 3.0) < 0.001000000047497451305389404296875)
                {
                    _t43.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                    _t43.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                    _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                    _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                }
                else
                {
                    if (abs(_666 - 4.0) < 0.001000000047497451305389404296875)
                    {
                        _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                        _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                        _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                        _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                    }
                    else
                    {
                        if (abs(_666 - 5.0) < 0.001000000047497451305389404296875)
                        {
                            _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                            _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                            _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                            _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                        }
                        else
                        {
                            if (abs(_666 - 6.0) < 0.001000000047497451305389404296875)
                            {
                                _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                                _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                            }
                            else
                            {
                                if (abs(_666 - 7.0) < 0.001000000047497451305389404296875)
                                {
                                    _t43.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t43.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                    _t44.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t44.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    float4 _1020 = mix(_p0.sample(_p0Smplr, _t43), _p0.sample(_p0Smplr, _t44), float4(_p2 - _666));
    float4 _t46 = _1020;
    return _1020.xyz / float3(_t46.w);
}

static inline __attribute__((always_inline))
float3 _f20(texture2d<float> _p0, sampler _p0Smplr, thread const float3& _p1, thread const float& _p2, thread const float& _p3)
{
    float3 param = _p1;
    float param_1 = _p2;
    float2 _1035 = _f18(param, param_1);
    float2 param_2 = _1035;
    float param_3 = _p3;
    return _f19(_p0, _p0Smplr, param_2, param_3);
}

static inline __attribute__((always_inline))
float3 _f22(thread const float& _p0, thread const float3& _p1)
{
    return fast::max(float3(_p0), ((((((_p1 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _p0) + ((_p1 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _p0) + ((_p1 * 2.755199909210205078125) + float3(0.69029998779296875))) * _p0);
}

static inline __attribute__((always_inline))
float3 _f24(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const EnvironmentParams& _p2, constant float4x4& u_Model, texture2d<float> u_envTex, sampler u_envTexSmplr, constant float& u_envMipLevel)
{
    float3 param = fast::normalize(float3x3(u_Model[0].xyz, u_Model[1].xyz, u_Model[2].xyz) * _p1.nDir);
    float param_1 = _p2.rotation;
    float param_2 = u_envMipLevel;
    float param_3 = _p0.occParams.x;
    float3 param_4 = _p0.diffCol;
    return ((_f20(u_envTex, u_envTexSmplr, param, param_1, param_2) * _p0.diffCol) * _f22(param_3, param_4)) * _p2.intensity;
}

static inline __attribute__((always_inline))
float3 _f21(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1)
{
    float4 _1068 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _p0.roughParams.x) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float4 _t52 = _1068;
    float2 _t54 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_t52.x * _t52.x, exp2((-9.27999973297119140625) * fast::max(0.0, dot(_p1.nDir, _p1.vDir)))) * _t52.x) + _t52.y)) + _1068.zw;
    float param = 50.0 * _p0.specCol.y;
    _t54.y *= _f3(param);
    return (_p0.specCol * _t54.x) + float3(_t54.y);
}

static inline __attribute__((always_inline))
float3 _f23(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const EnvironmentParams& _p2, constant float4x4& u_Model, texture2d<float> u_envTex, sampler u_envTexSmplr, constant float& u_envMipLevel)
{
    float3 param = fast::normalize(float3x3(u_Model[0].xyz, u_Model[1].xyz, u_Model[2].xyz) * mix(_p1.rDir, _p1.nDir, float3(_p0.roughParams.x * _p0.roughParams.y)));
    float param_1 = _p2.rotation;
    float param_2 = _p0.roughParams.x * u_envMipLevel;
    SurfaceParams param_3 = _p0;
    WorldSpaceVectors param_4 = _p1;
    float param_5 = _p0.occParams.y;
    float3 param_6 = _p0.specCol;
    return ((_f21(param_3, param_4) * _f20(u_envTex, u_envTexSmplr, param, param_1, param_2)) * _f22(param_5, param_6)) * _p2.intensity;
}

static inline __attribute__((always_inline))
float3 _f32(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float _1505 = fast::max(0.0, dot(_p1.nDir, _p1.vDir));
    float _1512 = fast::max(0.0, dot(_p1.nDir, _p2.lDir));
    float _1524 = dot(_p2.lDir, _p1.vDir) - (_1512 * _1505);
    float _1538 = _p0.roughParams.y * _p0.roughParams.y;
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * (fast::max(0.0, _1512) * ((1.0 + (_1538 * ((1.0 / (_1538 + 0.12999999523162841796875)) + (0.5 / (_1538 + 0.3300000131130218505859375))))) + ((((0.449999988079071044921875 * _1538) / (_1538 + 0.0900000035762786865234375)) * _1524) / mix(1.0, fast::max(_1512, _1505), step(0.0, _1524)))));
}

static inline __attribute__((always_inline))
float _f27(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return 0.5 / (((_p2 * ((_p1 * (1.0 - _p0)) + _p0)) + (_p1 * ((_p2 * (1.0 - _p0)) + _p0))) + 9.9999997473787516355514526367188e-06);
}

static inline __attribute__((always_inline))
float _f26(thread const float& _p0, thread const float& _p1)
{
    float _1284 = (((_p0 * _p1) - _p0) * _p0) + 1.0;
    return (_p1 * 0.31830990314483642578125) / ((_1284 * _1284) + 1.0000000116860974230803549289703e-07);
}

static inline __attribute__((always_inline))
float _f2(thread const float& _p0)
{
    float _206 = _p0 * _p0;
    return (_206 * _206) * _p0;
}

static inline __attribute__((always_inline))
float3 _f25(thread const float3& _p0, thread const float& _p1)
{
    float param = 1.0 - _p1;
    return _p0 + ((float3(1.0) - _p0) * _f2(param));
}

static inline __attribute__((always_inline))
float3 _f28(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float3 _1328 = fast::normalize(_p2.lDir + _p1.vDir);
    float _1347 = fast::max(0.0, dot(_p1.nDir, _p2.lDir));
    float param = _1347;
    float param_1 = fast::max(0.0, dot(_p1.nDir, _p1.vDir));
    float param_2 = _p0.roughParams.y;
    float param_3 = fast::max(0.0, dot(_p1.nDir, _1328));
    float param_4 = _p0.roughParams.z;
    float3 param_5 = _p0.specCol;
    float param_6 = fast::max(0.0, dot(_p1.vDir, _1328));
    return ((((((_f25(param_5, param_6) * _f27(param, param_1, param_2)) * _f26(param_3, param_4)) * 3.1415927410125732421875) * _1347) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

static inline __attribute__((always_inline))
float3 _f31(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * fast::max(0.0, dot(_p1.nDir, _p2.lDir));
}

static inline __attribute__((always_inline))
float _f29()
{
    return 0.25;
}

static inline __attribute__((always_inline))
float3 _f30(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float3 _1413 = fast::normalize(_p2.lDir + _p1.vDir);
    float param = fast::max(0.0, dot(_p1.nDir, _1413));
    float param_1 = _p0.roughParams.z;
    float3 param_2 = _p0.specCol;
    float param_3 = fast::max(0.0, dot(_p1.vDir, _1413));
    return ((((((_f25(param_2, param_3) * _f29()) * _f26(param, param_1)) * 3.1415927410125732421875) * fast::max(0.0, dot(_p1.nDir, _p2.lDir))) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

static inline __attribute__((always_inline))
float3 _f8(thread const float3& _p0)
{
    return (_p0 * ((_p0 * 1.7999999523162841796875) + float3(1.39999997615814208984375))) / fast::min(float3(1000.0), (_p0 * ((_p0 * 1.7999999523162841796875) + float3(0.5))) + float3(1.5));
}

static inline __attribute__((always_inline))
float3 _f11(thread const float3& _p0)
{
    float3 _385 = _p0 * 1.5;
    return _385 / (float3(1.0) + _385);
}

static inline __attribute__((always_inline))
float3 _f12(thread float3& _p0)
{
    _p0 *= 2.0;
    return ((((_p0 * ((_p0 * 0.1500000059604644775390625) + float3(0.0500000007450580596923828125))) + float3(0.0040000001899898052215576171875)) / ((_p0 * ((_p0 * 0.1500000059604644775390625) + float3(0.5))) + float3(0.060000002384185791015625))) - float3(0.066666662693023681640625)) * float3(1.3790643215179443359375);
}

static inline __attribute__((always_inline))
float3 _f10(thread const float3& _p0)
{
    float3 _356 = fast::max(float3(0.0), _p0 - float3(0.0040000001899898052215576171875));
    float3 _361 = _356 * 6.19999980926513671875;
    return pow((_356 * (_361 + float3(0.5))) / ((_356 * (_361 + float3(1.7000000476837158203125))) + float3(0.0599999986588954925537109375)), float3(2.2000000476837158203125));
}

static inline __attribute__((always_inline))
float3 _f4(thread float3& _p0)
{
    _p0.x = fast::clamp(_p0.x, 0.0, 1.0);
    _p0.y = fast::clamp(_p0.y, 0.0, 1.0);
    _p0.z = fast::clamp(_p0.z, 0.0, 1.0);
    return _p0;
}

static inline __attribute__((always_inline))
float3 _f9(thread const float3& _p0)
{
    float3 param = (_p0 * ((_p0 * 2.5099999904632568359375) + float3(0.02999999932944774627685546875))) / ((_p0 * ((_p0 * 2.4300000667572021484375) + float3(0.589999973773956298828125))) + float3(0.14000000059604644775390625));
    float3 _347 = _f4(param);
    return _347;
}

static inline __attribute__((always_inline))
float3 _f13(thread const float3& _p0)
{
    float3 _484 = _p0 * _p0;
    float3 _488 = _484 * _484;
    return (_p0 * (_488 + float3(1.0))) / ((_488 + _484) + _p0);
}

static inline __attribute__((always_inline))
float3 _f14(thread const float3& _p0)
{
    float _508 = dot(_p0, float3(0.4122214615345001220703125, 0.536332547664642333984375, 0.0514459945261478424072265625));
    float3 param = float3(_508);
    return (_p0 / float3(_508 + 9.9999997473787516355514526367188e-05)) * _f13(param).x;
}

static inline __attribute__((always_inline))
float3 _f15(thread const float3& _p0)
{
    float3 _532 = fast::max(float3(0.0), _p0 - float3(0.0500000007450580596923828125));
    float3 _543 = pow(_532 / (_532 + float3(0.9700000286102294921875)), float3(0.85000002384185791015625));
    return mix(float3(dot(_543, float3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875))), _543, float3(1.4500000476837158203125));
}

static inline __attribute__((always_inline))
float3 _f16(thread const float3& _p0)
{
    return (_p0 * (float3(1.0) + (_p0 / float3(16.0)))) / (float3(1.0) + _p0);
}

static inline __attribute__((always_inline))
float3 _f7(thread const float3& _p0)
{
    return float3(pow(_p0.x, 0.4545449912548065185546875), pow(_p0.y, 0.4545449912548065185546875), pow(_p0.z, 0.4545449912548065185546875));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_envTex [[texture(0)]], texture2d<float> u_albedoTex [[texture(1)]], texture2d<float> u_backTex [[texture(2)]], texture2d<float> u_inputTex [[texture(3)]], texture2d<float> u_normTex [[texture(4)]], sampler u_envTexSmplr [[sampler(0)]], sampler u_albedoTexSmplr [[sampler(1)]], sampler u_backTexSmplr [[sampler(2)]], sampler u_inputTexSmplr [[sampler(3)]], sampler u_normTexSmplr [[sampler(4)]])
{
    main0_out out = {};
    float3 _1806 = fast::normalize(in.v_nDirWS);
    float3 _1810 = fast::normalize(in.v_tDirWS);
    float3 _1814 = fast::normalize(in.v_bDirWS);
    float3 param = buffer.u_albedoColor.xyz;
    float3 _2610 = _f6(param);
    float _2611 = buffer.u_albedoColor.w;
    if (buffer.u_enableAlbedoTex > 0)
    {
        float2 param_1 = in.v_uv0;
        float2 param_2 = buffer.u_padding;
        int param_3 = 0;
        float4 _1847 = _f37(u_albedoTex, u_albedoTexSmplr, param_1, param_2, param_3);
        float4 _t110 = _1847;
        float3 param_4 = _1847.xyz;
        _2610 *= _f6(param_4);
        _2611 *= _t110.w;
    }
    float3 _1869 = fast::normalize(buffer.u_WorldSpaceCameraPos - in.v_posWS);
    float3 _1881 = -_1869;
    float3 _1889 = _1881 - (_1806 * (1.39999997615814208984375 * dot(_1806, _1881)));
    float3 _t114 = _1889;
    float2 _t118 = ((float2(((1.0 * _t114.x) / (buffer.u_ScreenParams.x / buffer.u_ScreenParams.y)) + 0.5, (1.0 * _t114.y) + 0.5) - float2(0.5)) * 1.2000000476837158203125) + float2(0.5);
    float2 param_5 = in.v_uv0;
    float param_6 = buffer.u_rotate;
    float2 param_7 = buffer.u_offset;
    float2 param_8 = buffer.u_scale;
    float2 _1941 = _f36(param_5, param_6, param_7, param_8, buffer.u_ScreenParams);
    float2 _1942 = _t118;
    float2 _1946 = mix(_1942, _1941, float2(smoothstep(0.85000002384185791015625, 1.0, (dot(float3(0.0, 0.0, 1.0), _1806) + 1.0) / 2.0)));
    _t118 = _1946;
    float4 _1962 = u_backTex.sample(u_backTexSmplr, (((_1946 - float2(0.5)) * 0.333000004291534423828125) + float2(0.5)));
    float2 param_9 = _1946;
    float4 _1971 = u_inputTex.sample(u_inputTexSmplr, _f33(param_9));
    float4 _2008 = mix(_1962, _1971, float4((smoothstep(-0.4000000059604644775390625, 0.0, _t118.x) * (1.0 - smoothstep(1.0, 1.39999997615814208984375, _t118.x))) * (smoothstep(-0.4000000059604644775390625, 0.0, _t118.y) * (1.0 - smoothstep(1.0, 1.39999997615814208984375, _t118.y)))));
    float4 _t123 = _2008;
    float _2012 = _t123.w;
    float4 _2016 = float4(_2008.xyz, _2012);
    _t123 = _2016;
    float4 _t128 = _2016;
    float3 _2021 = _2016.xyz;
    float3 param_10 = _2021;
    _2610 *= _f6(param_10);
    _2611 *= _t128.w;
    float3 _2613 = _1806;
    bool _2039 = buffer.u_enableNormTex > 0;
    if (_2039)
    {
        float2 param_11 = in.v_uv0;
        float2 param_12 = buffer.u_padding;
        int param_13 = 0;
        _2613 = float3x3(float3(_1810), float3(_1814), float3(_1806)) * fast::normalize(mix(float3(0.0, 0.0, 1.0), fast::normalize((_f37(u_normTex, u_normTexSmplr, param_11, param_12, param_13).xyz * 2.0) - float3(1.0)), float3(buffer.u_normInt)));
    }
    float2 _2614 = float2(0.0);
    float3 _2615 = float3(0.0);
    float2 _2617 = float2(1.0);
    _2614.x = buffer.u_metallic;
    _2614.y = 0.959999978542327880859375 * (1.0 - _2614.x);
    _2615.x = fast::clamp(buffer.u_roughness, 0.039999999105930328369140625, 1.0);
    float param_14 = _2615.x;
    _2615.y = _f0(param_14);
    float param_15 = _2615.y;
    _2615.z = _f0(param_15);
    float3 _2122 = _2610 * _2614.y;
    float3 _2130 = mix(float3(0.039999999105930328369140625), _2610, float3(_2614.x));
    float3 _2753;
    float3 _2754;
    if (_2039)
    {
        float3 _2154 = fast::normalize(cross(_2613, _1814));
        _2753 = _2154;
        _2754 = fast::normalize(cross(_2613, _2154));
    }
    else
    {
        _2753 = _1810;
        _2754 = _1814;
    }
    float3 _2755 = _1869;
    float3 _2182;
    if (dot(_1869, _2613) < 0.0)
    {
        _2182 = reflect(_2755, _2613);
    }
    else
    {
        _2182 = _2755;
    }
    _2755 = _2182;
    float3 _2201 = fast::normalize(reflect(-_2182, _2613));
    float _2621;
    float2 _2620;
    SurfaceParams param_16 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
    WorldSpaceVectors param_17 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2182, _2201 };
    _2617.y = _f17(param_16, param_17);
    bool _2221 = buffer.u_dirLightEnabled > 0.0;
    float3 _2837;
    float3 _2838;
    float _2839;
    float _2840;
    if (_2221)
    {
        _2837 = fast::normalize(-buffer.u_dirLightDirection);
        _2838 = buffer.u_dirLightColor;
        _2839 = buffer.u_dirLightIntensity * buffer.u_dirLightEnabled;
        _2840 = 0.5;
    }
    bool _2241 = buffer.u_pointLightEnabled > 0.0;
    float3 _2851;
    float3 _2852;
    float _2853;
    float _2854;
    if (_2241)
    {
        float3 _2249 = buffer.u_pointLightPosition - in.v_posWS;
        float _2252 = length(_2249);
        _2851 = _2249 / float3(_2252);
        _2852 = buffer.u_pointLightColor;
        _2853 = buffer.u_pointLightIntensity * buffer.u_pointLightEnabled;
        float _2270 = _2252 * buffer.u_pointLightAttenRangeInv;
        float param_18 = _2270;
        float param_19 = 1.0 - _f1(param_18);
        float param_20 = _f3(param_19);
        float param_21 = _2270;
        _2854 = (_f0(param_20) * (_f0(param_21) + 1.0)) * 0.25;
    }
    bool _2288 = buffer.u_spotLightEnabled > 0.0;
    float3 _2865;
    float3 _2866;
    float _2867;
    float _2868;
    if (_2288)
    {
        float3 _2296 = buffer.u_spotLightPosition - in.v_posWS;
        float _2299 = length(_2296);
        float3 _2304 = _2296 / float3(_2299);
        _2865 = _2304;
        _2866 = buffer.u_spotLightColor;
        _2867 = buffer.u_spotLightIntensity * buffer.u_spotLightEnabled;
        float _2317 = _2299 * buffer.u_spotLightAttenRangeInv;
        float param_22 = _2317;
        float param_23 = 1.0 - _f1(param_22);
        float param_24 = _f3(param_23);
        float param_25 = _2317;
        _2868 = ((_f0(param_24) * (_f0(param_25) + 1.0)) * 0.25) * smoothstep(buffer.u_spotLightOuterAngleCos, buffer.u_spotLightInnerAngleCos, fast::max(0.0, dot(_2304, fast::normalize(-buffer.u_spotLightDirection))));
    }
    float3 _t143 = _2021;
    bool _2362 = buffer.u_envEnabled > 0.0;
    if (((_2362 || _2221) || _2241) || _2288)
    {
        float3 _t147 = float3(0.0);
        if (_2362)
        {
            SurfaceParams param_26 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_27 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            EnvironmentParams _2833 = EnvironmentParams{ buffer.u_envInt * buffer.u_envEnabled, buffer.u_envRot };
            EnvironmentParams param_28 = _2833;
            _t147 += _f24(param_26, param_27, param_28, buffer.u_Model, u_envTex, u_envTexSmplr, buffer.u_envMipLevel);
            SurfaceParams param_29 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_30 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            EnvironmentParams param_31 = _2833;
            _t147 += _f23(param_29, param_30, param_31, buffer.u_Model, u_envTex, u_envTexSmplr, buffer.u_envMipLevel);
        }
        if (_2221)
        {
            SurfaceParams param_32 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_33 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            LightParams param_34 = LightParams{ _2837, _2838, _2839, _2840 };
            _t147 += _f32(param_32, param_33, param_34);
            SurfaceParams param_35 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_36 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            LightParams param_37 = LightParams{ _2837, _2838, _2839, _2840 };
            _t147 += _f28(param_35, param_36, param_37);
        }
        if (_2241)
        {
            SurfaceParams param_38 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_39 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            LightParams param_40 = LightParams{ _2851, _2852, _2853, _2854 };
            _t147 += _f31(param_38, param_39, param_40);
            SurfaceParams param_41 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_42 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            LightParams param_43 = LightParams{ _2851, _2852, _2853, _2854 };
            _t147 += _f30(param_41, param_42, param_43);
        }
        if (_2288)
        {
            SurfaceParams param_44 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_45 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            LightParams param_46 = LightParams{ _2865, _2866, _2867, _2868 };
            _t147 += _f31(param_44, param_45, param_46);
            SurfaceParams param_47 = SurfaceParams{ _2610, _2611, 0.0, _2613, _2614, _2615, float3(0.0), _2617, _2122, _2130, _2620, _2621 };
            WorldSpaceVectors param_48 = WorldSpaceVectors{ in.v_posWS, _2613, _1806, _2753, _2754, _2755, _2201 };
            LightParams param_49 = LightParams{ _2865, _2866, _2867, _2868 };
            _t147 += _f30(param_47, param_48, param_49);
        }
        if (buffer.u_enableToneMapping > 0)
        {
            if (buffer.u_toneMappingType == 0)
            {
                float3 param_50 = _t147;
                _t147 = _f8(param_50);
            }
            else
            {
                if (buffer.u_toneMappingType == 1)
                {
                    float3 param_51 = _t147;
                    _t147 = _f11(param_51);
                }
                else
                {
                    if (buffer.u_toneMappingType == 2)
                    {
                        float3 param_52 = _t147;
                        float3 _2492 = _f12(param_52);
                        _t147 = _2492;
                    }
                    else
                    {
                        if (buffer.u_toneMappingType == 3)
                        {
                            float3 param_53 = _t147;
                            _t147 = _f10(param_53);
                        }
                        else
                        {
                            if (buffer.u_toneMappingType == 4)
                            {
                                float3 param_54 = _t147;
                                _t147 = _f9(param_54);
                            }
                            else
                            {
                                if (buffer.u_toneMappingType == 5)
                                {
                                    float3 param_55 = _t147;
                                    _t147 = _f14(param_55);
                                }
                                else
                                {
                                    if (buffer.u_toneMappingType == 6)
                                    {
                                        float3 param_56 = _t147;
                                        _t147 = _f15(param_56);
                                    }
                                    else
                                    {
                                        if (buffer.u_toneMappingType == 7)
                                        {
                                            float3 param_57 = _t147;
                                            _t147 = _f16(param_57);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        float3 param_58 = _t147;
        float3 _2535 = _f7(param_58);
        _t147 = _2535;
        _t143 = mix(_t143, _2535, float3(buffer.u_lightingBlend));
    }
    float4 _2549 = float4(_t143, _2611);
    float4 _t148 = _2549;
    float _2573 = _t148.w;
    float4 _2577 = float4(_2549.xyz + (buffer.u_hightLightColor * (smoothstep(0.5, 0.75, fast::clamp(pow(fast::max(abs(dot(_1889, float3(1.0, 0.0, 0.0))), 0.0), 5.0) * 5.0, 0.0, 1.0)) * 0.5)), _2573);
    _t148 = _2577;
    out.o_fragColor = _2577;
    return out;
}

