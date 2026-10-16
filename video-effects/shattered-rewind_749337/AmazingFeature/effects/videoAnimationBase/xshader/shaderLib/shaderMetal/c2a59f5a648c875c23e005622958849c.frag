#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_lastBlend;
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
    if (buffer.u_lastBlend == 1.0)
    {
        out.o_fragColor = mix(_MainTex.sample(_MainTexSmplr, in.uv0), baseTex.sample(baseTexSmplr, in.uv1), float4(buffer._alpha));
    }
    else
    {
        float4 _49 = baseTex.sample(baseTexSmplr, in.uv1);
        float4 _t3 = _49;
        float4 _53 = _MainTex.sample(_MainTexSmplr, in.uv0);
        float4 _t4 = _53;
        out.o_fragColor = float4((_49.xyz * (1.0 - (_t4.w * buffer._alpha))) + (_53.xyz * buffer._alpha), fast::max(_t3.w, _t4.w));
    }
    return out;
}

