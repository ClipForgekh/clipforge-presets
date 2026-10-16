#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float _alpha;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 uv1 [[user(locn0)]];
    float2 uv0 [[user(locn1)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> baseTex [[texture(0)]], texture2d<float> _MainTex [[texture(1)]], sampler baseTexSmplr [[sampler(0)]], sampler _MainTexSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _19 = baseTex.sample(baseTexSmplr, in.uv1);
    float4 _t0 = _19;
    float4 _25 = _MainTex.sample(_MainTexSmplr, in.uv0);
    float4 _t1 = _25;
    out.o_fragColor = float4((_19.xyz * (1.0 - (_t1.w * buffer._alpha))) + (_25.xyz * buffer._alpha), fast::max(_t0.w, _t1.w));
    return out;
}

