#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_highlightParam;
    float u_shadowParam;
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
float3 _f1(thread const float3& _p0, thread const float& _p1)
{
    float3 _46 = float3(1.0) - _p0;
    float3 _50 = _46 * _46;
    return (float3(1.0) - pow(_46, float3(_p1))) - ((_50 - (_50 * _46)) * (_p1 - 1.0));
}

static inline __attribute__((always_inline))
float3 _f0(thread const float3& _p0, thread const float& _p1)
{
    float3 _22 = _p0 * _p0;
    return pow(_p0, float3(_p1)) + ((_22 - (_22 * _p0)) * (_p1 - 1.0));
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _84 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t7 = _84;
    float3 param = _84.xyz;
    float param_1 = buffer.u_highlightParam;
    float3 _92 = _f1(param, param_1);
    _t7.x = _92.x;
    _t7.y = _92.y;
    _t7.z = _92.z;
    float3 param_2 = _t7.xyz;
    float param_3 = buffer.u_shadowParam;
    float3 _109 = _f0(param_2, param_3);
    _t7.x = _109.x;
    _t7.y = _109.y;
    _t7.z = _109.z;
    out.o_fragColor = fast::clamp(_t7, float4(0.0), float4(1.0));
    return out;
}

