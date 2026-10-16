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

fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> u_inputTexture [[texture(0)]], texture2d<float> u_inputTexture2 [[texture(1)]], sampler u_inputTextureSmplr [[sampler(0)]], sampler u_inputTexture2Smplr [[sampler(1)]])
{
    main0_out out = {};
    float4 _22 = u_inputTexture.sample(u_inputTextureSmplr, in.v_uv);
    float4 _t1 = _22;
    float4 _27 = u_inputTexture2.sample(u_inputTexture2Smplr, in.v_uv);
    float4 _t2 = _27;
    float3 _34 = _27.xyz - float3(0.00999999977648258209228515625);
    _t2.x = _34.x;
    _t2.y = _34.y;
    _t2.z = _34.z;
    float4 _46 = _t2;
    float3 _54 = float3(1.0) - pow(float3(1.0) - _46.xyz, float3(0.2857142984867095947265625));
    _t2.x = _54.x;
    _t2.y = _54.y;
    _t2.z = _54.z;
    float4 _61 = _t2;
    float4 _64 = fast::clamp(_61, float4(0.0), float4(1.0));
    _t2 = _64;
    float _69 = _t1.w;
    float4 _72 = _22 + (_64 * (1.0 - _69));
    _t1 = _72;
    out.o_fragColor = _72;
    return out;
}

