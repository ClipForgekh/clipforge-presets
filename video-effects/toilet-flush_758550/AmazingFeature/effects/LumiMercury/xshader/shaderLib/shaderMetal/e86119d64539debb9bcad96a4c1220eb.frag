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
    float u_lightHeight;
    float4 u_ScreenParams;
    float u_specular;
    float u_strength;
    float2 u_lightPosition;
    float u_lightIntensity;
    float u_lightDirection;
    float u_metal;
    float u_roughness;
    float u_ambient;
    int u_lightType;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float _f0(thread const float3& _p0)
{
    return (_p0.x + (_p0.y / 255.0)) + (_p0.z / 65025.0);
}

static inline __attribute__((always_inline))
float2 _f1(thread const float2& _p0)
{
    return abs(mod(_p0 + float2(1.0), float2(2.0)) - float2(1.0));
}

static inline __attribute__((always_inline))
float3 _f2(thread const float3& _p0, thread const float3& _p1, thread const float3& _p2, thread const float3& _p3, thread const float3& _p4, thread const float3& _p5, thread const float& _p6, thread const float& _p7, thread const float& _p8, thread const float& _p9, thread const int& _p10, constant float& u_lightHeight)
{
    float3 _t2 = fast::normalize(_p2 - _p3);
    float3 _t3 = fast::normalize(_p4 - _p3);
    if (_p10 == 1)
    {
        _t2 = float3(0.0, 0.0, 1.0);
        _t3 = float3(cos((_p6 * 3.1415927410125732421875) / 180.0), sin((_p6 * 3.1415927410125732421875) / 180.0), u_lightHeight);
    }
    return (_p0 * _p9) + ((_p5 * mix(float3(1.0), _p0, float3(_p7))) * pow(fast::max(dot(fast::normalize(_p1), fast::normalize(_t2 + _t3)), 0.0), 1.0 / _p8));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_maskTex [[texture(0)]], texture2d<float> u_inputTexture [[texture(1)]], sampler u_maskTexSmplr [[sampler(0)]], sampler u_inputTextureSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _157 = u_maskTex.sample(u_maskTexSmplr, in.v_uv);
    float4 _t10 = _157;
    float3 param = _157.xyz;
    float2 _167 = float2(0.0, 2.0 / buffer.u_ScreenParams.y);
    float3 param_1 = u_maskTex.sample(u_maskTexSmplr, (in.v_uv - _167)).xyz;
    float3 param_2 = u_maskTex.sample(u_maskTexSmplr, (in.v_uv + _167)).xyz;
    float2 _187 = float2(2.0 / buffer.u_ScreenParams.x, 0.0);
    float3 param_3 = u_maskTex.sample(u_maskTexSmplr, (in.v_uv - _187)).xyz;
    float3 param_4 = u_maskTex.sample(u_maskTexSmplr, (in.v_uv + _187)).xyz;
    float3 _221 = float3((_f0(param_3) - _f0(param_4)) * 0.5, (_f0(param_1) - _f0(param_2)) * 0.5, _f0(param) * buffer.u_specular);
    float2 param_5 = in.v_uv + (_221.xy * buffer.u_strength);
    float4 _239 = u_inputTexture.sample(u_inputTextureSmplr, _f1(param_5)) * _t10.w;
    float4 _t19 = _239;
    float3 _246 = float3(buffer.u_lightPosition, buffer.u_lightHeight);
    float3 param_6 = _239.xyz;
    float3 param_7 = _221;
    float3 param_8 = _246;
    float3 param_9 = float3(in.v_uv, 0.0);
    float3 param_10 = _246;
    float3 param_11 = float3(1.0) * buffer.u_lightIntensity;
    float param_12 = buffer.u_lightDirection;
    float param_13 = buffer.u_metal;
    float param_14 = buffer.u_roughness;
    float param_15 = buffer.u_ambient;
    int param_16 = buffer.u_lightType;
    float3 _284 = _f2(param_6, param_7, param_8, param_9, param_10, param_11, param_12, param_13, param_14, param_15, param_16, buffer.u_lightHeight);
    _t19.x = _284.x;
    _t19.y = _284.y;
    _t19.z = _284.z;
    out.o_fragColor = _t19;
    return out;
}

