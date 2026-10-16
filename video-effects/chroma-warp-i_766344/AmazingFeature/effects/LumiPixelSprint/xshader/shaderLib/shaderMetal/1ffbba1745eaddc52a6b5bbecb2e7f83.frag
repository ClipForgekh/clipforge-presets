#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

static inline __attribute__((always_inline))
float3 _f0(thread const float4& _p0)
{
    return _p0.xyz / float3(fast::max(_p0.w, 9.9999999747524270787835121154785e-07));
}

static inline __attribute__((always_inline))
float3 _f1(texture2d<float> _p0, sampler _p0Smplr, thread float3& _p1)
{
    _p1 *= 63.0;
    float2 _58 = float2(floor(_p1.z), ceil(_p1.z));
    float2 _t2 = _58;
    float2 _63 = floor(_58 * 0.125);
    float4 _t5 = (float4(_58 - (_63 * 8.0), _63).xzyw * 0.125) + float4(((_p1.xy + float2(0.5)) * 0.001953125).xyxy);
    return mix(_p0.sample(_p0Smplr, float2(_t5.x, 1.0 - _t5.y)).xyz, _p0.sample(_p0Smplr, float2(_t5.z, 1.0 - _t5.w)).xyz, float3(_p1.z - _t2.x));
}

static inline __attribute__((always_inline))
float4 _f2(thread const float4& _p0, texture2d<float> _p1, sampler _p1Smplr, thread const float& _p2)
{
    float4 param = _p0;
    float3 _133 = _f0(param);
    float3 _t9 = _133;
    float3 param_1 = _133;
    float3 _137 = _f1(_p1, _p1Smplr, param_1);
    float3 _138 = _t9;
    float3 _142 = mix(_138, _137, float3(_p2));
    _t9 = _142;
    return float4(_142, 1.0) * _p0.w;
}

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_inputImageTexture [[texture(0)]], texture2d<float> u_depthFilter [[texture(1)]], sampler u_inputImageTextureSmplr [[sampler(0)]], sampler u_depthFilterSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 param = u_inputImageTexture.sample(u_inputImageTextureSmplr, in.v_uv);
    float param_1 = 2.0;
    out.o_fragColor = _f2(param, u_depthFilter, u_depthFilterSmplr, param_1);
    return out;
}

