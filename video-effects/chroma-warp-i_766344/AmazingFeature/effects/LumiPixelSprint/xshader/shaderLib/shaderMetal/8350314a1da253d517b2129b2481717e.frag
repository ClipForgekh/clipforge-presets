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
    float u_heightScale;
    float2 u_center;
    float u_intensity;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
    float3 v_tangentViewPos [[user(locn1)]];
    float3 v_tangentFragPos [[user(locn2)]];
};

static inline __attribute__((always_inline))
float2 _f0(thread const float2& _p0)
{
    return abs(mod(_p0 + float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0, thread const float3& _p1, constant float& u_heightScale, texture2d<float> u_depthMap, sampler u_depthMapSmplr)
{
    float _60 = mix(32.0, 32.0, abs(dot(float3(0.0, 0.0, 1.0), _p1)));
    float _64 = 0.4000000059604644775390625 / _60;
    float _t1 = _64;
    float _t3 = 0.0;
    float2 _100 = (((_p1.xy / float2(_p1.z)) * u_heightScale) * 0.4000000059604644775390625) / float2(_60);
    float2 _t6 = _100;
    float2 _t8 = _p0;
    float _t9 = 1.0 - u_depthMap.sample(u_depthMapSmplr, _p0).x;
    for (int _t10 = 0; _t10 < 1024; _t10++)
    {
        if (_t3 >= _t9)
        {
            break;
        }
        float _137 = mix(0.1500000059604644775390625, 1.0, abs(_t3 - _t9));
        _t1 = _64 * _137;
        float2 _145 = _100 * _137;
        _t6 = _145;
        float2 _147 = _t8;
        float2 _148 = _147 - _145;
        _t8 = _148;
        float2 param = _148;
        _t9 = 1.0 - u_depthMap.sample(u_depthMapSmplr, _f0(param)).x;
        _t3 += _t1;
    }
    float2 _165 = _t8 + _t6;
    float _169 = _t9 - _t3;
    float2 param_1 = _165;
    float _187 = _169 / (_169 - (((1.0 - u_depthMap.sample(u_depthMapSmplr, _f0(param_1)).x) - _t3) + _t1));
    return (_165 * _187) + (_t8 * (1.0 - _187));
}

static inline __attribute__((always_inline))
float3 _f2(thread const float4& _p0)
{
    if (_p0.w == 0.0)
    {
        return float3(0.0);
    }
    return _p0.xyz / float3(_p0.w);
}

static inline __attribute__((always_inline))
float3 _f3(texture2d<float> _p0, sampler _p0Smplr, thread float3& _p1)
{
    _p1 *= 63.0;
    float2 _227 = float2(floor(_p1.z), ceil(_p1.z));
    float2 _t17 = _227;
    float2 _232 = floor(_227 * 0.125);
    float4 _t20 = (float4(_227 - (_232 * 8.0), _232).xzyw * 0.125) + float4(((_p1.xy + float2(0.5)) * 0.001953125).xyxy);
    return mix(_p0.sample(_p0Smplr, float2(_t20.x, 1.0 - _t20.y)).xyz, _p0.sample(_p0Smplr, float2(_t20.z, 1.0 - _t20.w)).xyz, float3(_p1.z - _t17.x));
}

static inline __attribute__((always_inline))
float4 _f4(thread const float4& _p0, texture2d<float> _p1, sampler _p1Smplr, thread const float& _p2)
{
    float4 param = _p0;
    float3 _299 = _f2(param);
    float3 _t24 = _299;
    float3 param_1 = _299;
    float3 _303 = _f3(_p1, _p1Smplr, param_1);
    float3 _304 = _t24;
    float3 _308 = mix(_304, _303, float3(_p2));
    _t24 = _308;
    return float4(_308, 1.0) * _p0.w;
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_depthMap [[texture(0)]], texture2d<float> u_diffuseMap [[texture(1)]], texture2d<float> u_sFilterTex [[texture(2)]], sampler u_depthMapSmplr [[sampler(0)]], sampler u_diffuseMapSmplr [[sampler(1)]], sampler u_sFilterTexSmplr [[sampler(2)]])
{
    main0_out out = {};
    float2 param = ((in.v_uv - buffer.u_center) / float2(mix(1.0, 2.5, pow(buffer.u_heightScale, 1.2000000476837158203125)))) + buffer.u_center;
    float3 param_1 = fast::normalize(in.v_tangentViewPos - in.v_tangentFragPos);
    float2 param_2 = _f1(param, param_1, buffer.u_heightScale, u_depthMap, u_depthMapSmplr);
    float4 param_3 = u_diffuseMap.sample(u_diffuseMapSmplr, _f0(param_2));
    float param_4 = buffer.u_intensity;
    out.o_fragColor = _f4(param_3, u_sFilterTex, u_sFilterTexSmplr, param_4);
    return out;
}

