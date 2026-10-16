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
float cut(thread const float2& _u, thread float2& v_uv)
{
    return ((step(0.0, v_uv.x) * step(v_uv.x, 1.0)) * step(0.0, v_uv.y)) * step(v_uv.y, 1.0);
}

fragment main0_out main0(main0_in in [[stage_in]], constant buffer_t& buffer, texture2d<float> u_inputTexture [[texture(0)]], sampler u_inputTextureSmplr [[sampler(0)]])
{
    main0_out out = {};
    float _45 = buffer.inputWidth / buffer.inputHeight;
    float2 uv_ori = in.v_uv * float2(_45, 1.0);
    uv_ori = (buffer.u_InvModel * float4(fma(uv_ori.x, 2.0, -_45), fma(uv_ori.y, 2.0, -1.0), 0.0, 1.0)).xy;
    uv_ori.x = ((uv_ori.x / _45) + 1.0) * 0.5;
    uv_ori.y = (uv_ori.y + 1.0) * 0.5;
    float _131 = uv_ori.x;
    float _137 = uv_ori.y;
    float2 _142 = float2(1.0 - abs(abs(_131) - 1.0), 1.0 - abs(abs(_137) - 1.0));
    uv_ori = _142;
    float2 param = _142;
    out.o_fragColor = u_inputTexture.sample(u_inputTextureSmplr, _142) * cut(param, in.v_uv);
    return out;
}

