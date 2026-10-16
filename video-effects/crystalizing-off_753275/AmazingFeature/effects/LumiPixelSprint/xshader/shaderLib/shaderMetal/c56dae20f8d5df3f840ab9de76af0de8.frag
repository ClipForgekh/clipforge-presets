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
    if (_p0.w == 0.0)
    {
        return float3(0.0);
    }
    return _p0.xyz / float3(_p0.w);
}

static inline __attribute__((always_inline))
float3 _f1(texture2d<float> _p0, sampler _p0Smplr, thread float3& _p1)
{
    _p1 *= 63.0;
    float2 _63 = float2(floor(_p1.z), ceil(_p1.z));
    float2 _t1 = _63;
    float2 _68 = floor(_63 * 0.125);
    float4 _t4 = (float4(_63 - (_68 * 8.0), _68).xzyw * 0.125) + float4(((_p1.xy + float2(0.5)) * 0.001953125).xyxy);
    return mix(_p0.sample(_p0Smplr, float2(_t4.x, 1.0 - _t4.y)).xyz, _p0.sample(_p0Smplr, float2(_t4.z, 1.0 - _t4.w)).xyz, float3(_p1.z - _t1.x));
}

static inline __attribute__((always_inline))
float4 _f2(thread const float4& _p0, texture2d<float> _p1, sampler _p1Smplr, thread const float& _p2)
{
    float4 param = _p0;
    float3 _138 = _f0(param);
    float3 _t8 = _138;
    float3 param_1 = _138;
    float3 _142 = _f1(_p1, _p1Smplr, param_1);
    float3 _143 = _t8;
    float3 _147 = mix(_143, _142, float3(_p2));
    _t8 = _147;
    return float4(_147, 1.0) * _p0.w;
}

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_inputImageTexture [[texture(0)]], texture2d<float> u_depthFilter [[texture(1)]], sampler u_inputImageTextureSmplr [[sampler(0)]], sampler u_depthFilterSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 param = u_inputImageTexture.sample(u_inputImageTextureSmplr, in.v_uv);
    float param_1 = 2.0;
    out.o_fragColor = _f2(param, u_depthFilter, u_depthFilterSmplr, param_1);
    return out;
}

