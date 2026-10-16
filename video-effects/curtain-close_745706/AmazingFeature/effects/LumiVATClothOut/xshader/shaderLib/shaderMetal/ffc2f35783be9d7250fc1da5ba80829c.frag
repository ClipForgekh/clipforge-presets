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
    float u_envRot;
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
float2 _f25(thread float2& _p0, thread const float& _p1, thread const float2& _p2, thread const float2& _p3, constant float4& u_ScreenParams)
{
    _p0 -= _p2;
    _p0.y *= (u_ScreenParams.y / u_ScreenParams.x);
    float _1213 = sin(_p1);
    float _1216 = cos(_p1);
    _p0 = float2x2(float2(_1216, _1213), float2(-_1213, _1216)) * _p0;
    _p0.y *= (u_ScreenParams.x / u_ScreenParams.y);
    _p0 /= _p3;
    _p0 += _p2;
    return _p0;
}

static inline __attribute__((always_inline))
float2 _f23(thread const float2& _p0)
{
    float2 _1172 = mod(_p0, float2(1.0));
    return _1172 + (float2(1.0) - step(float2(0.0), _1172));
}

static inline __attribute__((always_inline))
float2 _f22(thread const float2& _p0)
{
    return abs(mod(_p0 - float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float _f24(thread const float2& _p0)
{
    float2 _t70 = step(float2(0.0), _p0) * step(_p0, float2(1.0));
    return _t70.x * _t70.y;
}

static inline __attribute__((always_inline))
float4 _f26(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float2& _p2, constant int& u_edgeType)
{
    float2 _t74 = _p1;
    bool _1253 = _p2.x < 0.0;
    bool _1260;
    if (!_1253)
    {
        _1260 = _p2.y < 0.0;
    }
    else
    {
        _1260 = _1253;
    }
    if (_1260)
    {
        if (u_edgeType == 0)
        {
            float2 param = _p1;
            _t74 = _f23(param);
        }
        else
        {
            if (u_edgeType == 1)
            {
                float2 param_1 = _p1;
                _t74 = _f22(param_1);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t74 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_2 = _p1;
                    if (_f24(param_2) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t74 = _p1;
                }
            }
        }
        return _p0.sample(_p0Smplr, _t74);
    }
    bool _1309 = _p1.x < _p2.x;
    bool _1319;
    if (!_1309)
    {
        _1319 = _p1.x > (1.0 - _p2.x);
    }
    else
    {
        _1319 = _1309;
    }
    bool _1329;
    if (!_1319)
    {
        _1329 = _p1.y > (1.0 - _p2.y);
    }
    else
    {
        _1329 = _1319;
    }
    if (_1329)
    {
        if (u_edgeType == 0)
        {
            float2 param_3 = _p1;
            _t74 = _f23(param_3);
        }
        else
        {
            if (u_edgeType == 1)
            {
                float2 param_4 = _p1;
                _t74 = _f22(param_4);
            }
            else
            {
                if (u_edgeType == 2)
                {
                    _t74 = fast::clamp(_p1, float2(0.0), float2(1.0));
                }
                else
                {
                    float2 param_5 = _p1;
                    if (_f24(param_5) < 1.0)
                    {
                        return float4(0.0);
                    }
                    _t74 = _p1;
                }
            }
        }
    }
    return _p0.sample(_p0Smplr, _t74);
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
    float _267 = fast::min(1.0 + dot(_p1.rDir, _p1.nDir), 1.0);
    return _f2(param) * (_267 * _267);
}

static inline __attribute__((always_inline))
float3 _f4(thread const float3& _p0)
{
    return float3(pow(_p0.x, 0.4545449912548065185546875), pow(_p0.y, 0.4545449912548065185546875), pow(_p0.z, 0.4545449912548065185546875));
}

static inline __attribute__((always_inline))
float3x3 _f9(thread const float& _p0)
{
    float _313 = sin(_p0);
    float _316 = cos(_p0);
    return float3x3(float3(_316, -_313, 0.0), float3(_313, _316, 0.0), float3(0.0, 0.0, 1.0));
}

static inline __attribute__((always_inline))
float3x3 _f8(thread const float& _p0)
{
    float _296 = sin(_p0);
    float _299 = cos(_p0);
    return float3x3(float3(_299, 0.0, _296), float3(0.0, 1.0, 0.0), float3(-_296, 0.0, _299));
}

static inline __attribute__((always_inline))
float3x3 _f7(thread const float& _p0)
{
    float _279 = sin(_p0);
    float _282 = cos(_p0);
    return float3x3(float3(1.0, 0.0, 0.0), float3(0.0, _282, -_279), float3(0.0, _279, _282));
}

static inline __attribute__((always_inline))
float2 _f10(thread const float3& _p0, thread const float& _p1, constant float3& u_WorldSpaceCameraPos, thread float3& v_posWS, constant float3& u_envRotAxis)
{
    float3 _336 = fast::normalize(u_WorldSpaceCameraPos - v_posWS);
    float3 _341 = fast::normalize(cross(float3(0.0, 1.0, 0.0), _336));
    float param = u_envRotAxis.z;
    float param_1 = u_envRotAxis.y;
    float param_2 = u_envRotAxis.x;
    float3 _t22 = fast::normalize((float3x3(float3(_341), float3(fast::normalize(cross(_336, _341))), float3(_336)) * ((_f9(param) * _f8(param_1)) * _f7(param_2))) * _p0);
    float2 _t23;
    _t23.x = ((precise::atan2(_t22.z, _t22.x) * 0.31830990314483642578125) * 0.5) + 0.5;
    _t23.y = acos(_t22.y) * 0.31830990314483642578125;
    _t23.x = fract(_t23.x + _p1);
    return _t23;
}

static inline __attribute__((always_inline))
float3 _f11(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, thread const float& _p2)
{
    float _416 = floor(_p2);
    float2 _t26 = _p1;
    float2 _t27 = _p1;
    if (abs(_416 - 0.0) < 0.001000000047497451305389404296875)
    {
        _t26.x = ((((_p1.x * 511.0) / 512.0) + 0.0009765625) * 1.0) + 0.0;
        _t26.y = ((((_p1.y * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
        _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
    }
    else
    {
        if (abs(_416 - 1.0) < 0.001000000047497451305389404296875)
        {
            _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
            _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
            _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
            _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
        }
        else
        {
            if (abs(_416 - 2.0) < 0.001000000047497451305389404296875)
            {
                _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.5;
                _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                _t27.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                _t27.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
            }
            else
            {
                if (abs(_416 - 3.0) < 0.001000000047497451305389404296875)
                {
                    _t26.x = ((((_p1.x * 255.0) / 256.0) + 0.001953125) * 0.5) + 0.0;
                    _t26.y = ((((_p1.y * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                    _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                    _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                }
                else
                {
                    if (abs(_416 - 4.0) < 0.001000000047497451305389404296875)
                    {
                        _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                        _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                        _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                        _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                    }
                    else
                    {
                        if (abs(_416 - 5.0) < 0.001000000047497451305389404296875)
                        {
                            _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                            _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.75;
                            _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                            _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                        }
                        else
                        {
                            if (abs(_416 - 6.0) < 0.001000000047497451305389404296875)
                            {
                                _t26.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.5;
                                _t26.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                                _t27.x = ((((_p1.x * 127.0) / 128.0) + 0.00390625) * 0.25) + 0.75;
                                _t27.y = ((((_p1.y * 63.0) / 64.0) + 0.0078125) * 0.125) + 0.875;
                            }
                            else
                            {
                                if (abs(_416 - 7.0) < 0.001000000047497451305389404296875)
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
    float4 _772 = mix(_p0.sample(_p0Smplr, _t26), _p0.sample(_p0Smplr, _t27), float4(_p2 - _416));
    float4 _t29 = _772;
    return _772.xyz / float3(_t29.w);
}

static inline __attribute__((always_inline))
float3 _f12(thread const float3& _p0, thread const float& _p1, constant float3& u_WorldSpaceCameraPos, thread float3& v_posWS, constant float3& u_envRotAxis, constant float& u_envRot, texture2d<float> u_envTex, sampler u_envTexSmplr)
{
    float3 param = _p0;
    float param_1 = u_envRot;
    float2 param_2 = _f10(param, param_1, u_WorldSpaceCameraPos, v_posWS, u_envRotAxis);
    float param_3 = _p1;
    return _f11(u_envTex, u_envTexSmplr, param_2, param_3);
}

static inline __attribute__((always_inline))
float3 _f13(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1)
{
    float4 _819 = (float4(-1.0, -0.0274999998509883880615234375, -0.572000026702880859375, 0.02199999988079071044921875) * _p0.roughParams.x) + float4(1.0, 0.0425000004470348358154296875, 1.03999996185302734375, -0.039999999105930328369140625);
    float4 _t33 = _819;
    float2 _t35 = (float2(-1.03999996185302734375, 1.03999996185302734375) * ((fast::min(_t33.x * _t33.x, exp2((-9.27999973297119140625) * fast::max(0.0, dot(_p1.nDir, _p1.vDir)))) * _t33.x) + _t33.y)) + _819.zw;
    float param = 50.0 * _p0.specCol.y;
    _t35.y *= _f2(param);
    return (_p0.specCol * _t35.x) + float3(_t35.y);
}

static inline __attribute__((always_inline))
float3 _f14(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float param = dot(_p1.nDir, _p2.lDir);
    float param_1 = dot(_p1.nDir, fast::normalize(_p2.lDir + _p1.vDir));
    return (((_p0.diffCol * mix(pow(1.0 - _f2(param), 3.0) * 0.5, (1.0 - pow(1.0 - _f2(param_1), 5.0)) * 0.699999988079071044921875, 0.5)) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

static inline __attribute__((always_inline))
float _f17(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return 0.5 / (((_p2 * ((_p1 * (1.0 - _p0)) + _p0)) + (_p1 * ((_p2 * (1.0 - _p0)) + _p0))) + 9.9999997473787516355514526367188e-06);
}

static inline __attribute__((always_inline))
float _f16(thread const float& _p0, thread const float& _p1)
{
    float _946 = (((_p0 * _p1) - _p0) * _p0) + 1.0;
    return (_p1 * 0.31830990314483642578125) / ((_946 * _946) + 1.0000000116860974230803549289703e-07);
}

static inline __attribute__((always_inline))
float _f1(thread const float& _p0)
{
    float _150 = _p0 * _p0;
    return (_150 * _150) * _p0;
}

static inline __attribute__((always_inline))
float3 _f15(thread const float3& _p0, thread const float& _p1)
{
    float param = 1.0 - _p1;
    return _p0 + ((float3(1.0) - _p0) * _f1(param));
}

static inline __attribute__((always_inline))
float3 _f18(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float3 _989 = fast::normalize(_p2.lDir + _p1.vDir);
    float _1008 = fast::max(0.0, dot(_p1.nDir, _p2.lDir));
    float param = _1008;
    float param_1 = fast::max(0.0, dot(_p1.nDir, _p1.vDir));
    float param_2 = _p0.roughParams.y;
    float param_3 = fast::max(0.0, dot(_p1.nDir, _989));
    float param_4 = _p0.roughParams.z;
    float3 param_5 = _p0.specCol;
    float param_6 = fast::max(0.0, dot(_p1.vDir, _989));
    return ((((((_f15(param_5, param_6) * _f17(param, param_1, param_2)) * _f16(param_3, param_4)) * 3.1415927410125732421875) * _1008) * _p2.color) * _p2.intensity) * _p2.attenuate;
}

static inline __attribute__((always_inline))
float3 _f21(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    return (((_p0.diffCol * _p2.color) * _p2.intensity) * _p2.attenuate) * fast::max(0.0, dot(_p1.nDir, _p2.lDir));
}

static inline __attribute__((always_inline))
float _f19()
{
    return 0.25;
}

static inline __attribute__((always_inline))
float3 _f20(thread const SurfaceParams& _p0, thread const WorldSpaceVectors& _p1, thread const LightParams& _p2)
{
    float3 _1073 = fast::normalize(_p2.lDir + _p1.vDir);
    float param = fast::max(0.0, dot(_p1.nDir, _1073));
    float param_1 = _p0.roughParams.z;
    float3 param_2 = _p0.specCol;
    float param_3 = fast::max(0.0, dot(_p1.vDir, _1073));
    return ((((((_f15(param_2, param_3) * _f19()) * _f16(param, param_1)) * 3.1415927410125732421875) * fast::max(0.0, dot(_p1.nDir, _p2.lDir))) * _p2.color) * _p2.intensity) * _p2.attenuate;
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
    float2 _1405 = _f25(param, param_1, param_2, param_3, buffer.u_ScreenParams);
    float2 param_4 = _1405;
    float2 param_5 = buffer.u_padding;
    float4 _1415 = _f26(u_input, u_inputSmplr, param_4, param_5, buffer.u_edgeType);
    float4 _t78 = _1415;
    float3 param_6 = buffer.u_mainColor.xyz;
    float3 _1982 = _f3(param_6);
    float _1983 = buffer.u_mainColor.w;
    float3 _1428 = _1415.xyz;
    float3 param_7 = _1428;
    _1982 *= _f3(param_7);
    _1983 *= _t78.w;
    float3 _1985 = in.v_nDirWS;
    bool _1446 = buffer.u_enableNormTex > 0;
    if (_1446)
    {
        _1985 = float3x3(float3(in.v_tDirWS), float3(in.v_bDirWS), float3(in.v_nDirWS)) * fast::normalize(mix(float3(0.0, 0.0, 1.0), fast::normalize((mix(u_normTex.sample(u_normTexSmplr, in.v_uv0).xyz, u_normTex.sample(u_normTexSmplr, (in.v_uv0 * 3.0)).xyz, float3(0.300000011920928955078125)) * 2.0) - float3(1.0)), float3(buffer.u_normInt * 2.0)));
    }
    float2 _1986 = float2(0.0);
    float3 _1987 = float3(0.0);
    float2 _1989 = float2(1.0);
    _1986.x = fast::max(0.0199999995529651641845703125, buffer.u_metallic * 0.100000001490116119384765625);
    _1986.y = 0.9900000095367431640625 * (1.0 - _1986.x);
    _1987.x = fast::clamp(mix(0.85000002384185791015625, buffer.u_roughness, 0.300000011920928955078125), 0.039999999105930328369140625, 1.0);
    float param_8 = _1987.x;
    _1987.y = _f0(param_8);
    float param_9 = _1987.y;
    _1987.z = _f0(param_9);
    float3 _1549 = (_1982 * _1986.y) * 1.2000000476837158203125;
    float3 _1557 = mix(float3(0.0199999995529651641845703125), _1982, float3(_1986.x));
    float2 _1571 = float2(buffer.u_anisoAngle * 3.1415927410125732421875, fast::max(0.60000002384185791015625, buffer.u_anisoStrength));
    float3 _2113;
    float3 _2114;
    if (_1446)
    {
        float3 _1595 = fast::normalize(cross(_1985, in.v_bDirWS));
        _2113 = _1595;
        _2114 = fast::normalize(cross(_1985, _1595));
    }
    else
    {
        _2113 = in.v_tDirWS;
        _2114 = in.v_bDirWS;
    }
    float3 _1620 = fast::normalize(reflect(float3(-0.0, -0.0, -1.0), _1985));
    float _1993;
    SurfaceParams param_10 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
    WorldSpaceVectors param_11 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
    _1989.y = _f6(param_10, param_11);
    bool _1657 = buffer.u_pointLightEnabled > 0.0;
    float3 _2197;
    float3 _2198;
    float _2199;
    float _2200;
    if (_1657)
    {
        float3 _1665 = buffer.u_pointLightPosition - in.v_posWS;
        _2197 = fast::normalize(_1665);
        _2198 = buffer.u_pointLightColor;
        _2199 = buffer.u_pointLightIntensity * buffer.u_pointLightEnabled;
        _2200 = pow(1.0 - smoothstep(0.0, 1.2000000476837158203125 / buffer.u_pointLightAttenRangeInv, length(_1665)), 1.60000002384185791015625);
    }
    bool _1696 = buffer.u_spotLightEnabled > 0.0;
    float3 _2211;
    float3 _2212;
    float _2213;
    float _2214;
    if (_1696)
    {
        float3 _1711 = float3(buffer.u_spotLightPosition.x, -buffer.u_spotLightPosition.y, buffer.u_spotLightPosition.z) - in.v_posWS;
        float _1714 = length(_1711);
        _2211 = fast::normalize(_1711);
        _2212 = buffer.u_spotLightColor;
        _2213 = buffer.u_spotLightIntensity * buffer.u_spotLightEnabled;
        float _1730 = 1.0 / buffer.u_spotLightAttenRangeInv;
        float _1735 = 1.0 - smoothstep(0.0, _1730, _1714);
        _2214 = fast::max(_1735 * _1735, pow(1.0 - smoothstep(0.0, _1730 * 0.5, _1714), 1.5) * 0.60000002384185791015625);
    }
    float3 _t103 = _1428;
    float3 param_12 = in.v_vertexColor.xyz;
    bool _1773 = buffer.u_envEnabled > 0.0;
    bool _1775 = buffer.u_dirLightEnabled > 0.0;
    if (((_1773 || _1775) || _1657) || _1696)
    {
        float3 _t106 = float3(0.0);
        if (_1773)
        {
            float3 param_13 = _1985;
            float param_14 = 7.0;
            float3 param_15 = _1620;
            float param_16 = _1987.x * 7.0;
            SurfaceParams param_17 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
            WorldSpaceVectors param_18 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
            _t106 += ((((_f12(param_13, param_14, buffer.u_WorldSpaceCameraPos, in.v_posWS, buffer.u_envRotAxis, buffer.u_envRot, u_envTex, u_envTexSmplr) * _1549) * 1.2999999523162841796875) + ((_f12(param_15, param_16, buffer.u_WorldSpaceCameraPos, in.v_posWS, buffer.u_envRotAxis, buffer.u_envRot, u_envTex, u_envTexSmplr) * _f13(param_17, param_18)) * 0.20000000298023223876953125)) * (buffer.u_envInt * buffer.u_envEnabled));
        }
        if (_1775)
        {
            SurfaceParams param_19 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
            WorldSpaceVectors param_20 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
            LightParams _2191 = LightParams{ fast::normalize(-buffer.u_dirLightDirection), buffer.u_dirLightColor, buffer.u_dirLightIntensity * buffer.u_dirLightEnabled, 1.0 };
            LightParams param_21 = _2191;
            SurfaceParams param_22 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
            WorldSpaceVectors param_23 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
            LightParams param_24 = _2191;
            float param_25 = dot(_1985, float3(0.0, 0.0, 1.0));
            _t106 += ((_f14(param_19, param_20, param_21) + (_f18(param_22, param_23, param_24) * 0.300000011920928955078125)) + (float3(0.20000000298023223876953125) * pow(1.0 - _f2(param_25), 3.0)));
        }
        if (_1657)
        {
            SurfaceParams param_26 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
            WorldSpaceVectors param_27 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
            LightParams param_28 = LightParams{ _2197, _2198, _2199, _2200 };
            SurfaceParams param_29 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
            WorldSpaceVectors param_30 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
            LightParams param_31 = LightParams{ _2197, _2198, _2199, _2200 };
            _t106 += (((_f21(param_26, param_27, param_28) * 1.2000000476837158203125) + (_f20(param_29, param_30, param_31) * 0.300000011920928955078125)) * 1.0);
        }
        if (_1696)
        {
            SurfaceParams param_32 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
            WorldSpaceVectors param_33 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
            LightParams param_34 = LightParams{ _2211, _2212, _2213, _2214 };
            SurfaceParams param_35 = SurfaceParams{ _1982, _1983, 0.0, _1985, _1986, _1987, float3(0.0), _1989, _1549, _1557, _1571, _1993 };
            WorldSpaceVectors param_36 = WorldSpaceVectors{ in.v_posWS, _1985, in.v_nDirWS, _2113, _2114, float3(0.0, 0.0, 1.0), _1620 };
            LightParams param_37 = LightParams{ _2211, _2212, _2213, _2214 };
            _t106 += (((_f21(param_32, param_33, param_34) * 1.2000000476837158203125) + (_f20(param_35, param_36, param_37) * 0.300000011920928955078125)) * 1.0);
        }
        if (buffer.u_enableToneMapping > 0)
        {
            float3 param_38 = _t106;
            _t106 = _f5(param_38);
        }
        float3 param_39 = _t106;
        float3 _1938 = _f4(param_39);
        _t106 = _1938;
        _t103 = mix(_t103, _1938, float3(buffer.u_lightingBlend)) * mix(float3(1.0), pow(_f4(param_12), float3(buffer.u_shadowContrast)) * buffer.u_shadowColor, float3(buffer.u_shadowIntensity));
    }
    out.o_fragColor = float4(_t103, _1983);
    return out;
}

