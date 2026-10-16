#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct buffer_t
{
    float inputWidth;
    float inputHeight;
    float4x4 u_InvModel;
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
float _f0(thread const float2& _p0, thread float2& v_uv)
{
    return ((step(0.0, v_uv.x) * step(v_uv.x, 1.0)) * step(0.0, v_uv.y)) * step(v_uv.y, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _45 = buffer.inputWidth / buffer.inputHeight;
    float2 _t5 = in.v_uv * float2(_45, 1.0);
    _t5 = (buffer.u_InvModel * float4((_t5.x * 2.0) - _45, (_t5.y * 2.0) - 1.0, 0.0, 1.0)).xy;
    _t5.x = ((_t5.x / _45) + 1.0) / 2.0;
    _t5.y = (_t5.y + 1.0) / 2.0;
    float _131 = _t5.x;
    float _137 = _t5.y;
    float2 _142 = float2(1.0 - abs(abs(_131) - 1.0), 1.0 - abs(abs(_137) - 1.0));
    _t5 = _142;
    float2 param = _142;
    out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, _142) * _f0(param, in.v_uv);
    return out;
}

