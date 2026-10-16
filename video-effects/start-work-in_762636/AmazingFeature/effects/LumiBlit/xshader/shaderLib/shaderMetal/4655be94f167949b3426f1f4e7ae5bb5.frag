#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float u_offsety;
    float2 u_scale;
    float2 u_scale2;
};

struct main0_out
{
    float4 o_fragColor [[color(0)]];
};

struct main0_in
{
    float2 v_uv [[user(locn0)]];
};

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> _MaskMp4 [[texture(0)]], texture2d<float> u_inputTexture2 [[texture(1)]], sampler _MaskMp4Smplr [[sampler(0)]], sampler u_inputTexture2Smplr [[sampler(1)]])
{
    main0_out out = {};
    float2 _22 = float2(in.v_uv.x, 1.0 - in.v_uv.y);
    float2 _29 = float2(0.0, buffer.u_offsety);
    float2 _30 = _22 + _29;
    float2 _t1 = _30;
    float2 _35 = _22 - _29;
    float2 _t2 = _35;
    float _41 = step(0.5, _t1.y);
    float _46 = 1.0 - step(0.5, _t2.y);
    float2 _57 = mix(_35, _30, float2(_41)) - float2(0.5);
    float4 _75 = _MaskMp4.sample(_MaskMp4Smplr, ((_57 / buffer.u_scale) + float2(0.5)));
    float4 _90 = u_inputTexture2.sample(u_inputTexture2Smplr, ((_57 / buffer.u_scale2) + float2(0.5)));
    float4 _t9 = _90 * _41;
    float4 _t10 = _90 * _46;
    out.o_fragColor = fast::clamp(((_75 * _41) * (1.0 - smoothstep(0.5, 0.89999997615814208984375, _t9.x))) + ((_75 * _46) * (1.0 - smoothstep(0.5, 0.89999997615814208984375, _t10.x))), float4(0.0), float4(1.0));
    return out;
}

