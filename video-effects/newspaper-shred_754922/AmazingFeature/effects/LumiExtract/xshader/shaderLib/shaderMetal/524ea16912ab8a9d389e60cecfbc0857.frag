#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_BlackField;
    float u_BlackSoft;
    float u_WhiteField;
    float u_WhiteSoft;
    float u_Reverse;
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
float _f0(thread const float& _p0, thread const float& _p1, thread const float& _p2)
{
    return fast::clamp((_p2 - _p0) / ((_p1 - _p0) + 9.9999997473787516355514526367188e-06), 0.0, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_InputTexture [[texture(0)]], sampler u_InputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float4 _42 = u_InputTexture.sample(u_InputTextureSmplr, in.v_uv);
    float4 _t1 = _42;
    float _49 = _t1.w;
    float3 _53 = _42.xyz / float3(fast::max(_49, 9.9999997473787516355514526367188e-05));
    _t1.x = _53.x;
    _t1.y = _53.y;
    _t1.z = _53.z;
    float _70 = dot(_t1.xyz, float3(0.300000011920928955078125, 0.588235318660736083984375, 0.111764706671237945556640625));
    float param = buffer.u_BlackField - buffer.u_BlackSoft;
    float param_1 = buffer.u_BlackField;
    float param_2 = _70;
    float param_3 = buffer.u_WhiteField;
    float param_4 = buffer.u_WhiteField + buffer.u_WhiteSoft;
    float param_5 = _70;
    out.o_fragColor = _t1 * abs(buffer.u_Reverse - (_f0(param, param_1, param_2) * (1.0 - _f0(param_3, param_4, param_5))));
    return out;
}

