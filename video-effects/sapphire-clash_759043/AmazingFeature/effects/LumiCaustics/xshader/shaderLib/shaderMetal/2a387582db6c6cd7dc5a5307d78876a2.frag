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
    float u_height;
    int u_lightMode;
    float3 u_lightDirOrPos;
    float u_height0;
    float u_refract;
    int u_bottomEdgeMode;
    float2 u_bottomSize;
    float u_causticsIntensity;
    float3 u_waterColor;
    float u_waterOpacity;
    float u_skyIntensity;
    float u_skyReflect;
    int u_skyEdgeMode;
    float2 u_skySize;
    float3 u_lightColor;
    int u_lightDiffuse;
    float u_lightIntensity;
    float u_diffuse;
    float u_specular;
    float u_specularExp;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_xy [[user(locn0)]];
};

static inline __attribute__((always_inline))
float2 _f0(constant float4& u_ScreenParams)
{
    return u_ScreenParams.xy;
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, constant float4& u_ScreenParams)
{
    return (_p0 / _f0(u_ScreenParams)) + float2(0.5);
}

static inline __attribute__((always_inline))
float _f2(thread const float4& _p0)
{
    return ((_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0)) + (_p0.w / 16581375.0);
}

static inline __attribute__((always_inline))
float _f3(thread const float2& _p0, constant float4& u_ScreenParams, texture2d<float> u_heightTexture, sampler u_heightTextureSmplr, constant float& u_height)
{
    float2 param = _p0;
    float4 param_1 = u_heightTexture.sample(u_heightTextureSmplr, _f1(param, u_ScreenParams));
    return _f2(param_1) * u_height;
}

static inline __attribute__((always_inline))
float3 _f4(thread const float2& _p0, constant float4& u_ScreenParams, texture2d<float> u_heightTexture, sampler u_heightTextureSmplr, constant float& u_height)
{
    float2 param = _p0 + float2(5.0, 0.0);
    float2 param_1 = _p0 - float2(5.0, 0.0);
    float2 param_2 = _p0 + float2(0.0, 5.0);
    float2 param_3 = _p0 - float2(0.0, 5.0);
    return fast::normalize(cross(float3(1.0, 0.0, _f3(param, u_ScreenParams, u_heightTexture, u_heightTextureSmplr, u_height) - _f3(param_1, u_ScreenParams, u_heightTexture, u_heightTextureSmplr, u_height)), float3(0.0, 1.0, _f3(param_2, u_ScreenParams, u_heightTexture, u_heightTextureSmplr, u_height) - _f3(param_3, u_ScreenParams, u_heightTexture, u_heightTextureSmplr, u_height))));
}

static inline __attribute__((always_inline))
float2 _f11(thread const float2& _p0, thread const float2& _p1, constant float4& u_ScreenParams)
{
    return (((_p1 * u_ScreenParams.xy) - (u_ScreenParams.xy * 0.5)) / _p0) + float2(0.5);
}

static inline __attribute__((always_inline))
float4 _f7(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1)
{
    return _p0.sample(_p0Smplr, fast::clamp(_p1, float2(0.0), float2(1.0)));
}

static inline __attribute__((always_inline))
float4 _f8(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1)
{
    return _p0.sample(_p0Smplr, fract(_p1));
}

static inline __attribute__((always_inline))
float4 _f9(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    _p1 = abs(mod(_p1 + float2(1.0), float2(2.0)) - float2(1.0));
    return _p0.sample(_p0Smplr, _p1);
}

static inline __attribute__((always_inline))
float4 _f6(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    float2 _191 = _p1;
    _p1 = step(float2(0.0), _p1) * step(_p1, float2(1.0));
    return (_p0.sample(_p0Smplr, _191) * _p1.x) * _p1.y;
}

static inline __attribute__((always_inline))
float4 _f10(thread const int& _p0, texture2d<float> _p1, sampler _p1Smplr, thread const float2& _p2)
{
    if (_p0 == 0)
    {
        float2 param = _p2;
        return _f7(_p1, _p1Smplr, param);
    }
    else
    {
        if (_p0 == 1)
        {
            float2 param_1 = _p2;
            return _f8(_p1, _p1Smplr, param_1);
        }
        else
        {
            if (_p0 == 2)
            {
                float2 param_2 = _p2;
                float4 _270 = _f9(_p1, _p1Smplr, param_2);
                return _270;
            }
            else
            {
                float2 param_3 = _p2;
                float4 _275 = _f6(_p1, _p1Smplr, param_3);
                return _275;
            }
        }
    }
}

static inline __attribute__((always_inline))
float4 _f5(thread const float4& _p0)
{
    if (_p0.w == 0.0)
    {
        return float4(0.0);
    }
    return float4(_p0.xyz / float3(_p0.w), _p0.w);
}

static inline __attribute__((always_inline))
float3 _f12(thread const float3& _p0, constant int& u_lightMode, constant float3& u_lightDirOrPos)
{
    if (u_lightMode == 1)
    {
        return fast::normalize(u_lightDirOrPos - _p0);
    }
    else
    {
        return u_lightDirOrPos;
    }
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_heightTexture [[texture(0)]], texture2d<float> u_bottomTexture [[texture(1)]], texture2d<float> u_normalTexture [[texture(2)]], texture2d<float> u_skyTexture [[texture(3)]], sampler u_heightTextureSmplr [[sampler(0)]], sampler u_bottomTextureSmplr [[sampler(1)]], sampler u_normalTextureSmplr [[sampler(2)]], sampler u_skyTextureSmplr [[sampler(3)]])
{
    main0_out out = {};
    float2 param = in.v_xy;
    float _323 = _f3(param, buffer.u_ScreenParams, u_heightTexture, u_heightTextureSmplr, buffer.u_height) + buffer.u_height0;
    float2 param_1 = in.v_xy;
    float3 _327 = _f4(param_1, buffer.u_ScreenParams, u_heightTexture, u_heightTextureSmplr, buffer.u_height);
    float2 param_2 = in.v_xy + ((_327.xy * _323) * buffer.u_refract);
    float2 _341 = _f1(param_2, buffer.u_ScreenParams);
    float2 param_3 = buffer.u_bottomSize;
    float2 param_4 = _341;
    int param_5 = buffer.u_bottomEdgeMode;
    float2 param_6 = _f11(param_3, param_4, buffer.u_ScreenParams);
    float4 param_7 = _f10(param_5, u_bottomTexture, u_bottomTextureSmplr, param_6);
    float4 _357 = _f5(param_7);
    float4 _t12 = _357;
    float3 _t13 = _357.xyz;
    float4 param_8 = u_normalTexture.sample(u_normalTextureSmplr, _341);
    _t13 = fast::clamp(_t13 + float3(((_f2(param_8) * 2.0) - 1.0) * buffer.u_causticsIntensity), float3(0.0), float3(1.0));
    float _382 = buffer.u_height + buffer.u_height0;
    if (_382 > 1.0)
    {
        _t13 = mix(_t13, buffer.u_waterColor, float3(((_323 + buffer.u_height0) / _382) * buffer.u_waterOpacity));
    }
    float3 _408 = fast::normalize(reflect(float3(0.0, 0.0, -1.0), _327));
    if (buffer.u_skyIntensity > 0.0)
    {
        float2 param_9 = in.v_xy + ((_408.xy * buffer.u_height0) * buffer.u_skyReflect);
        float2 param_10 = buffer.u_skySize;
        float2 param_11 = _f1(param_9, buffer.u_ScreenParams);
        int param_12 = buffer.u_skyEdgeMode;
        float2 param_13 = _f11(param_10, param_11, buffer.u_ScreenParams);
        float4 param_14 = _f10(param_12, u_skyTexture, u_skyTextureSmplr, param_13);
        float4 _442 = _f5(param_14);
        float4 _t19 = _442;
        _t13 = mix(_t13, _442.xyz, float3(buffer.u_skyIntensity * _t19.w));
    }
    float3 param_15 = float3(in.v_xy, _323);
    float3 _459 = _f12(param_15, buffer.u_lightMode, buffer.u_lightDirOrPos);
    float3 _t21 = buffer.u_lightColor;
    if (buffer.u_lightDiffuse == 1)
    {
        _t13 *= ((buffer.u_lightIntensity * buffer.u_diffuse) * fast::max(dot(_459, _327), 0.0));
    }
    float3 _492 = _t21;
    float3 _493 = _492 * ((buffer.u_lightIntensity * buffer.u_specular) * pow(fast::max(dot(_459, _408), 0.0), buffer.u_specularExp));
    _t21 = _493;
    float3 _494 = _t13;
    float3 _499 = fast::clamp(_494 + _493, float3(0.0), float3(1.0));
    _t13 = _499;
    out.o_fragColor = float4(_499, 1.0) * _t12.w;
    return out;
}

