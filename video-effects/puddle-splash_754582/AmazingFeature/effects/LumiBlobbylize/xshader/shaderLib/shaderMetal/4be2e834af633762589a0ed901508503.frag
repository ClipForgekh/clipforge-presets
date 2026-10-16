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
    float u_cutAway;
    float u_height;
    int u_lightMode;
    float3 u_lightDirOrPos;
    float3 u_lightColor;
    float u_lightIntensity;
    float u_ambient;
    float u_diffuse;
    float u_metallic;
    float u_specular;
    float u_roughness;
    float u_displacement;
    float u_cutAwayFade;
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
float2 _f0(thread const float2& _p0, constant float4& u_ScreenParams)
{
    return (_p0 / u_ScreenParams.xy) + float2(0.5);
}

static inline __attribute__((always_inline))
float _f1(thread const float4& _p0)
{
    return fma(_p0.w, 6.0308629201699659461155533790588e-08, fma(_p0.z, 1.5378700481960549950599670410156e-05, fma(_p0.y, 0.0039215688593685626983642578125, _p0.x)));
}

static inline __attribute__((always_inline))
float _f5(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, constant float4& u_ScreenParams)
{
    float2 param = _p1;
    float4 param_1 = _p0.sample(_p0Smplr, _f0(param, u_ScreenParams));
    return _f1(param_1);
}

static inline __attribute__((always_inline))
float _f4(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return fast::clamp((_p2 - _p0) / (_p1 - _p0), 0.0, 1.0);
}

static inline __attribute__((always_inline))
float _f6(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, constant float4& u_ScreenParams, constant float& u_cutAway, constant float& u_height)
{
    float2 param = _p1;
    float param_1 = u_cutAway;
    float param_2 = 1.00100004673004150390625;
    float param_3 = _f5(_p0, _p0Smplr, param, u_ScreenParams);
    return _f4(param_1, param_2, param_3) * u_height;
}

static inline __attribute__((always_inline))
float3 _f7(texture2d<float> _p0, sampler _p0Smplr, thread const float2& _p1, constant float4& u_ScreenParams, constant float& u_cutAway, constant float& u_height)
{
    float2 param = _p1 + float2(0.5, 0.0);
    float2 param_1 = _p1 - float2(0.5, 0.0);
    float2 param_2 = _p1 + float2(0.0, 0.5);
    float2 param_3 = _p1 - float2(0.0, 0.5);
    return fast::normalize(cross(float3(1.0, 0.0, _f6(_p0, _p0Smplr, param, u_ScreenParams, u_cutAway, u_height) - _f6(_p0, _p0Smplr, param_1, u_ScreenParams, u_cutAway, u_height)), float3(0.0, 1.0, _f6(_p0, _p0Smplr, param_2, u_ScreenParams, u_cutAway, u_height) - _f6(_p0, _p0Smplr, param_3, u_ScreenParams, u_cutAway, u_height))));
}

static inline __attribute__((always_inline))
float4 _f2(texture2d<float> _p0, sampler _p0Smplr, thread float2& _p1)
{
    _p1 = abs(mod(_p1 + float2(1.0), float2(2.0)) - float2(1.0));
    return _p0.sample(_p0Smplr, _p1);
}

static inline __attribute__((always_inline))
float4 _f3(thread const float4& _p0)
{
    if (_p0.w == 0.0)
    {
        return float4(0.0);
    }
    return float4(_p0.xyz / float3(_p0.w), _p0.w);
}

static inline __attribute__((always_inline))
float3 _f8(thread const float2& _p0, constant int& u_lightMode, constant float3& u_lightDirOrPos)
{
    if (u_lightMode == 1)
    {
        return fast::normalize(u_lightDirOrPos - float3(_p0, 0.0));
    }
    else
    {
        return u_lightDirOrPos;
    }
}

static inline __attribute__((always_inline))
float3 _f9(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, constant float3& u_lightColor, constant float& u_lightIntensity, constant float& u_ambient, constant float& u_diffuse, constant float& u_metallic, constant float& u_specular, constant float& u_roughness)
{
    float3 _241 = u_lightColor * u_lightIntensity;
    return ((_p2 * u_ambient) + (((_p2 * _241) * u_diffuse) * fast::max(dot(_p0, _p1), 0.0))) + (((mix(float3(1.0), _p2, float3(u_metallic)) * _241) * u_specular) * pow(fast::max(reflect(-_p0, _p1).z, 0.0), u_roughness));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_heightTexture [[texture(0)]], texture2d<float> u_inputTexture [[texture(1)]], sampler u_heightTextureSmplr [[sampler(0)]], sampler u_inputTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float2 param = in.v_xy;
    float3 _301 = _f7(u_heightTexture, u_heightTextureSmplr, param, buffer.u_ScreenParams, buffer.u_cutAway, buffer.u_height);
    float2 param_1 = in.v_xy;
    float _308 = _f5(u_heightTexture, u_heightTextureSmplr, param_1, buffer.u_ScreenParams);
    float param_2 = buffer.u_cutAway;
    float param_3 = 1.00100004673004150390625;
    float param_4 = _308;
    float2 param_5 = in.v_xy + (_301.xy * buffer.u_displacement);
    float2 param_6 = _f0(param_5, buffer.u_ScreenParams);
    float4 _331 = _f2(u_inputTexture, u_inputTextureSmplr, param_6);
    float4 param_7 = _331;
    float4 _333 = _f3(param_7);
    float4 _t17 = _333;
    float2 param_8 = in.v_xy;
    float3 param_9 = _f8(param_8, buffer.u_lightMode, buffer.u_lightDirOrPos);
    float3 param_10 = _301;
    float3 param_11 = _333.xyz;
    out.o_fragColor = float4(_f9(param_9, param_10, param_11, buffer.u_lightColor, buffer.u_lightIntensity, buffer.u_ambient, buffer.u_diffuse, buffer.u_metallic, buffer.u_specular, buffer.u_roughness), 1.0) * (_t17.w * smoothstep(mix(-buffer.u_cutAwayFade, 1.0, buffer.u_cutAway) - 9.9999997473787516355514526367188e-05, mix(0.0, 1.0 + buffer.u_cutAwayFade, buffer.u_cutAway), _308));
    return out;
}

