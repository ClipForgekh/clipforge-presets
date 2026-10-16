#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float _alpha;
};

struct main0_out
{
    float4 gl_FragColor [[color(0)]];
};

struct main0_in
{
    float2 uv1 [[user(uv1)]];
    float2 uv0 [[user(uv0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> baseTex [[texture(0)]], texture2d<float> _MainTex [[texture(1)]], sampler baseTexSmplr [[sampler(0)]], sampler _MainTexSmplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _19 = baseTex.sample(baseTexSmplr, in.uv1);
    float4 _25 = _MainTex.sample(_MainTexSmplr, in.uv0);
    float _36 = _25.w;
    out.gl_FragColor = float4((_19.xyz * fma(-_36, buffer._alpha, 1.0)) + (_25.xyz * buffer._alpha), fast::max(_36, _19.w));
    return out;
}

