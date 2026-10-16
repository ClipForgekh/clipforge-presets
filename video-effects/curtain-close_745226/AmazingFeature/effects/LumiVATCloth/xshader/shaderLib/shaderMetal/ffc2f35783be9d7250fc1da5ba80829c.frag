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
    float3 u_WorldSpaceCameraPos;
    float3 u_envRotAxis;
    float4 u_ScreenParams;
    int u_edgeType;
    float u_rotate;
    float2 u_offset;
    float2 u_scale;
    float2 u_padding;
    float4 u_mainColor;
    int u_enableNormTex;
    float u_normInt;
    float u_metallic;
    float u_roughness;
    float u_anisoAngle;
    float u_anisoStrength;
    float u_envInt;
    float u_envEnabled;
    float u_envRot;
    float3 u_dirLightDirection;
    float3 u_dirLightColor;
    float u_dirLightIntensity;
    float u_dirLightEnabled;
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
    float u_shadowContrast;
    float3 u_shadowColor;
    int u_enableToneMapping;
    float u_lightingBlend;
    float u_shadowIntensity;
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
    float4 v_vertexColor [[user(locn6)]];
};

static inline __attribute__((always_inline))
float2 _f28(thread float2& _p0, thread const float& _p1, thread const float2& _p2, thread const float2& _p3, constant float4& u_ScreenParams)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _1396 = sin(_p1);
    float _1399 = cos(_p1);
    _p0 = float2x2(float2(_1399, _1396), float2(-_1396, _1399)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

static inline __attribute__((always_inline))
float2 _f26(thread const float2& _p0)
{
    float2 _1355 = mod(_p0, float2(1.0));
    return _1355 + (float2(1.0) - step(float2(0.0), _1355));
}

static inline __attribute__((always_inline))
float2 _f25(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f27(thread const float2& _p0)
{
    float2 _t85 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t85.x * _t85.y;
}

static inline __attribute__((always_inline))
float4 _f29(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float2& _p2, constant int& u_edgeType)
{
    float2 _t89 = _p1;
    bool _1436 = _p2.x < 0.0;
    bool _1443;
    if (!_1436)
    {
        _1443 = _p2.y < 0.0;
    }
    else
    {
        _1443 = _1436;
    }
    if (_1443)
    {
        if (u_edgeType == 0)
        {
            float2 param = _p1;
            _t89 = _f26(param);
        }
        else
        {
            if (u_edgeType == 1)
            {
                float2 param_1 = _p1;
                _t89 = _f25(param_1);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t89 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_2 = _p1;
                    if (_f27(param_2) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t89 = _p1;
                }
            }
        }
        return _p0.sample(_p0Smplr, _t89);
    }
    bool _1492 = _p1.x < _p2.x;
    bool _1502;
    if (!_1492)
    {
        _1502 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _1502 = _1492;
    }
    bool _1512;
    if (!_1502)
    {
        _1512 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _1512 = _1502;
    }
    if (_1512)
    {
        if (u_edgeType == 0)
        {
            float2 param_3 = _p1;
            _t89 = _f26(param_3);
        }
        else
        {
            if (u_edgeType == 1)
            {
                float2 param_4 = _p1;
                _t89 = _f25(param_4);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t89 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_5 = _p1;
                    if (_f27(param_5) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t89 = _p1;
                }
            }
        }
    }
    return _p0.sample(_p0Smplr, _t89);
}

static inline __attribute__((always_inline))
float3 _f3(thread const float3& _p0)
{
    return float3(pow(_p0.x, 2.2000000476837158203125), pow(_p0.y, 2.2000000476837158203125), pow(_p0.z, 2.2000000476837158203125));
}

static inline __attribute__((always_inline))
float _f0(thread const float& _p0)
{
    return _p0 * _p0;
}

static inline __attribute__((always_inline))
float _f2(thread const float& _p0)
{
    return fast::clamp(_p0, 0.0, 1.0);
}

static inline __attribute__((always_inline))
float _f6(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1)
{
    float param = (pow(fast::max(0.0, dot(_p1.nDir, _p1.vDir)) + _p0.occParams.x, exp2(((-16.0) * _p0.roughParams.x) - 1.0)) - 1.0) + _p0.occParams.x;
    float _288 = fast::min(1.0 + dot(_p1.rDir, _p1.nDir), 1.0);
    return _f2(param) * (_288 * _288);
}

static inline __attribute__((always_inline))
float3 _f4(thread const float3& _p0)
{
    return float3(pow(_p0.x, 0.4545449912548065185546875), pow(_p0.y, 0.4545449912548065185546875), pow(_p0.z, 0.4545449912548065185546875));
}

static inline __attribute__((always_inline))
float3x3 _f9(thread const float& _p0)
{
    float _334 = sin(_p0);
    float _337 = cos(_p0);
    return float3x3(float3(_337, -_334, 0.0), float3(_334, _337, 0.0), float3(0.0, 0.0, 1.0));
}

static inline __attribute__((always_inline))
float3x3 _f8(thread const float& _p0)
{
    float _317 = sin(_p0);
    float _320 = cos(_p0);
    return float3x3(float3(_320, 0.0, _317), float3(0.0, 1.0, 0.0), float3(-_317, 0.0, _320));
}

static inline __attribute__((always_inline))
float3x3 _f7(thread const float& _p0)
{
    float _300 = sin(_p0);
    float _303 = cos(_p0);
    return float3x3(float3(1.0, 0.0, 0.0), float3(0.0, _303, -_300), float3(0.0, _300, _303));
}

static inline __attribute__((always_inline))
float2 _f10(thread const float3& _p0, thread const float& _p1, constant float3& u_WorldSpaceCameraPos, thread float3& v_posWS, constant float3& u_envRotAxis)
{
    float3 _357 = fast::normalize(u_WorldSpaceCameraPos - v_posWS);
    float3 _362 = fast::normalize(cross(float3(0.0, 1.0, 0.0), _357));
    float param = u_envRotAxis.z;
    float param_1 = u_envRotAxis.y;
    float param_2 = u_envRotAxis.x;
    float3 _t22 = fast::normalize((float3x3(float3(_362), float3(fast::normalize(cross(_357, _362))), float3(_357)) * ((_f9(param) * _f8(param_1)) * _f7(param_2))) * _p0);
    float2 _t23;
    _t23.x = ((precise::atan2(_t22.z, _t22.x) * 0.31830990314483642578125) * 0.5) + 0.5;
    _t23.y = acos(_t22.y) * 0.31830990314483642578125;
    _t23.x = fract(_t23.x + _p1);
    return _t23;
}

static inline __attribute__((always_inline))
float3 _f11(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2)
{
    float _437 = floor(_p2);
    float2 _t26 = _p1;
    float2 _t27 = _p1;
    if (abs(_437 - 0.0) < 0.001000000047497451305389404296875)
    {
        _t26.x = ((((_p1.x * 511.0) / 512.0) + 0.0009765625) * 1.0) + 0.0;
        _t26.y = ((((_p1.y * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
    }
    else
    {
        if (abs(_437 - 1.0) < 0.001000000047497451305389404296875)
        {
            _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
            _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
            _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
            _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
        }
        else
        {
            if (abs(_437 - 2.0) < 0.001000000047497451305389404296875)
            {
                _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
                _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
            }
            else
            {
                if (abs(_437 - 3.0) < 0.001000000047497451305389404296875)
                {
                    _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                    _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                    _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                    _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                }
                else
                {
                    if (abs(_437 - 4.0) < 0.001000000047497451305389404296875)
                    {
                        _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                        _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                        _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                        _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                    }
                    else
                    {
                        if (abs(_437 - 5.0) < 0.001000000047497451305389404296875)
                        {
                            _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                            _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                            _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                            _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                        }
                        else
                        {
                            if (abs(_437 - 6.0) < 0.001000000047497451305389404296875)
                            {
                                _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                                _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                            }
                            else
                            {
                                if (abs(_437 - 7.0) < 0.001000000047497451305389404296875)
                                {
                                    _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                    _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                    _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    float4 _793 = mix(_p0.sample(_p0Smplr, _t26), _p0.sample(_p0Smplr, _t27), float4(_p2 - _437));
    float4 _t29 = _793;
    return _793.xyz / float3(_t29.w);
}

static inline __attribute__((always_inline))
float3 _f12(texture2d<float> _p0, sampler _p0Smplr, thread const float3& _p1, thread const float& _p2, thread const float& _p3, constant float3& u_WorldSpaceCameraPos, thread float3& v_posWS, constant float3& u_envRotAxis)
{
    float3 param = _p1;
    float param_1 = _p2;
    float2 param_2 = _f10(param, param_1, u_WorldSpaceCameraPos, v_posWS, u_envRotAxis);
    float param_3 = _p3;
    return _f11(_p0, _p0Smplr, param_2, param_3);
}

static inline __attribute__((always_inline))
float3 _f14(thread const float& _p0, thread const float3& _p1)
{
    return fast::max(float3(_p0), ((((((_p1 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _p0) + ((_p1 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _p0) + ((_p1 * 2.755199909210205078125) + float3(0.69029998779296875))) * _p0);
}

static inline __attribute__((always_inline))
float3 _f16(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const EnvironmentParams& _p2, constant float3& u_WorldSpaceCameraPos, thread float3& v_posWS, constant float3& u_envRotAxis, texture2d<float> u_envTex, sampler u_envTexSmplr)
{
    float3 param = _p1.nDir;
    float param_1 = _p2.rotation;
    float param_2 = 7.0;
    float param_3 = _p0.occParams.x;
    float3 param_4 = _p0.diffCol;
    return ((_f12(u_envTex, u_envTexSmplr, param, param_1, param_2, u_WorldSpaceCameraPos, v_posWS, u_envRotAxis) * _p0.diffCol) * _f14(param_3, param_4)) * _p2.intensity;
}

static inline __attribute__((always_inline))
float3 _f13(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1)
{
    float4 _838 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _p0.roughParams.x) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float4 _t33 = _838;
    float2 _t35 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_t33.x * _t33.x, exp2((-9.27999973297119140625) * fast::max(0.0, dot(_p1.nDir, _p1.vDir)))) * _t33.x) + _t33.y)) + _838.zw;
    float param = 50.0 * _p0.specCol.y;
    _t35.y *= _f2(param);
    return (_p0.specCol * _t35.x) + float3(_t35.y);
}

static inline __attribute__((always_inline))
float3 _f15(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const EnvironmentParams& _p2, constant float3& u_WorldSpaceCameraPos, thread float3& v_posWS, constant float3& u_envRotAxis, texture2d<float> u_envTex, sampler u_envTexSmplr)
{
    float3 param = mix(_p1.rDir, _p1.nDir, float3(_p0.roughParams.x * _p0.roughParams.y));
    float param_1 = _p2.rotation;
    float param_2 = _p0.roughParams.x * 7.0;
    SurfaceParams param_3 = _p0;
    WorldSpaceVectors param_4 = _p1;
    float param_5 = _p0.occParams.y;
    float3 param_6 = _p0.specCol;
    return ((_f13(param_3, param_4) * _f12(u_envTex, u_envTexSmplr, param, param_1, param_2, u_WorldSpaceCameraPos, v_posWS, u_envRotAxis)) * _f14(param_5, param_6)) * _p2.intensity;
}

static inline __attribute__((always_inline))
float3 _f24(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float _1251 = fast::max(0.0, dot(_p1.nDir, _p2.lDir));
    float _1258 = fast::max(0.0, dot(_p1.nDir, _p1.vDir));
    float _1264 = fast::max(0.0, dot(_p1.vDir, fast::normalize(_p2.lDir + _p1.vDir)));
    float _1273 = _p0.roughParams.y * _p0.roughParams.y;
    float _1285 = (((2.0 * _1264) * _1264) - 1.0) - (_1258 * _1251);
    float _1306;
    if (_1285 >= 0.0)
    {
        _1306 = 1.0 / fast::max(_1251, _1258);
    }
    else
    {
        _1306 = 1.0;
    }
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * ((((1.0 - ((0.5 * _1273) / (_1273 + 0.3300000131130218505859375))) + ((((0.449999988079071044921875 * _1273) / (_1273 + 0.0900000035762786865234375)) * _1285) * _1306)) * (1.0 + (_p0.roughParams.x * 0.5))) * _1251);
}

static inline __attribute__((always_inline))
float _f19(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return 0.5 / (((_p2 * ((_p1 * (1.0 - _p0)) + _p0)) + (_p1 * ((_p2 * (1.0 - _p0)) + _p0))) + 9.9999997473787516355514526367188e-06);
}

static inline __attribute__((always_inline))
float _f18(thread const float& _p0, thread const float& _p1)
{
    float _1023 = (((_p0 * _p1) - _p0) * _p0) + 1.0;
    return (_p1 * 0.31830990314483642578125) / ((_1023 * _1023) + 1.0000000116860974230803549289703e-07);
}

static inline __attribute__((always_inline))
float _f1(thread const float& _p0)
{
    float _171 = _p0 * _p0;
    return (_171 * _171) * _p0;
}

static inline __attribute__((always_inline))
float3 _f17(thread const float3& _p0, thread const float& _p1)
{
    float param = 1.0 - _p1;
    return _p0 + ((float3(1.0) - _p0) * _f1(param));
}

static inline __attribute__((always_inline))
float3 _f20(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float3 _1066 = fast::normalize(_p2.lDir + _p1.vDir);
    float _1085 = fast::max(0.0, dot(_p1.nDir, _p2.lDir));
    float param = _1085;
    float param_1 = fast::max(0.0, dot(_p1.nDir, _p1.vDir));
    float param_2 = _p0.roughParams.y;
    float param_3 = fast::max(0.0, dot(_p1.nDir, _1066));
    float param_4 = _p0.roughParams.z;
    float3 param_5 = _p0.specCol;
    float param_6 = fast::max(0.0, dot(_p1.vDir, _1066));
    return ((((((_f17(param_5, param_6) * _f19(param, param_1, param_2)) * _f18(param_3, param_4)) * 3.1415927410125732421875) * _1085) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

static inline __attribute__((always_inline))
float3 _f23(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * fast::max(0.0, dot(_p1.nDir, _p2.lDir));
}

static inline __attribute__((always_inline))
float _f21()
{
    return 0.25;
}

static inline __attribute__((always_inline))
float3 _f22(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float3 _1152 = fast::normalize(_p2.lDir + _p1.vDir);
    float param = fast::max(0.0, dot(_p1.nDir, _1152));
    float param_1 = _p0.roughParams.z;
    float3 param_2 = _p0.specCol;
    float param_3 = fast::max(0.0, dot(_p1.vDir, _1152));
    return ((((((_f17(param_2, param_3) * _f21()) * _f18(param, param_1)) * 3.1415927410125732421875) * fast::max(0.0, dot(_p1.nDir, _p2.lDir))) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

static inline __attribute__((always_inline))
float3 _f5(thread const float3& _p0)
{
    return (_p0 * ((_p0 * 1.7999999523162841796875) + float3(1.39999997615814208984375))) / fast::min(float3(1000.0), (_p0 * ((_p0 * 1.7999999523162841796875) + float3(0.5))) + float3(1.5));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_envTex [[texture(0)]], texture2d<float> u_input [[texture(1)]], texture2d<float> u_normTex [[texture(2)]], sampler u_envTexSmplr [[sampler(0)]], sampler u_inputSmplr [[sampler(1)]], sampler u_normTexSmplr [[sampler(2)]])
{
    main0_out out = {};
    float2 param = in.v_uv0;
    float param_1 = buffer.u_rotate;
    float2 param_2 = buffer.u_offset;
    float2 param_3 = buffer.u_scale;
    float2 _1588 = _f28(param, param_1, param_2, param_3, buffer.u_ScreenParams);
    float2 param_4 = _1588;
    float2 param_5 = buffer.u_padding;
    float4 _1598 = _f29(u_input, u_inputSmplr, param_4, param_5, buffer.u_edgeType);
    float4 _t93 = _1598;
    float3 param_6 = buffer.u_mainColor.xyz;
    float3 _2174 = _f3(param_6);
    float _2175 = buffer.u_mainColor.w;
    float3 _1611 = _1598.xyz;
    float3 param_7 = _1611;
    _2174 *= _f3(param_7);
    _2175 *= _t93.w;
    float3 _2177 = in.v_nDirWS;
    bool _1629 = buffer.u_enableNormTex > 0;
    if (_1629)
    {
        _2177 = float3x3(float3(in.v_tDirWS), float3(in.v_bDirWS), float3(in.v_nDirWS)) * fast::normalize(mix(float3(0.0, 0.0, 1.0), fast::normalize((mix(u_normTex.sample(u_normTexSmplr, in.v_uv0).xyz, u_normTex.sample(u_normTexSmplr, (in.v_uv0 * 3.0)).xyz, float3(0.300000011920928955078125)) * 2.0) - float3(1.0)), float3(buffer.u_normInt * 2.0)));
    }
    float2 _2178 = float2(0.0);
    float3 _2179 = float3(0.0);
    float2 _2181 = float2(1.0);
    _2178.x = fast::max(0.0199999995529651641845703125, buffer.u_metallic * 0.100000001490116119384765625);
    _2178.y = 0.9900000095367431640625 * (1.0 - _2178.x);
    _2179.x = fast::clamp(mix(0.85000002384185791015625, buffer.u_roughness, 0.300000011920928955078125), 0.039999999105930328369140625, 1.0);
    float param_8 = _2179.x;
    _2179.y = _f0(param_8);
    float param_9 = _2179.y;
    _2179.z = _f0(param_9);
    float3 _1732 = (_2174 * _2178.y) * 1.2000000476837158203125;
    float3 _1740 = mix(float3(0.0199999995529651641845703125), _2174, float3(_2178.x));
    float2 _1754 = float2(buffer.u_anisoAngle * 3.1415927410125732421875, fast::max(0.60000002384185791015625, buffer.u_anisoStrength));
    float3 _2317;
    float3 _2318;
    if (_1629)
    {
        float3 _1778 = fast::normalize(cross(_2177, in.v_bDirWS));
        _2317 = _1778;
        _2318 = fast::normalize(cross(_2177, _1778));
    }
    else
    {
        _2317 = in.v_tDirWS;
        _2318 = in.v_bDirWS;
    }
    float3 _1803 = fast::normalize(reflect(float3(-0.0, -0.0, -1.0), _2177));
    float _2185;
    SurfaceParams param_10 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
    WorldSpaceVectors param_11 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
    _2181.y = _f6(param_10, param_11);
    float3 _1825 = fast::normalize(-buffer.u_dirLightDirection);
    bool _1839 = buffer.u_pointLightEnabled > 0.0;
    float3 _2415;
    float3 _2416;
    float _2417;
    float _2418;
    if (_1839)
    {
        float3 _1847 = buffer.u_pointLightPosition - in.v_posWS;
        _2415 = fast::normalize(_1847);
        _2416 = buffer.u_pointLightColor;
        _2417 = buffer.u_pointLightIntensity * buffer.u_pointLightEnabled;
        _2418 = pow(1.0 - smoothstep(0.0, 1.2000000476837158203125 / buffer.u_pointLightAttenRangeInv, length(_1847)), 1.60000002384185791015625);
    }
    bool _1878 = buffer.u_spotLightEnabled > 0.0;
    float3 _2429;
    float3 _2430;
    float _2431;
    float _2432;
    if (_1878)
    {
        float3 _1893 = float3(buffer.u_spotLightPosition.x, -buffer.u_spotLightPosition.y, buffer.u_spotLightPosition.z) - in.v_posWS;
        float _1896 = length(_1893);
        _2429 = fast::normalize(_1893);
        _2430 = buffer.u_spotLightColor;
        _2431 = buffer.u_spotLightIntensity * buffer.u_spotLightEnabled;
        float _1912 = 1.0 / buffer.u_spotLightAttenRangeInv;
        float _1917 = 1.0 - smoothstep(0.0, _1912, _1896);
        _2432 = fast::max(_1917 * _1917, pow(1.0 - smoothstep(0.0, _1912 * 0.5, _1896), 1.5) * 0.60000002384185791015625);
    }
    float3 _t118 = _1611;
    float3 param_12 = in.v_vertexColor.xyz;
    bool _1955 = buffer.u_envEnabled > 0.0;
    bool _1957 = buffer.u_dirLightEnabled > 0.0;
    if (((_1955 || _1957) || _1839) || _1878)
    {
        float3 _t121 = float3(0.0);
        if (_1955)
        {
            SurfaceParams param_13 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_14 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            EnvironmentParams _2397 = EnvironmentParams{ buffer.u_envInt * buffer.u_envEnabled, buffer.u_envRot };
            EnvironmentParams param_15 = _2397;
            SurfaceParams param_16 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_17 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            EnvironmentParams param_18 = _2397;
            _t121 += (((_f16(param_13, param_14, param_15, buffer.u_WorldSpaceCameraPos, in.v_posWS, buffer.u_envRotAxis, u_envTex, u_envTexSmplr) * 1.2999999523162841796875) + (_f15(param_16, param_17, param_18, buffer.u_WorldSpaceCameraPos, in.v_posWS, buffer.u_envRotAxis, u_envTex, u_envTexSmplr) * 0.20000000298023223876953125)) * in.v_vertexColor.w);
        }
        if (_1957)
        {
            SurfaceParams param_19 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_20 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            LightParams _2409 = LightParams{ _1825, buffer.u_dirLightColor, buffer.u_dirLightIntensity * buffer.u_dirLightEnabled, 1.0 };
            LightParams param_21 = _2409;
            SurfaceParams param_22 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_23 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            LightParams param_24 = _2409;
            _t121 += (((((_f24(param_19, param_20, param_21) * 1.39999997615814208984375) + (_f20(param_22, param_23, param_24) * 0.300000011920928955078125)) + (float3(0.20000000298023223876953125) * pow(1.0 - fast::max(0.0, dot(_2177, float3(0.0, 0.0, 1.0))), 3.0))) + float3(pow(fast::max(0.0, dot(_2177, -_1825)), 2.0) * 0.100000001490116119384765625)) * in.v_vertexColor.w);
        }
        if (_1839)
        {
            SurfaceParams param_25 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_26 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            LightParams param_27 = LightParams{ _2415, _2416, _2417, _2418 };
            SurfaceParams param_28 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_29 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            LightParams param_30 = LightParams{ _2415, _2416, _2417, _2418 };
            _t121 += (((_f23(param_25, param_26, param_27) * 1.2000000476837158203125) + (_f22(param_28, param_29, param_30) * 0.300000011920928955078125)) * in.v_vertexColor.w);
        }
        if (_1878)
        {
            SurfaceParams param_31 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_32 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            LightParams param_33 = LightParams{ _2429, _2430, _2431, _2432 };
            SurfaceParams param_34 = SurfaceParams{ _2174, _2175, 0.0, _2177, _2178, _2179, float3(0.0), _2181, _1732, _1740, _1754, _2185 };
            WorldSpaceVectors param_35 = WorldSpaceVectors{ in.v_posWS, _2177, in.v_nDirWS, _2317, _2318, float3(0.0, 0.0, 1.0), _1803 };
            LightParams param_36 = LightParams{ _2429, _2430, _2431, _2432 };
            _t121 += (((_f23(param_31, param_32, param_33) * 1.2000000476837158203125) + (_f22(param_34, param_35, param_36) * 0.300000011920928955078125)) * in.v_vertexColor.w);
        }
        if (buffer.u_enableToneMapping > 0)
        {
            float3 param_37 = _t121;
            _t121 = _f5(param_37);
        }
        float3 param_38 = _t121;
        float3 _2130 = _f4(param_38);
        _t121 = _2130;
        _t118 = mix(_t118, _2130, float3(buffer.u_lightingBlend)) * mix(float3(1.0), pow(_f4(param_12), float3(buffer.u_shadowContrast)) * buffer.u_shadowColor, float3(buffer.u_shadowIntensity));
    }
    out.o_fragColor = float4(_t118, _2175);
    return out;
}

